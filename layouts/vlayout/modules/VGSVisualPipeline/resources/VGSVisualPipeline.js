/**
 * VGS Visual Pipeline Module
 *
 *
 * @package        VGSVisualPipeline Module
 * @author         Curto Francisco - www.vgsglobal.com
 * @license        vTiger Public License.
 * @version        Release: 1.0
 */

jQuery.Class("VGSVisualPipeline_Js", {}, {
    showVisualPipeline: function(){
        var instance = this;
        var seleccionados = new Array();
        jQuery('.listViewEntriesCheckBox:checkbox:checked').each(function(){
            seleccionados.push(jQuery(this).val());
        });
        params = {
            'module': 'VGSVisualPipeline',
            'view': 'VGSVisualPipelineView',
            'mode': 'showVPView',
            'module1': jQuery('#module').val(),
            'seleccionados': seleccionados,
        }
        AppConnector.request(params).then(
            function (data) {
                jQuery('div.listViewPageDiv').html(data);
                instance.fixHeight();
                instance.registerVPEvents();
            },
            function (jqXHR, textStatus, errorThrown) {
            }
        );
    },
    fixHeight: function() {
        jQuery('.column').each(function(){
            jQuery(this).height(jQuery('.listViewPageDiv').height());
        });

    },
    tilt_direction: function(item) {
    var left_pos = item.position().left,
        move_handler = function (e) {
            if (e.pageX >= left_pos) {
                item.addClass("right");
                item.removeClass("left");
            } else {
                item.addClass("left");
                item.removeClass("right");
            }
            left_pos = e.pageX;
        };
        jQuery("html").bind("mousemove", move_handler);
        item.data("move_handler", move_handler);
    },
    registerVPEvents: function(){
        jQuery( ".column-list" ).sortable({
            connectWith: ".column-list",
            handle: ".portlet-header",
            cancel: ".portlet-toggle",
            start: function (event, ui) {
                ui.item.addClass('tilt');
                var instance = new VGSVisualPipeline_Js();
                instance.tilt_direction(ui.item);
            },
            stop: function (event, ui) {
                ui.item.removeClass("tilt");
                jQuery("html").unbind('mousemove', ui.item.data("move_handler"));
                ui.item.removeData("move_handler");
                var valor_columna = ui.item.closest('div.column-list').attr('id');
                var sorting = [];
                jQuery("div.column-list").each(function () {
                    jQuery("div[id='" + $(this).attr('id') + "']>div.portlet").each(function () {
                        sorting.push($(this).attr('id'));
                    });
                });
                
                var dataUrl = "index.php?module=VGSVisualPipeline&action=VGSSaveVP&id=" + ui.item.closest('div.portlet').attr('id') + "&modulo=" + jQuery('#modulo').val() + "&columna=" + jQuery('#columna_filtro').val() + "&valor=" + valor_columna + "&sort_order="+sorting;
                
                AppConnector.request(dataUrl).then(
                    function (data) {
                        if (data.success) {
                        }
                    },
                    function (error, err) {
                    }
                );          
            }
        });
        jQuery( ".portlet" )
            .addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
            .find( ".portlet-header" )
            .addClass( "ui-widget-header ui-corner-all" )
            .prepend( "<span class='ui-icon ui-icon-minusthick portlet-toggle'></span>");

        jQuery( ".portlet-toggle" ).click(function() {
            var icon = jQuery( this );
            icon.toggleClass( "ui-icon-minusthick ui-icon-plusthick" );
            icon.closest( ".portlet" ).find( ".portlet-content" ).toggle();
        });       
    }
});
function changeView() {
    var instance = new VGSVisualPipeline_Js();
    instance.showVisualPipeline();
}