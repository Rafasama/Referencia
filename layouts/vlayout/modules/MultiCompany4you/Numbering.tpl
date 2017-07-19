{*<!--
/* * *******************************************************************************
* The content of this file is subject to the MultiCompany4you license.
* ("License"); You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
* Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
* All Rights Reserved.
* ****************************************************************************** */
-->*}
{strip}
    <input type="hidden" id="supportedImageFormats" value='{ZEND_JSON::encode(MultiCompany4you_CompanyDetails_Model::$logoSupportedFormats)}' />
    <div class="padding-left1per">
        <div class="row-fluid widget_header">
            <div class="span8">
							<h3>
            		<a href="index.php?parent=Settings&module=MultiCompany4you&view=CompanyList&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}">{vtranslate('LBL_MODULE_NAME', $QUALIFIED_MODULE)}</a>
            		{if $DESCRIPTION}<span style="font-size:12px;color: black;"> - &nbsp;{vtranslate({$DESCRIPTION}, $QUALIFIED_MODULE)}</span>{/if}
							</h3>
						</div>
						<div class="span4">
	            <button id="NumberingSettings" class="btn pull-right" onclick="window.location.href = 'index.php?parent=Settings&module=MultiCompany4you&view=NumberingModules&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}&companyid={$smarty.request.companyid}';" title="{vtranslate('LBL_CONFIGURE_MODULES_FOR_CN', $QUALIFIED_MODULE)}"><img class="alignMiddle" src="{vimage_path('tools.png')}" alt="{vtranslate($QUALIFIED_MODULE, $QUALIFIED_MODULE)}" /></button>
            </div>
        </div>
        <hr>
        <div class="contents tabbable ui-sortable">
            <ul class="nav nav-tabs layoutTabs massEditTabs">
                <li class="relatedListTab">
                    <a href="index.php?parent=Settings&module=MultiCompany4you&view=Detail&companyid={$smarty.request.companyid}&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}"><strong>{vtranslate('LBL_COMPANY_DETAILS', $QUALIFIED_MODULE)}</strong></a>
                </li>
                <li class="active">
                    <a href=""><strong>{vtranslate('LBL_NUMBERING', $QUALIFIED_MODULE)}</strong></a>
                </li>
            </ul>
            <div class="tab-content layoutContent padding20 themeTableColor overflowVisible">
            </div>
        </div>
        <div  id="CompanyDetailsContainer">
            <div class="row-fluid">
                <form id="EditView" method="post">
                    <input type="hidden" id="companyid" name="companyid" value="{$smarty.request.companyid}">
                    <div class="row-fluid">
                        <div class="span12">
                            <table id="customRecordNumbering" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th width="30%">
                                            <strong>{vtranslate('LBL_CUSTOMIZE_RECORD_NUMBERING', $QUALIFIED_MODULE)}</strong>
                                        </th>
                                        <th width="70%">
                                            <span class="pull-right">
                                                <button type="button" class="btn" name="updateRecordWithSequenceNumber"><b>{vtranslate('LBL_UPDATE_MISSING_RECORD_SEQUENCE', $QUALIFIED_MODULE)}</b></button>
                                            </span>
                                        </th>
                                    </tr>
                                </thead>

                                <tbody>
                                    {if $SUPPORTED_MODULES_COUNT > 0}
                                        {assign var=DEFAULT_MODULE_DATA value=$DEFAULT_MODULE_MODEL->getModuleCustomNumberingData($smarty.request.companyid)}
                                        {assign var=DEFAULT_MODULE_NAME value=$DEFAULT_MODULE_MODEL->getName()}
                                        <tr>
                                            <td class="fieldLabel">
                                                <label class="pull-right marginRight10px"><b>{vtranslate('LBL_SELECT_MODULE', $QUALIFIED_MODULE)}</b></label>
                                            </td>
                                            <td class="fieldValue">
                                                <select class="chzn-select" name="sourceModule">
                                                    {foreach key=index item=MODULE_MODEL from=$SUPPORTED_MODULES}
                                                        {assign var=MODULE_NAME value=$MODULE_MODEL->get('name')}
                                                        <option value={$MODULE_NAME} {if $MODULE_NAME eq $DEFAULT_MODULE_NAME} selected {/if}>
                                                            {vtranslate($MODULE_NAME, $MODULE_NAME)}
                                                        </option>
                                                    {/foreach}
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="fieldLabel">
                                                <label class="pull-right marginRight10px"><b>{vtranslate('LBL_USE_PREFIX', $QUALIFIED_MODULE)}</b></label>
                                            </td>
                                            <td class="fieldValue">
                                                <input type="text" value="{$DEFAULT_MODULE_DATA['prefix']}" data-old-prefix="{$DEFAULT_MODULE_DATA['prefix']}" name="prefix" data-validation-engine="validate[funcCall[MultiCompany_AlphaNumeric_Validator_Js.invokeValidation]]"/>
                                                &nbsp;
																								<select name="special_values" onchange="if (this.value != 0) this.form.prefix.value += this.value" class="chzn-select">
                                                    <option value="0">{vtranslate('LBL_CHOOSE_ONCE', $QUALIFIED_MODULE)}
                                                    <option value="$year$">{vtranslate('LBL_YEAR', $QUALIFIED_MODULE)}
                                                    <option value="$month$">{vtranslate('LBL_MONTH', $QUALIFIED_MODULE)}
                                                    <option value="$week$">{vtranslate('LBL_WEEK', $QUALIFIED_MODULE)}
                                                    <option value="$day$">{vtranslate('LBL_DAY', $QUALIFIED_MODULE)}
                                                </select>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="fieldLabel">
                                                <label class="pull-right marginRight10px">
                                                    <b>{vtranslate('LBL_START_SEQUENCE', $QUALIFIED_MODULE)}</b><span class="redColor">*</span>
                                                </label>
                                            </td>
                                            <td class="fieldValue">
                                                <input type="text" value="{$DEFAULT_MODULE_DATA['cur_id']}"
                                                       data-old-sequence-number="{$DEFAULT_MODULE_DATA['sequenceNumber']}" name="sequenceNumber"
                                                       data-validation-engine="validate[required,funcCall[Vtiger_WholeNumber_Validator_Js.invokeValidation]]"/>
                                            </td>
                                        </tr>
                                    {else}
                                        <tr>
                                            <td>{vtranslate('no_supported_module_info', $QUALIFIED_MODULE)}</td>
                                        </tr>
                                    {/if}
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <br>
                    <div class="row-fluid">
                        <div class="span12">
                            <span class="pull-right">
                                <button class="btn btn-success saveButton" type="submit" disabled="disabled"><strong>{vtranslate('LBL_SAVE', $QUALIFIED_MODULE)}</strong></button>
                                <a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate('LBL_CANCEL', $QUALIFIED_MODULE)}</a>
                            </span>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    {/strip}
    <script type="text/javascript">
        jQuery('#js_strings').html('{Zend_Json::encode($JS_LANG)}');
    </script>