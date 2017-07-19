/*********************************************************************************
 * The content of this file is subject to the ListView Colors 4 You license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

EMAILMaker_EditME_Js("EMAILMaker_EditME5_Js",{},{
	
	init : function() {
		this.initialize();
	},
	getContainer : function() {
		return this.step5Container;
	},
	setContainer : function(element) {
		this.step5Container = element;
		return this;
	},	
	initialize : function(container) {
            if(typeof container == 'undefined') {
                    container = jQuery('#massemail_step5');
            }
            if(container.is('#massemail_step5')) {
                    this.setContainer(container);
            }else{
                    this.setContainer(jQuery('#massemail_step5'));
            }
 	},	
	submit : function(){
	}, 
        loadSummaryContent : function(form){
                var thisInstance = this;
                var aDeferred = jQuery.Deferred();
                var container = this.getContainer();
                //jQuery("#EditMassEmail").find('[type="submit"]').attr('disabled','disabled');
                var formData = form.serializeFormData();
                var params = {
                        module : app.getModuleName(),
                        view : 'IndexAjax',
                        mode : 'showMESummary',
                        data : formData
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
                        progressIndicatorElement.progressIndicator({'mode':'hide'});
                        aDeferred.resolve();
                });        
  		return aDeferred.promise();
	},
	registerEvents : function(){
            var container = this.getContainer();
	}
});