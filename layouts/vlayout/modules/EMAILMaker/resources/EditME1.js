/*********************************************************************************
 * The content of this file is subject to the ListView Colors 4 You license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

EMAILMaker_EditME_Js("EMAILMaker_EditME1_Js",{},{
	
	init : function() {
		this.initialize();
	},
	getContainer : function() {
		return this.step1Container;
	},
	setContainer : function(element) {
		this.step1Container = element;
		return this;
	},	
	initialize : function(container) {
            if(typeof container == 'undefined') {
                    container = jQuery('#massemail_step1');
            }
            if(container.is('#massemail_step1')) {
                    this.setContainer(container);
            }else{
                    this.setContainer(jQuery('#massemail_step1'));
            }
 	},	
	submit : function(){
	},	
	registerEvents : function(){
            var container = this.getContainer();
            jQuery("#EditMassEmail").find('[type="submit"]').removeAttr('disabled');
            var opts = app.validationEngineOptions;
            opts['onValidationComplete'] = function(form,valid) {
                return valid;
            };
            opts['promptPosition'] = "bottomRight";
            jQuery("#EditMassEmail").validationEngine(opts);
	}
});