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
            <h3>
							<a href="index.php?parent=Settings&module=MultiCompany4you&view=CompanyList&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}">{vtranslate('LBL_MODULE_NAME', $QUALIFIED_MODULE)}</a> &nbsp;&gt; &nbsp;
            	{vtranslate('LBL_EDIT_COMPANY_DETAILS', $QUALIFIED_MODULE)}{if $DESCRIPTION}<span style="font-size:12px;color: black;"> - &nbsp;{vtranslate({$DESCRIPTION}, $QUALIFIED_MODULE)}</span>{/if}
            </h3>
        </div>
        <hr>

        <form class="form-horizontal"  id="updateCompanyDetailsForm" method="post" action="index.php" enctype="multipart/form-data">
            <input type="hidden" name="module" value="MultiCompany4you" />
            <input type="hidden" name="action" value="Save" />
            <input type="hidden" name="companyid" value="{$smarty.request.companyid}" />
            <input type="hidden" name="block" value="{$smarty.request.block}" />
            <input type="hidden" name="fieldid" value="{$smarty.request.fieldid}" />
            {include file="ModalFooter.tpl"|@vtemplate_path:$QUALIFIED_MODULE}
            <table class="table table-bordered">
                <thead>
                    <tr class="blockHeader">
                        <th><strong>{vtranslate('LBL_COMPANY_LOGO',$QUALIFIED_MODULE)}</strong></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <input type="file" name="logo" id="logoFile" />&nbsp;&nbsp;
                            <span class="alert alert-info">
                                {vtranslate('LBL_LOGO_RECOMMENDED_MESSAGE',$QUALIFIED_MODULE)}
                            </span>
                            {if !empty($ERROR_MESSAGE)}
                                <br><br><div class="marginLeftZero span9 alert alert-error">
                                    {vtranslate($ERROR_MESSAGE,$QUALIFIED_MODULE)}
                                </div>
                            {/if}
                            <div class="companyLogo">
                                <img src="{$MODULE_MODEL->getLogoPath()}" class="alignMiddle" style="max-height:60px;" />
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="table table-bordered">
                <thead>
                    <tr class="blockHeader">
                        <th colspan="2"><strong>{vtranslate('LBL_COMPANY_INFORMATION',$QUALIFIED_MODULE)}</strong></th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$MODULE_MODEL->getFields() item=FIELD_TYPE key=FIELD}
                        {if $FIELD neq 'logoname' && $FIELD neq 'logo' && $FIELD neq 'stampname' && $FIELD neq 'stamp'}
                        <tr>
                            <td width="30%"><strong>{vtranslate($FIELD,$QUALIFIED_MODULE)}{if $FIELD eq 'companyname'}<span class="redColor">*</span>{/if}</strong></td>
                            <td>
                                {if $FIELD eq 'street' || $FIELD eq 'additionalinformations'}
                                    <textarea name="{$FIELD}" style="width: 30.5%">{$MODULE_MODEL->get($FIELD)}</textarea>
                                {elseif $FIELD eq 'role'}
                                    <select id="role" name="role" class="small">
                                        <option value="0">{$APP.LBL_NONE}</option>
                                        {foreach from=$AVAILABLEROLES item="roleinfo" key="iter"}
                                            <option value="{$roleinfo.roleid}"{if $roleinfo.roleid eq $MODULE_MODEL->get($FIELD)} selected="selected"{/if}>{$roleinfo.rolename}</option>
                                        {/foreach}
                                    </select>
                                {else}
                                    <input type="text" {if $FIELD eq 'companyname'} data-validation-engine="validate[required]" {/if} class="input-xlarge" name="{$FIELD}" id="{$FIELD}" value="{$MODULE_MODEL->get($FIELD)}"/>
                                {/if}
                            </td>
                        </tr>
                        {*<div class="control-group">
                            <div class="control-label">
                                {vtranslate($FIELD,$QUALIFIED_MODULE)}{if $FIELD eq 'companyname'}<span class="redColor">*</span>{/if}
                            </div>
                            <div class="controls">
                                {if $FIELD eq 'street' || $FIELD eq 'additionalinformations'}
                                    <textarea name="{$FIELD}" style="width: 30.5%">{$MODULE_MODEL->get($FIELD)}</textarea>
                                {elseif $FIELD eq 'role'}
                                    <select id="role" name="role" class="small">
                                        <option value="0">{$APP.LBL_NONE}</option>
                                        {foreach from=$AVAILABLEROLES item="roleinfo" key="iter"}
                                            <option value="{$roleinfo.roleid}"{if $roleinfo.roleid eq $MODULE_MODEL->get($FIELD)} selected="selected"{/if}>{$roleinfo.rolename}</option>
                                        {/foreach}
                                    </select>
                                {else}
                                    <input type="text" {if $FIELD eq 'companyname'} data-validation-engine="validate[required]" {/if} class="input-xlarge" name="{$FIELD}" id="{$FIELD}" value="{$MODULE_MODEL->get($FIELD)}"/>
                                {/if}
                            </div>
                        </div>*}
                    {/if}
                {/foreach}
                </tbody>
            </table>
            <table class="table table-bordered">
                <thead>
                    <tr class="blockHeader">
                        <th><strong>{vtranslate('LBL_COMPANY_STAMP',$QUALIFIED_MODULE)}</strong></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <input type="file" name="stamp" id="stampFile" />&nbsp;&nbsp;
                            <span class="alert alert-info">
                                {vtranslate('LBL_STAMP_RECOMMENDED_MESSAGE',$QUALIFIED_MODULE)}
                            </span>
                            {if !empty($ERROR_MESSAGE)}
                                <br><br><div class="marginLeftZero span9 alert alert-error">
                                    {vtranslate($ERROR_MESSAGE,$QUALIFIED_MODULE)}
                                </div>
                            {/if}
                            <div class="companyLogo">
                                <img src="{$MODULE_MODEL->getStampPath()}" class="alignMiddle" style="max-height:60px;" />
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            {include file="ModalFooter.tpl"|@vtemplate_path:$QUALIFIED_MODULE}
        </form>
    {/strip}