/*********************************************************************************
 * The content of this file is subject to the ListView Colors 4 You license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

EMAILMaker_EditME_Js("EMAILMaker_EditME2_Js",{},{
	
	init : function() {
            this.initialize();
	},
	getContainer : function() {
            return this.step2Container;
	},
	setContainer : function(element) {
            this.step2Container = element;
            return this;
	},
	initialize : function(container) {
            if(typeof container == 'undefined') {
                container = jQuery('#massemail_step2');
            }
            if(container.is('#massemail_step2')) {
                this.setContainer(container);
            }else{
                this.setContainer(jQuery('#massemail_step2'));
            }
 	},
	submit : function(){
	},
        registerChangeModuleEvent : function(data) {
            jQuery('.forModule',data).on('change',function(e){
                    var selectedModule =  jQuery(e.currentTarget).val();
                    var params = {
                            module : app.getModuleName(),
                            action : 'IndexAjax',
                            source_module : selectedModule,
                            mode : 'getFiltersForModule'
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
                            jQuery('#moduleFiltersContainer').html(data);
                            progressIndicatorElement.progressIndicator({'mode':'hide'});
                            app.changeSelectElementView(jQuery('#moduleFiltersContainer'));
                    });
            });
	},
        registerEvents : function(){
            var container = this.getContainer();
            app.changeSelectElementView(container);
            this.registerChangeModuleEvent(container);
	}
});