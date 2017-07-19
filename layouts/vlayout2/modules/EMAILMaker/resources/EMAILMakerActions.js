/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
if (typeof(EMAILMaker_Actions_Js) == 'undefined'){
    
    EMAILMaker_Actions_Js = {
        
        active_notifications: {},
        getSelectedTemplates: function (){
            return jQuery('#use_common_email_template').val();
        },
        getSelectedPDFTemplates: function (){
            var pdf_templates = []; 
            $('#use_common_pdf_template :selected').each(function(i, selected){ 
              pdf_templates[i] = $(selected).val(); 
            });
            return pdf_templates.join(';');
        },        
        getEMAILImagesDiv: function (rootElm, id){
        },
        sendMail: function (module, idstrings){
        },
        sendEMAILMakermail: function (module, idstrings){            
        },
        validate_sendMail: function (idlist, module){            
        },
        saveEMAILImages: function (){            
        },
        getListViewPopup: function (srcButt, module){
            var thisInstance = this;
            var EMAILMakerUrl = 'index.php?module=EMAILMaker&view=IndexAjax&mode=showComposeEmailForm&step=step1&selecttemplates=true&sourcemodule='+module;
            Vtiger_List_Js.triggerMassAction(EMAILMakerUrl, function(data) {
                thisInstance.callBackFunction(data, module);
            });
        },
        getCampaignsListViewPopup: function (module,cid){
            var thisInstance = this;
            var EMAILMakerUrl = 'index.php?module=EMAILMaker&view=IndexAjax&mode=showComposeEmailForm&step=step1&selecttemplates=true&sourcemodule='+module+'&cid='+cid;
            Vtiger_List_Js.triggerMassAction(EMAILMakerUrl, function(data) {
                thisInstance.callBackFunction(data, module,'','',cid);
            });
        },
        loadEMAILCSS: function (filename){
            return;
        },
        callBackFunction: function (data, module, crmid, pid, cid){            
            var thisInstance = this;            
            if (crmid == undefined) crmid = '';            
            var selectEmailForm = jQuery('#SendEmailFormStep1');
            selectEmailForm.on('submit', function(e){
                var fieldLists = new Array();
                var form = jQuery(e.currentTarget);
                var params = form.serializeFormData();                
                
                //find('input:checked')
                form.find('.emailToFields').find('option:selected').each(function (i, ob) { 
                    fieldLists.push(jQuery(ob).val());
                });
                params['field_lists'] = JSON.stringify(fieldLists);
                app.hideModalWindow();
                if (typeof params['email_template_language'] == 'undefined') params['email_template_language'] = jQuery('#email_template_language').val();
                if (typeof params['emailtemplateid'] == 'undefined') params['emailtemplateid'] = EMAILMaker_Actions_Js.getSelectedTemplates();
                thisInstance.openEmailComposeWindow(params, module, crmid, pid, cid)
                e.preventDefault();
            });            
            jQuery('#addPDFMakerTemplate').on('click',function(e){
                    jQuery('#EMAILMakerPDFTemplatesContainer').show();
                    jQuery('#EMAILMakerPDFTemplatesBtn').hide();
                    jQuery('#ispdfactive').val('1');
            });            
            jQuery('#removePDFMakerTemplate').on('click',function(e){
                    jQuery('#EMAILMakerPDFTemplatesContainer').hide();
                    jQuery('#EMAILMakerPDFTemplatesBtn').show();
                    jQuery('#ispdfactive').val('0');
            });
        },
        openEmailComposeWindow: function (params, module, crmid, pid, cid) {
            if (typeof crmid == 'undefined') crmid = '';
            if (typeof pid == 'undefined') pid = '';
            if (typeof cid == 'undefined') cid = '';
            params['module'] = 'EMAILMaker';
            params['view'] = 'SendEmail';
            params['formodule'] = module;
            params['mode'] = 'composeMailData';
            params['record'] = crmid;
            params['pid'] = pid;
            params['cid'] = cid;
            params['language'] = params['email_template_language'];  
            var pdfactiveel = jQuery('#ispdfactive');
            if (pdfactiveel.length > 0){
                var ispdfactive = pdfactiveel.val(); 
                if (ispdfactive == '1') params['pdftemplateid'] = EMAILMaker_Actions_Js.getSelectedPDFTemplates(); 
            } else {
                if (params['pdftemplateid'] != "") params['ispdfactive'] = "1";    
            }            
            eventName = 'postSelection'+ Math.floor(Math.random() * 10000);
            params['triggerEventName'] = eventName;
            
            if (typeof Vtiger_List_Js === 'function') {
                var listViewInstance = new Vtiger_List_Js(); 
                if (typeof listViewInstance.getListSearchParams == 'function') {
                    params['search_params'] = JSON.stringify(listViewInstance.getListSearchParams());
                }
            }
            var urlString = jQuery.param(params);
            var url = 'index.php?'+urlString;
            var popupWinRef =  window.open(url, 'EMAILMaker','width=1100,height=850,resizable=0,scrollbars=1');
        },
        emailmaker_sendMail: function (module, crmid, pdftemplateid, pdflanguage, pid){
            var thisInstance = this;
            Vtiger_Helper_Js.checkServerConfig('EMAILMaker').then(function(data){
                if (data == true) {                    
                    cid = crmid.split(',');
                    var postData = {
                        'pid': pid,
                        'selected_ids': JSON.stringify(cid),
                        'sourcemodule': module,
                        'pdftemplateid': pdftemplateid,
                        'pdflanguage': pdflanguage
                    };
                    
                    if (typeof Vtiger_List_Js === 'function') {
                        var listViewInstance = new Vtiger_List_Js();   
                        if (typeof listViewInstance.getListSearchParams == 'function') {
                            postData['search_params'] = JSON.stringify(listViewInstance.getListSearchParams());
                        }
                    }
                
                    var actionParams = {
                        'type': "POST",
                        'url': 'index.php?module=EMAILMaker&view=IndexAjax&mode=showComposeEmailForm&step=step1',
                        'dataType': "html",
                        'data': postData
                    };

                    AppConnector.request(actionParams).then(
                            function(data){
                                if (data){
                                    data = jQuery(data);
                                    var form = data.find('#SendEmailFormStep1');
                                    var params = form.serializeFormData();
                                    var emailFields = form.find('.emailFields');
                                    var length = emailFields.val();
                                    var total_emailoptout = params['total_emailoptout'];
                                    if (total_emailoptout == '' || total_emailoptout == undefined) total_emailoptout = 0;
                                    if(length > 1 || total_emailoptout > 0){
                                        app.showModalWindow(data, {'text-align': 'left'});
                                        thisInstance.callBackFunction(data, module, crmid, pid);
                                    } else {                                        
                                        var fieldLists = new Array();
                                        form.find('.emailToFields').find('option').each(function (i, ob) { 
                                            fieldLists.push(jQuery(ob).val());
                                        });
                                        params['field_lists'] = JSON.stringify(fieldLists);
                                        if (pdftemplateid != "") params['pdftemplateid'] = pdftemplateid;
                                        if (pdflanguage != "") params['pdflanguage'] = pdflanguage;
                                        params['email_template_language'] = jQuery('#email_template_language').val();
                                        params['emailtemplateid'] = EMAILMaker_Actions_Js.getSelectedTemplates();
                                        thisInstance.openEmailComposeWindow(params, module, crmid, pid)
                                    }  
                                }
                            }
                    );            
                } else {
                    alert(app.vtranslate('JS_EMAIL_SERVER_CONFIGURATION'));
                }
            });
        },        
        closeRunProcess : function(esentid_val){
            jQuery('#emailmaker_notifi_btn_hide_' + esentid_val).trigger('click');
        },        
        showEmailsPopup : function(record){
		var thisInstance = this;
                var emailmaker_notifi_title = jQuery('#emailmaker_notifi_title_' + record.id);
                var emailmaker_notifi_text = jQuery('#emailmaker_notifi_text_' + record.id);
                var control_emailmaker_notifi = emailmaker_notifi_title.attr('id'); 
                if (control_emailmaker_notifi != undefined){
                    emailmaker_notifi_title.html(record.title);
                    emailmaker_notifi_text.html(record.content);
                    if (record.sent_emails === record.total_emails){ 
                        thisInstance.active_notifications[record.id]  = '';                        
                        setTimeout(function(){thisInstance.closeRunProcess(record.id);},4000);
                    }                    
                } else { 
                    var params = {
                        title: '<span class="paddingLeft10px" id="emailmaker_notifi_title_' + record.id +'" style="position: relative; top: 8px;">'+record.title+'</span>',
                        text: '<div class="row-fluid paddingLeft10px" style="color:black"><div class="span7 paddingTop10" id="emailmaker_notifi_text_' + record.id +'">'+record.content+'</div>'+record.buttons+'<input type="button" class="hide" value="x" id="emailmaker_notifi_btn_hide_' + record.id +'"></div>',
                        width: '30%',
                        min_height: '75px',
                        addclass:'vtReminder',
                        icon: 'vtReminder-icon',
                        hide:false,
                        closer:true,
                        type:'info',
                        animation: 'show',
                        after_open:function(p) {
                                jQuery(p).data('info', record);
                        }
                    };
                    var notify = Vtiger_Helper_Js.showPnotify(params);
                    jQuery('#emailmaker_notifi_btn_'+record.id).bind('click', function(){
                        var url_params = {
                            module: 'EMAILMaker',
                            view: 'SendEmail',
                            mode: 'sending',
                            esentid: record.id
                        };
                        var urlString = jQuery.param(url_params);
                        var url = 'index.php?'+urlString;
                        var popupWinRef =  window.open(url, 'EMAILMaker','width=1100,height=850,resizable=0,scrollbars=1');
                    });                    
                    jQuery('#emailmaker_notifi_btn_stop_'+record.id).bind('click', function(){
                        Vtiger_Helper_Js.showConfirmationBox({'message' : record.stop_q}).then(
                            function(e) {
                                    var progressIndicatorElement = jQuery.progressIndicator({
                                            'position' : 'html',
                                            'blockInfo' : {
                                                    'enabled' : true
                                            }
                                    });
                                    var stop_params = {
                                        module: 'EMAILMaker',
                                        action: 'IndexAjax',
                                        mode: 'stopSendingEmails',
                                        esentid: record.id
                                    };    
                                    AppConnector.request(stop_params).then(
                                        function() {
                                                progressIndicatorElement.progressIndicator({
                                                        'mode' : 'hide'
                                                })
                                                thisInstance.active_notifications[record.id]  = "";
                                                notify.hide('slow',function() {this.remove(); }); 
                                        }
                                    );
                                },
                            function(error, err){
                        })
                    });
                    jQuery('#emailmaker_notifi_btn_hide_'+record.id).bind('click', function(){
                        thisInstance.active_notifications[record.id]  = "";
                        notify.hide('slow',function() {this.remove(); }); 
                    });
                }
	},        
        controlEmails: function (){
            var thisInstance = this;
            var act_view = jQuery('#view').val();
            if (act_view == 'List' || act_view == 'Detail' || act_view == 'Calendar'){
                var url = 'index.php?module=EMAILMaker&action=IndexAjax&mode=controlEmails';
                AppConnector.request(url).then(function(data){
                    if(data.success && data.result){
                        if (data.result.length > 0){
                            for(i=0; i< data.result.length; i++){
                                var record  = data.result[i];
                                if (record.id && record.sent_emails != record.total_emails) thisInstance.active_notifications[record.id] = record;
                            }
                        }
                    }                    
                    jQuery.each(thisInstance.active_notifications,function(lrecordid,lrecord){   
                        if (lrecord != ''){ 
                            AppConnector.request(url + '&esentid='+ lrecordid).then(function(data2){
                                if(data2.success && data2.result){
                                    if (data2.result.length > 0){
                                        for(i=0; i< data2.result.length; i++){
                                            var record2  = data2.result[i];
                                            thisInstance.showEmailsPopup(record2);
                                        }
                                    }
                                } 
                            }); 
                        }
                    });
                });                
                //setTimeout(function(){EMAILMaker_Actions_Js.controlEmails()},10000);
                return;
            }
        }
    }    
    jQuery(document).ready(function(){
        EMAILMaker_Actions_Js.controlEmails();
    });
}
EMAILMakerCommon = {
    showproductimages: function(record){
        AppConnector.request('index.php?module=EMAILMaker&view=imagesSelect&return_id=' + encodeURIComponent(record)).then(
                function(data) {
                    app.showModalWindow(data);
                }
        );
    },
    saveproductimages: function(record){
        var frm = document.PDFImagesForm;
        var url = 'index.php?module=EMAILMaker&action=IndexAjax&mode=SaveEMAILImages&record=' + encodeURIComponent(record);
        var url_suf = '';
        if (frm != 'undefined'){
            for (i = 0; i < frm.elements.length; i++){
                if (frm.elements[i].type == 'radio'){
                    if (frm.elements[i].checked){
                        url_suf += '&' + frm.elements[i].name + '=' + frm.elements[i].value;
                    }
                } else if (frm.elements[i].type == 'text'){
                    url_suf += '&' + frm.elements[i].name + '=' + frm.elements[i].value;
                }
            }
            url += url_suf;
            AppConnector.request(url).then(
                    function(data){
                        app.hideModalWindow();
                    }
            );
        }
    }
}
function showEMAILMakerEmailPreview(templateid){
    window.location.href = "index.php?module=EMAILMaker&view=ComposeEmail&mode=emailPreview&record="+templateid+"&relatedLoad=true"; 
}
jQuery(document).ready(function() {
    var moduleName = app.getModuleName();		
    if(moduleName == 'Campaigns'){
        if (typeof(Vtiger_List_Js) != 'undefined'){
            Vtiger_List_Js.triggerSendEmail = function (massActionUrl, module, params) {
                var formodule = '';
                var pairs = massActionUrl.substring(massActionUrl.indexOf('?') + 1).split('&');
                for (var i = 0; i < pairs.length; i++) {
                  var pair = pairs[i].split('=');
                  if (decodeURIComponent(pair[0]) == 'module') formodule = decodeURIComponent(pair[1]);
                }
                javascript:EMAILMaker_Actions_Js.getCampaignsListViewPopup(formodule,params['sourceRecord']);
            };
        }
    }
})