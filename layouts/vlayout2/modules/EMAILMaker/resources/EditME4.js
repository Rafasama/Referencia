/*********************************************************************************
 * The content of this file is subject to the ListView Colors 4 You license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

EMAILMaker_EditME_Js("EMAILMaker_EditME4_Js",{},{
	
	init : function() {
		this.initialize();
	},
	getContainer : function() {
		return this.step4Container;
	},
	setContainer : function(element) {
		this.step4Container = element;
		return this;
	},	
	initialize : function(container) {
            if(typeof container == 'undefined') {
                    container = jQuery('#massemail_step4');
            }
            if(container.is('#massemail_step4')) {
                    this.setContainer(container);
            }else{
                    this.setContainer(jQuery('#massemail_step4'));
            }
 	},	
	registerEvents : function(){
            var container = this.getContainer();
	}
});