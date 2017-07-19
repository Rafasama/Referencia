/*********************************************************************************
 * The content of this file is subject to the ListView Colors 4 You license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

EMAILMaker_EditME_Js("EMAILMaker_EditME3_Js",{},{	
	init : function() {
            this.initialize();
	},
	getContainer : function() {
            return this.step3Container;
	},
	setContainer : function(element) {
            this.step3Container = element;
            return this;
	},	
	initialize : function(container) {
            if(typeof container == 'undefined') {
                    container = jQuery('#massemail_step3');
            }
            if(container.is('#massemail_step3')) {
                    this.setContainer(container);
            }else{
                    this.setContainer(jQuery('#massemail_step3'));
            }
 	},	
	loadEmailThemes : function(pInstance, stepVal, nextStepVal ){
                var thisInstance = this;
                var aDeferred = jQuery.Deferred();
                var container = this.getContainer();
                jQuery("#EditMassEmail").find('[type="submit"]').attr('disabled','disabled');
                var templateid = jQuery("#emailtemplateid").val();
                selectedModule = jQuery(".forModule").val();
                var params = {
                        module : app.getModuleName(),
                        action : 'IndexAjax',
                        source_module : selectedModule,
                        mode : 'getEmailTemplatesForModule',
                        templateid : templateid,
                }
                var progressIndicatorElement = jQuery.progressIndicator({
                        'position' : 'html',
                        'blockInfo' : {
                                'enabled' : true
                        }
                });
                var actionParams = {
                    "type": "POST",
                    "url": 'index.php',
                    "dataType": "html",
                    "data": params
                };
                AppConnector.request(actionParams).then(function(data){
                        container.html(data);
                        var selectedemailtemplateid = jQuery('#emailtemplateid').val();     
                        if (selectedemailtemplateid != ""){
                            if(jQuery('#EmailTemplateHeader'+selectedemailtemplateid).length) {
                                 jQuery("#EditMassEmail").find('[type="submit"]').removeAttr('disabled');
                            }
                        }
                        container.find(".EmailTemplatePreview").each(function (i, ob) { 
                            jQuery(ob).on('click',function(e){
                                var templateid = jQuery(e.currentTarget).data('templateid');
                                thisInstance.showPreviewModal(templateid);
                            });
                        });
                        container.find(".EmailTemplateSelect").each(function (i, ob) { 
                            jQuery(ob).on('click',function(e){
                                var templateid = jQuery(e.currentTarget).data('templateid');
                                
                                thisInstance.selectEmailTemplate(pInstance, templateid);
                            });
                        });
                        progressIndicatorElement.progressIndicator({'mode':'hide'});
                        pInstance.loadStepContent(stepVal, nextStepVal);
                });        
  		return aDeferred.promise();
	},
        selectEmailTemplate : function(pInstance, templateid){
                var thisInstance = this;
                var container = this.getContainer();
                container.find(".EmailTemplateSelect").each(function (i, ob) { 
                    jQuery(ob).removeClass('blockHeader');
                    jQuery(ob).addClass('tableHeading');
                });
                var SelectedEmailTemplate = jQuery('#EmailTemplateHeader' + templateid);
                SelectedEmailTemplate.removeClass('tableHeading');
                SelectedEmailTemplate.addClass('blockHeader');
                jQuery('#emailtemplateid').val(templateid);
                setTimeout(function() { 
                    jQuery("#EditMassEmail").find('[type="submit"]').removeAttr('disabled');
                    var step = pInstance.getStepValue();
                    var nextStep = parseInt(step) + 1;
                    pInstance.initiateStep(nextStep);
                    pInstance.loadStepContent(step, nextStep);
                
                }, 300);
        },
        showPreviewModal : function(templateid){
                var params = {
                        module : app.getModuleName(),
                        action : 'IndexAjax',
                        templateid : templateid,
                        mode : 'getEmailTemplatePreview'
                }
                var progressIndicatorElement = jQuery.progressIndicator({
                        'position' : 'html',
                        'blockInfo' : {
                                'enabled' : true
                        }
                });
                var actionParams = {
                        "type": "POST",
                        "url": 'index.php',
                        "dataType": "html",
                        "data": params
                };
                AppConnector.request(actionParams).then(function(data){
                        progressIndicatorElement.progressIndicator({'mode':'hide'});
                        
                        app.showModalWindow(data);
                });     
        },
        setStepValue : function(step){
		var form = jQuery("#EditMassEmail");; 
		return jQuery('.step',form).val(step);
	},        
        activateHeader : function(step) {
		var headersContainer = jQuery('.crumbs ');
		headersContainer.find('.active').removeClass('active');
		jQuery('#'+step,headersContainer).addClass('active');
	},
	registerEvents : function(){
		var container = this.getContainer();
	}
});