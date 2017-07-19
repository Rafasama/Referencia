/**
 * VGS Users SMTP Module
 *
 *
 * @package        VGSUserSMTP Module
 * @author         Conrado Maggi - www.vgsglobal.com
 * @license        vTiger Public License.
 * @version        Release: 1.0
 */

jQuery.Class("SMTP_Js", {}, {
    hideUnusefulThings: function(){
        if(jQuery('#parent_view').val() != 'Settings'){
            jQuery(".contentsDiv").removeClass('span10').addClass('span12');
            jQuery("#leftPanel").hide();
            jQuery("#toggleButton").hide();
        }
    },
    saveEntry: function () {
        jQuery('#add_entry').on('click', function (e) {
            var loadingMessage = jQuery('.listViewLoadingMsg').text();

            var progressIndicatorElement = jQuery.progressIndicator({
                'message': loadingMessage,
                'position': 'html',
                'blockInfo': {
                    'enabled': true
                }
            });

            var params = {
                module: 'VGSUserSMTP',
                action: 'SaveSMTPConfig',
                mode: 'addEntry',
                user_id: jQuery("[name='user_id']").val(),
                server_name: jQuery("#server_name").val(),
                user_name: jQuery("#user_name").val(),
                password: jQuery("#password").val(),
                email_from: jQuery("#email_from").val(),
                smtp_auth: (jQuery('#smtp_auth').prop("checked")) ? 1 : 0,
                from_name: jQuery('#from_name').val(),
            };

            if(jQuery('#parent_view').val() === 'Settings'){
                var from_settings = true;
            }else{
                var from_settings = false;
            }
            AppConnector.request(params).then(
                function (data) {
                    if (data.success) {
                        var response = data.result;
                        if (response.result === 'ok') {
                            if(from_settings === true){
                              window.location = 'index.php?module=VGSUserSMTP&view=SettingsIndex&parent=Settings';
                                return false;
                            }else{
                                window.location = 'index.php?module=VGSUserSMTP&view=SMTPindex';
                                return false;
                            }

                        } else {
                             Vtiger_Helper_Js.showPnotify(response.message);
                        }
                    }
                },
                function (error, err) {

                }
            );
            progressIndicatorElement.progressIndicator({
                'mode': 'hide'
            });
        });
    },
    deleteEntry: function () {
        jQuery('.deleteRecordButton').on('click', function (e) {
            var loadingMessage = jQuery('.listViewLoadingMsg').text();
            var progressIndicatorElement = jQuery.progressIndicator({
                'message': loadingMessage,
                'position': 'html',
                'blockInfo': {
                    'enabled': true
                }
            });
            var params = {
                module: 'VGSUserSMTP',
                action: 'SaveSMTPConfig',
                mode: 'deleteRecord',
                record_id: jQuery(this).attr('id'),
            };
            
            var line = jQuery(this).closest('tr');
            AppConnector.request(params).then(
                function (data) {
                    if (data.success) {
                        var response = data.result;
                        if (response.result == 'ok') {
                            line.hide('slow');
                            jQuery('#add-settings').show();
                        } else {
                            alert(app.tranlsate('JS_ERROR_DELETING'));   
                        }
                    }
                },
                function (error, err) {

                }
            );

            progressIndicatorElement.progressIndicator({
                'mode': 'hide'
            });

        });
    },
    registerEvents: function () {
        this.hideUnusefulThings();
        this.saveEntry();
        this.deleteEntry();
    },
});

var instance;
jQuery(document).ready(function () {
    instance = new SMTP_Js();
    instance.registerEvents();
});
