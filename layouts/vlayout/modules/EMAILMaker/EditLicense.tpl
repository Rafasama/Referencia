{*<!--
/* * *******************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 * ****************************************************************************** */
-->*}
{strip}
<div class="CustomLabelModalContainer">
    <div class="modal-header">
        <button class="close vtButton" data-dismiss="modal">×</button>
        <h3>
        {if $TYPE eq "reactivate"}{vtranslate('LBL_REACTIVATE', 'EMAILMaker')}{else}{vtranslate('LBL_ACTIVATE_KEY', 'EMAILMaker')}{/if}
        </h3>
    </div>
    <form id="editLicense" class="form-horizontal contentsBackground">
        <input type="hidden" name="module" value="EMAILMaker">
        <input type="hidden" name="action" value="License">
        <input type="hidden" name="mode" value="editLicense">
        <input type="hidden" name="type" value="{$TYPE}">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="control-group">
                    <label class="muted control-label">{vtranslate('LBL_LICENCEKEY', 'EMAILMaker')}</label>
                    <div class="controls"><input type="text" name="licensekey" value="{$LICENSEKEY}" data-validation-engine='validate[required]' /></div>	
                </div>
            </div>
        </div>
        {if $LABELID eq ""}<input type="hidden" class="addCustomLabelView" value="true" />{/if}                        
        {include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
    </form>
</div>
{/strip}