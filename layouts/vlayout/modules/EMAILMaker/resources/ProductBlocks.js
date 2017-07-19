/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

if (typeof(EMAILMaker_ProductBlocks_Js) == 'undefined'){

    EMAILMaker_ProductBlocks_Js = {
	saveProductBlock : function(form){		
            var thisInstance = this;
		var data = form.serializeFormData();
		var progressIndicatorElement = jQuery.progressIndicator({
				'position' : 'html',
				'blockInfo' : {
					'enabled' : true
				}
			});
		
		if(typeof data == 'undefined' ){
			data = {};
		}
		data.module = app.getModuleName();
		data.action = 'IndexAjax';
                data.mode = 'SaveProductBlock';
	},
	registerEditViewEvents : function(){
		var thisInstance = this;
		var form = jQuery('#EditView');
		
		//register validation engine
		var params = app.validationEngineOptions;
		params.onValidationComplete = function(form, valid){
                    if(valid) {
				return valid;
			}
		}
		form.validationEngine(params);
		form.submit(function(e) {
		})
	},
	registerEvents: function() {
		var thisInstance = this;
		thisInstance.registerEditViewEvents();
   	}
    }
}