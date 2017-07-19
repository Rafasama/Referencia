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
<div class="SendEmailFormStep2" id="composeEmailContainer">
    <form class="form-horizontal" id="massEmailForm" method="post" action="index.php" enctype="multipart/form-data" name="massEmailForm">
    <input type="hidden" name="selected_ids" value='{ZEND_JSON::encode($SELECTED_IDS)}' />
    <input type="hidden" name="excluded_ids" value='{ZEND_JSON::encode($EXCLUDED_IDS)}' />
    <input type="hidden" name="viewname" value="{$VIEWNAME}" />
    <input type="hidden" name="module" value="EMAILMaker"/>
    <input type="hidden" name="for_module" value="{$FOR_MODULE}"/>
    <input type="hidden" name="mode" value="massSave" />
    <div class="hide" style="display:none;">
    <textarea name="toemailinfo_emailField" >{if $TOMAIL_INFO neq ""}{ZEND_JSON::encode($TOMAIL_INFO)}{else}{}{/if}</textarea>
    <textarea name="toMailNamesList_emailField" >{if $TOMAIL_NAMES_LIST neq ""}{ZEND_JSON::encode($TOMAIL_NAMES_LIST)}{else}{}{/if}</textarea>
    <textarea name="toemailinfo_emailCCField" >{if $TOMAIL_CC_INFO neq ""}{ZEND_JSON::encode($TOMAIL_CC_INFO)}{else}{}{/if}</textarea>
    <textarea name="toMailNamesList_emailCCField" >{if $TOMAIL_CC_NAMES_LIST neq ""}{ZEND_JSON::encode($TOMAIL_CC_NAMES_LIST)}{else}{}{/if}</textarea>
    <textarea name="toemailinfo_emailBCCField" >{if $TOMAIL_BCC_INFO neq ""}{ZEND_JSON::encode($TOMAIL_BCC_INFO)}{else}{}{/if}</textarea>
    <textarea name="toMailNamesList_emailBCCField" >{if $TOMAIL_BCC_NAMES_LIST neq ""}{ZEND_JSON::encode($TOMAIL_BCC_NAMES_LIST)}{else}{}{/if}</textarea>
    </div>
    <input type="hidden" name="view" value="MassSaveAjax" />
    <input type="hidden" name="to" value=""/>
    <input type="hidden" id="flag" name="flag" value="" />
    <input type="hidden" id="maxUploadSize" value="{$MAX_UPLOAD_SIZE}" />
    <input type="hidden" id="documentIds" name="documentids" value="" />
    <input type="hidden" name="emailMode" value="{$EMAIL_MODE}" />
    <input type="hidden" value="EMAILMaker_Popup_Js" id="popUpClassName"/>
    <input type="hidden" id="emails_seq" value="{$EMAILS_SEQ}" />
    {if !empty($PARENT_EMAIL_ID)}
        <input type="hidden" name="parent_id" value="{$PARENT_EMAIL_ID}" />
        <input type="hidden" name="parent_record_id" value="{$PARENT_RECORD}" />
    {/if}
    {if !empty($RECORDID)}
        <input type="hidden" name="record" value="{$RECORDID}" />
    {/if}
    <input type="hidden" name="search_key" value= "{$SEARCH_KEY}" />
    <input type="hidden" name="operator" value="{$OPERATOR}" />
    <input type="hidden" name="search_value" value="{$ALPHABET_VALUE}" />  
    <input type="hidden" name="email_language" value="{$EMAIL_LANGUAGE}" />
    <input type="hidden" name="sorce_ids" value="{$smarty.request.pid}" />
    <input type="hidden" id="selected_sourceid" name="selected_sourceid" value="{$SELECTED_SOURCEID}">
    
    <div class="row-fluid margin0px" style="padding-top:10px">	
        <div class="span7 margin0px padding-right1per">
            <span class="span7 row-fluid margin0px padding-bottom1per">
                    <h3>{vtranslate('LBL_COMPOSE_EMAIL', $MODULE)}</h3>
            </span>
        </div>
        <span class="span5 row-fluid margin0px">
             <select name="from_email" class="span12" title="{vtranslate('LBL_FROM_EMAIL','EMAILMaker')}">
            {html_options  options=$FROM_EMAILS selected=$SELECTED_DEFAULT_FROM}
            </select>
        </span>
    </div>
    <hr class="margin0px " style='width:100%'>                    
        <div class="row-fluid margin0px">	
            <div class="span7 margin0px">
                <div style="padding-right:20px;padding-top:5px;">
                    <div class="row-fluid" style="height:140px;">
                            <span class="row-fluid">
                                {if $SINGLE_RECORD neq 'yes'}
                                    <span class="span2 textAlignRight">
                                        <label class="padding5per">{vtranslate('LBL_RECORDS_LIST',$FOR_MODULE)}:</label>
                                    </span>
                                    <span class="span">
                                        <select class="chzn-select emailSourcesList">
                                        {foreach item=source_name key=source_id name="sourcenames" from=$SOURCE_NAMES}
                                            <option value="{$source_id}" {if $SELECTED_SOURCEID eq $source_id}selected{/if}>{$source_name}</option>
                                        {/foreach}
                                        </select>
                                    </span>
                                {/if}
                                <div class="input-prepend">
                                    <span class="pull-right">
                                        <select name="select_recipients" class="chzn-select emailModulesList" style="width:150px;">
                                            <optgroup>
                                                 {if $FOR_MODULE|in_array:$RELATED_MODULES}
                                                     {assign var=SELECTED_FOR_MODULE value=$FOR_MODULE} 
                                                 {else}
                                                     {if "Contacts"|in_array:$RELATED_MODULES}
                                                         {assign var=SELECTED_FOR_MODULE value="Contacts"} 
                                                     {elseif "Accounts"|in_array:$RELATED_MODULES}
                                                         {assign var=SELECTED_FOR_MODULE value="Accounts"} 
                                                     {else}
                                                         {assign var=SELECTED_FOR_MODULE value=""} 
                                                     {/if}
                                                 {/if}
                                                 {foreach item=MODULE_NAME from=$RELATED_MODULES}
                                                         <option value="{$MODULE_NAME}" {if $SELECTED_FOR_MODULE eq $MODULE_NAME}selected{/if}>{vtranslate($MODULE_NAME,$MODULE_NAME)}</option>
                                                 {/foreach}
                                                 <option value="">{vtranslate('LBL_OTHER','EMAILMaker')}</option>
                                             </optgroup>
                                        </select>
                                        <span class="pull-right" id="select_recipients">       
                                             <span id="selectEmailBtn" data-sourceid="{$SELECTED_SOURCEID}" class="add-on selectEmail cursorPointer "><i class="icon-search" title="{vtranslate('LBL_SELECT', $MODULE)}"></i></span>
                                        </span>
                                    </span>
                                </div>
                            </span>                                                    
                            <span class="row-fluid">
                                <span class="span2 textAlignRight">{vtranslate('LBL_TO',$MODULE)}<span class="redColor">*</span>:</span>
                                {if !empty($TO)}
                                        {assign var=TO_EMAILS value=","|implode:$TO}
                                {/if}
                                <span class="span10">
                                            <input id="emailField" name="toEmail" type="text" style="width:100%" class="autoComplete sourceField select2"
                                            value="{$TO_EMAILS}" data-validation-engine="validate[required{*, funcCall[Vtiger_To_EMAILMaker_Validator_Js.invokeValidation]*}]"
                                            data-fieldinfo='{$FIELD_INFO}' {if !empty($SPECIAL_VALIDATOR)}data-validator='{Zend_Json::encode($SPECIAL_VALIDATOR)}'{/if}/>
                                </span>
                            </span>                                
                            <div class="row-fluid {if empty($CC)}hide {/if}" id="ccContainer" style="margin-top:5px">
                                        <div class="span2 textAlignRight">{vtranslate('LBL_CC',$MODULE)}:</div>
                                        <span class="span10">
                                        <input id="emailCCField" class="autoComplete sourceField select2" style="width:100%" type="text" name="cc" value="{if !empty($CC)}{$CC}{/if}"/>
                                        </span>
                            </div>            
                            <div class="row-fluid {if empty($BCC)}hide {/if}" id="bccContainer" style="margin-top: 5px">
                                    <span class="span2 textAlignRight">{vtranslate('LBL_BCC',$MODULE)}:</span>
                                    <span class="span10">
                                    <input id="emailBCCField" class="autoComplete sourceField select2" style="width:100%"  class="span10" type="text" name="bcc" value="{if !empty($BCC)}{$BCC}{/if}"/>
                                    </span>
                            </div>
                            <div class="row-fluid {if (!empty($CC)) and (!empty($BCC))} hide {/if} padding10">
                                                <span class="span2">&nbsp;</span>
                                                <span class="span10">
                                                        <a class="cursorPointer {if (!empty($CC))}hide{/if}" id="ccLink">{vtranslate('LBL_ADD_CC', $MODULE)}</a>&nbsp;&nbsp;
                                                        <a class="cursorPointer {if (!empty($BCC))}hide{/if}" id="bccLink">{vtranslate('LBL_ADD_BCC', $MODULE)}</a>
                                                </span>
                            </div>                                
                    </div>                    
                    <span class="row-fluid margin0px zeroPaddingAndMargin" >
                        <span class="span12 row-fluid zeroPaddingAndMargin" style="padding-top:5px">
                            <span class="span2"> 
                                <span class="margin0px textAlignRight">
                                    <label style="padding:5px;">{vtranslate('LBL_SUBJECT',$MODULE)}<span class="redColor">*</span>:</label>
                                </span>
                            </span>
                            <span class="span10 textAlignRight" style="margin:0px 0px 0px 10px">   
                                <input class="row-fluid" data-validation-engine='validate[required]' style="width:99%"  type="text" name="subject" value="{$SUBJECT}" id="subject"/> 
                            </span>                            
                        </span>    
                    </span>                            
                </div>
            </div>
            <div class="span5 margin0px" style="padding-top:5px;">
                <div class="summaryWidgetContainer margin0px">
                    <div class="widgetContainer_1" {if $PDFTEMPLATES eq ""}style="height:140px"{/if}>
                        <div class="widget_header row-fluid">
                            <div class="marginBottom10px"><h4>{vtranslate('LBL_ATTACHMENT',$MODULE)}</h4>
                            </div>
                           <div class="row-fluid margin0px">
                                <span class="pull-left"><input type="file" id="multiFile" name="file[]" class="btn btn-small" /></span>     
                                <span class="pull-right"><button type="button" class="btn btn-small" id="browseCrm" data-url="{$DOCUMENTS_URL}" title="{vtranslate('LBL_BROWSE_CRM',$MODULE)}">{vtranslate('LBL_BROWSE_CRM',$MODULE)}</button></span> 
                           </div> 
                         </div>
                        <div class="widget_contents">
                             <div id="attachments" class="row-fluid" {if $PDFTEMPLATES eq ""}style="overflow:auto;height:80px;"{/if}>
                                {foreach item=ATTACHMENT from=$ATTACHMENTS}
                                        {if ('docid'|array_key_exists:$ATTACHMENT)}
                                                {assign var=DOCUMENT_ID value=$ATTACHMENT['docid']}
                                                {assign var=FILE_TYPE value="document"}
                                        {else}
                                                {assign var=FILE_TYPE value="file"}
                                        {/if}
                                        <div class="MultiFile-label customAttachment" data-file-id="{$ATTACHMENT['fileid']}" data-file-type="{$FILE_TYPE}"  data-file-size="{$ATTACHMENT['size']}" {if $FILE_TYPE eq "document"} data-document-id="{$DOCUMENT_ID}"{/if}>
                                        {if $ATTACHMENT['nondeletable'] neq true}
                                            <a name="removeAttachment" class="cursorPointer">x </a>
                                        {/if}
                                        <span>{$ATTACHMENT['attachment']}</span>
                                        </div>
                                {/foreach}
                             </div>
                        </div>
                        {if $PDFTEMPLATES neq ""}<br>
                           <div class="widget_header row-fluid">
                                <h4>{vtranslate('LBL_PDFMAKER_TEMPLATES','EMAILMaker')}</h4>
                           </div>
                           {foreach key=pdftemplateid item=pdftemplatename from=$PDFTEMPLATES}
                               <div class="MultiFile-label customAttachment">
                               <span>{$pdftemplatename}</span>
                               </div>
                          {/foreach}
                          <input type="hidden" name="pdftemplateids" value="{$PDFTEMPLATEIDS}"> 
                          <input type="hidden" name="pdflanguage" value="{$PDFLANGUAGE}">
                       {/if}           
                    </div>   
                </div>
            </div>
        </div>
        <div class="row-fluid margin0px">
                <div class="btn-toolbar zeroPaddingAndMargin">
                    <div class="row-fluid btn-group">
                        <button class="floatNone btn btn-success" id="sendEmail" type="submit" title="{vtranslate('LBL_SEND',$MODULE)}"><span class="paddingLeftRight10px"><span class="paddingLeftRight10px"><strong>{vtranslate('LBL_SEND',$MODULE)}</strong></span></span></button>&nbsp;&nbsp;
                        <button type="button" class="btn" id="selectEmailTemplate" data-url="{$EMAIL_TEMPLATE_URL}" title="{vtranslate('LBL_SELECT_EMAIL_TEMPLATE',$MODULE)}"><strong>{vtranslate('LBL_SELECT_EMAIL_TEMPLATE',$MODULE)}</strong></button>
                         <span name="progressIndicator" style="height:30px;">&nbsp;</span>
                    </div>                   
            </div>
        </div>
        {if $RELATED_LOAD eq true}
            <input type="hidden" name="related_load" value={$RELATED_LOAD} />
        {/if}
		<textarea id="description" name="description">{$DESCRIPTION}</textarea>
		<input type="hidden" name="attachments" value='{ZEND_JSON::encode($ATTACHMENTS)}' />
                <div class="row-fluid margin0px">
			<div class="span8">
				<div class="btn-toolbar" >
					<span class="btn-group">
						<button class="floatNone btn btn-success" id="sendEmail2" type="submit" title="{vtranslate('LBL_SEND',$MODULE)}"><span class="paddingLeftRight10px"><span class="paddingLeftRight10px"><strong>{vtranslate('LBL_SEND',$MODULE)}</strong></span></span></button>&nbsp;&nbsp;
					</span>
				</div>
			</div>
		</div>
	</form>
</div>
<select id="to_selectbox_pattern" class="buttonNormal margin0px span2" style="display:none">
    <option value="to">{vtranslate("LBL_TO",$MODULE)}</option>
    <option value="cc">{vtranslate("LBL_CC",$MODULE)}</option>
    <option value="bcc">{vtranslate("LBL_BCC",$MODULE)}</option>
</select>
<div id="setEmailAddress" class='hide modelContainer'>
	<div class="modal-header ">
		<button data-dismiss="modal" class="close" title="{vtranslate('LBL_CLOSE')}">x</button>
		<h3 style="white-space: nowrap;padding-right: 40px;">{vtranslate('LBL_SET_EMAIL_ADRESS', 'EMAILMaker')}</h3>
	</div>
	<form class="form-horizontal row-fluid" method="post" action="index.php">
		<div name='exportCalendar'>
                    <div class="modal-body">
                        <div class="row-fluid">
                            <div class="control-group">
                                <label class="muted control-label">{vtranslate('SINGLE_Emails')}</label>
                                <div class="controls input-append">
                                        <input type="text" name="emailaddress" class="input-large" placeholder="" value="" data-validation-engine="validate[funcCall[Vtiger_Email_Validator_Js.invokeValidation]]" />
                                </div>	
                            </div>
                        </div>
                    </div>
		</div>
		<div class="modal-footer">
			<button class="btn btn-success" type="button" name="setButton"><strong>{vtranslate('LBL_ADD')}</strong></button>
                </div>
	</form>
</div>
{include file='JSResources.tpl'|@vtemplate_path}
{/strip}