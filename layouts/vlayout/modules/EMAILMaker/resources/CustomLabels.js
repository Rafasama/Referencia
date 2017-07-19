/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

if (typeof(EMAILMaker_CustomLabelsJs) == 'undefined') {

    EMAILMaker_CustomLabelsJs = {
        
	editCustomLabel : function(url, currentTrElement) {
		var aDeferred = jQuery.Deferred();
		var thisInstance = this;
		var progressIndicatorElement = jQuery.progressIndicator({
			'position' : 'html',
			'blockInfo' : {
				'enabled' : true
			}
		});		
		AppConnector.request(url).then(
			function(data) {
				var callBackFunction = function(data) {
					var form = jQuery('#editCustomLabel');
					var params = app.validationEngineOptions;
					params.onValidationComplete = function(form, valid){
						if(valid) {
							thisInstance.saveCustomLabelDetails(form, currentTrElement);
							return valid;
						}
					}
					form.validationEngine(params);
					form.submit(function(e) {
						e.preventDefault();
					})
				}
				progressIndicatorElement.progressIndicator({'mode':'hide'});
				app.showModalWindow(data,function(data){
					if(typeof callBackFunction == 'function'){
						callBackFunction(data);
					}
				}, {'width':'500px'});
			},
			function(error) {
				aDeferred.reject(error);
			}
		);
		return aDeferred.promise();
	},
        showCustomLabelValues : function(url){
		var thisInstance = this;		
		var progressIndicatorElement = jQuery.progressIndicator({
			'position' : 'html',
			'blockInfo' : {
				'enabled' : true
			}
		});
		AppConnector.request(url).then(
			function(data) {				
                            var callBackFunction = function(data) {
                                    var form = jQuery('#showCustomLabelValues');
                                    var params = app.validationEngineOptions;
                                    params.onValidationComplete = function(form, valid){
                                        if(valid) {
                                            thisInstance.saveCustomLabelValues(form);
                                            return valid;
                                        }
                                    }
                                    form.validationEngine(params);
                                    form.submit(function(e) {
                                            e.preventDefault();
                                    })     
				}
				progressIndicatorElement.progressIndicator({'mode':'hide'});
				app.showModalWindow(data,function(data){
					if(typeof callBackFunction == 'function'){
						callBackFunction(data);
					}
				}, {'width':'500px'});
			}
		);
	},
	saveCustomLabelDetails : function(form, currentTrElement){
		var thisInstance = this;
		var params = form.serializeFormData();
		if(typeof params == 'undefined' ) {
			params = {};
		}
		thisInstance.validateCustomLabelKey(params).then(
			function(data) {
				var progressIndicatorElement = jQuery.progressIndicator({
					'position' : 'html',
					'blockInfo' : {
						'enabled' : true
					}
				});
				params.module = app.getModuleName();
				params.action = 'IndexAjax';
                                params.mode = 'SaveCustomLabel';
                                
				AppConnector.request(params).then(
					function(data) {
						progressIndicatorElement.progressIndicator({'mode':'hide'});
						app.hideModalWindow();
						if(form.find('.addCustomLabelView').val() == "true") {
							thisInstance.addCustomLabelDetails(data['result']);
						} else {
							thisInstance.updateCustomLabelDetails(data['result'], currentTrElement);
						}
						var params = {
							text: app.vtranslate('JS_CUSTOM_LABEL_SAVED_SUCCESSFULLY')
						};
						thisInstance.showMessage(params);
					}
				);
			},
			function(data,err) {
			}
		);
	},
	addCustomLabelDetails : function(details){
            var container = jQuery('#CustomLabelsContainer');
            var CustomLabelTable = jQuery('.CustomLabelTable', container);
            total_tr = jQuery('#CustomLabelTable tr').length;
            next_chid = total_tr - 1;
            var trElementForCustomLabel = jQuery('<tr class="opacity"><td><input type="checkbox" name="chx_'+details.labelid+'" id="chx_'+next_chid+'"/></td><td><label class="CustomLabelKey textOverflowEllipsis">'+details.lblkey+'</label></td><td><label class="CustomLabelValue textOverflowEllipsis">'+details.lblval+'</label></td><td style="border-left: none;"><div class="pull-right actions"> <a class="editCustomLabel cursorPointer" data-url="?module=EMAILMaker&view=IndexAjax&mode=editCustomLabel&labelid='+details.labelid+'&langid='+details.langid+'"><i title="Edit" class="icon-pencil alignBottom"></i></a>&nbsp;</div></td><td ><a class="showCustomLabelValues textOverflowEllipsis cursorPointer" data-url="?module=EMAILMaker&view=IndexAjax&mode=showCustomLabelValues&labelid='+details.labelid+'&langid='+details.langid+'" id="other_langs_'+details.labelid+'">'+app.vtranslate('LBL_OTHER_VALS','EMAILMaker')+'</a></td>');
            CustomLabelTable.append(trElementForCustomLabel);
            $('#noItemFountTr').remove();
	},
	updateCustomLabelDetails : function(data, currentTrElement){
            currentTrElement.find('.CustomLabelValue').text(data['lblval']);
	},
        saveCustomLabelValues : function(form){
            var thisInstance = this;
            var params = form.serializeFormData();
            if(typeof params == 'undefined' ){
                params = {};
            }
            var progressIndicatorElement = jQuery.progressIndicator({
                'position' : 'html',
                'blockInfo' : {
                    'enabled' : true
                }
            });
            params.module = app.getModuleName();
            params.action = 'IndexAjax';
            params.mode = 'SaveCustomLabelValues';
            AppConnector.request(params).then(
                function(data) {
                    progressIndicatorElement.progressIndicator({'mode':'hide'});
                    app.hideModalWindow();
                    var params = {
                            text: app.vtranslate('JS_CUSTOM_LABEL_VALUES_SAVED_SUCCESSFULLY')
                    };
                    thisInstance.showMessage(params);
                }
            );
	},
	validateCustomLabelKey : function(data){
          	var thisInstance = this;
		var aDeferred = jQuery.Deferred();
		var KeyValue = data.taxlabel;
		var form = jQuery('#editCustomLabel');
		var CustomLabelElement = form.find('[name="LblKey"]');
	        thisInstance.checkDuplicateKey(data).then(
                        function(data){
                                aDeferred.resolve();
                        },
                        function(data, err){
                                CustomLabelElement.validationEngine('showPrompt', data['message'] , 'error','bottomLeft',true);
                                aDeferred.reject(data);
                        }
                );
		return aDeferred.promise();
	},
	checkDuplicateKey : function(details){
		var aDeferred = jQuery.Deferred();
		var LblKey = details.LblKey;
        	var params = {
			'module' : 'EMAILMaker',
			'action' : 'IndexAjax',
			'mode' : 'checkDuplicateKey',
			'lblkey' : LblKey
		}
		AppConnector.request(params).then(
			function(data) {
		                var response = data['result'];
		                var result = response['success'];
				if(result == true) {
					aDeferred.reject(response);
				} else {
					aDeferred.resolve(response);
				}
			},
			function(error,err){
				aDeferred.reject();
			}
		);
		return aDeferred.promise();
	},
        registerActions : function(){
                var thisInstance = this;
                var container = jQuery('#CustomLabelsContainer');
                container.find('.addCustomLabel').click(function(e){
                        var addTaxButton = jQuery(e.currentTarget);
                        var createTaxUrl = addTaxButton.data('url')+'&type='+addTaxButton.data('type');
                        thisInstance.editCustomLabel(createTaxUrl);
                });
                container.on('click', '.editCustomLabel', function(e){
                        var editTaxButton = jQuery(e.currentTarget);
                        var currentTrElement = editTaxButton.closest('tr');
                        thisInstance.editCustomLabel(editTaxButton.data('url'), currentTrElement);
                });
                container.on('click', '.showCustomLabelValues', function(e){
                        var editTaxButton = jQuery(e.currentTarget);
                        thisInstance.showCustomLabelValues(editTaxButton.data('url'));
                });
	},
	registerEvents: function(){
		this.registerActions();
	},
        showMessage : function(customParams){
		var params = {};
		params.animation = "show";
		params.type = 'info';
		params.title = app.vtranslate('JS_MESSAGE');		
		if(typeof customParams != 'undefined') {
			var params = jQuery.extend(params,customParams);
		}
		Vtiger_Helper_Js.showPnotify(params);
	}
    }
}