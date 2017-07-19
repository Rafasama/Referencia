/**
 * VGS Users SMTP Module
 *
 *
 * @package        VGSUserSMTP Module
 * @author         Conrado Maggi - www.vgsglobal.com
 * @license        vTiger Public License.
 * @version        Release: 1.0
 */
jQuery(document).ready(function () {
   
    if (jQuery('[name="module"]').val() == 'Emails') {
        var options = "<option selected>--</option>";
        var params = {
            module: 'VGSUserSMTP',
            action: 'SaveSMTPConfig',
            mode: 'getUserSMTPs',
        };
        AppConnector.request(params).then(
                function (data) {
                    if (data.success && jQuery('.fromEmailField').length == 0) {
                        var response = data.result.smtps;
                        if(response == 'yes'){
                            jQuery('input[name="module"]').val('VGSUserSMTP');
                        }
                        
                    }
                },
                function (error, err) {

                }
        );
    } else if (jQuery('[name="module"]').val() == 'Users' && jQuery('#view').val() == 'PreferenceDetail') {
        if(jQuery('#vgs-multismtp').length == 0){
            jQuery('.detailViewButtoncontainer > .btn-toolbar').append('<div id="vgs-multismtp" class="btn-group"><button class="btn" onclick="window.location.href=\'index.php?module=VGSUserSMTP&view=SMTPindex\'"><strong>SMTP Config</strong></button></div>')
        }
    }
});
