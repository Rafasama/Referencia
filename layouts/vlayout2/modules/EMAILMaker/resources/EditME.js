/*********************************************************************************
 * The content of this file is subject to the ListView Colors 4 You license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

Vtiger_Edit_Js("EMAILMaker_EditME_Js",{	
	instance : {}	
},{
	currentInstance : false,
	massemailContainer : false,	
	init : function() {
		this.initiate();
	},
	getContainer : function() {
		return this.massemailContainer;
	},
	setContainer : function(element) {
		this.massemailContainer = element;
		return this;
	},	
	getInstance : function(step) {
		if(step in EMAILMaker_EditME_Js.instance ){
			return EMAILMaker_EditME_Js.instance[step];
		} else {
			var moduleClassName = 'EMAILMaker_EditME'+step+'_Js' ;
			EMAILMaker_EditME_Js.instance[step] =  new window[moduleClassName]();
			return EMAILMaker_EditME_Js.instance[step]
		}
	},	
	getStepValue : function(){
		var form = jQuery("#EditMassEmail");; 
		return jQuery('.step',form).val();
	},	
        setStepValue : function(step){
		var form = jQuery("#EditMassEmail");; 
		return jQuery('.step',form).val(step);
	},        
	initiate : function(container){
		if(typeof container == 'undefined') {
			container = jQuery('.massemailContents');
		}
		if(container.is('.massemailContents')) {
			this.setContainer(container);
		}else{
			this.setContainer(jQuery('.massemailContents',container));
		}
		this.initiateStep('1');
		this.currentInstance.registerEvents();
	},
	initiateStep : function(stepVal) {		
                this.setStepValue(stepVal);            
                var step = 'step'+stepVal;
                this.activateHeader(step);
		var currentInstance = this.getInstance(stepVal);
		this.currentInstance = currentInstance;                
                var backStepEl = jQuery(".backStep");
                if (stepVal == "1") {
                    backStepEl.attr('disabled','disabled');
                } else {
                    backStepEl.removeAttr('disabled');                    
                }
                var fieldInfo = jQuery("#max_limit").data('fieldinfo');
                if (stepVal == "4") {
                    fieldInfo.type = "integer";
                } else {
                    fieldInfo.type = "";
                }
                if (stepVal != 3) jQuery("#EditMassEmail").find('[type="submit"]').removeAttr('disabled');
	},	
	activateHeader : function(step) {
		var headersContainer = jQuery('.crumbs ');
		headersContainer.find('.active').removeClass('active');
		jQuery('#'+step,headersContainer).addClass('active');
	},
	registerFormSubmitEvent : function() {
                form = jQuery("#EditMassEmail");
                var thisInstance = this;
                form.on('submit',function(e){
                        var form = jQuery(e.currentTarget);
                        var specialValidation = true;
                        if(jQuery.isFunction(thisInstance.currentInstance.isFormValidate)){
                                var specialValidation =  thisInstance.currentInstance.isFormValidate();
                        }
                        var stepVal = thisInstance.getStepValue();
                        var nextStepVal = parseInt(stepVal) + 1;

                        if ( form.validationEngine('validate') && specialValidation) {
                                if (nextStepVal != 6) {
                                    thisInstance.initiateStep(nextStepVal);
                                    thisInstance.currentInstance.initialize();
                                    thisInstance.currentInstance.registerEvents();
                                    if (nextStepVal == "3") {
                                        thisInstance.currentInstance.loadEmailThemes(thisInstance, stepVal, nextStepVal);
                                    } else if (nextStepVal == "5") {
                                        thisInstance.currentInstance.loadSummaryContent(form).then(function(){
                                            thisInstance.loadStepContent(stepVal, nextStepVal);
                                        })                                    
                                    } else {
                                        thisInstance.loadStepContent(stepVal, nextStepVal);
                                    }
                                }
                        }
                        if (nextStepVal != 6) e.preventDefault();
                })		
	},
        loadStepContent : function(hideStepVal, showStepVal) {
                jQuery("#massemail_step"+hideStepVal).addClass('hide');
                jQuery("#massemail_step"+showStepVal).removeClass('hide');
                
                var sendExampleEmailBTN = jQuery("#sendExampleEmail");
                
                if (showStepVal == "5") {
                    hideBtn = "nextStep";
                    showBtn = "saveBTN";
                    
                    sendExampleEmailBTN.removeClass('hide');
                } else {
                    hideBtn = "saveBTN";
                    showBtn = "nextStep";
                    
                    sendExampleEmailBTN.addClass('hide');
                }
                
                jQuery("."+hideBtn).addClass('hide');
                jQuery("."+showBtn).removeClass('hide');
                
                
        },        
	back : function(){
		var step = this.getStepValue();
		var prevStep = parseInt(step) - 1;
		this.initiateStep(prevStep);
                this.loadStepContent(step, prevStep);
	},	
	registerBackStepClickEvent : function(){
		var thisInstance = this;
		var container = this.getContainer();
		container.on('click','.backStep',function(e){
			thisInstance.back();
		});
	},
        
        registerSendExampleEmailBTNClickEvent : function(){
		var thisInstance = this;
		var container = this.getContainer();
		container.on('click','.sendExampleEmailBTN',function(e){
			thisInstance.showSEM();
		});
	},
        
        showSEM :  function(){
            var thisInstance = this;
            var ExmapleEmailContent = jQuery("#sendExmapleEmailContent").html();
            var callBackFunction = function(data) {
                    //cache should be empty when modal opened 
                    var form = jQuery('.sendExmapleEmailForm',data);
                    var params = app.validationEngineOptions;
                    params.onValidationComplete = function(form, valid){
                            if(valid){
                                    thisInstance.sendExampleEmailAction(form);
                                    return valid;
                            }
                    }
                    form.validationEngine(params);
                    form.submit(function(e){
                        e.preventDefault();
                    })
            }
            
            
            app.showModalWindow(ExmapleEmailContent, function (data) {
                if (typeof callBackFunction == 'function') {
                    callBackFunction(data);
                }
            });
        },
        
        sendExampleEmailAction : function(form){
            var aDeferred = jQuery.Deferred();
            var thisInstance = this;
            var progressIndicatorElement = jQuery.progressIndicator({
                'position' : 'html',
                'blockInfo' : {
                        'enabled' : true
                }
            });            
            var params = {};
            params.module = "EMAILMaker";
            params.action = "IndexAjax";
            params.mode = "sendExampleMEmail";
            params.type = "activate"; 
            var formME = jQuery('#EditMassEmail');
            params.datame = formME.serializeFormData();
            params.datap = form.serializeFormData();
            AppConnector.request(params).then(
                function(data) {
                    progressIndicatorElement.progressIndicator({'mode':'hide'});
                    var response = data['result'];
                    var result = response['success'];
                    var params = {text : response['status']};
                    if(result == true) {                    
                        params.type = 'info'; 
                    } else {
                        params.type = 'error';
                    }

                    Vtiger_Helper_Js.showMessage(params);  
                    
                    
                },
                function(error) {
                    progressIndicatorElement.progressIndicator({'mode':'hide'});
                    aDeferred.reject(error);
                }
            );
            return aDeferred.promise();
	},    
    
	registerEvents : function(){
		this.registerFormSubmitEvent();
                this.registerBackStepClickEvent();
                this.registerSendExampleEmailBTNClickEvent();
                app.registerEventForDatePickerFields();
                app.registerEventForTimeFields(); 
	}
});

