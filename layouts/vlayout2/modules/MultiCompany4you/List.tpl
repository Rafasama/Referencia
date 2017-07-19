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
    <div class="padding-left1per">
        <div class="row-fluid widget_header">
            <div class="span8">
							<h3>
								{vtranslate('LBL_COMPANY_LIST', $QUALIFIED_MODULE)}
								{if $DESCRIPTION}<span style="font-size:12px;color: black;"> - &nbsp;{vtranslate({$DESCRIPTION}, $QUALIFIED_MODULE)}</span>{/if}
							</h3>
						</div>
						<div class="span4">
            	{*button id="updateCompanyDetails" class="btn pull-right">{vtranslate('LBL_EDIT',$QUALIFIED_MODULE)}</button>*}
            	<button id="NumberingSettings" class="btn pull-right" onclick="window.location.href = 'index.php?parent=Settings&module=MultiCompany4you&view=License&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}';" title="{vtranslate('LICENSE_SETTINGS_INFO', $QUALIFIED_MODULE)}"><img class="alignMiddle" src="{vimage_path('tools.png')}" alt="{vtranslate('LICENSE_SETTINGS_INFO', $QUALIFIED_MODULE)}" /></button>
            </div>
        </div>
        <hr>
        <div class="row-fluid">
            <span class="span6 btn-toolbar">
                <button class="btn addButton" onclick="window.location.href='index.php?parent=Settings&module=MultiCompany4you&view=Edit&companyid=&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}';"><i class="icon-plus icon-white"></i>&nbsp;<strong>{vtranslate('LBL_NEW_COMPANY', $QUALIFIED_MODULE)}</strong></button>
            </span>
            <div class="clearfix"></div>
        </div>
        <div class="listViewContentDiv" id="listViewContents">
            <div class="listViewEntriesDiv contents-bottomscroll">
                <div class="bottomscroll-div">
                    <table border=0 cellspacing=0 cellpadding=5 width=100% class="table table-bordered listViewEntriesTable">
                        <thead>
                            <tr class="listViewHeaders">
                                <th width="2%" class="narrowWidthType">#</th>
                                <th width="20%" class="narrowWidthType">{vtranslate("LBL_COMPANY_NAME",$QUALIFIED_MODULE)}</th>
                                <th width="20%" class="narrowWidthType">{vtranslate("email",$QUALIFIED_MODULE)}</th>
                                <th width="20%" class="narrowWidthType">{vtranslate("phone",$QUALIFIED_MODULE)}</th>
                                <th width="20%" class="narrowWidthType">{vtranslate("role",$QUALIFIED_MODULE)}</th>
                                <th width="10%" class="narrowWidthType">{vtranslate('LBL_ACTIONS')}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach item=company name=companiesforeach from=$COMPANIES}
                                <tr class="listViewEntries" data-id="{$company.companyid}" data-recordurl="index.php?parent=Settings&module=MultiCompany4you&view=Detail&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}&companyid={$company.companyid}" id="MultiCompany_List_row_{$company.companyid}">
                                    <td class="narrowWidthType">{$smarty.foreach.companiesforeach.iteration}</td>
                                    <td class="narrowWidthType"><a href="index.php?parent=Settings&module=MultiCompany4you&view=Detail&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}&companyid={$company.companyid}">{$company.companyname}</a></td>
                                    <td class="narrowWidthType"><a href="index.php?parent=Settings&module=MultiCompany4you&view=Detail&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}&companyid={$company.companyid}">{$company.email}</a></td>
                                    <td class="narrowWidthType"><a href="index.php?parent=Settings&module=MultiCompany4you&view=Detail&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}&companyid={$company.companyid}">{$company.phone}</a></td>
                                    <td class="narrowWidthType">{$company.rolename}</td>
                                    <td class="narrowWidthType">
                                        <div class="pull-right actions">
                                            <a class="editTax cursorPointer" href="index.php?parent=Settings&module=MultiCompany4you&view=Edit&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}&companyid={$company.companyid}"><i title="{vtranslate('LBL_EDIT')}" class="icon-pencil alignMiddle"></i></a>&nbsp;&nbsp;
                                            <a class="editTax cursorPointer" onclick="MultiCompany4you_List_Js.getInstance();MultiCompany4you_List_Js.deleteRecord({$company.companyid});"><i title="{vtranslate('LBL_DELETE')}" class="icon-trash alignMiddle"></i></a>&nbsp;&nbsp;
                                        </div>
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        {*<div  id="CompanyDetailsContainer" class="{if !empty($ERROR_MESSAGE)}hide{/if}">
        <div class="row-fluid">
        <table class="table table-bordered">
        <thead>
        <tr class="blockHeader">
        <th colspan="2"><strong>{vtranslate('LBL_COMPANY_INFORMATION',$QUALIFIED_MODULE)}</strong></th>
        </tr>
        </thead>
        <tbody>
        {foreach from=$MODULE_MODEL->getFields() item=FIELD_TYPE key=FIELD}
        {if $FIELD neq 'logoname' && $FIELD neq 'logo' }
        <tr>
        <td>{vtranslate($FIELD,$QUALIFIED_MODULE)}</td>
        <td>{$MODULE_MODEL->get($FIELD)}</td>
        </tr>
        {/if}
        {/foreach}
        </tbody>
        </table>
        </div>
        </div>*}

        <form class="form-horizontal {if empty($ERROR_MESSAGE)}hide{/if}"  id="updateCompanyDetailsForm" method="post" action="index.php" enctype="multipart/form-data">
            <input type="hidden" name="module" value="Vtiger" />
            <input type="hidden" name="parent" value="Settings" />
            <input type="hidden" name="action" value="CompanyDetailsSave" />
            <div class="control-group">
                <div class="control-label">{vtranslate('LBL_COMPANY_LOGO',$QUALIFIED_MODULE)}</div>
                <div class="controls">
                    <div class="companyLogo">
                        <img src="{$MODULE_MODEL->getLogoPath()}" class="alignMiddle" />
                    </div>
                    <input type="file" name="logo" id="logoFile" />&nbsp;&nbsp;
                    <span class="alert alert-info">
                        {vtranslate('LBL_LOGO_RECOMMENDED_MESSAGE',$QUALIFIED_MODULE)}
                    </span>
                    {if !empty($ERROR_MESSAGE)}
                        <br><br><div class="marginLeftZero span9 alert alert-error">
                            {vtranslate($ERROR_MESSAGE,$QUALIFIED_MODULE)}
                        </div>
                    {/if}
                </div>
            </div>
            {foreach from=$MODULE_MODEL->getFields() item=FIELD_TYPE key=FIELD}
                {if $FIELD neq 'logoname' && $FIELD neq 'logo' }
                    <div class="control-group">
                        <div class="control-label">
                            {vtranslate($FIELD,$QUALIFIED_MODULE)}{if $FIELD eq 'organizationname'}<span class="redColor">*</span>{/if}
                        </div>
                        <div class="controls">
                            {if $FIELD eq 'address'}
                                <textarea name="{$FIELD}" style="width: 30.5%">{$MODULE_MODEL->get($FIELD)}</textarea>
                            {else}
                                <input type="text" {if $FIELD eq 'organizationname'} data-validation-engine="validate[required]" {/if} class="input-xlarge" name="{$FIELD}" value="{$MODULE_MODEL->get($FIELD)}"/>
                            {/if}
                        </div>
                    </div>
                {/if}
            {/foreach}
            {include file="ModalFooter.tpl"|@vtemplate_path:$QUALIFIED_MODULE}
        </form>
    </div>
{/strip}
