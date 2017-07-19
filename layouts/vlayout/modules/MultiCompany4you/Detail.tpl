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
	            <button id="updateCompanyDetails" class="btn pull-right" onclick="window.location.href = 'index.php?parent=Settings&module=MultiCompany4you&view=Edit&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}&companyid={$smarty.request.companyid}';">{vtranslate('LBL_EDIT',$QUALIFIED_MODULE)}</button>
            </div>
        </div>
        <hr>
        <div class="contents tabbable ui-sortable">
            <ul class="nav nav-tabs layoutTabs massEditTabs">
                <li class="active">
                    <a href=""><strong>{vtranslate('LBL_COMPANY_DETAILS', $QUALIFIED_MODULE)}</strong></a>
                </li>
                <li class="relatedListTab">
                    <a href="index.php?parent=Settings&module=MultiCompany4you&view=Numbering&companyid={$smarty.request.companyid}&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}"><strong>{vtranslate('LBL_NUMBERING', $QUALIFIED_MODULE)}</strong></a>
                </li>
            </ul>
            <div class="tab-content layoutContent padding20 themeTableColor overflowVisible">
                {*<div class="tab-pane active" id="detailViewLayout">Kekso
                </div>
                <div class="tab-pane active" id="relatedTabOrder">koksa
                </div>*}
            </div>
        </div>
        <div  id="CompanyDetailsContainer" class="{if !empty($ERROR_MESSAGE)}hide{/if}">
            <div class="row-fluid">
                <table class="table table-bordered">
                    <thead>
                        <tr class="blockHeader">
                            <th><strong>{vtranslate('LBL_COMPANY_LOGO',$QUALIFIED_MODULE)}</strong></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="companyLogo">
                                    <img src="{$MODULE_MODEL->getLogoPath()}" class="padding10 alignMiddle" style="max-height:60px;" />
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
                            {if $FIELD neq 'logoname' && $FIELD neq 'logo'  && $FIELD neq 'stampname' && $FIELD neq 'stamp' && $FIELD neq 'role'}
                                <tr>
                                    <td width="30%"><strong>{vtranslate($FIELD,$QUALIFIED_MODULE)}</strong></td>
                                    <td>{$MODULE_MODEL->get($FIELD)}</td>
                                </tr>
                            {/if}
                            {if $FIELD eq 'role'}
                                <tr>
                                    <td width="30%"><strong>{vtranslate($FIELD,$QUALIFIED_MODULE)}</strong></td>
                                    <td>{$MODULE_MODEL->get('rolename')}</td>
                                </tr>
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
                                <div class="companyLogo">
                                    <img src="{$MODULE_MODEL->getStampPath()}" class="padding10 alignMiddle" style="max-height:60px;" />
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    {/strip}