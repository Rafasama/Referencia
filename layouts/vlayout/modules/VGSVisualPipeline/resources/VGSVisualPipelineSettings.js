/**
 * VGS Visual Pipeline Module
 *
 *
 * @package        VGSVisualPipeline Module
 * @author         Curto Francisco - www.vgsglobal.com
 * @license        vTiger Public License.
 * @version        Release: 1.0
 */

jQuery.Class("VGSVisualPipelineSetting_Js", {}, {
    SourceModuleUpdate: function () {
        jQuery('#module1').on('change', function (e) {

            var module1 = jQuery(this).val();
            jQuery('#picklist1').find('option').remove().end().append('<option value="--">--</option>').val('--').trigger('liszt:updated');

            jQuery(".notice").hide();
            var loadingMessage = jQuery('.listViewLoadingMsg').text();

            var progressIndicatorElement = jQuery.progressIndicator({
                'message': loadingMessage,
                'position': 'html',
                'blockInfo': {
                    'enabled': true
                }
            });

            var dataUrl = "index.php?module=VGSVisualPipeline&action=VGSGetPicklistFields&source_module=" + module1;
            AppConnector.request(dataUrl).then(
                    function (data) {

                        if (data.success) {

                            var result = data.result;
                            if (result.result == 'ok') {

                                jQuery.each(result.options, function (i, item) {
                                    var o = new Option(item, i);
                                    jQuery(o).html(item);
                                    jQuery("#picklist1").append(o);
                                });

                                jQuery("#picklist1").trigger('liszt:updated');

                            } else {
                                alert(app.tranlsate('JS_ERROR_LOADING_FIELDS'));
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
    saveEntry: function () {
        jQuery('#add_entry').on('click', function (e) {

            jQuery(".notices").hide();
            var loadingMessage = jQuery('.listViewLoadingMsg').text();

            var progressIndicatorElement = jQuery.progressIndicator({
                'message': loadingMessage,
                'position': 'html',
                'blockInfo': {
                    'enabled': true
                }
            });

            var params = {
                module: 'VGSVisualPipeline',
                action: 'VGSsave',
                mode: 'addEntry',
                module1: jQuery("#module1").val(),
                picklist1: jQuery("#picklist1").val(),
            };

            AppConnector.request(params).then(
                    function (data) {

                        if (data.success) {
                            var response = data.result;

                            if (response.result == 'ok') {

                                   window.location = 'index.php?module=VGSVisualPipeline&view=VGSIndexSettings&parent=Settings';

                            } else {
                                
                                   jQuery(".alert").addClass('alert-danger').html(response.message);
                                
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

            jQuery(".notices").hide();
            var loadingMessage = jQuery('.listViewLoadingMsg').text();

            var progressIndicatorElement = jQuery.progressIndicator({
                'message': loadingMessage,
                'position': 'html',
                'blockInfo': {
                    'enabled': true
                }
            });

            var params = {
                module: 'VGSVisualPipeline',
                action: 'VGSsave',
                mode: 'deleteRecord',
                module1: jQuery(this).data('sourcemodule'),
                record_id: jQuery(this).attr('id')
            };
            
            var line = jQuery(this).closest('tr');

            AppConnector.request(params).then(
                    function (data) {

                        if (data.success) {
                            var response = data.result;

                            if (response.result == 'ok') {
                                line.hide('slow');
                            

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
        this.SourceModuleUpdate();
        this.saveEntry();
        this.deleteEntry();
    }
    
});

jQuery(document).ready(function () {
    var instance = new VGSVisualPipelineSetting_Js();
    instance.registerEvents();
});