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
    <form name="allowed_modules_form" action="index.php" method="post">
        <input type="hidden" name="module" value="MultiCompany4you">
        <input type="hidden" name="action" value="SaveAllowedModules">
        <input type="hidden" name="block" value="{$smarty.request.block}">
        <input type="hidden" name="fieldid" value="{$smarty.request.fieldid}">
        <input type="hidden" name="companyid" value="{$smarty.request.companyid}">
        <div class="padding-left1per">
            <div class="row-fluid widget_header">
							<h3>
                <a href="index.php?parent=Settings&module=MultiCompany4you&view=CompanyList&block={$smarty.request.block}&fieldid={$smarty.request.fieldid}">{vtranslate('LBL_MODULE_NAME', $QUALIFIED_MODULE)}</a>
                {if $DESCRIPTION}<span style="font-size:12px;color: black;"> - &nbsp;{vtranslate({$DESCRIPTION}, $QUALIFIED_MODULE)}</span>{/if}
							</h3>
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
                <div class="tab-content layoutContent padding20 themeTableColor overflowVisible"></div>
            </div>
            {include file="ModalFooter.tpl"|@vtemplate_path:$QUALIFIED_MODULE}
            <div  id="CompanyDetailsContainer" class="{if !empty($ERROR_MESSAGE)}hide{/if}">
                <div class="row-fluid">
                    <table class="table table-bordered">
                        <thead>
                            <tr class="blockHeader">
                                <th colspan="2"><strong>{vtranslate('LBL_AVAILABLE_MODULES',$QUALIFIED_MODULE)}</strong></th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$SUPPORTED_MODULES item=module}
                                <tr>
                                    <td><input type="checkbox" name="allowed_{$module.tabid}" id="allowed_{$module.tabid}" {if $module.tab_id}checked{/if}>
                                    <td>{$module.name|@getTranslatedString:$module.name}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>

                </div>
            </div>
            {include file="ModalFooter.tpl"|@vtemplate_path:$QUALIFIED_MODULE}
        </div>
    </form>

{/strip}