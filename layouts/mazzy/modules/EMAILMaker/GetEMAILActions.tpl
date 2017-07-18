{*
/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
*}
{if $ENABLE_EMAILMAKER eq 'true'}
    <div class="row-fluid">
        <div class="span10">
            <ul class="nav nav-list">
                {if $CRM_TEMPLATES_EXIST eq '0'}
                <li>
                    <select name="emailtemplateid" id="use_common_email_template" class="detailedViewTextBox" style="width:1{if $MODE neq 'listview'}3{else}0{/if}0%;" size="5">
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
                </li>
                {/if}
                {if $TEMPLATE_LANGUAGES|@sizeof > 1}
                    <li>
                        <select name="email_template_language" id="email_template_language" class="detailedViewTextBox" style="width:1{if $MODE neq 'listview'}3{else}0{/if}0%;" size="1">
                                    {html_options  options=$TEMPLATE_LANGUAGES selected=$CURRENT_LANGUAGE}
                        </select>
                    </li>
                {else}
                    {foreach from="$TEMPLATE_LANGUAGES" item="lang" key="lang_key"}
                        <input type="hidden" name="email_template_language" id="email_template_language" value="{$lang_key}"/>
                    {/foreach}
                {/if}
                {* Send Email *}
                <li>
                    <a href="javascript:;" onclick="EMAILMaker_Actions_Js.emailmaker_sendMail('{$MODULE}','{$ID}','','','{$ID}');" class="webMnu" style="padding-left:10px;"><i class="fa fa-envelope"></i>&nbsp;{vtranslate('LBL_SEND_EMAIL')}</a>
                </li>
            </ul>
        </div>
        <br clear="all"/>
    </div>
{else}
    <div class="row-fluid">
        <div class="span10">
            <ul class="nav nav-list">
                <li><a href="index.php?module=EMAILMaker&view=List">{vtranslate('LBL_PLEASE_FINISH_INSTALLATION', 'EMAILMaker')}</a></li>
            </ul>
        </div>
    </div>
{/if}
