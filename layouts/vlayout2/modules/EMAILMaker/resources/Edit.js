/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
Vtiger_Edit_Js("EMAILMaker_Edit_Js",{
    duplicateCheckCache : {},
    formElement : false,
    advanceFilterInstance : false,
    
    getForm : function(){
        if(this.formElement == false){
                this.setForm(jQuery('#EditView'));
        }
        return this.formElement;
    },
    setForm : function(element){
        this.formElement = element;
        return this;
    },    
    calculateValues : function(){
        if(this.advanceFilterInstance) {
            var advfilterlist = this.advanceFilterInstance.getValues();
            jQuery('#advanced_filter').val(JSON.stringify(advfilterlist));
        }
    },
    registerRecordPreSaveEvent : function(form){
        var thisInstance = this;
        if(typeof form == 'undefined'){
                form = this.getForm();
        }
        form.on(Vtiger_Edit_Js.recordPreSave, function(e, data){
            var email_name = document.getElementById("templatename").value;
            var error = 0;
            if (email_name == ""){
                var is_theme = jQuery("#is_theme").val()
                if (is_theme == "0"){
                    name_lang = app.vtranslate("LBL_EMAIL_NAME");
                } else {
                    name_lang = app.vtranslate("LBL_THEME_NAME");
                }
                alert(name_lang + app.vtranslate('CANNOT_BE_EMPTY'));
                error++;
            }
            if (!EMAILMaker_EditJs.CheckSharing()){
                error++;
            }

            if (error == 0){       
                return true;
            }     
            
            e.preventDefault();
        })
    },    
    registerBasicEvents: function(container){
        this._super(container);
        this.registerRecordPreSaveEvent();
    },    
    registerSubmitEvent: function(){
        var thisInstance = this;
        var editViewForm = this.getForm();
        editViewForm.submit(function(e){
            if(typeof editViewForm.data('submit') != "undefined"){
                    return false;
            } else {
                thisInstance.calculateValues();
                editViewForm.data('submit', 'true');
                var recordPreSaveEvent = jQuery.Event(Vtiger_Edit_Js.recordPreSave);
                editViewForm.trigger(recordPreSaveEvent, {'value' : 'edit'});
                if(recordPreSaveEvent.isDefaultPrevented()) {
                        editViewForm.removeData('submit');
                        e.preventDefault();
                }
            }
        });
    },

    registerSelectModuleOption : function() {
        var thisInstance = this;
        var selectElement = jQuery('[name="modulename"]');
        selectElement.on('change', function() {
            
            if (selected_module != '') {
                question = confirm(app.vtranslate("LBL_CHANGE_MODULE_QUESTION"));
                if (question) {
                    var oEditor = CKEDITOR.instances.body;
                    oEditor.setData("");
                } else {
                    //selectElement.val(selected_module);
                    
                    //app.destroyChosenElement(selectElement);
                    //var formElement = thisInstance.getForm();
                    //app.changeSelectElementView(formElement); 
                    return;
                }
            }   
            
            var selectedOption = selectElement.find('option:selected');
            var moduleName = selectedOption.val();

            thisInstance.getFields(moduleName,"modulefields","");
            thisInstance.updateModuleConditions(moduleName);
            
            EMAILMaker_EditJs.fill_module_lang_array(moduleName);
            EMAILMaker_EditJs.fill_related_blocks_array(moduleName);
            EMAILMaker_EditJs.fill_module_product_fields_array(moduleName);
            
        });		
    },
    
    registerSelectRecipientModuleOption : function() {
        var thisInstance = this;
        var selectElement = jQuery('[name="r_modulename"]');
        selectElement.on('change', function() {            
                    
            //app.destroyChosenElement(selectElement);
            var selectedOption = selectElement.find('option:selected');
            var moduleName = selectedOption.val();
            thisInstance.getFields(moduleName,"recipientmodulefields","");
            
            //var formElement = thisInstance.getForm();
            //app.changeSelectElementView(formElement); 
            
        });		
    },
    
    updateModuleConditions : function(moduleName) {

            var params = {
                            module : app.getModuleName(),
                            view : 'IndexAjax',
                            source_module : moduleName,
                            mode : 'getModuleConditions'
            }
            var actionParams = {
                "type": "POST",
                "url": 'index.php',
                "dataType": "html",
                "data": params
            };
            AppConnector.request(actionParams).then(function(data){
                    jQuery('#advanceFilterContainer').html(data);

                    var container = jQuery('#display_div');
                    this.advanceFilterInstance = Vtiger_AdvanceFilter_Js.getInstance(jQuery('.filterContainer',container));
                    
                    jQuery("#display_tab").show();
            });
    },    
    
    registerSelectRelatedModuleOption : function() {
        var thisInstance = this;
        var selectElement = jQuery('[name="relatedmodulesorce"]');
        selectElement.on('change', function() {
            var selectedOption = selectElement.find('option:selected');
            var moduleName = selectedOption.data('module');
            var fieldName = selectedOption.val();
            
            thisInstance.getFields(moduleName,"relatedmodulefields",fieldName);
        });		
    },
    
    getFields : function(moduleName,selectname,fieldName) {
        var thisInstance = this;
        

        var urlParams = {
            "module": "EMAILMaker",
            "formodule" : moduleName,
            "forfieldname" : fieldName,
            "action" : "IndexAjax",
            "mode" : "getModuleFields"            
        }

        AppConnector.request(urlParams).then(
            function(data){
                thisInstance.updateFields(data,selectname);
            }      
        );
    },
    
    updateFields: function(data,selectname){
        var thisInstance = this;
        var response = data['result'];
        var result = response['success'];
        var formElement = this.getForm();
        
        if(result == true) {

            var ModuleFieldsElement = jQuery('#'+selectname);
            ModuleFieldsElement.find('option:not([value=""]').remove();
            ModuleFieldsElement.find('optgroup').remove();
            
            if (selectname == "subject_fields") {
            
                jQuery.each(response['subject_fields'], function (i, fields) {

                    var optgroup = jQuery('<optgroup/>');
                    optgroup.attr('label',i);

                    jQuery.each(fields, function (key, field) {

                        optgroup.append(jQuery('<option>', { 
                            value: key,
                            text : field 
                        }));
                    })

                    ModuleFieldsElement.append(optgroup);
                });                   
            }
            
            
            jQuery.each(response['fields'], function (i, fields) {

                var optgroup = jQuery('<optgroup/>');
                optgroup.attr('label',i);

                jQuery.each(fields, function (key, field) {

                    optgroup.append(jQuery('<option>', { 
                        value: key,
                        text : field 
                    }));
                })

                ModuleFieldsElement.append(optgroup);
            });

            app.destroyChosenElement(ModuleFieldsElement);
            app.changeSelectElementView(formElement); 
            
            if (selectname == "modulefields") {                        

                var RelatedModuleSourceElement = jQuery('#relatedmodulesorce');
                RelatedModuleSourceElement.find('option:not([value=""]').remove();
                jQuery.each(response['related_modules'], function (i, item) {

                    RelatedModuleSourceElement.append(jQuery('<option>', { 
                        value: item[0],
                        text : item[2] + " (" + item[1] + ")",
                    }).data("module",item[3]));
                });

                app.destroyChosenElement(RelatedModuleSourceElement);
                app.changeSelectElementView(formElement); 
                thisInstance.updateFields(data,"subject_fields");
            } 

            
        }
    },
    
    registerEvents: function(){
        var editViewForm = this.getForm();
        var statusToProceed = this.proceedRegisterEvents();
        if(!statusToProceed){
                return;
        }

        var container = jQuery('#display_div');
        if (container.length > 0){
            this.advanceFilterInstance = Vtiger_AdvanceFilter_Js.getInstance(jQuery('.filterContainer',container));
            container.hide();
        }

        this.registerBasicEvents(this.getForm());
        this.registerSelectRecipientModuleOption();
        this.registerSelectModuleOption();
        this.registerSelectRelatedModuleOption();
        this.registerSubmitEvent();
        
        if (typeof this.registerLeavePageWithoutSubmit == 'function'){
            this.registerLeavePageWithoutSubmit(editViewForm);
        }             
    }

});

if (typeof(EMAILMaker_EditJs) == 'undefined'){
    EMAILMaker_EditJs = {
        reportsColumnsList : false,
        advanceFilterInstance : false,
        availListObj : false,
        selectedColumnsObj : false,
        myCodeMirror : false,
        clearRelatedModuleFields: function() {
            second = document.getElementById("relatedmodulefields");
            lgth = second.options.length - 1;
            second.options[lgth] = null;
            if (second.options[lgth])
                optionTest = false;
            if (!optionTest)
                return;
            var box2 = second;
            var optgroups = box2.childNodes;
            for (i = optgroups.length - 1; i >= 0; i--) {
                box2.removeChild(optgroups[i]);
            }
            objOption = document.createElement("option");
            objOption.innerHTML = app.vtranslate("LBL_SELECT_MODULE_FIELD");
            objOption.value = "";
            box2.appendChild(objOption);
        },
        change_relatedmodulesorce: function(first, second_name){
            second = document.getElementById(second_name);
            optionTest = true;
            lgth = second.options.length - 1;
            second.options[lgth] = null;
            if (second.options[lgth])
                optionTest = false;
            if (!optionTest)
                return;
            var box = first;
            var number = box.options[box.selectedIndex].value;
            
            if (!number)
                return;

             var params = {
                            module : app.getModuleName(),
                            view : 'IndexAjax',
                            source_module : number,
                            mode : 'getModuleConditions'
            }
            var actionParams = {
                "type": "POST",
                "url": 'index.php',
                "dataType": "html",
                "data": params
            };
            AppConnector.request(actionParams).then(function(data){
                    jQuery('#advanceFilterContainer').html(data);

                    var container = jQuery('#display_div');
                    this.advanceFilterInstance = Vtiger_AdvanceFilter_Js.getInstance(jQuery('.filterContainer',container));
                    
                    jQuery("#display_tab").show();
            });
            
            var box2 = second;
            var optgroups = box2.childNodes;
            for (i = optgroups.length - 1; i >= 0; i--){
                box2.removeChild(optgroups[i]);
            }
            var list = all_related_modules[number];
            for (i = 0; i < list.length; i += 2){
                objOption = document.createElement("option");
                objOption.innerHTML = list[i];
                objOption.value = list[i + 1];
                box2.appendChild(objOption);
            }
            EMAILMaker_EditJs.clearRelatedModuleFields();
        },
        change_relatedmodule: function(first, second_name){
            second = document.getElementById(second_name);
            optionTest = true;
            lgth = second.options.length - 1;
            second.options[lgth] = null;
            if (second.options[lgth])
                optionTest = false;
            if (!optionTest)
                return;
            var box = first;
            var number = box.options[box.selectedIndex].value;
            if (!number)
                return;
            var box2 = second;
            var optgroups = box2.childNodes;
            for (i = optgroups.length - 1; i >= 0; i--){
                box2.removeChild(optgroups[i]);
            }
            if (number == "none"){
                objOption = document.createElement("option");
                objOption.innerHTML = app.vtranslate("LBL_SELECT_MODULE_FIELD");
                objOption.value = "";
                box2.appendChild(objOption);
            } else {
                var tmpArr = number.split('|', 2);
                var moduleName = tmpArr[0];
                number = tmpArr[1];
                var blocks = module_blocks[moduleName];
                for (b = 0; b < blocks.length; b += 2) {
                    var list = related_module_fields[moduleName + '|' + blocks[b + 1]];
                    if (list.length > 0) {
                        optGroup = document.createElement('optgroup');
                        optGroup.label = blocks[b];
                        box2.appendChild(optGroup);
                        for (i = 0; i < list.length; i += 2) {
                            objOption = document.createElement("option");
                            objOption.innerHTML = list[i];
                            var objVal = list[i + 1];
                            objOption.value = objVal;
                            optGroup.appendChild(objOption);
                        }
                    }
                }
            }
        },
        change_acc_info: function(element){            
            jQuery('.au_info_div').css('display','none');            
            switch (element.value){
                case "Assigned":
                    var div_name = 'user_info_div';
                    break;
                case "Logged":
                    var div_name = 'logged_user_info_div';
                    break;
                case "Modifiedby":
                    var div_name = 'modifiedby_user_info_div';
                    break; 
                case "Creator":
                    var div_name = 'smcreator_user_info_div';
                    break; 
                default:
                    var div_name = 'acc_info_div';
                    break;
            }            
            jQuery('#'+div_name).css('display','inline');
        },
        ControlNumber: function(elid, final){
            var control_number = document.getElementById(elid).value;
            var re = new Array();
            re[1] = new RegExp("^([0-9])");
            re[2] = new RegExp("^[0-9]{1}[.]$");
            re[3] = new RegExp("^[0-9]{1}[.][0-9]{1}$");
            if (control_number.length > 3 || !re[control_number.length].test(control_number) || (final == true && control_number.length == 2)) {
                alert(app.vtranslate("LBL_MARGIN_ERROR"));
                document.getElementById(elid).focus();
                return false;
            } else {
                return true;
            }
        },
        showHideTab: function(tabname){            
            var selectedTab = jQuery("#selectedTab").val();

            jQuery('#' + selectedTab + '_tab').removeClass("active");
            jQuery('#' + tabname + '_tab').addClass("active");
            
            jQuery('#' + selectedTab + '_div').hide();
            jQuery('#' + tabname + '_div').show();
            
            
            var formerTab = selectedTab;
            var selectedTab = tabname;
            jQuery("#selectedTab").val(selectedTab);
            
            jQuery('#' + tabname + '_div').find(".chzn-select").each(function(index,element){
                    var selectElement = jQuery(element);
                    app.destroyChosenElement(selectElement);
            });
            
            var formElement = jQuery('#EditView');
            app.changeSelectElementView(formElement); 
            
        },
        
        showHideTab2: function(tabname){
            var selectedTab2 = jQuery("#selectedTab2").val();
            jQuery('#' + selectedTab2 + '_tab2').removeClass("active");
            jQuery('#' + tabname + '_tab2').addClass("active");
            
            jQuery('#' + selectedTab2 + '_div2').hide();
            jQuery('#' + tabname + '_div2').show();

            this.registerCodeMirror();

            var selectedTab2 = tabname;
            jQuery("#selectedTab2").val(selectedTab2);
        },
        registerCodeMirror: function(){
            if (this.myCodeMirror == false) {
                jQuery('#css_style_div2').find(".CodeMirror").each(function(index,element){
                    var TextAreaID = jQuery(element).attr("id");
                    var myTextArea = document.getElementById(TextAreaID);
                    CodeMirror.fromTextArea(myTextArea,{
                        height: "dynamic",
                        lineNumbers: true,
                        styleActiveLine: true,
                        matchBrackets: true,
                        readOnly: true
                      });
                });                
                this.myCodeMirror = true
            }
        },
        fill_module_lang_array: function(module, selected){
            
            var urlParams = {
                "module" : "EMAILMaker",
                "handler" : "fill_lang",
                "action" : "AjaxRequestHandle",
                "langmod" : module            
            }

            AppConnector.request(urlParams).then(function(data){

                var response = data['result'];
                var result = response['success'];

                if(result == true) {    
                    var moduleLangElement = jQuery('#module_lang');
                    moduleLangElement.find('option:not([value=""]').remove();

                    app.destroyChosenElement(moduleLangElement);

                    jQuery.each(response['labels'], function (key, langlabel) {
     
                         moduleLangElement.append(jQuery('<option>', { 
                                    value: key,
                                    text : langlabel
                        }));
                    })

                    var formElement = jQuery('#EditView');
                    app.changeSelectElementView(formElement); 
                }
            })
        },
fill_related_blocks_array: function(module, selected){
            
            var urlParams = {
                "module" : "EMAILMaker",
                "handler" : "fill_relblocks",
                "action" : "AjaxRequestHandle",
                "selmod" : module            
            }

            AppConnector.request(urlParams).then(function(data){

                var response = data['result'];
                var result = response['success'];

                if(result == true) {    
                    var relatedBlockElement = jQuery('#related_block');
                    relatedBlockElement.find('option:not([value=""]').remove();

                    app.destroyChosenElement(relatedBlockElement);

                    jQuery.each(response['relblocks'], function (key, blockname) {
     
                        if (selected != undefined && key == selected) {
                            var is_selected = true;
                        } else {
                            var is_selected = false;
                        }
                        relatedBlockElement.append(jQuery('<option>', { 
                                    value: key,
                                    text : blockname
                        }).attr("selected",is_selected));
                    })

                    var formElement = jQuery('#EditView');
                    app.changeSelectElementView(formElement); 
                }
            })
        },
        fill_module_product_fields_array: function(module){
            var ajax_url = 'index.php?module=EMAILMaker&action=AjaxRequestHandle&handler=fill_module_product_fields&productmod=' + module;
            jQuery.ajax(ajax_url).success(function(response){

                var product_fields = document.getElementById('psfields');
                product_fields.length = 0;
                var map = response.split('|@|');
                var keys = map[0].split('||');
                var values = map[1].split('||');
                for (i = 0; i < values.length; i++){
                    var item = document.createElement('option');
                    item.text = values[i];
                    item.value = keys[i];
                    try {
                        product_fields.add(item, null);
                    } catch (ex){
                        product_fields.add(item);
                    }
                }
            }).error(function(){
                alert('fill_module_product_fields_array error');
            });
        },
        refresh_related_blocks_array: function(selected){
            var module = document.getElementById('modulename').value;
            EMAILMaker_EditJs.fill_related_blocks_array(module, selected);
        },
        InsertRelatedBlock: function(){
            var relblockid = document.getElementById('related_block').value;
            if (relblockid == '')
                return false;
            var oEditor = CKEDITOR.instances.body;
            var ajax_url = 'index.php?module=EMAILMaker&action=AjaxRequestHandle&handler=get_relblock&relblockid=' + relblockid;
            jQuery.ajax(ajax_url).success(function(response){
                oEditor.insertHtml(response);
            }).error(function(){
                alert('error');
            });
        },
        EditRelatedBlock: function(){
            var relblockid = document.getElementById('related_block').value;
            if (relblockid == ''){
                alert(app.vtranslate('LBL_SELECT_RELBLOCK'));
                return false;
            }

            var popup_url = 'index.php?module=EMAILMaker&view=EditRelatedBlock&record=' + relblockid;
            window.open(popup_url, "Editblock", "width=1230,height=700,scrollbars=yes");
        },
        CreateRelatedBlock: function(){
            var email_module = document.getElementById("modulename").value;
            if (email_module == ''){
                alert(app.vtranslate("LBL_MODULE_ERROR"));
                return false;
            }
            var popup_url = 'index.php?module=EMAILMaker&view=EditRelatedBlock&emailmodule=' + email_module;
            window.open(popup_url, "Editblock", "width=1230,height=700,scrollbars=yes");
        },
        DeleteRelatedBlock: function(){
            var relblockid = document.getElementById('related_block').value;
            var result = false;
            if (relblockid == ''){
                alert(app.vtranslate('LBL_SELECT_RELBLOCK'));
                return false;
            } else {
                result = confirm(app.vtranslate('LBL_DELETE_RELBLOCK_CONFIRM') + jQuery("#related_block option:selected").text());
            }

            if (result){
                var ajax_url = 'index.php?module=EMAILMaker&action=AjaxRequestHandle&handler=delete_relblock&relblockid=' + relblockid;
                jQuery.ajax(ajax_url).success(function(){
                    EMAILMaker_EditJs.refresh_related_blocks_array();
                }).error(function(){
                    alert('DeleteRelatedBlock error');
                });
            }
        },
        CustomFormat: function(){
            var selObj;
            selObj = document.getElementById('email_format');
            if (selObj.value == 'Custom'){
                document.getElementById('custom_format_table').style.display = 'table';
            } else {
                document.getElementById('custom_format_table').style.display = 'none';
            }
        },
         isLvTmplClicked: function(source){
            var oTrigger = document.getElementById('isListViewTmpl');
            var oButt = jQuery("#listviewblocktpl_butt");
            var oDlvChbx = document.getElementById('is_default_dv');

            var listViewblockTPLElement = jQuery("#listviewblocktpl");

            app.destroyChosenElement(listViewblockTPLElement);
            
            listViewblockTPLElement.attr("disabled",!(oTrigger.checked));

            var formElement = jQuery('#EditView');
            app.changeSelectElementView(formElement); 

            oButt.attr("disabled",!(oTrigger.checked));

            if (source != 'init'){
                oDlvChbx.checked = false;
            }
            
            oDlvChbx.disabled = oTrigger.checked;
        },
        hf_checkboxes_changed: function(oChck, oType){
            var prefix;
            var optionsArr;
            if (oType == 'header'){
                prefix = 'dh_';
                optionsArr = new Array('allid', 'firstid', 'otherid');
            } else {
                prefix = 'df_';
                optionsArr = new Array('allid', 'firstid', 'otherid', 'lastid');
            }
            var tmpArr = oChck.id.split("_");
            var sufix = tmpArr[1];
            var i;
            if (sufix == 'allid') {
                for (i = 0; i < optionsArr.length; i++){
                    document.getElementById(prefix + optionsArr[i]).checked = oChck.checked;
                }
            } else {
                var allChck = document.getElementById(prefix + 'allid');
                var allChecked = true;
                for (i = 1; i < optionsArr.length; i++){
                    if (document.getElementById(prefix + optionsArr[i]).checked == false){
                        allChecked = false;
                        break;
                    }
                }
                allChck.checked = allChecked;
            }
        },
        templateActiveChanged: function(activeElm){
            var is_defaultElm1 = document.getElementById('is_default_dv');
            var is_defaultElm2 = document.getElementById('is_default_lv');
            if (activeElm.value == '1') {
                is_defaultElm1.disabled = false;
                is_defaultElm2.disabled = false;
            } else {
                is_defaultElm1.checked = false;
                is_defaultElm1.disabled = true;
                is_defaultElm2.checked = false;
                is_defaultElm2.disabled = true;
            }
        },
        CheckSharing: function(){
            if (document.getElementById('sharing').value == 'share'){
                var selColStr = '';
                var selColObj = document.getElementById('sharingSelectedColumns');
                for (i = 0; i < selColObj.options.length; i++){
                    selColStr += selColObj.options[i].value + ';';
                }
                if (selColStr == ''){
                    alert(app.vtranslate('LBL_SHARING_ERROR'));
                    document.getElementById('sharingAvailList').focus();
                    return false;
                }
                document.getElementById('sharingSelectedColumnsString').value = selColStr;
            }
            return true;
        },
        sharing_changed: function(){
            var selectedValue = document.getElementById('sharing').value;
            if (selectedValue != 'share') {
                document.getElementById('sharing_share_div').style.display = 'none';
            } else {
                document.getElementById('sharing_share_div').style.display = 'block';
                EMAILMaker_EditJs.setSharingObjects();
                EMAILMaker_EditJs.showSharingMemberTypes();
            }
        },
        showSharingMemberTypes: function(){
            var selectedOption = document.getElementById('sharingMemberType').value;
            //Completely clear the select box
            document.getElementById('sharingAvailList').options.length = 0;
            if (selectedOption == 'groups'){
                EMAILMaker_EditJs.constructSelectOptions('groups', grpIdArr, grpNameArr);
            } else if (selectedOption == 'roles'){
                EMAILMaker_EditJs.constructSelectOptions('roles', roleIdArr, roleNameArr);
            } else if (selectedOption == 'rs'){
                EMAILMaker_EditJs.constructSelectOptions('rs', roleIdArr, roleNameArr);
            } else if (selectedOption == 'users'){
                EMAILMaker_EditJs.constructSelectOptions('users', userIdArr, userNameArr);
            }
        },
        constructSelectOptions: function(selectedMemberType, idArr, nameArr){
            var i;
            var findStr = document.getElementById('sharingFindStr').value;
            if (findStr.replace(/^\s+/g, '').replace(/\s+$/g, '').length != 0) {
                var k = 0;
                for (i = 0; i < nameArr.length; i++) {
                    if (nameArr[i].indexOf(findStr) == 0) {
                        constructedOptionName[k] = nameArr[i];
                        constructedOptionValue[k] = idArr[i];
                        k++;
                    }
                }
            } else {
                constructedOptionValue = idArr;
                constructedOptionName = nameArr;
            }

            var j;
            var nowNamePrefix;
            for (j = 0; j < constructedOptionName.length; j++){
                if (selectedMemberType == 'roles') {
                    nowNamePrefix = 'Roles::';
                } else if (selectedMemberType == 'rs'){
                    nowNamePrefix = 'RoleAndSubordinates::';
                } else if (selectedMemberType == 'groups'){
                    nowNamePrefix = 'Group::';
                } else if (selectedMemberType == 'users'){
                    nowNamePrefix = 'User::';
                }
                var nowName = nowNamePrefix + constructedOptionName[j];
                var nowId = selectedMemberType + '::' + constructedOptionValue[j]
                document.getElementById('sharingAvailList').options[j] = new Option(nowName, nowId);
            }
            constructedOptionValue = new Array();
            constructedOptionName = new Array();
        },
        sharingAddColumn: function(){
            for (i = 0; i < this.selectedColumnsObj.length; i++){
                this.selectedColumnsObj.options[i].selected = false;
            }
            for (i = 0; i < this.availListObj.length; i++){
                if (this.availListObj.options[i].selected == true){
                    var rowFound = false;
                    var existingObj = null;
                    for (j = 0; j < this.selectedColumnsObj.length; j++){
                        if (this.selectedColumnsObj.options[j].value == this.availListObj.options[i].value){
                            rowFound = true;
                            existingObj = this.selectedColumnsObj.options[j];
                            break;
                        }
                    }
                    if (rowFound != true){
                        var newColObj = document.createElement("OPTION");
                        newColObj.value = this.availListObj.options[i].value;
                        newColObj.text = this.availListObj.options[i].text;
                        this.selectedColumnsObj.appendChild(newColObj);
                        this.availListObj.options[i].selected = false;
                        newColObj.selected = true;
                        rowFound = false;
                    } else {
                        if (existingObj != null)
                            existingObj.selected = true;
                    }
                }
            }
        },
        sharingDelColumn: function() {
            for (i = this.selectedColumnsObj.options.length; i > 0; i--) {
                if (this.selectedColumnsObj.options.selectedIndex >= 0)
                    this.selectedColumnsObj.remove(this.selectedColumnsObj.options.selectedIndex);
            }
        },
        setSharingObjects: function() {
            this.availListObj = document.getElementById("sharingAvailList");
            this.selectedColumnsObj = document.getElementById("sharingSelectedColumns");
        }      
    }    
}
EMAILMaker_EditJs.setSharingObjects();