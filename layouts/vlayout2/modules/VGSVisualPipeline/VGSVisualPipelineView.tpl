{**
* VGS Visual Pipeline Module
*
*
* @package        VGSVisualPipeline Module
* @author         Curto Francisco, Conrado Maggi - www.vgsglobal.com
* @license        vTiger Public License.
* @version        Release: 1.0
*}
<style>
    .tilt.right {
        transform: rotate(3deg);
        -moz-transform: rotate(3deg);
        -webkit-transform: rotate(3deg);
    }
    .tilt.left {
        transform: rotate(-3deg);
        -moz-transform: rotate(-3deg);
        -webkit-transform: rotate(-3deg);
    }
    body {
        min-width: 520px;
    }
    .vgs-visual-pipeline{
        width: 100%;
        margin: 0 auto;
        height: 500px;
        min-height: 500px;
        white-space: nowrap;
        overflow-x: scroll;
        overflow-y: hidden;
    }

    .columnTitle{
        text-align: center;
        margin-bottom: 5%;
        word-wrap: break-word;


    }    
    .vgs-visual-pipeline .column {
        width: 250px;
        padding-bottom: 100px;
        display: inline-block;
        height: 500px;
        margin-right: 5.7px;
    }

    .vgs-visual-pipeline .column-list {
        overflow-y: scroll;
        width: 250px;
        padding-bottom: 100px;
        display: inline-block;
        height: 80%;
        margin-right: 5.7px;
    }


    .vgs-visual-pipeline .quickLinksDiv p.selectedQuickLink a:after{
        border-bottom: 20px solid rgba(0, 0, 0, 0);
    }
    .vgs-visual-pipeline .quickLinksDiv {
        margin: 10px auto 10px 1%;
        width: 90%;
    }

    .vgs-visual-pipeline  .quickLinksDiv p {
        font-size: 1em;
        padding: 5% 0 0 2%;

    }

    .vgs-visual-pipeline .table th, .table td {
        padding: 3%;   
        font-size: 80%;
        word-wrap: break-word;
        white-space: normal; 
    }

    .vgs-visual-pipeline .table {
    }
    .arrow-right {
        width: 0; 
        height: 0; 
        border-top: 60px solid transparent;
        border-bottom: 60px solid transparent;

        border-left: 60px solid green;
    }
    .portlet {
        margin: 0 1em 1em 0;
        padding: 0.3em;
    }
    .portlet-header {
        padding: 0.2em 0.3em;
        margin-bottom: 0.5em;
        position: relative;
        background-color: rgb(245, 245, 245);
        background-image: -webkit-linear-gradient(top, rgb(246, 246, 246), rgb(243, 243, 244));
        background-repeat: repeat-x;
        border-bottom-color: rgb(221, 221, 221);
        border-bottom-style: solid;
        border-bottom-width: 1px;
        border-collapse: separate;
        border-left-color: rgb(68, 68, 68);
        border-left-style: none;
        border-left-width: 0px;
        border-right-color: rgba(0, 0, 0, 0.0980392);
        border-top-color: rgb(255, 255, 255);
        border-top-style: solid;
        border-top-width: 1px;
        color: rgb(68, 68, 68);
    }
    .portlet-toggle {
        position: absolute;
        top: 50%;
        right: 0;
        margin-top: -8px;
        display: none;
    }
    .portlet-content {
        padding: 0.4em;
    }
    .portlet-placeholder {
        border: 1px dotted black;
        margin: 0 1em 1em 0;
        height: 50px;
    }
    .portlet.ui-widget.ui-widget-content.ui-helper-clearfix.ui-corner-all{
        height: auto;
    }

    .ui-widget-content {
        border-radius: 1px;
        border-color: #ffffff;
        box-shadow: 0 0 3px -1px inset;
        margin-top: 2px;
        margin-left: 5px;
        height: 12px;
    }

</style>

<input type="hidden" id="columna_filtro" value="{$COLUMNA}">
<input type="hidden" id="modulo" value="{$MODULENAME}">

{if $NOT_IN_FILTER eq 'true'}

    <div class="vgs-visual-pipeline">
        {foreach $RECORDS_ARRAY as $order => $RECORDS}

            {foreach $RECORDS as $llave => $otro}
                <div class="column">
                    {if $llave neq ''}
                        <div class="quickLinksDiv"><p class="columnTitle selectedQuickLink "><a class="quickLinks"><strong>{vtranslate($llave,$MODULENAME)}</strong></a></p></div>
                                    {else}
                        <h4 class="columnTitle">None</h4>
                    {/if}
                    <div class="column-list" id="{$llave}">
                        {if $otro|@count > 0}
                            {foreach $otro as $key => $RECORD_INFO}
                                <div class="portlet" id="{$RECORD_INFO.RECORD}" data-key="{$llave}">
                                    <div class="portlet-header"><a href="index.php?module={$MODULENAME}&record={$RECORD_INFO.RECORD_MODEL->get('id')}&view=Detail" target="_blank">{$RECORD_INFO.RECORD_LABEL}</a></div>
                                    <div class="portlet-content">
                                        <div class="detailViewInfo">
                                            <table class="table table-bordered equalSplit detailview-table">
                                                {foreach item=FIELD_MODEL from=$RECORD_INFO.TOOLTIP_FIELDS name=fieldsCount}
                                                    {if $smarty.foreach.fieldsCount.index < 4}
                                                        <tr>
                                                            <td class="fieldLabel narrowWidthType" nowrap>
                                                                <label style="font-size: 80%;" class="muted">{vtranslate($FIELD_MODEL->get('label'),$MODULE)}</label>
                                                            </td>
                                                            <td class="fieldValue narrowWidthType">
                                                                <span class="value">
                                                                    {$FIELD_MODEL->getDisplayValue($RECORD_INFO.RECORD_MODEL->get($FIELD_MODEL->get('name')),$RECORD_INFO.RECORD_MODEL->get('id'))}   
                                                                </span>
                                                            </td>
                                                        </tr>
                                                    {/if}
                                                {/foreach}
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                        {/if}
                    </div>
                </div>
            {/foreach}

        {/foreach}

    </div>

{else}
    <div style="margin: 10% auto; width: 50%; font-size: 125%; font-weight: 700; color: red;">
        {vtranslate('The selected filter does not include the field: ', $MODULENAME)}  {vtranslate($COLUMNA,$MODULENAME)} <br><br>
        {vtranslate('Please choose another filter or add the column to this one ', $MODULENAME)} 
    </div>
{/if}

<script>
    {literal}
        jQuery(document).ready(function() {
            jQuery('.vgs-visual-pipeline').height(jQuery(window).height()-jQuery('.navbar-fixed-top').height())
        });

    {/literal}    
</script>