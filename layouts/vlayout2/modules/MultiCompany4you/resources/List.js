/* * *******************************************************************************
 * The content of this file is subject to the MultiCompany4you license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 * ****************************************************************************** */


jQuery.Class("MultiCompany4you_List_Js", {
    listInstance: false,
    getInstance: function() {
        if (MultiCompany4you_List_Js.listInstance == false) {
            var instance = new MultiCompany4you_List_Js();
            MultiCompany4you_List_Js.listInstance = instance;
            return instance;
        }
        return MultiCompany4you_List_Js.listInstance;
    },
    deleteRecord: function(recordId) {
        var listInstance = MultiCompany4you_List_Js.getInstance();
        var message = app.vtranslate('LBL_DELETE_CONFIRMATION');
        Vtiger_Helper_Js.showConfirmationBox({'message': message}).then(
            function(e) {
            	var module = app.getModuleName();
				var postData = {
                    "module": module,
                    "action": "Delete",
                    "companyid": recordId,
                    "parent": app.getParentModuleName()
                }
                var deleteMessage = app.vtranslate('JS_RECORD_GETTING_DELETED');
                var progressIndicatorElement = jQuery.progressIndicator({
                    'message': deleteMessage,
                    'position': 'html',
                    'blockInfo': {
                        'enabled': true
                    }
                });
                AppConnector.request(postData).then(
                	function(data) {
                        progressIndicatorElement.progressIndicator({
                            'mode': 'hide'
                        });
                        if (data.success) {
							window.location.href='index.php?parent=Settings&module=MultiCompany4you&view=CompanyList';
                        } else {
                            var params = {
                                text: app.vtranslate(data.error.message),
                                title: app.vtranslate('JS_LBL_PERMISSION')
                            }
                            Vtiger_Helper_Js.showPnotify(params);
						}
                	},
                    function(error, err) {
                        progressIndicatorElement.progressIndicator({
                            'mode': 'hide'
                        });
                    }
                );
            }
        );
    }

}, {}
);
