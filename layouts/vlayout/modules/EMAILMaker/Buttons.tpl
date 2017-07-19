{*<!--
/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
-->*}
<script type="text/javascript" src="layouts/vlayout/modules/EMAILMaker/resources/CustomLabels.js"></script>
<div class="container-fluid" id="EMAILMakerButtonsContainer">
    <form name="custom_labels" action="index.php" method="post" class="form-horizontal">
    <input type="hidden" name="module" value="EMAILMaker" />
    <input type="hidden" name="action" value="IndexAjax" />
    <input type="hidden" name="mode" value="DeleteCustomLabels" />
    <input type="hidden" name="newItems" value="" />
    <br>
    <label class="pull-left themeTextColor font-x-x-large">{vtranslate('LBL_EMAIL_BUTTONS','EMAILMaker')}</label>
    <br clear="all">{vtranslate('LBL_EMAIL_BUTTONS_DESC','EMAILMaker')}
    <hr>
    <div class="row-fluid">
        <div class="pushDownHalfper">    
            {assign var=WIDTHTYPE value=$USER_MODEL->get('rowheight')}
            <table class="table table-bordered listViewEntriesEMAILMakerButtons">
            <thead>
                <tr class="listViewHeaders">
                    <th style="border-left: 1px solid #DDD !important;" width="50%" class="{$WIDTHTYPE}">{vtranslate('LBL_MODULENAMES','EMAILMaker')}</th>
                    <th style="border-left: 1px solid #DDD !important;" width="25%" class="{$WIDTHTYPE}">{vtranslate('LBL_ALOWED_DETAIL_BLOCK','EMAILMaker')}</th>
                    <th style="border-left: 1px solid #DDD !important;" width="25%" class="{$WIDTHTYPE}">{vtranslate('LBL_ALOWED_LISTVIEW_BUTTON','EMAILMaker')}</th>
                </tr>
            </thead>
            <tbody>
            <script type="text/javascript" language="javascript">var existingKeys = new Array();</script>
            {assign var="lang_id" value=$CURR_LANG.id}
            {foreach item=module_data from=$MODULES_LIST name=btns_foreach}
                <tr class="listViewEntries">
                    <td nowrap class="{$WIDTHTYPE}">
                        {vtranslate($module_data.tablabel,$module_data.name)}
                    </td>
                    <td nowrap class="{$WIDTHTYPE}">
                       <input type="checkbox" name="moduleEMAILMakerLink" data-linktype="1" data-module="{$module_data.name}" data-module-translation="{vtranslate($module_data.tablabel,$module_data.name)}" {$module_data.link_type_a}>
                    </td>
                    <td nowrap class="{$WIDTHTYPE}">
                       <input type="checkbox" name="moduleEMAILMakerLink" data-linktype="2" data-module="{$module_data.name}" data-module-translation="{vtranslate($module_data.tablabel,$module_data.name)}" {$module_data.link_type_b}>
                    </td>
                </tr>
            {foreachelse}
                <tr id="noItemFountTr">
                    <td colspan="3" class="listViewEntries" align="center" style="padding:10px;"><strong>{vtranslate('LBL_NO_ITEM_FOUND','EMAILMaker')}</strong></td>
                </tr>
            {/foreach}
            </tbody>
        </table>
        </div>
    </div>    
</form>
</div>
<br />