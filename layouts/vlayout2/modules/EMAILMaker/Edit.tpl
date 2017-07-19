{*<!--
/*********************************************************************************
* The content of this file is subject to the EMAIL Maker license.
* ("License"); You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
* Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
* All Rights Reserved.
********************************************************************************/
-->*}
<div class='editViewContainer'>
    <form class="form-horizontal recordEditView" id="EditView" name="EditView" method="post" action="index.php" enctype="multipart/form-data">
        <input type="hidden" name="module" value="EMAILMaker">
        <input type="hidden" name="parenttab" value="{$PARENTTAB}">
        <input type="hidden" name="templateid" value="{$SAVETEMPLATEID}">
        <input type="hidden" name="action" value="SaveEMAILTemplate">
        <input type="hidden" name="redirect" value="true">
        <input type="hidden" name="return_module" value="{$smarty.request.return_module}">
        <input type="hidden" name="return_view" value="{$smarty.request.return_view}">
        <input type="hidden" name="is_theme" value="{if $THEME_MODE eq "true"}1{else}0{/if}">
        <input type="hidden" name="selectedTab" id="selectedTab" value="properties">
        <input type="hidden" name="selectedTab2" id="selectedTab2" value="body">
        <div class="contentHeader row-fluid">
            {if $EMODE eq 'edit'}
                {if $DUPLICATE_TEMPLATENAME eq ""}
                    <span class="span8 font-x-x-large textOverflowEllipsis" title="{vtranslate('LBL_EDIT','EMAILMaker')} &quot;{$TEMPLATENAME}&quot;">{vtranslate('LBL_EDIT','EMAILMaker')} &quot;{$TEMPLATENAME}&quot;</span>
                {else}
                    <span class="span8 font-x-x-large textOverflowEllipsis" title="{vtranslate('LBL_DUPLICATE','EMAILMaker')} &quot;{$DUPLICATE_TEMPLATENAME}&quot;">{vtranslate('LBL_DUPLICATE','EMAILMaker')} &quot;{$DUPLICATE_TEMPLATENAME}&quot;</span>
                {/if}
            {else}
                <span class="span8 font-x-x-large textOverflowEllipsis">
                    {if $THEME_MODE eq "true"}{vtranslate('LBL_NEW_THEME','EMAILMaker')}{else}{vtranslate('LBL_NEW_TEMPLATE','EMAILMaker')}{/if}
                </span>
            {/if}
            <span class="pull-right">
                <button class="btn" type="submit" onclick="document.EditView.redirect.value = 'false';" ><strong>{vtranslate('LBL_APPLY','EMAILMaker')}</strong></button>&nbsp;&nbsp;
                <button class="btn btn-success" type="submit"><strong>{vtranslate('LBL_SAVE', $MODULE)}</strong></button>
                {if $smarty.request.return_view neq ''}
                    <a class="cancelLink" type="reset" onclick="window.location.href = 'index.php?module={if $smarty.request.return_module neq ''}{$smarty.request.return_module}{else}EMAILMaker{/if}&view={$smarty.request.return_view}{if $smarty.request.record neq ""}&record={$smarty.request.record}{/if}';">{vtranslate('LBL_CANCEL', $MODULE)}</a>
                {else}
                    <a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate('LBL_CANCEL', $MODULE)}</a>
                {/if}
            </span>
        </div>
       <div class="modal-body tabbable" style="padding:0px;">
            <ul class="nav nav-pills" style="margin-bottom:0px; padding-left:5px;">
                <li class="active" id="properties_tab" onclick="EMAILMaker_EditJs.showHideTab('properties');"><a data-toggle="tab" href="javascript:void(0);">{vtranslate('LBL_PROPERTIES_TAB','EMAILMaker')}</a></li>
                {if $THEME_MODE neq "true"}
                    <li id="module_tab" onclick="EMAILMaker_EditJs.showHideTab('module');"><a data-toggle="tab" href="javascript:void(0);">{vtranslate('LBL_MODULE_INFO','EMAILMaker')}</a></li>
                {/if}
                <li id="company_tab" onclick="EMAILMaker_EditJs.showHideTab('company');"><a data-toggle="tab" href="javascript:void(0);">{vtranslate('LBL_OTHER_INFO','EMAILMaker')}</a></li>
                <li id="labels_tab" onclick="EMAILMaker_EditJs.showHideTab('labels');"><a data-toggle="tab" href="javascript:void(0);">{vtranslate('LBL_LABELS','EMAILMaker')}</a></li>
                {if $THEME_MODE neq "true"}
                    <li id="products_tab" onclick="EMAILMaker_EditJs.showHideTab('products');"><a data-toggle="tab" href="javascript:void(0);">{vtranslate('LBL_ARTICLE','EMAILMaker')}</a></li>
                    <li id="settings_tab" onclick="EMAILMaker_EditJs.showHideTab('settings');"><a data-toggle="tab" href="javascript:void(0);">{vtranslate('LBL_SETTINGS_TAB','EMAILMaker')}</a></li>
                    <li id="sharing_tab" onclick="EMAILMaker_EditJs.showHideTab('sharing');"><a data-toggle="tab" href="javascript:void(0);">{vtranslate('LBL_SHARING_TAB','EMAILMaker')}</a></li>
                    {if $TYPE eq "professional"}
                        <li id="display_tab" onclick="EMAILMaker_EditJs.showHideTab('display');" {if $SELECTMODULE eq ""}style="display:none"{/if}><a data-toggle="tab" href="javascript:void(0);">{vtranslate('LBL_DISPLAY_TAB','EMAILMaker')}</a></li>
                    {/if}
                {/if}
            </ul>
        </div>     
        {********************************************* PROPERTIES DIV*************************************************}
        <table class="table table-bordered blockContainer ">
            <tbody id="properties_div">
                {* EMAIL module name and description *}
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px"><span class="redColor">*</span>{if $THEME_MODE eq "true"}{vtranslate('LBL_THEME_NAME','EMAILMaker')}{else}{vtranslate('LBL_EMAIL_NAME','EMAILMaker')}{/if}:</label></td>
                    <td class="fieldValue" colspan="3"><input name="templatename" id="templatename" type="text" value="{$TEMPLATENAME}" class="detailedViewTextBox" tabindex="1">&nbsp;
                    <span class="muted">&nbsp;&nbsp;&nbsp;{vtranslate('LBL_DESCRIPTION','EMAILMaker')}:&nbsp;</span>
                    <span class="small cellText">
                        <input name="description" type="text" value="{$EMAIL_TEMPLATE_RESULT.description}" class="detailedViewTextBox span5" tabindex="2">
                    </span>
                    </td>
                </tr>     					
                {* EMAIL source module and its available fields *}
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_RECIPIENT_FIELDS','EMAILMaker')}:</label></td>
                    <td class="fieldValue row-fluid" colspan="3">
                        <select name="r_modulename" id="r_modulename" class="chzn-select span4"> {* onChange="fillModuleFields(this,'recipientmodulefields');" *}
                            {html_options  options=$RECIPIENTMODULENAMES}
                        </select>
                        &nbsp;&nbsp;
                        <select name="recipientmodulefields" id="recipientmodulefields" class="chzn-select span4">
                            <option value="">{vtranslate('LBL_SELECT_MODULE_FIELD','EMAILMaker')}</option>
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('recipientmodulefields');" >{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                    </td>      						
                </tr> 
                {* email subject *}
                {if $THEME_MODE neq "true"} 
                    <tr>
                        <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_EMAIL_SUBJECT','EMAILMaker')}:</label></td>
                        <td class="fieldValue" colspan="3"><input name="subject" id="subject" type="text" value="{$EMAIL_TEMPLATE_RESULT.subject}" class="detailedViewTextBox span8" tabindex="1">&nbsp;
                        <span class="muted">
                            <select name="subject_fields" id="subject_fields" class="chzn-select span4" onchange="insertFieldIntoSubject(this.value);">
                                <option value="">{vtranslate('LBL_SELECT_MODULE_FIELD','EMAILMaker')}</option>
                                <optgroup label="{vtranslate('LBL_COMMON_EMAILINFO','EMAILMaker')}">
                                    {html_options  options=$SUBJECT_FIELDS}
                                </optgroup>
                                {if $TEMPLATEID neq "" || $SELECTMODULE neq ""}
                                    {html_options  options=$SELECT_MODULE_FIELD_SUBJECT}
                                {/if}
                            </select>
                        </span>
                        </td>
                    </tr>
                {/if}     
            </tbody>  
            {if $THEME_MODE neq "true"}   
                <tbody id="module_div" style="display:none;">    
                    <tr>
                        <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_MODULENAMES','EMAILMaker')}:</label></td>
                        <td class="fieldValue" colspan="3">
                            <select name="modulename" id="modulename" class="chzn-select span4" {*{if $TEMPLATEID neq ""} style="display:none;"{/if}*}> {* onChange="change_modulesorce(this, 'modulefields');" *}
                                {if $TEMPLATEID neq "" || $SELECTMODULE neq ""}
                                    {html_options  options=$MODULENAMES selected=$SELECTMODULE}
                                {else}
                                    {html_options  options=$MODULENAMES}
                                {/if}
                            </select>
                            &nbsp;&nbsp;
                            <select name="modulefields" id="modulefields" class="chzn-select span5">
                                {if $TEMPLATEID eq "" && $SELECTMODULE eq ""}
                                    <option value="">{vtranslate('LBL_SELECT_MODULE_FIELD','EMAILMaker')}</option>
                                {else}
                                    {html_options  options=$SELECT_MODULE_FIELD}
                                {/if}
                            </select>
                            <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('modulefields');" >{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                        </td>      						
                    </tr>    					
                    {* related modules and its fields *}                					
                    <tr id="body_variables">
                        <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_RELATED_MODULES','EMAILMaker')}:</label></td>
      <td class="fieldValue row-fluid" colspan="3">

                        <select name="relatedmodulesorce" id="relatedmodulesorce" class="chzn-select span4">
                            <option value="">{vtranslate('LBL_SELECT_MODULE','EMAILMaker')}</option>
                            {foreach item=RelMod from=$RELATED_MODULES}
                                <option value="{$RelMod.0}" data-module="{$RelMod.3}">{$RelMod.1} ({$RelMod.2})</option>
                            {/foreach}
                        </select>
                        &nbsp;&nbsp;

                        <select name="relatedmodulefields" id="relatedmodulefields" class="chzn-select span5">
                            <option value="">{vtranslate('LBL_SELECT_MODULE_FIELD','EMAILMaker')}</option>
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('relatedmodulefields');">{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}</button>
                    </td> 
                    </tr>
                    {* related bloc tpl *}
                    <tr id="related_block_tpl_row">
                        <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_RELATED_BLOCK_TPL','EMAILMaker')}:</label></td>
                        <td class="fieldValue row-fluid" colspan="3">
                            <select name="related_block" id="related_block" class="chzn-select span4" >
                                {html_options options=$RELATED_BLOCKS}
                            </select>
                            <button type="button" class="btn btn-success marginLeftZero" onclick="EMAILMaker_EditJs.InsertRelatedBlock();">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                            <button type="button" class="btn addButton marginLeftZero" onclick="EMAILMaker_EditJs.CreateRelatedBlock();"><i class="icon-plus icon-white"></i>&nbsp;<strong>{vtranslate('LBL_CREATE')}</strong></button>
                            <button type="button" class="btn marginLeftZero" onclick="EMAILMaker_EditJs.EditRelatedBlock();">{vtranslate('LBL_EDIT')}</button>
                            <button class="btn btn-danger marginLeftZero" class="crmButton small delete" onclick="EMAILMaker_EditJs.DeleteRelatedBlock();">{vtranslate('LBL_DELETE')}</button>
                        </td>
                    </tr>
                    <tr id="listview_block_tpl_row">
                        <td class="fieldLabel">
                            <label class="muted pull-right marginRight10px"><input type="checkbox" name="is_listview" id="isListViewTmpl" {$IS_LISTVIEW_CHECKED} onclick="EMAILMaker_EditJs.isLvTmplClicked();" title="{vtranslate('LBL_LISTVIEW_TEMPLATE','EMAILMaker')}" />
                            {vtranslate('LBL_LISTVIEWBLOCK','EMAILMaker')}:</label>
                        </td>
                    <td class="fieldValue" colspan="3">
                        <span>
                        <select name="listviewblocktpl" id="listviewblocktpl" class="chzn-select">
                                {html_options  options=$LISTVIEW_BLOCK_TPL}
                            </select>
                         </span>
                            <button type="button" id="listviewblocktpl_butt" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('listviewblocktpl');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                        </td>
                    </tr>
            </tbody>
            {/if}
            {********************************************* Labels *************************************************}
            <tbody id="labels_div" style="display:none;">
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_GLOBAL_LANG','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="global_lang" id="global_lang" class="chzn-select span9">
                            {html_options  options=$GLOBAL_LANG_LABELS}
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('global_lang');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                    </td>
                </tr>
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_MODULE_LANG','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="module_lang" id="module_lang" class="chzn-select span9">
                            {html_options  options=$MODULE_LANG_LABELS}
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('module_lang');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                    </td>
                </tr>
                {if $TYPE eq "professional"}
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_CUSTOM_LABELS','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="custom_lang" id="custom_lang" class="chzn-select span9">
                            {html_options  options=$CUSTOM_LANG_LABELS}
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('custom_lang');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                    </td>
                </tr>
                {/if}
            </tbody>
             {********************************************* Company and User information DIV *************************************************}
            <tbody id="company_div" style="display:none;">
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_COMPANY_USER_INFO','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="acc_info_type" id="acc_info_type" class="chzn-select span4" onChange="EMAILMaker_EditJs.change_acc_info(this)">
                            {html_options  options=$CUI_BLOCKS}
                        </select>
                        <div id="acc_info_div" class="au_info_div" style="display:inline;">
                            <select name="acc_info" id="acc_info" class="chzn-select span5">
                                {html_options  options=$ACCOUNTINFORMATIONS}
                            </select>
                            <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('acc_info');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                        </div>
                        <div id="user_info_div" class="au_info_div" style="display:none;">
                            <select name="user_info" id="user_info" class="chzn-select span5">
                                {html_options  options=$USERINFORMATIONS['s']}
                            </select>
                            <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('user_info');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                        </div>
                        <div id="logged_user_info_div" class="au_info_div"  style="display:none;">
                            <select name="logged_user_info" id="logged_user_info" class="chzn-select span5">
                                {html_options  options=$USERINFORMATIONS['l']}
                            </select>
                            <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('logged_user_info');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                        </div>
                        <div id="modifiedby_user_info_div" class="au_info_div" style="display:none;">
                            <select name="modifiedby_user_info" id="modifiedby_user_info" class="chzn-select span5">
                                {html_options  options=$USERINFORMATIONS['m']}
                            </select>
                            <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('modifiedby_user_info');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                        </div>
                        <div id="smcreator_user_info_div" class="au_info_div" style="display:none;">
                            <select name="smcreator_user_info" id="smcreator_user_info" class="chzn-select span5">
                                {html_options  options=$USERINFORMATIONS['c']}
                            </select>
                            <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('smcreator_user_info');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                        </div>
                    </td>
                </tr>
                {if $MULTICOMPANYINFORMATIONS neq ''}
                    <tr>
                        <td class="fieldLabel"><label class="muted pull-right marginRight10px">{$LBL_MULTICOMPANY}:</label></td>
                        <td class="fieldValue" colspan="3">
                            <select name="multicomapny" id="multicomapny" class="chzn-select span4">
                                {html_options  options=$MULTICOMPANYINFORMATIONS}
                            </select>
                            <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('multicomapny');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                        </td>
                    </tr>
                {/if}
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('TERMS_AND_CONDITIONS','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="invterandcon" id="invterandcon" class="chzn-select span4">
                            {html_options  options=$INVENTORYTERMSANDCONDITIONS}
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('invterandcon');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                    </td>
                </tr>
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_CURRENT_DATE','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="dateval" id="dateval" class="chzn-select span4">
                            {html_options  options=$DATE_VARS}
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('dateval');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                    </td>
                </tr>
               {************************************ Custom Functions *******************************************}
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('CUSTOM_FUNCTIONS','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="custom_function_type" id="custom_function_type" class="chzn-select span4">
                            <option value="before">{vtranslate('LBL_BEFORE','EMAILMaker')}</option>
                            <option value="after">{vtranslate('LBL_AFTER','EMAILMaker')}</option>
                        </select>
                        <select name="customfunction" id="customfunction" class="chzn-select span4">
                            {html_options options=$CUSTOM_FUNCTIONS}
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('customfunction');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                    </td>
                </tr>
            </tbody>
            {*********************************************Products bloc DIV*************************************************}
            <tbody id="products_div" style="display:none;">
                {* product bloc tpl which is the same as in main Properties tab*}
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_PRODUCT_BLOC_TPL','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="productbloctpl2" id="productbloctpl2" class="chzn-select span4">
                            {html_options  options=$PRODUCT_BLOC_TPL}
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('productbloctpl2');"/>{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                    </td>
                </tr>
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_ARTICLE','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="articelvar" id="articelvar" class="chzn-select span4">
                            {html_options  options=$ARTICLE_STRINGS}
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('articelvar');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>
                    </td>
                </tr>
                {* insert products & services fields into text *}
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">*{vtranslate('LBL_PRODUCTS_AVLBL','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="psfields" id="psfields" class="chzn-select span4">
                            {html_options  options=$SELECT_PRODUCT_FIELD}
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('psfields');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>            						
                    </td>
                </tr>
                {* products fields *}                                
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">*{vtranslate('LBL_PRODUCTS_FIELDS','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="productfields" id="productfields" class="chzn-select span4">
                            {html_options  options=$PRODUCTS_FIELDS}
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('productfields');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>            						
                    </td>
                </tr>
                {* services fields *}                                
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">*{vtranslate('LBL_SERVICES_FIELDS','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="servicesfields" id="servicesfields" class="chzn-select span4">
                            {html_options  options=$SERVICES_FIELDS}
                        </select>
                        <button type="button" class="btn btn-success marginLeftZero" onclick="InsertIntoTemplate('servicesfields');">{if $THEME_MODE eq "true"}{vtranslate('LBL_INSERT_TO_THEME','EMAILMaker')}{else}{vtranslate('LBL_INSERT_TO_TEXT','EMAILMaker')}{/if}</button>            						
                    </td>
                </tr>
                <tr>
                    <td class="fieldLabel" colspan="4"><label class="muted marginRight10px"><small>{vtranslate('LBL_PRODUCT_FIELD_INFO','EMAILMaker')}</small></label></td>
                </tr>
            </tbody>
            {********************************************* Settings DIV *************************************************}
            <tbody id="settings_div" style="display:none;">
                {* email category setting *}
                <tr>
                    <td class="fieldLabel" title="{vtranslate('Category')}"><label class="muted pull-right marginRight10px">{vtranslate('Category')}:</label></td>
                    <td class="fieldValue" colspan="3"><input type="text" name="email_category" value="{$EMAIL_CATEGORY}" class="detailedViewTextBox span6"/></td>
                </tr>
                {* default from setting *}
                <tr>
                    <td class="fieldLabel" title="{vtranslate('LBL_DEFAULT_FROM','EMAILMaker')}"><label class="muted pull-right marginRight10px">{vtranslate('LBL_DEFAULT_FROM','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                    <select name="default_from_email" class="chzn-select span6">
                        {html_options  options=$DEFAULT_FROM_OPTIONS selected=$SELECTED_DEFAULT_FROM}
                    </select>
                    </td>
                </tr>
                {* ignored picklist values settings *}
                <tr>
                    <td class="fieldLabel" title="{vtranslate('LBL_IGNORE_PICKLIST_VALUES_DESC','EMAILMaker')}"><label class="muted pull-right marginRight10px">{vtranslate('LBL_IGNORE_PICKLIST_VALUES','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3" title="{vtranslate('LBL_IGNORE_PICKLIST_VALUES_DESC','EMAILMaker')}"><input type="text" name="ignore_picklist_values" value="{$IGNORE_PICKLIST_VALUES}" class="detailedViewTextBox span6"/></td>
                </tr>
                {* status settings *}
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('Status')}:</label></td>    					   
                    <td class="fieldValue" colspan="3">
                        <select name="is_active" id="is_active" class="chzn-select span4" onchange="EMAILMaker_EditJs.templateActiveChanged(this);">
                            {html_options options=$STATUS selected=$IS_ACTIVE}   
                        </select>
                    </td>
                </tr>
                {* decimal settings *}    					
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_DECIMALS','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <table>
                            <tr>
                                <td align="right" nowrap>{vtranslate('LBL_DEC_POINT','EMAILMaker')}</td>
                                <td><input type="text" maxlength="2" name="dec_point" class="detailedViewTextBox" value="{$DECIMALS.point}" style="width:{$margin_input_width}"/></td>

                                <td align="right" nowrap>{vtranslate('LBL_DEC_DECIMALS','EMAILMaker')}</td>
                                <td><input type="text" maxlength="2" name="dec_decimals" class="detailedViewTextBox" value="{$DECIMALS.decimals}" style="width:{$margin_input_width}"/></td>

                                <td align="right" nowrap>{vtranslate('LBL_DEC_THOUSANDS','EMAILMaker')}</td>
                                <td><input type="text" maxlength="2" name="dec_thousands"  class="detailedViewTextBox" value="{$DECIMALS.thousands}" style="width:{$margin_input_width}"/></td>                                       
                            </tr>
                        </table>
                    </td>
                </tr>    
                {* is default settings *}
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_SETASDEFAULT','EMAILMaker')}:</label></td>    					   
                    <td class="fieldValue" colspan="3">
                        {vtranslate('LBL_FOR_DV','EMAILMaker')}&nbsp;&nbsp;<input type="checkbox" id="is_default_dv" name="is_default_dv" {$IS_DEFAULT_DV_CHECKED}/>
                        &nbsp;&nbsp;
                        {vtranslate('LBL_FOR_LV','EMAILMaker')}&nbsp;&nbsp;<input type="checkbox" id="is_default_lv" name="is_default_lv" {$IS_DEFAULT_LV_CHECKED}/>
                        {* hidden variable for template order settings *}
                        <input type="hidden" name="tmpl_order" value="{$ORDER}" />
                    </td>
                </tr>
            </tbody>
            {********************************************* Sharing DIV *************************************************}
            <tbody id="sharing_div" style="display:none;">
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_TEMPLATE_OWNER','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="template_owner" id="template_owner" class="chzn-select span4">
                            {html_options  options=$TEMPLATE_OWNERS selected=$TEMPLATE_OWNER}
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_SHARING_TAB','EMAILMaker')}:</label></td>
                    <td class="fieldValue" colspan="3">
                        <select name="sharing" id="sharing" class="classname" onchange="EMAILMaker_EditJs.sharing_changed();">
                            {html_options options=$SHARINGTYPES selected=$SHARINGTYPE}
                        </select>

                        <div id="sharing_share_div" style="display:none; border-top:2px dotted #DADADA; margin-top:10px; width:100%;">
                            <table width="100%"  border="0" align="center" cellpadding="5" cellspacing="0">
                                <tr>
                                    <td width="40%" valign=top class="cellBottomDotLinePlain small"><strong>{vtranslate('LBL_MEMBER_AVLBL','EMAILMaker')}</strong></td>
                                    <td width="10%">&nbsp;</td>
                                    <td width="40%" class="cellBottomDotLinePlain small"><strong>{vtranslate('LBL_MEMBER_SELECTED','EMAILMaker')}</strong></td>
                                </tr>
                                <tr>
                                    <td valign=top class="small">
                                        {vtranslate('LBL_ENTITY','EMAILMaker')}:&nbsp;
                                        <select id="sharingMemberType" name="sharingMemberType" class="small" onchange="EMAILMaker_EditJs.showSharingMemberTypes()">
                                            <option value="groups" selected>{$APP.LBL_GROUPS}</option>
                                            <option value="roles">{vtranslate('LBL_ROLES','EMAILMaker')}</option>
                                            <option value="rs">{vtranslate('LBL_ROLES_SUBORDINATES','EMAILMaker')}</option>
                                            <option value="users">{$APP.LBL_USERS}</option>
                                        </select>
                                        <input type="hidden" name="sharingFindStr" id="sharingFindStr">&nbsp;
                                    </td>
                                    <td width="50">&nbsp;</td>
                                    <td class="small">&nbsp;</td>
                                </tr>
                                <tr class="small">
                                    <td valign=top>{vtranslate('LBL_MEMBER_OF','EMAILMaker')} {vtranslate('LBL_ENTITY','EMAILMaker')}<br>
                                        <select id="sharingAvailList" name="sharingAvailList" multiple size="10" class="small crmFormList"></select>
                                    </td>
                                    <td width="50">
                                        <div align="center">
                                            <input type="button" name="sharingAddButt" value="&nbsp;&rsaquo;&rsaquo;&nbsp;" onClick="EMAILMaker_EditJs.sharingAddColumn()" class="crmButton small"/><br /><br />
                                            <input type="button" name="sharingDelButt" value="&nbsp;&lsaquo;&lsaquo;&nbsp;" onClick="EMAILMaker_EditJs.sharingDelColumn()" class="crmButton small"/>
                                        </div>
                                    </td>
                                    <td class="small" style="background-color:#ddFFdd" valign=top>{vtranslate('LBL_MEMBER_OF','EMAILMaker')} &quot;{$GROUPNAME}&quot; <br>
                                        <select id="sharingSelectedColumns" name="sharingSelectedColumns" multiple size="10" class="small crmFormList">
                                            {foreach item=element from=$MEMBER}
                                                <option value="{$element.0}">{$element.1}</option>
                                            {/foreach}
                                        </select>
                                        <input type="hidden" name="sharingSelectedColumnsString" id="sharingSelectedColumnsString" value="" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </tbody>
            {if $TYPE eq "professional" && $THEME_MODE neq "true"}
                {********************************************* Display DIV *************************************************}
                <tbody id="display_div">
                    <tr>
                        <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_DISPLAYED','EMAILMaker')}:</label></td>
                        <td class="fieldValue" colspan="3">
                            <select id="displayedValue" name="displayedValue" class="small">
                                    <option value="0" {if $EMAIL_TEMPLATE_RESULT.displayed neq "1"}selected{/if}>{vtranslate('LBL_YES','EMAILMaker')}</option>
                                    <option value="1" {if $EMAIL_TEMPLATE_RESULT.displayed eq "1"}selected{/if}>{vtranslate('LBL_NO','EMAILMaker')}</option>
                            </select>
                            &nbsp;{vtranslate('LBL_IF','EMAILMaker')}:
                        </td>
                    </tr>
                    <tr>
                        <td class="fieldLabel"><label class="muted pull-right marginRight10px">{vtranslate('LBL_CONDITIONS','EMAILMaker')}:</label></td>
                        <td class="fieldValue" colspan="3">
                            <input type="hidden" name="display_conditions" id="advanced_filter" value='' />
                            <div id="advanceFilterContainer" class="conditionsContainer">
                                {include file='AdvanceFilter.tpl'|@vtemplate_path RECORD_STRUCTURE=$RECORD_STRUCTURE}
                                {*include file="FieldExpressions.tpl"|@vtemplate_path:$QUALIFIED_MODULE EXECUTION_CONDITION=$EMAIL_TEMPLATE_RESULT.conditions*}
                                {*include file="FieldExpressions.tpl"|@vtemplate_path:$QUALIFIED_MODULE EXECUTION_CONDITION=$L*}
                            </div>
                        </td>
                    </tr>
                </tbody>
            {/if}            
        </table>
        {if $ITS4YOUSTYLE_FILES neq ""}
            <div class="row-fluid paddingTop20">
                <div class="modal-body tabbable" style="padding:0px;">
                    <ul class="nav nav-pills" style="margin-bottom:0px; padding-left:5px;">
                        <li class="active" id="body_tab2" onclick="EMAILMaker_EditJs.showHideTab2('body');"><a data-toggle="tab2" href="javascript:void(0);">{vtranslate('LBL_BODY_TAB','EMAILMaker')}</a></li>
                        <li id="css_style_tab2" onclick="EMAILMaker_EditJs.showHideTab2('css_style');"><a data-toggle="tab2" href="javascript:void(0);">{vtranslate('LBL_CSS_STYLE_TAB','EMAILMaker')}</a></li>
                    </ul>
                </div>    
            </div>
        {else}
            <br><br>
        {/if}
        {*********************************************BODY DIV*************************************************}
        
        <div style="display:block;" id="body_div2">
            <textarea name="body" id="body" style="width:90%;height:700px" class=small tabindex="5">{$EMAIL_TEMPLATE_RESULT.body}</textarea>
        </div>
        {if $ITS4YOUSTYLE_FILES neq ""}
        <div class="border" style="display:none; border: 1px solid silver" id="css_style_div2">
            {foreach item=STYLE_DATA from=$STYLES_CONTENT}
                <table class="table table-bordered">
                    <thead>
                        <tr class="listViewHeaders">
                            <th>
                                <div class="pull-left">
                                <a href="index.php?module=ITS4YouStyles&view=Detail&record={$STYLE_DATA.id}" target="_blank">{$STYLE_DATA.name}</a>
                                </div>
                                <div class="pull-right actions">
                                        <a href="index.php?module=ITS4YouStyles&view=Detail&record={$STYLE_DATA.id}" target="_blank"><i title="{vtranslate('LBL_SHOW_COMPLETE_DETAILS', $MODULE)}" class="icon-th-list alignMiddle"></i></a>&nbsp;
                                        {if $STYLE_DATA.iseditable eq "yes"}
                                            <a href="index.php?module=ITS4YouStyles&view=Edit&record={$STYLE_DATA.id}" target="_blank" class="cursorPointer"><i class="icon-pencil alignMiddle" title="{vtranslate('LBL_EDIT', $MODULE)}"></i></a>
                                        {/if}
                                </div>
                            </th>
                        </tr>
                    </thead> 
                    <tbody>
                        <tr>
                            <td>
                                <textarea name="css_style" id="css_style{$STYLE_DATA.id}" style="border: 1px solid black; " class="CodeMirror" tabindex="5">{$STYLE_DATA.stylecontent}</textarea>
                            </td>
                        </tr>
                    </tbody>  
                </table>
                <br>
            {/foreach}            
        </div>
        {/if}
        <script type="text/javascript">
            jQuery(document).ready(function(){ldelim} 
            {if $ITS4YOUSTYLE_FILES neq ""} CKEDITOR.config.contentsCss = [{$ITS4YOUSTYLE_FILES}];{/if}
            {literal}     
                CKEDITOR.replace('body', {height: '1000'}); 
            }){/literal}                        
        </script>
        
        <div class="contentHeader row-fluid">
            <span class="pull-right">
                <button class="btn" type="submit" onclick="document.EditView.redirect.value = 'false';" ><strong>{vtranslate('LBL_APPLY','EMAILMaker')}</strong></button>&nbsp;&nbsp;
                <button class="btn btn-success" type="submit"><strong>{vtranslate('LBL_SAVE', $MODULE)}</strong></button>
                {if $smarty.request.return_view neq ''}
                    <a class="cancelLink" type="reset" onclick="window.location.href = 'index.php?module={if $smarty.request.return_module neq ''}{$smarty.request.return_module}{else}EMAILMaker{/if}&view={$smarty.request.return_view}{if $smarty.request.record neq ""}&record={$smarty.request.record}{/if}';">{vtranslate('LBL_CANCEL', $MODULE)}</a>
                {else}
                    <a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate('LBL_CANCEL', $MODULE)}</a>
                {/if}
            </span>
        </div>
    <div align="center" class="small" style="color: rgb(153, 153, 153);">{vtranslate('EMAIL_MAKER','EMAILMaker')} {$VERSION} {vtranslate('COPYRIGHT','EMAILMaker')}</div>
    </form>
</div>
<script type="text/javascript">
    var selectedTab = 'properties';
    var selectedTab2 = 'body';    
    var module_blocks = new Array();

    var invarray = ['SUBTOTAL', 'TOTALWITHOUTVAT', 'TOTALDISCOUNT', 'TOTALDISCOUNTPERCENT', 'TOTALAFTERDISCOUNT', 
                'VAT', 'VATPERCENT', 'VATBLOCK', 'TOTALWITHVAT', 'ADJUSTMENT', 'TOTAL', 'SHTAXTOTAL', 'SHTAXAMOUNT',
                'CURRENCYNAME', 'CURRENCYSYMBOL', 'CURRENCYCODE'];  


    var selected_module = '{$SELECTMODULE}';
    
    function InsertIntoTemplate(element){ldelim}    
    selectField = document.getElementById(element).value;            
    var oEditor = CKEDITOR.instances.body;           
    if (element != 'header_var' && element != 'footer_var' && element != 'hmodulefields' && element != 'fmodulefields' && element != 'dateval'){ldelim}
    if (selectField != ''){ldelim}
        if (selectField == 'ORGANIZATION_STAMP_SIGNATURE')
                insert_value = '{$COMPANY_STAMP_SIGNATURE}';
        else if (selectField == 'COMPANY_LOGO')
                insert_value = '{$COMPANYLOGO}';
        else if (selectField == 'ORGANIZATION_HEADER_SIGNATURE')
                insert_value = '{$COMPANY_HEADER_SIGNATURE}';
        else if (selectField == 'VATBLOCK')
                insert_value = '{$VATBLOCK_TABLE}';
        else {ldelim}
            if (element == "articelvar" || selectField == "LISTVIEWBLOCK_START" || selectField == "LISTVIEWBLOCK_END")
                insert_value = '#' + selectField + '#';
            else if (element == "relatedmodulefields") {ldelim}                                                  
                rel_module_sorce = document.getElementById('relatedmodulesorce').value; 
                //rel_module_data = rel_module_sorce.split("|");                                    
                insert_value = '$r-'+ selectField+'$';   
            {rdelim}  
            else if (element == "productbloctpl" || element == "productbloctpl2")
                insert_value = selectField;
            else if (element == "global_lang")
                insert_value = '%G_' + selectField + '%';
            else if (element == "module_lang")
                insert_value = '%M_' + selectField + '%';
            else if (element == "custom_lang")
                insert_value = '%' + selectField + '%';
            else if(element == "modulefields") {ldelim}           
               if(inArray(selectField, invarray))
                   insert_value = '$'+selectField+'$';  
               else
                   insert_value = '$s-'+selectField+'$';      
           {rdelim}
            else if (element == "customfunction") {ldelim} 
                var cft = jQuery("#custom_function_type").val();
                if(cft == "after")
                    insert_value = '[CUSTOMFUNCTION_AFTER|'+selectField+'|CUSTOMFUNCTION_AFTER]'; 
                else
                    insert_value = '[CUSTOMFUNCTION|'+selectField+'|CUSTOMFUNCTION]'; 
            {rdelim}
            else
                insert_value = '$' + selectField + '$';
        {rdelim}
        oEditor.insertHtml(insert_value);
    {rdelim}
    {rdelim} else {ldelim}
    if (selectField != ''){ldelim}
    if (element == 'hmodulefields' || element == 'fmodulefields')
            oEditor.insertHtml('$' + selectField + '$');
            else
            oEditor.insertHtml(selectField);
    {rdelim}
    {rdelim}
    {rdelim}    
    {literal}
    function arrayCompare(a1, a2){
        if (a1.length != a2.length) return false;
        var length = a2.length;
        for (var i = 0; i < length; i++){
            if (a1[i] !== a2[i]) return false;
        }
        return true;
    }    
    function inArray(needle, haystack){
        var length = haystack.length;
        for(var i = 0; i < length; i++){
            if(typeof haystack[i] == 'object'){
                if(arrayCompare(haystack[i], needle)) return true;
            } else {
                if(haystack[i] == needle) return true;
            }
        }
        return false;
    }    
    function insertFieldIntoSubject(val){
        if(val!=''){
            if(val=='##DD.MM.YYYY##' || val=='##DD-MM-YYYY##' || val=='##DD/MM/YYYY##' || val=='##MM-DD-YYYY##' || val=='##MM/DD/YYYY##' || val=='##YYYY-MM-DD##')
                document.getElementById('subject').value+= val;
            else
                document.getElementById('subject').value+='$s-'+val+'$'; 
        }               
    }
    {/literal}    
    var constructedOptionValue;
    var constructedOptionName;
    {if $THEME_MODE neq "true"}
    var roleIdArr = new Array({$ROLEIDSTR});
    var roleNameArr = new Array({$ROLENAMESTR});
    var userIdArr = new Array({$USERIDSTR});
    var userNameArr = new Array({$USERNAMESTR});
    var grpIdArr = new Array({$GROUPIDSTR});
    var grpNameArr = new Array({$GROUPNAMESTR});
   
    jQuery(document).ready(function(){
        EMAILMaker_EditJs.isLvTmplClicked('init');
        EMAILMaker_EditJs.sharing_changed();
    });
    {/if}
</script>