/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

Vtiger_Email_Validator_Js("Vtiger_To_EMAILMaker_Validator_Js", {

	/**
	 *Function which invokes field validation
	 *@param accepts field element as parameter
	 * @return error if validation fails true on success
	 */
	invokeValidation: function(field, rules, i, options){
		var toEmailInstance = new Vtiger_To_EMAILMaker_Validator_Js();
		toEmailInstance.setElement(field);
		return toEmailInstance.validate();
	}
},{
	/**
	 * Function to validate the email field data
	 */
	validate: function() {
         
	}
});

jQuery.Class("EMAILMaker_SendEmail_Js",{},{
	ckEditorInstance : false,
	massEmailForm : false,
	saved : "SAVED",
	sent : "SENT",
        send : false,
	attachmentsFileSize : 0,
	documentsFileSize : 0,
	total_emails_count : 0,
        previous_element_show: false,
        previous_element_hide: false,
        next_element_show: false,
        next_element_hide: false,
        click_func_ready: true,
        all_showed: false,

	getckEditorInstance : function(){
            if(this.ckEditorInstance == false){
                this.ckEditorInstance = CKEDITOR.replace('description', {height: '400'});
            }
            return this.ckEditorInstance;
	},
	showComposeEmailForm : function(params,cb,windowName){
	    app.hideModalWindow();
            var popupInstance = Vtiger_Popup_Js.getInstance();
            return popupInstance.show(params,cb,windowName);
	},
	getMassEmailForm : function(){
            if(this.massEmailForm == false){
                    this.massEmailForm = jQuery("#massEmailForm");
            }
            return this.massEmailForm;
	},
	registerEmailFieldSelectionEvent : function(){
            var thisInstance = this;
            var selectEmailForm = jQuery("#SendEmailFormStep1");
            selectEmailForm.on('submit',function(e){
                    var form = jQuery(e.currentTarget);
                    var params = form.serializeFormData();
                    thisInstance.showComposeEmailForm(params,"","composeEmail");
                    e.preventDefault();
            });
	},
        registerSendEmailEvent : function(){
	    var thisInstance = this;
            this.getMassEmailForm().on('submit',function(e){
                var formElement = jQuery(e.currentTarget);
                var invalidFields = formElement.data('jqv').InvalidFields;
                var progressElement = formElement.find('[name="progressIndicator"]');

                if (!thisInstance.send){   
                        var te = 0;
                        var se = 0;
                        var mailInfoElement = formElement.find('[name="toemailinfo_emailField"]');
                        var previousValue = JSON.parse(mailInfoElement.val());
                        for(var id in previousValue){
                            te += 1
                            for(var j in previousValue[id]){
                                se += 1;
                                break;
                            }
                        }
                        if (te != se) {
                            thisInstance.showCB();
                            return false;
                        }
                }

                if(invalidFields.length > 0){
                    return false;
                }

                jQuery('#sendEmail').attr('disabled',"disabled");
                jQuery('#saveDraft').attr('disabled',"disabled");

                progressElement.progressIndicator();
                return true;


            }).on('keypress',function(e){
                    if(e.which == 13){
                            e.preventDefault();
                    }
            });
	}, 
        showCB : function(){
            var thisInstance = this;                
            var message = app.vtranslate('LBL_NO_RCPTS_EMAIL_ERROR2');
            Vtiger_Helper_Js.showConfirmationBox({'message' : message}).then(function(e){
                    thisInstance.send = true;
                    thisInstance.getMassEmailForm().submit();
                }
            );
	},        
	setAttachmentsFileSizeByElement : function(element){
            if(jQuery.browser.msie){
                var	filesize = element.fileSize;
                if(typeof fileSize != 'undefined'){
                        this.attachmentsFileSize += filesize;
                }
            } else {
                this.attachmentsFileSize += element.get(0).files[0].size;
            }
	},
	setAttachmentsFileSizeBySize : function(fileSize){
            this.attachmentsFileSize += parseFloat(fileSize);
	},
	removeAttachmentFileSizeByElement : function(element){
            if(jQuery.browser.msie){
                    var	filesize = element.fileSize;
                    if(typeof fileSize != 'undefined'){
                            this.attachmentsFileSize -= filesize;
                    }
            } else {
                    this.attachmentsFileSize -= element.get(0).files[0].size;
            }
	},
	removeAttachmentFileSizeBySize : function(fileSize){
            this.attachmentsFileSize -= parseFloat(fileSize);
	},
	getAttachmentsFileSize : function(){
            return this.attachmentsFileSize;
	},
	setDocumentsFileSize : function(documentSize){
            this.documentsFileSize += parseFloat(documentSize);
	},
	getDocumentsFileSize : function(){
            return this.documentsFileSize;
	},
	getTotalAttachmentsSize : function(){
            return parseFloat(this.getAttachmentsFileSize())+parseFloat(this.getDocumentsFileSize());
	},
	getMaxUploadSize : function(){
            return jQuery('#maxUploadSize').val();
	},
	removeDocumentsFileSize : function(documentSize){
            this.documentsFileSize -= parseFloat(documentSize);
	},
	removeAttachmentsFileSize : function(){
	},
	fileAfterSelectHandler : function(element, value, master_element){
            var thisInstance = this;
            var mode = jQuery('[name="emailMode"]').val();
            var existingAttachment = JSON.parse(jQuery('[name="attachments"]').val());
            element = jQuery(element);
            thisInstance.setAttachmentsFileSizeByElement(element);
            var totalAttachmentsSize = thisInstance.getTotalAttachmentsSize();
            var maxUploadSize = thisInstance.getMaxUploadSize();
            if(totalAttachmentsSize > maxUploadSize){
                    Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_MAX_FILE_UPLOAD_EXCEEDS'));
                    this.removeAttachmentFileSizeByElement(jQuery(element));
                    master_element.list.find('.MultiFile-label:last').find('.MultiFile-remove').trigger('click');
            }else if((mode != "") && (existingAttachment != "")){
                    var pattern = /\\/;
                    var val = value.split(pattern);
                    if(jQuery.browser.mozilla){
                            fileuploaded = value;
                    } else if(jQuery.browser.webkit || jQuery.browser.msie){
                            var fileuploaded = val[2];
                            fileuploaded=fileuploaded.replace(" ","_");
                    }
                    jQuery.each(existingAttachment,function(key,value){
                            if((value['attachment'] == fileuploaded) && !(value.hasOwnProperty( "docid"))){
                                    var errorMsg = app.vtranslate("JS_THIS_FILE_HAS_ALREADY_BEEN_SELECTED")+fileuploaded;
                                    Vtiger_Helper_Js.showPnotify(app.vtranslate(errorMsg));
                                    thisInstance.removeAttachmentFileSizeByElement(jQuery(element),value);
                                    master_element.list.find('.MultiFile-label:last').find('.MultiFile-remove').trigger('click');
                                    return false;
                            }
                    })
            }
            return true;
	},
	registerEventsToGetFlagValue : function(){
            var thisInstance = this;
            jQuery('#saveDraft').on('click',function(e){
                    jQuery('#flag').val(thisInstance.saved);
            });
            jQuery('#sendEmail').on('click',function(e){
                    jQuery('#flag').val(thisInstance.sent);
            });
	},	
	checkHiddenStatusofCcandBcc : function(){
            var ccLink = jQuery('#ccLink');
            var bccLink = jQuery('#bccLink');
            if(ccLink.is(':hidden') && bccLink.is(':hidden')){
               ccLink.closest('div.row-fluid').addClass('hide');
            } 
	},
	registerCcAndBccEvents : function(){
            var thisInstance = this;
            jQuery('#ccLink').on('click',function(e){
                    jQuery('#ccContainer').show();
                    jQuery(e.currentTarget).hide();
                    thisInstance.checkHiddenStatusofCcandBcc();
            });
            jQuery('#bccLink').on('click',function(e){
                    jQuery('#bccContainer').show();
                    jQuery(e.currentTarget).hide();
                    thisInstance.checkHiddenStatusofCcandBcc();
            });
	},
	registerSendEmailTemplateEvent : function(){
		var thisInstance = this;
		jQuery('#selectEmailTemplate').on('click',function(e){
			var url = jQuery(e.currentTarget).data('url');
			var popupInstance = Vtiger_Popup_Js.getInstance();
			popupInstance.show(url,function(data){
				var responseData = JSON.parse(data);
				for(var id in responseData){
                                    var selectedName = responseData[id].name;
                                    var selectedTemplateBody = responseData[id].info;
                                    var params = {
                                            module : 'EMAILMaker',
                                            action : 'IndexAjax',
                                            mode : 'getDocuments',
                                            templateid: id
                                    };
                                    AppConnector.request(params).then(function(data){
                                            var responseData = data.result;
                                            for(var id in responseData){
                                                    selectedDocumentId = id;
                                                    var selectedFileName = responseData[id].filename;
                                                    var selectedFileSize =  responseData[id].filesize;
                                                    var response = thisInstance.writeDocumentIds(selectedDocumentId)
                                                    if(response){
                                                            var attachmentElement = thisInstance.getDocumentAttachmentElement(selectedFileName,id,selectedFileSize);
                                                            jQuery(attachmentElement).appendTo(jQuery('#attachments'));
                                                            jQuery('.MultiFile-applied,.MultiFile').addClass('removeNoFileChosen');
                                                            thisInstance.setDocumentsFileSize(selectedFileSize);
                                                    }
                                            }
                                    })
 				}
				var ckEditorInstance = thisInstance.getckEditorInstance();
                                var editorData = ckEditorInstance.getData();
                                var replaced_text = editorData.replace(editorData, selectedTemplateBody); 
                                ckEditorInstance.setData(replaced_text);	
				jQuery('#subject').val(selectedName);
			},'tempalteWindow');
		});
	},
	getDocumentAttachmentElement : function(selectedFileName,id,selectedFileSize){
            return '<div class="MultiFile-label"><a class="removeAttachment cursorPointer" data-id='+id+' data-file-size='+selectedFileSize+'>x </a><span>'+selectedFileName+'</span></div>';
	},
	registerBrowseCrmEvent : function(){
            var thisInstance = this;
            jQuery('#browseCrm').on('click',function(e){
                var selectedDocumentId;
                var url = jQuery(e.currentTarget).data('url');
                var popupInstance = Vtiger_Popup_Js.getInstance();
                popupInstance.show(url,function(data){
                        var responseData = JSON.parse(data);
                        for(var id in responseData){
                                selectedDocumentId = id;
                                var selectedFileName = responseData[id].info['filename'];
                                var selectedFileSize =  responseData[id].info['filesize'];
                                var response = thisInstance.writeDocumentIds(selectedDocumentId)
                                if(response){
                                        var attachmentElement = thisInstance.getDocumentAttachmentElement(selectedFileName,id,selectedFileSize);
                                        jQuery(attachmentElement).appendTo(jQuery('#attachments'));
                                        jQuery('.MultiFile-applied,.MultiFile').addClass('removeNoFileChosen');
                                        thisInstance.setDocumentsFileSize(selectedFileSize);
                                }
                        }
                },'browseCrmWindow');
            });
	},
	checkIfExisitingAttachment : function(selectedDocumentId){
            var documentExist;
            var documentPresent;
            var mode = jQuery('[name="emailMode"]').val();
            var selectedDocumentIds = jQuery('#documentIds').val();
            var existingAttachment = JSON.parse(jQuery('[name="attachments"]').val());
            if((mode != "") && (existingAttachment != "")){
                    jQuery.each(existingAttachment,function(key,value){
                            if(value.hasOwnProperty( "docid")){
                                    if(value['docid'] == selectedDocumentId){
                                            documentExist = 1;
                                            return false;
                                    } 
                            }
                    })
                    if(selectedDocumentIds != ""){
                            selectedDocumentIds = JSON.parse(selectedDocumentIds);
                    }
                    if((documentExist == 1) || (jQuery.inArray(selectedDocumentId,selectedDocumentIds) != '-1')){
                            documentPresent = 1;
                    } else {
                            documentPresent = 0;
                    }
            } else if(selectedDocumentIds != ""){
                    selectedDocumentIds = JSON.parse(selectedDocumentIds);
                    if((jQuery.inArray(selectedDocumentId,selectedDocumentIds) != '-1')){
                            documentPresent = 1;
                    } else {
                            documentPresent = 0;
                    }
            }
            if(documentPresent == 1){
                    var errorMsg = app.vtranslate("JS_THIS_DOCUMENT_HAS_ALREADY_BEEN_SELECTED");
                    Vtiger_Helper_Js.showPnotify(app.vtranslate(errorMsg));
                    return true;
            } else {
                    return false;
            }
	},
	writeDocumentIds :function(selectedDocumentId){
            var thisInstance = this;
            var newAttachment;
            var selectedDocumentIds = jQuery('#documentIds').val();
            if(selectedDocumentIds != ""){
                    selectedDocumentIds = JSON.parse(selectedDocumentIds);
                    var existingAttachment = thisInstance.checkIfExisitingAttachment(selectedDocumentId);
                    if(!existingAttachment){
                            newAttachment = 1;
                    } else {
                            newAttachment = 0;
                    }
            } else {
                    var existingAttachment = thisInstance.checkIfExisitingAttachment(selectedDocumentId);
                    if(!existingAttachment){
                            newAttachment = 1;
                            var selectedDocumentIds = new Array();
                    }
            }
            if(newAttachment == 1){
                    selectedDocumentIds.push(selectedDocumentId);
                    jQuery('#documentIds').val(JSON.stringify(selectedDocumentIds));
                    return true;
            } else {
                    return false;
            }
	},	
	removeDocumentIds : function(removedDocumentId){
            var documentIdsContainer = jQuery('#documentIds');
            var documentIdsArray = JSON.parse(documentIdsContainer.val());
            documentIdsArray.splice( jQuery.inArray('"'+removedDocumentId+'"', documentIdsArray), 1 );
            documentIdsContainer.val(JSON.stringify(documentIdsArray));
	},	
	registerRemoveAttachmentEvent : function(){
            var thisInstance = this;
            this.getMassEmailForm().on('click','.removeAttachment',function(e){
                    var currentTarget = jQuery(e.currentTarget);
                    var id = currentTarget.data('id');
                    var fileSize = currentTarget.data('fileSize');
                    currentTarget.closest('.MultiFile-label').remove();
                    thisInstance.removeDocumentsFileSize(fileSize);
                    thisInstance.removeDocumentIds(id);
                    if (jQuery('#attachments').is(':empty')){
                            jQuery('.MultiFile,.MultiFile-applied').removeClass('removeNoFileChosen');
                    }
            });
	},	
	registerEventsForToField : function(){
                var thisInstance = this;
		this.getMassEmailForm().on('click','.selectEmail',function(e){
                    thisInstance.source_id = jQuery(e.currentTarget).data('sourceid');
                    var callBackFunction = function(pInstance,parentElem,id,responseData,data,aDeferred){
                        var selectEmailForm = jQuery("#SendEmailFormStep1");
                        selectEmailForm.on('submit', function(e){
                            var form = jQuery(e.currentTarget);
                            form.find(":checked").each(function (i, ob){ 
                                selected_email = jQuery(ob).data('email');
                                var field_val = jQuery(ob).val(); 
                                var data = {
                                'name' : responseData[id].name,
                                'id' : id,
                                'emailid' : selected_email,
                                'field' : field_val 
                                };
                                pInstance.addToEmailAddressRow(data);
                            });
                            app.hideModalWindow();
                            e.preventDefault();
                            delete responseData[id];                            
                            if (aDeferred) aDeferred.resolve(responseData);                            
                        });
                    }                    
                    var moduleSelected = jQuery('.emailModulesList').val();
                    var parentElem = jQuery(e.target).closest('.toEmailField');
                    var sourceModule = jQuery('[name=module]').val();
                    var forModule = jQuery('[name=for_module]').val();
                    if (moduleSelected == ""){
                        var s_name = jQuery('.emailModulesList').find(":selected").text();
                        var content = jQuery('#setEmailAddress').html();
                        var callBackFunction = function(data){
                            var selectElement = jQuery('[name=emailaddress]', data);
                            jQuery('[name="setButton"]',data).on('click',function(e){
                                var email_address = selectElement.val();
                                var result = Vtiger_Email_Validator_Js.invokeValidation(selectElement);
                                if(result == undefined){
                                    selectElement.validationEngine('hide');
                                    app.hideModalWindow();
                                    var data = {
                                    'name' : s_name,
                                    'id' : '0',
                                    'emailid' : email_address,
                                    'field' : 'email|' + email_address + '|' + forModule 
                                    };
                                    thisInstance.addToEmailAddressRow(data);
                               } else {
                                    selectElement.validationEngine('showPrompt', result , 'error','bottomLeft',true);
                                    return false;
                                }
                            });
                        }
                        app.showModalWindow(content,function(content){
                            if(typeof callBackFunction == 'function'){
                                    callBackFunction(content);
                            }
                        },{
                            'text-align' : 'left'
                        });
                    } else {
                        var params = {
                                'module' : moduleSelected,
                                'src_module' : sourceModule,
                                'view': 'EmailsRelatedModulePopup'
                        }
                        var popupInstance =Vtiger_Popup_Js.getInstance();
                        popupInstance.show(params, function(data){
                                var responseData = JSON.parse(data);
                                
                                thisInstance.addEmails(responseData,parentElem,callBackFunction);
                                
                        },'relatedEmailModules');
                    }
                });
	},        
        addEmails : function(responseData,parentElem,callBackFunction) {
            var thisInstance = this;            
            var moduleSelected = jQuery('.emailModulesList').val();
            for(var id in responseData){

                    var cid = id.split(',');

                    var postData = {
                        "selected_ids": JSON.stringify(cid),
                        "sourcemodule": moduleSelected
                    }; 
                    var actionParams = {
                        "type": "POST",
                        "url": 'index.php?module=EMAILMaker&view=IndexAjax&mode=showComposeEmailForm&step=step1&basic=true',
                        "dataType": "html",
                        "data": postData
                    };

                    thisInstance.searchEmails(thisInstance,responseData,id,actionParams,parentElem,callBackFunction).then(function(responseData){                    
                    thisInstance.addEmails(responseData, parentElem, callBackFunction);

                    });
                    break;
            }
        },
        searchEmails : function(thisInstance,responseData,id,params,parentElem,callBackFunction) {
		var aDeferred = jQuery.Deferred();
		AppConnector.request(params).then(
			function(data){
                            if (data){
                                thisInstance.ch_count = 0; 
                                var total_emailoptout = jQuery(data).find('input[name="total_emailoptout"]').val();
                                if (total_emailoptout == undefined || total_emailoptout == "") total_emailoptout = 0;
                                jQuery(data).find("input:checkbox").each(function (i, ob){ 
                                    selected_email = jQuery(ob).data('email');
                                    var field_val = jQuery(ob).val(); 
                                    thisInstance.edata = {
                                    'name' : responseData[id].name,
                                    'id' : id,
                                    'emailid' : selected_email,
                                    'field' : field_val
                                    };
                                    thisInstance.ch_count++;
                                })
                                if (thisInstance.ch_count == 1 && total_emailoptout == 0){
                                    thisInstance.addToEmailAddressRow(thisInstance.edata);
                                    delete responseData[id];
                                    aDeferred.resolve(responseData);
                                } else {
                                    app.showModalWindow(data, {'text-align': 'left'});
                                    if (typeof callBackFunction == 'function'){
                                        callBackFunction(thisInstance,parentElem,id,responseData,data,aDeferred);
                                    }
                                }
                            }
			},
			function(error){
				aDeferred.reject();
			}
		)
		return aDeferred.promise();
	},
    addToEmailAddressRow : function(mailInfo){    
        var composeEmailForm = this.getMassEmailForm();
        var sourceid = composeEmailForm.find('[name="selected_sourceid"]').val();                
        var thisInstance = this;
        var elementName = "emailField";
        var composeEmailForm = this.getMassEmailForm();
        var preloadData = thisInstance.getPreloadData('emailField');

        var emailInfo = {
                'recordId' : mailInfo.id,
                'id' : mailInfo.field,
                'sid' : sourceid,
                'email' : mailInfo.emailid,
                'text' : mailInfo.name +' <b>(' + mailInfo.emailid + ')</b>'
        }
        preloadData.push(emailInfo);
        thisInstance.setPreloadData('emailField',preloadData);
        composeEmailForm.find('#emailField').select2('data', preloadData);
        
        var data = {
                'id' : mailInfo.id,
                'sid' : sourceid,
                'emailid' : mailInfo.emailid
        }
        
        thisInstance.addToEmailAddressData(elementName,data); 
        
        var emailData = {
                'id' : mailInfo.field,
                'recordid' : mailInfo.id,
                'sid' : sourceid,
                'label' : mailInfo.name,
                'value' : mailInfo.emailid
        }
        
        thisInstance.addToEmailAddressListData(elementName,emailData);
    },
    addToEmailAddressData : function(elementName,mailInfo){

        var mailInfoElement = this.getMassEmailForm().find('[name="toemailinfo_'+elementName+'"]');
        var existingToMailInfo = JSON.parse(mailInfoElement.val());
        
        if(typeof existingToMailInfo[mailInfo.sid].length != 'undefined') {
            existingToMailInfo[mailInfo.sid] = {};
        } 
        
        if(existingToMailInfo[mailInfo.sid].hasOwnProperty(mailInfo.id) === true){
            var existingValues = existingToMailInfo[mailInfo.sid][mailInfo.id];
            var newValue = new Array(mailInfo.emailid);
            existingToMailInfo[mailInfo.sid][mailInfo.id] = jQuery.merge(existingValues,newValue);
        } else {
            existingToMailInfo[mailInfo.sid][mailInfo.id] = new Array(mailInfo.emailid);
        }
        mailInfoElement.val(JSON.stringify(existingToMailInfo));
    },
    addToEmailAddressListData : function(elementName,mailInfo){
        var mailInfoElement = this.getMassEmailForm().find('[name="toMailNamesList_'+elementName+'"]');
        var existingToMailInfo = JSON.parse(mailInfoElement.val());

        if(typeof existingToMailInfo[mailInfo.sid].length != 'undefined') {
            existingToMailInfo[mailInfo.sid] = {};
        } 
        existingToMailInfo[mailInfo.sid][mailInfo.id] = mailInfo;

        mailInfoElement.val(JSON.stringify(existingToMailInfo));
    },
    appendToSelectedIds : function(selectedId){
        var selectedIdElement = this.getMassEmailForm().find('[name="selected_ids"]');
        var previousValue = JSON.parse(selectedIdElement.val());
        previousValue.push(selectedId);
        selectedIdElement.val(JSON.stringify(previousValue));
    },
    addToEmails : function(mailInfo){
    },
    registerEventForRemoveCustomAttachments : function(){
        var thisInstance = this;
        var composeEmailForm = this.getMassEmailForm();
        jQuery('[name="removeAttachment"]').on('click',function(e){
            var attachmentsContainer = composeEmailForm.find('[ name="attachments"]');
            var attachmentsInfo = JSON.parse(attachmentsContainer.val());
            var element = jQuery(e.currentTarget);
            var imageContainer = element.closest('div.MultiFile-label');
            var imageContainerData = imageContainer.data();
            var fileType = imageContainerData['fileType'];
            var fileSize = imageContainerData['fileSize'];
            var fileId = imageContainerData['fileId'];
            if(fileType == "document"){
                thisInstance.removeDocumentsFileSize(fileSize);
            } else if(fileType == "file"){
                thisInstance.removeAttachmentFileSizeBySize(fileSize);
            }
            jQuery.each(attachmentsInfo,function(index,attachmentObject){
                if((typeof attachmentObject != "undefined") && (attachmentObject.fileid == fileId)){
                        attachmentsInfo.splice(index,1);
                }
            })
            attachmentsContainer.val(JSON.stringify(attachmentsInfo));
            imageContainer.remove();
        })
    },
    calculateUploadFileSize : function(){
        var thisInstance = this;
        var composeEmailForm = this.getMassEmailForm();
        var attachmentsList = composeEmailForm.find('#attachments');
        var attachments = attachmentsList.find('.customAttachment');
        jQuery.each(attachments,function(){
            var element = jQuery(this);
            var fileSize = element.data('fileSize');
            var fileType = element.data('fileType');
            if(fileType == "file"){
                thisInstance.setAttachmentsFileSizeBySize(fileSize);
            } else if(fileType == "document"){
                if (fileSize){
                    thisInstance.setDocumentsFileSize(fileSize);
                }
            }
        })
    },
    registerEventForGoToPreview : function(){
        jQuery('#gotoPreview').on('click',function(e){
            var recordId = jQuery('[name="parent_id"]').val();
            var parentRecordId = jQuery('[name="parent_record_id"]').val();
            var params = {};
            params['module'] = "Emails";
            params['view'] = "ComposeEmail";
            params['mode'] = "emailPreview";
            params['record'] = recordId;
            params['parentId'] = parentRecordId;
            var urlString = (typeof params == 'string')? params : jQuery.param(params);
            var url = 'index.php?'+urlString;
            self.location.href = url;
        })
    },
   registerSelectRTypes : function(){     
        var thisInstance = this; 
        jQuery('.selectRType').on('change',function(e){
             thisInstance.changeSelectRTypes(e);
        });
    },
    changeSelectRTypes : function(e){     
        var element = jQuery(e.currentTarget);
        var element_val = jQuery(e.currentTarget).val(); 
        if (element_val === 'to'){
            var sourceid = element.data('sourceid');
            var select_element = jQuery('#select_recipients'); 
            select_element.validationEngine('hide');
        }
    },    
    registerEmailSourcesList : function(){
        var thisInstance = this;
        jQuery('.emailSourcesList').on('change',function(e){
            var new_sourceid = jQuery(e.currentTarget).val();
            var composeEmailForm = thisInstance.getMassEmailForm();            
            composeEmailForm.find('[name="selected_sourceid"]').val(new_sourceid);
            
            thisInstance.actualizeSelect2El(composeEmailForm,'emailField');
            thisInstance.actualizeSelect2El(composeEmailForm,'emailCCField');
            thisInstance.actualizeSelect2El(composeEmailForm,'emailBCCField');
            
            var showcc = false;
            var showbcc = false;
            var ccLink = jQuery('#ccLink');
            var ccContainer = jQuery('#ccContainer');
            var bccLink = jQuery('#bccLink');
            var bccContainer = jQuery('#bccContainer');            
            var emailCCFieldData = thisInstance.getPreloadData('emailCCField');

            for(var id in emailCCFieldData){
                showcc = true;
                break;
            }

            var emailBCCFieldData = thisInstance.getPreloadData('emailBCCField');

            for(var id in emailBCCFieldData){
                showbcc = true;
                break;
            }

            if (showcc) {
                ccContainer.show();
                ccLink.hide();
            } else {
                ccContainer.hide();
                ccLink.show();
            }

            if (showbcc) {
                bccContainer.show();
                bccLink.hide();
            } else {
                bccContainer.hide();
                bccLink.show();
            }

            if(!showcc || !showbcc){
               ccLink.closest('div.row-fluid').removeClass('hide');
            } 

        });
    },
    registerEvents : function(){
        var thisInstance = this;
        var composeEmailForm = this.getMassEmailForm();
        if(composeEmailForm.length > 0){
            jQuery("#multiFile").MultiFile({
                    list: '#attachments',
                    'afterFileSelect' : function(element, value, master_element){
                            var masterElement = master_element;
                            var newElement = jQuery(masterElement.current);
                            newElement.addClass('removeNoFileChosen');
                            thisInstance.fileAfterSelectHandler(element, value, master_element);
                    },
                    'afterFileRemove' : function(element, value, master_element){
                            if (jQuery('#attachments').is(':empty')){
                                    jQuery('.MultiFile,.MultiFile-applied').removeClass('removeNoFileChosen');
                            }
                            thisInstance.removeAttachmentFileSizeByElement(jQuery(element));
                    }
            });
            this.getMassEmailForm().validationEngine(app.validationEngineOptions);            
            this.registerSendEmailEvent();
            var textAreaElement = jQuery('#description');
            var ckEditorInstance = this.getckEditorInstance(textAreaElement);
            this.registerAutoCompleteFields('emailField',composeEmailForm);
            this.registerAutoCompleteFields('emailCCField',composeEmailForm);
            this.registerAutoCompleteFields('emailBCCField',composeEmailForm);
            this.registerRemoveAttachmentEvent();
            this.registerEventsToGetFlagValue();
            this.registerCcAndBccEvents();
            this.registerSendEmailTemplateEvent();
            this.registerBrowseCrmEvent();
            this.registerEventsForToField();
            this.registerEventForRemoveCustomAttachments();
            this.calculateUploadFileSize();
            this.registerEventForGoToPreview();
            this.registerSelectRTypes();
            this.registerEmailSourcesList();
        }
    },
    runProcess : function(esentid_val){
        var thisInstance = this;
        var params = {
                module : 'EMAILMaker',
                action : 'IndexAjax',
                mode : 'sendEmail',
                esentid: esentid_val
        };
        var actionParams = {
            "type": "POST",
            "url": 'index.php',
            "dataType": "html",
            "data": params
        };
        AppConnector.request(params).then(function(data){
            var result = data.result;
            if (typeof result == 'undefined'){
                var urlString = jQuery.param(params);
                var url = 'index.php?dataType=html&debug=true&'+urlString;
                window.open(url, 'test','width=1100,height=850,resizable=0,scrollbars=1');    
            } else {
                var esentid = result.emails_info.id;
                jQuery("#popup_notifi_title").html(result.emails_info.title);
                jQuery("#popup_notifi_content").html(result.emails_info.content);
                jQuery("#emailmaker_notifi_title_" + esentid, window.opener.document).html(result.emails_info.title);
                jQuery("#emailmaker_notifi_text_" + esentid, window.opener.document).html(result.emails_info.content);
                if (result.message !== ''){
                    if (result.correct == "true"){
                        var mess_type = "info";
                    } else {
                        var mess_type = "error";
                    }
                    var sm_params = {
                        text : result.message,
                        type: mess_type
                    };
                    Vtiger_Helper_Js.showMessage(sm_params); 
                }
                if (result.emails_info.error_emails > 0){
                    jQuery("#popupinfo1").hide();
                    jQuery("#popupinfo2").hide();
                    
                    jQuery("#popup_notifi_content").html(result.emails_info.content + "<br><br><font color='red'>"+result.emails_info.error_info+"</font>");
                }
                if (result.emails_info.sent_emails === result.emails_info.total_emails){
                    if (result.emails_info.error_emails > 0){
                        jQuery("#popupinfo3").hide();
                    } else {
                        setTimeout(function(){thisInstance.closeRunProcess(esentid);},4000);
                    }
                } else {
                    thisInstance.runProcess(esentid);
                }    
            }
        },
        function(error){
            var urlString = jQuery.param(params);
            var url = 'index.php?dataType=html&debug=true&'+urlString;
            window.open(url, 'test','width=1100,height=850,resizable=0,scrollbars=1');  
        });        
    },
    closeRunProcess : function(esentid_val){
        jQuery('#emailmaker_notifi_btn_hide_' + esentid_val, window.opener.document).trigger('click');
        window.close();
    },
    registerAutoCompleteFields : function(elementName,container) {
		var thisInstance = this;

		container.find('#'+elementName).select2({
			minimumInputLength: 3,
			closeOnSelect : false,
			tags : [],
			tokenSeparators: [","],
			createSearchChoice : function(term) {
				return {id: term, text: term};
			},

			ajax : {
                            'url' : 'index.php?module=EMAILMaker&action=IndexAjax&mode=SearchEmails',
                            'dataType' : 'json',
                            'data' : function(term,page){
                                 var data = {};
                                 data['searchValue'] = term;
                                 return data;
                            },
                            'results' : function(data){
                                                    var skey = container.find('[name="selected_sourceid"]').val();
                                                    var finalResult = [];
                                                    
                                                    var results = data.result;
                                                    var resultData = new Array();
                                                    for(var moduleName in results) {
                                                                                var moduleResult = [];
                                                                                moduleResult.text = moduleName;

                                                                                var children = new Array();
                                                                                for(var recordId in data.result[moduleName]) {
                                                                                        var emailInfo = data.result[moduleName][recordId];
                                                                                        for (var i in emailInfo) {
                                                                                                var childrenInfo = [];
                                                                                                childrenInfo.recordId = recordId;
                                                                                                childrenInfo.sid = skey;
                                                                                                childrenInfo.id = emailInfo[i].id;
                                                                                                childrenInfo.name = emailInfo[i].name;
                                                                                                childrenInfo.text = emailInfo[i].label;
                                                                                                childrenInfo.emailid = emailInfo[i].emailid;
                                                                                                children.push(childrenInfo);
                                                                                        }
                                                                                }
                                                                                
                                                                                moduleResult.children = children;
                                                                                resultData.push(moduleResult);
                                                    }
                                                                        finalResult.results = resultData;
                                                    return finalResult;
                                                },
                                            transport : function(params) {
                                                    return jQuery.ajax(params);
                                            }
                        }

		}).on("change", function (selectedData) {

                    console.log("Change of select element");
			var addedElement = selectedData.added;

			if (typeof addedElement != 'undefined') {
                           
                                if (typeof addedElement.recordId == 'undefined') {
                                    addedElement.recordId = 0
                                    var for_module = container.find('[name="for_module"]').val();
                                    addedElement.id = "email|" + addedElement.text + '|' + for_module;
                                    
                                    if (addedElement.text != "") {
                                        var emailInstance = new Vtiger_Email_Validator_Js();
                                        var response = emailInstance.validateValue(addedElement.text);
                                        if(response != true) {
                                            errorMsg = emailInstance.getError();
                                            Vtiger_Helper_Js.showPnotify(errorMsg);
                                            thisInstance.actualizeSelect2El(container,elementName);
                                            return;
                                        } 
                                    }
                                }
                            
                                if (typeof addedElement.sid == 'undefined') {
                                    addedElement.sid = container.find('[name="selected_sourceid"]').val();
                                }
                            
                                if (typeof addedElement.emailid == 'undefined') {
                                    addedElement.emailid = addedElement.text;
                                }
                            
				var data = {
					'id' : addedElement.recordId,
                                        'sid' : addedElement.sid,
					'name' : addedElement.text,
					'emailid' : addedElement.emailid
				}
                                

                                thisInstance.addToEmails(data);
				if (typeof addedElement.recordId != 'undefined') {
					thisInstance.addToEmailAddressData(elementName,data);
                                        var emailData = {
                                                'id' : addedElement.id,
                                                'recordid' : addedElement.recordId,
                                                'sid' : addedElement.sid,
                                                'label' : addedElement.name,
                                                'value' : addedElement.emailid
                                        }
                                        thisInstance.addToEmailAddressListData(elementName,emailData);
				}

				var preloadData = thisInstance.getPreloadData(elementName);
				var emailInfo = {
					'id' : addedElement.id
				}
				if (typeof addedElement.recordId != 'undefined') {
					emailInfo['text'] = addedElement.text;
					emailInfo['recordId'] = addedElement.recordId;
				} else {
					emailInfo['text'] = addedElement.id;
				}

				preloadData.push(emailInfo);
				thisInstance.setPreloadData(elementName,preloadData);
			}

			var removedElement = selectedData.removed;
			if (typeof removedElement != 'undefined') {

                                var data = {
					'recordId' : removedElement.recordId,
                                        'id' : removedElement.id,
                                        'sid' : removedElement.sid,
					'name' : removedElement.text,
                                        'email' : removedElement.email,
					'emailid' : removedElement.id
				}
				thisInstance.removeFromEmails(data);
				if (typeof removedElement.recordId != 'undefined') {
					thisInstance.removeFromEmailAddressData(elementName,data);
				}

				var preloadData = thisInstance.getPreloadData(elementName);
				var updatedPreloadData = [];
				for(var i in preloadData) {
					var preloadDataInfo = preloadData[i];
					var skip = false;
					if (removedElement.id == preloadDataInfo.id) {
						skip = true;
					}
					if (skip == false) {
						updatedPreloadData.push(preloadDataInfo);
					}
				}
				thisInstance.setPreloadData(elementName,updatedPreloadData);
			}
		});
		container.find('#emailField').select2("container").find("ul.select2-choices").sortable({
			containment: 'parent',
			start: function(){
				container.find('#emailField').select2("onSortStart");
			},
			update: function(){
				container.find('#emailField').select2("onSortEnd");
			}
		});
		thisInstance.actualizeSelect2El(container,elementName);
	},
        
        actualizeSelect2El : function(container,elementName) {
            var thisInstance = this;
            var toEmailNamesList = JSON.parse(container.find('[name="toMailNamesList_'+elementName+'"]').val());
            var toEmailInfo = JSON.parse(container.find('[name="toemailinfo_'+elementName+'"]').val());
            var toEmails = container.find('[name="toEmail"]').val();
            var toFieldValues = Array();
            if (toEmails.length > 0) {
                    toFieldValues = toEmails.split(',');
            }
            var preloadData = new Array();
            var skey = container.find('[name="selected_sourceid"]').val();
            if (skey == "") skey = "0";

            for(var key in toEmailNamesList[skey]) {
                    var emailInfo = [];
                    var emailId = toEmailNamesList[skey][key].value;

                    if (toEmailNamesList[skey][key].label != undefined) {
                        var emailinfotext = toEmailNamesList[skey][key].label+' <b>('+emailId+')</b>';
                    } else {
                        var emailinfotext = emailId;
                    }                        
                
                    var emailInfo = {
                            'recordId' : toEmailNamesList[skey][key].recordid,
                            'id' : key,
                            'sid' : skey,
                            'email' : emailId,
                            'text' : emailinfotext
                    }
                    preloadData.push(emailInfo);
            }

            if (typeof preloadData != 'undefined') {
                    thisInstance.setPreloadData(elementName,preloadData);
                    container.find('#'+elementName).select2('data', preloadData);
            }
        },
        preloadData: new Array(),
        preloademailFieldData: new Array(),
        preloademailCCFieldData: new Array(),
        preloademailBCCCFieldData: new Array(),
        
	getPreloadData : function(type) {
            if (type == "emailField")
		return this.preloademailFieldData;
            else if (type == "emailCCField")
		return this.preloademailCCFieldData;
            else if (type == "emailBCCField")
		return this.preloademailBCCCFieldData;
            else
		return this.preloadData;
	},
	setPreloadData : function(type,dataInfo){		
            if (type == "emailField")
		this.preloademailFieldData = dataInfo;
            else if (type == "emailCCField")
		this.preloademailCCFieldData = dataInfo;
            else if (type == "emailBCCField")
		this.preloademailBCCCFieldData = dataInfo;
            else
		this.preloadData = dataInfo;
        
            return this;
	},
        removeFromEmailAddressData : function(elementName,mailInfo) {
            var mailInfoElement = this.getMassEmailForm().find('[name="toemailinfo_'+elementName+'"]');
            var previousValue = JSON.parse(mailInfoElement.val());            
            var toMailNamesListElement = this.getMassEmailForm().find('[name="toMailNamesList_'+elementName+'"]');
            var toMailNamesListValue = JSON.parse(toMailNamesListElement.val());
            var selectedSId = mailInfo.sid;
            var selectedId = mailInfo.recordId;
            var elementSize = previousValue[selectedSId][selectedId].length;
            var emailAddress = mailInfo.email;

            delete toMailNamesListValue[selectedSId][mailInfo.id];

            if(elementSize < 2){
                    delete previousValue[selectedSId][selectedId];
            } else {
                    var newValue;
                    var reserveValue = previousValue[selectedSId][selectedId];
                    delete previousValue[selectedSId][selectedId];
                    newValue = jQuery.grep(reserveValue, function(value) {
                            return value != emailAddress;
                    });
                    previousValue[selectedSId][selectedId] = newValue;
            }
            mailInfoElement.val(JSON.stringify(previousValue));
            toMailNamesListElement.val(JSON.stringify(toMailNamesListValue));
    },
    removeFromEmails : function(mailInfo){            
    },
});

jQuery(document).ready(function() {
	var emailMassEditInstance = new EMAILMaker_SendEmail_Js();
	emailMassEditInstance.registerEvents();
});