/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

jQuery.Class('EMAILMaker_Buttons_Js', {
}, {
	updateModuleLinks : function(currentTarget) {
		var aDeferred = jQuery.Deferred();
		var forModule = currentTarget.data('module');
                var linktype = currentTarget.data('linktype');
		var status = currentTarget.is(':checked');
		var progressIndicatorElement = jQuery.progressIndicator({
				'position' : 'html',
				'blockInfo' : {
					'enabled' : true
				}
			});
		var params = {}
		params['module'] = app.getModuleName();
		params['updateType'] = status;
		params['forModule'] = forModule
		params['action'] = 'IndexAjax';
                params['linkType'] = linktype;
                params['mode'] = 'updateLinkForModule';            
		AppConnector.request(params).then(
			function(data) {
                                progressIndicatorElement.progressIndicator({'mode' : 'hide'});
				aDeferred.resolve(data);
			},
			function(error) {
				progressIndicatorElement.progressIndicator({'mode' : 'hide'});
				aDeferred.reject(error);
			}
		);
		return aDeferred.promise();
	},
	showNotify : function(customParams) {
		var params = {
			title : app.vtranslate('JS_MESSAGE'),
			text: customParams.text,
			animation: 'show',
			type: 'info'
		};
		Vtiger_Helper_Js.showPnotify(params);
	},
	registerEventForModulesList : function(e){
                var thisInstance = this;
		var container = jQuery('#EMAILMakerButtonsContainer');
		container.on('click', '[name="moduleEMAILMakerLink"]', function(e){
			var currentTarget = jQuery(e.currentTarget);
			var forModule = currentTarget.data('moduleTranslation');			
			if(currentTarget.is(':checked')){
				thisInstance.updateModuleLinks(currentTarget).then(
					function(data) {
						var params = {
							text: forModule+' '+app.vtranslate('JS_MODULE_ENABLED')
						}
						thisInstance.showNotify(params);
					}
				);
			} else {
				thisInstance.updateModuleLinks(currentTarget).then(
					function(data) {
						var params = {
							text: forModule+' '+app.vtranslate('JS_MODULE_DISABLED')
						}
						thisInstance.showNotify(params);
					}
				);
			}			
		});
	},        
        registerEvents : function(){
            var thisInstance = this;
            this.registerEventForModulesList();
        }        
});