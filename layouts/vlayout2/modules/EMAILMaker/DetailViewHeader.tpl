{*<!--
/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
-->*}
{strip}
<script>
    function ExportTemplates() {ldelim}
        window.location.href = "index.php?module=EMAILMaker&action=ExportEMAILTemplate&templates={$TEMPLATEID}";
    {rdelim}
</script>
<div class="detailViewContainer">
    <div class="row-fluid detailViewTitle">
        <div class="row-fluid">
            <div class="span7">
                <div class="row-fluid">
                    <span class="span2"></span>
                    <span class="span8 margin0px">
                        <span class="row-fluid">
                            <span class="recordLabel font-x-x-large textOverflowEllipsis pushDown span" title="{$TEMPLATENAME}">
                                <span class="templatename">{$TEMPLATENAME}</span>
                            </span>
                        </span>
                        <span class="row-fluid">
                            <span class="modulename_label">{vtranslate('LBL_MODULENAMES','EMAILMaker')}:</span>
                            &nbsp;{$MODULENAME}
                        </span>
                    </span>
                </div>
            </div>
            <div class="span5">
                <div class="pull-right detailViewButtoncontainer">
                    <div class="btn-toolbar">
                        {if $EDIT eq 'permitted'}
                            <span class="btn-group">
                                <button class="btn" id="EMAILMaker_detailView_basicAction_LBL_EDIT" onclick="window.location.href = 'index.php?module={$MODULE}&view=Edit{if $IS_EMAIL_CAMPAIGN eq "yes"}ME&record={$RECORDID}{else}&record={$TEMPLATEID}{/if}&return_module=EMAILMaker&return_view=Detail';
    return false;"><strong>{vtranslate('LBL_EDIT')}</strong></button>
                            </span>
                            {if $IS_EMAIL_CAMPAIGN neq "yes"}
                            <span class="btn-group">
                                <button class="btn" id="EMAILMaker_detailView_basicAction_LBL_DUPLICATE" onclick="window.location.href = 'index.php?module={$MODULE}&view=Edit&record={$TEMPLATEID}&isDuplicate=true&return_module=EMAILMaker&return_view=Detail'; return false;"><strong>{vtranslate('LBL_DUPLICATE')}</strong></button>
                            </span>
                            {/if}
                        {/if}
                        {if $DELETE eq 'permitted'}
                            <span class="btn-group">
                                <button class="btn" id="EMAILMaker_detailView_basicAction_Delete" onclick="Vtiger_Detail_Js.deleteRecord('index.php?module=EMAILMaker&action=IndexAjax&mode=Delete{if $IS_EMAIL_CAMPAIGN eq "yes"}ME&record={$RECORDID}{else}Template&templateid={$TEMPLATEID}{/if}'); return false;" style="font-weight:bold" ><strong>{vtranslate('LBL_DELETE')}</strong></button>
                            </span>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
<div class="detailViewInfo row-fluid">
    <div class="span10 details">
    <form id="detailView" method="post" action="index.php" name="etemplatedetailview" onsubmit="VtigerJS_DialogBox.block();">  
    <div class="contents">
        <input type="hidden" name="action" value="">
        <input type="hidden" name="view" value="">
        <input type="hidden" name="module" value="EMAILMaker">
        <input type="hidden" name="retur_module" value="EMAILMaker">
        <input type="hidden" name="return_action" value="EMAILMaker">
        <input type="hidden" name="return_view" value="Detail">
        <input type="hidden" name="templateid" id="templateid" value="{$TEMPLATEID}">
        <input type="hidden" name="record" value="{$TEMPLATEID}">
        <input type="hidden" name="parenttab" value="{$PARENTTAB}">
        <input type="hidden" name="isDuplicate" value="false">
        <input type="hidden" name="subjectChanged" value="">
        <input id="recordId" value="{$TEMPLATEID}" type="hidden">        
{/strip}