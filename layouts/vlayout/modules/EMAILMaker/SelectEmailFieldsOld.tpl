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
    <div id="sendEmailContainer" class="modelContainer"  style="min-width: 400px">
        <form class="form-horizontal" id="SendEmailFormStep1" method="post" action="index.php">
            <div class="modal-header contentsBackground">
                <span class='pull-right'>
                    <span class=" pull-right cancelLinkContainer">
                        <a class="cancelLink" type="reset" data-dismiss="modal">{vtranslate('LBL_CANCEL', $MODULE)}</a>
                    </span>
                    {if $EMAIL_FIELDS_COUNT neq "0" || $BASIC neq "true"}<button class="btn addButton" type="submit" name="selectfield"><strong>{vtranslate('LBL_SELECT', $MODULE)}</strong></button>{/if}
                </span>
                <h3>{if $FORLISTVIEW eq 'yes' && $EMAIL_FIELDS_COUNT eq "0"}{vtranslate('LBL_SELECT_TEMPLATES','EMAILMaker')}{else}{vtranslate('LBL_SELECT_EMAIL_IDS', $MODULE)}{/if}</h3>
            </div>
            <input type="hidden" name="selected_ids" value={ZEND_JSON::encode($SELECTED_IDS)} />
            <input type="hidden" name="excluded_ids" value={ZEND_JSON::encode($EXCLUDED_IDS)} />
            <input type="hidden" name="cvid" value="{$VIEWNAME}" />
            <input type="hidden" name="viewname" value="{$VIEWNAME}" />
            <input type="hidden" name="module" value="{$MODULE}"/>
            <input type="hidden" name="view" value="ComposeEmail"/>
            <input type="hidden" name="search_key" value= "{$SEARCH_KEY}" />
            <input type="hidden" name="operator" value="{$OPERATOR}" />
            <input type="hidden" name="search_value" value="{$ALPHABET_VALUE}" />
            <input type="hidden" name="ispdfactive" id="ispdfactive" value="0" />
            <input type="hidden" name="total_emailoptout" value="{$TOTAL_EMAILOPTOUT}" />
            {if !empty($PARENT_MODULE)}
                <input type="hidden" name="sourceModule" value="{$PARENT_MODULE}" />
                <input type="hidden" name="sourceRecord" value="{$PARENT_RECORD}" />
                <input type="hidden" name="parentModule" value="{$RELATED_MODULE}" />
            {/if}
            {if $FORLISTVIEW neq 'yes'}
                <input type="hidden" name="ispdfactive" value="{if $PDFTEMPLATEID neq ""}1{else}0{/if}">
                <input type="hidden" name="pdftemplateid" value="{$PDFTEMPLATEID}">
                <input type="hidden" name="pdflanguage" value="{$PDFLANGUAGE}">
            {/if}
            <div id='multiEmailContainer'>
                <div class='padding20'>
                    {if $FORLISTVIEW eq 'yes'}
                        {if $EMAIL_FIELDS_COUNT neq "0"}<h4>{vtranslate('LBL_SELECT_TEMPLATES','EMAILMaker')}</h4><br>{/if} 
                        {if $CRM_TEMPLATES_EXIST eq '0'}
                            <select id="use_common_email_template" name="emailtemplateid" class="detailedViewTextBox" style="width:100%">
                                <option value="">{vtranslate('LBL_NONE','EMAILMaker')}</option>
                                {foreach from=$CRM_TEMPLATES["1"] item="options" key="category_name"}
                                    <optgroup label="{$category_name}">
                                        {foreach from=$options item="option"}
                                        <option value="{$option.value}" {if $option.title neq ""}title="{$option.title}"{/if} {if $option.value eq $DEFAULT_TEMPLATE}selected{/if}>{$option.label}</option>   
                                        {/foreach}
                                    </optgroup>
                                {/foreach}
                                {foreach from=$CRM_TEMPLATES["0"] item="option"}
                                    <option value="{$option.value}" {if $option.title neq ""}title="{$option.title}"{/if} {if $option.value eq $DEFAULT_TEMPLATE}selected{/if}>{$option.label}</option>    
                                {/foreach}
                            </select>        
                        {/if}
                        {if $IS_PDFMAKER eq 'yes'}
                        <div class='hide' id='EMAILMakerPDFTemplatesContainer'>
                        <br><h4>{vtranslate('LBL_PDFMAKER_TEMPLATES','EMAILMaker')}</h4><br>
                        <select id="use_common_pdf_template" class="detailedViewTextBox" multiple style="width:100%;" size="5">
                        {foreach name="tplForeach" from="$PDF_TEMPLATES" item="itemArr" key="templateid"}
                            {if $itemArr.is_default eq '1' || $itemArr.is_default eq '3'}
                                <option value="{$templateid}" selected="selected">{$itemArr.templatename}</option>
                            {else}
                                <option value="{$templateid}">{$itemArr.templatename}</option>
                            {/if}
                        {/foreach}
                        </select><br>
                        <div class='pull-right' style='padding:10px 0px 10px 0px'><button id='removePDFMakerTemplate' class='btn' onClick='return false'><!--i class='icon-plus-sign'></i--><i class="icon-minus icon-black"></i> {vtranslate('LBL_REMOVE_PDFMAKER_TEMPLATES','EMAILMaker')}</button></div>
                        </div>
                        {/if}
                        <br><br>
                        {if $TEMPLATE_LANGUAGES|@sizeof > 1}
                            <select name="email_template_language" id="email_template_language" class="detailedViewTextBox" style="width:100%" size="1">
                                        {html_options  options=$TEMPLATE_LANGUAGES selected=$CURRENT_LANGUAGE}
                            </select>
                        {else}
                            {foreach from="$TEMPLATE_LANGUAGES" item="lang" key="lang_key"}
                                <input type="hidden" name="email_template_language" id="email_template_language" value="{$lang_key}"/>
                            {/foreach}
                        {/if}
                        <br><br>
                        {if $IS_PDFMAKER eq 'yes'}
                        <span class='pull-right' id='EMAILMakerPDFTemplatesBtn'><button id='addPDFMakerTemplate' class='btn' onClick='return false'><!--i class='icon-plus-sign'></i--><i class="icon-plus icon-black"></i> {vtranslate('LBL_ADD_PDFMAKER_TEMPLATES','EMAILMaker')}</button></span>
                        {/if}
                        {if $EMAIL_FIELDS_COUNT neq "0"}<br><h4>{vtranslate('LBL_EMAILS','EMAILMaker')}</h4><br>{/if} 
                    {/if}
                    {assign var=IS_INPUT_CHECKED_DEFINED value='0'}
                    {foreach item=EMAIL_FIELD_LIST from=$EMAIL_FIELDS_LIST name= email_fields_foreach}
                        {foreach item=EMAIL_FIELD_DATA key=EMAIL_FIELD_NAME from=$EMAIL_FIELD_LIST name=emailFieldIterator}
                            {assign var=EMAIL_NAME value=$EMAIL_FIELD_DATA.crmname}
                            {if $EMAIL_FIELD_DATA.crmname neq ""}{assign var=EMAIL_NAME value=$EMAIL_FIELD_DATA.crmname}{else}{assign var=EMAIL_NAME value=$EMAIL_FIELD_DATA.fieldlabel}{/if}
                            
                            {if $EMAIL_FIELD_DATA.emailoptout eq "0" && $smarty.foreach.emailFieldIterator.index eq "0" && $SINGLE_RECORD eq "yes" && $IS_INPUT_CHECKED_DEFINED eq "0"}
                                {assign var=IS_INPUT_CHECKED value='checked'}
                                {assign var=IS_INPUT_CHECKED_DEFINED value='1'}
                            {else}
                                {assign var=IS_INPUT_CHECKED value=''}
                            {/if}
                            <div class="control-group">
                                <label title="{$EMAIL_FIELD_DATA.fieldlabel} &lt;{$EMAIL_FIELD_DATA.label}&gt;" {if $EMAIL_FIELD_DATA.emailoptout eq "1" && $SINGLE_RECORD eq "yes"}class="redColor"{/if}>
                                    <input type="checkbox" class="emailField" data-email="{$EMAIL_FIELD_DATA.value}" value="{$EMAIL_FIELD_DATA.crmid}|{$EMAIL_FIELD_DATA.fieldname}|{$EMAIL_FIELD_DATA.module}" {$IS_INPUT_CHECKED}/>&nbsp;
                                    {if $EMAIL_NAME neq ""}<b>{$EMAIL_NAME}</b> &nbsp; {/if}&lt;{if $EMAIL_FIELD_DATA.value neq "" && $SINGLE_RECORD eq "yes"}{$EMAIL_FIELD_DATA.value}{else}{$EMAIL_FIELD_DATA.label}{/if}&gt;
                                    {if $EMAIL_FIELD_DATA.emailoptout eq "1" && $SINGLE_RECORD eq "yes"}&nbsp({vtranslate('Email Opt Out', $MODULE)}){/if}
                                </label>
                            </div>
                        {/foreach}
                    {/foreach}
                    {if $EMAIL_FIELDS_COUNT eq "0" && $SOURCE_NAME neq "" && $FORLISTVIEW neq 'yes'}{$SOURCE_NAME} {vtranslate('DO_NOT_HAVE_AN_EMAIL_ID','EMAILMaker')}{/if} 
                </div>
            </div>
            <div class='modal-footer'>
                <div class=" pull-right cancelLinkContainer">
                    <a class="cancelLink" type="reset" data-dismiss="modal">{vtranslate('LBL_CANCEL', $MODULE)}</a>
                </div>
                {if $EMAIL_FIELDS_COUNT neq "0" || $BASIC neq "true"}<button class="btn addButton" type="submit" name="selectfield"><strong>{vtranslate('LBL_SELECT', $MODULE)}</strong></button>{/if}
            </div>
            {if $RELATED_LOAD eq true}
                <input type="hidden" name="relatedLoad" value={$RELATED_LOAD} />
            {/if}
        </form>
    </div>
{/strip}