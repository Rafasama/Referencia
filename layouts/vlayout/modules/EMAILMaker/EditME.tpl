{*
/*********************************************************************************
 * The content of this file is subject to the ListView Colors 4 You license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
*}
{strip}
    <div class="massemailContents" style="padding-left: 3%;padding-right: 3%">
        <form id="EditMassEmail" name="EditMassEmail" action="index.php" method="post" class="form-horizontal">
            <input type="hidden" name="module" value="EMAILMaker">
            <input type="hidden" name="action" value="SaveME">
            <input type="hidden" name="mode" value="Step{$NEXTSTEP}" />
            <input type="hidden" class="step" value="{$STEP}" />
            <input type="hidden" name="record" value="{$RECORDID}" />
            <input type="hidden" name="emailtemplateid"  id="emailtemplateid" value="{$MASSEMAILRECORD_MODEL->get('templateid')}">
            <div class="padding1per contentsBackground" style="border:1px solid #ccc; box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.5);">
                <div id="massemail_step1">
                    <div class="control-group">
                        <div class="control-label">{vtranslate('LBL_EMAIL_SUBJECT', $QUALIFIED_MODULE)}<span class="redColor">*</span></div>
                        <div class="controls">
                            <input type="text" name="subject" class="span5" data-validation-engine='validate[required]' value="{$MASSEMAILRECORD_MODEL->get('me_subject')}" id="subject" />
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">{vtranslate('LBL_FROM_NAME', $QUALIFIED_MODULE)}</div>
                        <div class="controls">
                            <input type="text" name="from_name" class="span5" value="{$MASSEMAILRECORD_MODEL->get('from_name')}" id="from_name" />
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">{vtranslate('LBL_FROM_EMAIL', $QUALIFIED_MODULE)}<span class="redColor">*</span></div>
                        <div class="controls"><input type="text" name="from_email" class="span5" data-validation-engine='validate[required]' value="{$MASSEMAILRECORD_MODEL->get('from_email')}" id="from_email" /></div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">{vtranslate('LBL_EMAIL_LANGUAGE', $QUALIFIED_MODULE)}</div>
                        <div class="controls">
                            <select name="me_language" id="me_language" class="chzn-select span5">
                                {html_options  options=$EMAIL_LANGUAGES selected=$MASSEMAILRECORD_MODEL->get('language')}
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">{vtranslate('LBL_DESCRIPTION', $QUALIFIED_MODULE)}</div>
                        <div class="controls">
                            <input type="text" name="description" class="span5" value="{$MASSEMAILRECORD_MODEL->get('description')}" id="description" />
                        </div>
                    </div>
                </div>
                <div id="massemail_step2" class="hide">        
                    <div class="control-group">
                        <div class="control-label">{vtranslate('LBL_MODULENAMES', $QUALIFIED_MODULE)}</div>
                        <div class="controls">
                            {assign var=PEDDEFINED_MODULE value=$MASSEMAILRECORD_MODEL->get('module_name')}  
                            {if $PEDDEFINED_MODULE neq "" && $PEDDEFINED_MODULE eq $MASSEMAILRECORD_MODEL->getTemplateModule()}
                                <label><b>{vtranslate($PEDDEFINED_MODULE,$PEDDEFINED_MODULE)}</b></label>
                                <input type="hidden" name="for_module" value="{$PEDDEFINED_MODULE}" class="forModule">
                            {else}
                                <select name="for_module" class="chzn-select forModule">
                                    {foreach name=foreachname item=module_name from=$AVAILABLE_MODULES}
                                    <option value="{$module_name}" {if $PEDDEFINED_MODULE eq $module_name}selected{/if}>{vtranslate($module_name,$module_name)}</option>
                                    {/foreach}
                                </select>
                            {/if} 
                        </div>
                    </div>
                    <div id="moduleFiltersContainer">
                        <div class="control-group">
                            <div class="control-label">{vtranslate('LBL_FILTER', $QUALIFIED_MODULE)}</div>
                            <div class="controls">{$CUSTOMVIEW_OPTION}</div>
                        </div>
                        <div class="control-group">
                            <div class="control-label">{vtranslate('LBL_COLUMN', $QUALIFIED_MODULE)}</div>
                            <div class="controls">{$COLUMNS_OPTION}</div>
                        </div>    
                    </div>    
                        
                </div>
                <div id="massemail_step3" class="hide"></div>   
                <div id="massemail_step4" class="hide">   
                    <div class="control-group">
                        <div class="control-label">{vtranslate('LBL_START_OF', $QUALIFIED_MODULE)}<span class="redColor">*</span></div>
                        <div class="controls">
                            <div class="row-fluid">
                                <div class="pull-left">
                                    <div class="input-append">
                                        <div class="date">
                                            <input id="start_of_date" type="text" class="span2 dateField" name="start_of_date" data-date-format="{$DATEFORMAT}" type="text" value="{$MASSEMAILRECORD_MODEL->get('start_of_date')}" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" />
                                            <span class="add-on"><i class="icon-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="pull-left">
                                    &nbsp;&nbsp; <select name="start_of_time" id="start_of_time" class="span2 chzn-select">
                                    {html_options  options=$HOURS selected=$MASSEMAILRECORD_MODEL->get('start_of_time')}
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="control-label">{vtranslate('LBL_LIMIT', $QUALIFIED_MODULE)}</div>
                        <div class="controls"><input type="text" name="max_limit" data-fieldinfo="{ldelim}{rdelim}" value="{$MASSEMAILRECORD_MODEL->get('limits')}" id="max_limit" class="input-large" data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" /></div>
                    </div>
                </div>
                <div id="massemail_step5" class="hide"></div>
            </div>
            <br>
            <div class="pull-right">
                    <button class="btn btn-danger backStep" type="button"><strong>{vtranslate('LBL_BACK', $QUALIFIED_MODULE)}</strong></button>&nbsp;&nbsp;
                    <span id="sendExampleEmail" class="hide">
                    <button class="btn btn-info sendExampleEmailBTN" type="button"><strong>{vtranslate('LBL_SEND_EXAMPLE_EMAIL', $QUALIFIED_MODULE)}</strong></button>&nbsp;&nbsp;
                    </span>
                    <button class="btn btn-success nextStep" type="submit" disabled="disabled"><strong>{vtranslate('LBL_NEXT', $QUALIFIED_MODULE)}</strong></button>
                    <button class="btn btn-success saveBTN hide" type="submit"><strong>{vtranslate('LBL_SAVE', $QUALIFIED_MODULE)}</strong></button>
                    <a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate('LBL_CANCEL', $QUALIFIED_MODULE)}</a>
            </div>
            <div class="clearfix"></div>
        </form>
    </div><br>
    <div id="sendExmapleEmailContent" class="hide">
        <div class="CustomLabelModalContainer">
            <div class="modal-header">
                <button class="close vtButton" data-dismiss="modal">×</button>
                <h3>{vtranslate('LBL_SEND_EXAMPLE_EMAIL', $QUALIFIED_MODULE)}
                </h3>
            </div>
            <form class="form-horizontal contentsBackground sendExmapleEmailForm">
                <div class="modal-body">
                    <div class="row-fluid">
                        <div class="control-group">
                            <label class="muted control-label">{vtranslate('LBL_SEND_TO', 'EMAILMaker')}<span class="redColor">*</span></label>
                            <div class="controls"><input type="text" name="toemail" data-validation-engine='validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]' data-fieldinfo='{ldelim}&quot;mandatory&quot;:true,&quot;type&quot;:&quot;email&quot;,&quot;name&quot;:&quot;emailaddress&quot;,&quot;label&quot;:&quot;{vtranslate('LBL_SEND_TO', 'EMAILMaker')}&quot;{rdelim}'/></div>	
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="pull-right cancelLinkContainer" style="margin-top:0px;">
                            <a class="cancelLink" type="reset" data-dismiss="modal">{vtranslate('LBL_CANCEL', $MODULE)}</a>
                    </div>
                    <button class="btn btn-success" type="submit" name="sendButton"><strong>{vtranslate('LBL_SEND_EMAIL', $MODULE)}</strong></button>
                </div>
            </form>
        </div>
    </div>
{/strip}