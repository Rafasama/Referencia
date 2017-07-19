{*<!--
/*********************************************************************************
* The content of this file is subject to the EMAIL Maker license.
* ("License"); You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
* Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
* All Rights Reserved.
********************************************************************************/
-->*}
<table class="table table-bordered table-condensed themeTableColor">
    <thead>
        <tr class="blockHeader">
            <th class="mediumWidthType">
                <span class="alignMiddle">{vtranslate('LBL_COMPANY_LICENSE_INFO', 'EMAILMaker')}</span>
            </th>
            <th class="mediumWidthType" style="border-left: none; text-align: right;">
                <button type="button" id="company_button" class="btn btn-info" onclick="window.location.href='index.php?module=Vtiger&parent=Settings&view=CompanyDetails&block=3&fieldid=14'"/>{vtranslate('LBL_CHANGE_COMPANY_INFORMATION','EMAILMaker')}</button>
            </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td width="25%"><label  class="muted pull-right marginRight10px">{vtranslate('organizationname', 'Settings:Vtiger')}:</label></td>
            <td style="border-left: none;"><div class="pull-left" id="organizationname_label">{$COMPANY_DETAILS->get("organizationname")}</div></td>
        </tr>
        <tr>
            <td width="25%"><label  class="muted pull-right marginRight10px">{vtranslate('address', 'Settings:Vtiger')}:</label></td>
            <td style="border-left: none;"><div class="pull-left" id="address_label">{$COMPANY_DETAILS->get("address")}</div></td>
        </tr>
        <tr>
            <td width="25%"><label  class="muted pull-right marginRight10px">{vtranslate('city', 'Settings:Vtiger')}:</label></td>
            <td style="border-left: none;"><div class="pull-left" id="city_label">{$COMPANY_DETAILS->get("city")}</div></td>
        </tr>
        <tr>
            <td width="25%"><label  class="muted pull-right marginRight10px">{vtranslate('state', 'Settings:Vtiger')}:</label></td>
            <td style="border-left: none;"><div class="pull-left" id="state_label">{$COMPANY_DETAILS->get("state")}</div></td>
        </tr>
        <tr>
            <td width="25%"><label  class="muted pull-right marginRight10px">{vtranslate('country', 'Settings:Vtiger')}:</label></td>
            <td style="border-left: none;"><div class="pull-left" id="country_label">{$COMPANY_DETAILS->get("country")}</div></td>
        </tr>
        <tr>
            <td width="25%"><label  class="muted pull-right marginRight10px">{vtranslate('code', 'Settings:Vtiger')}:</label></td>
            <td style="border-left: none;"><div class="pull-left" id="code_label">{$COMPANY_DETAILS->get("code")}</div></td>
        </tr>
        <tr>
            <td width="25%"><label  class="muted pull-right marginRight10px">{vtranslate('vatid', 'Settings:Vtiger')}:</label></td>
            <td style="border-left: none;"><div class="pull-left" id="vatid_label">{$COMPANY_DETAILS->get("vatid")}</div></td>
        </tr>
  </tbody>
</table><br>
{if $STEP eq ""}<label class="fieldLabel"><strong>{vtranslate('LICENSE_SETTINGS_INFO','EMAILMaker')}:</strong></label><br>{/if}
<table class="table table-bordered table-condensed themeTableColor">
    <thead>
        <tr class="blockHeader">
            <th colspan="2" class="mediumWidthType"><span class="alignMiddle">{vtranslate('LICENSE_SETTINGS', 'EMAILMaker')}</span></th>
        </tr>
    </thead>
    <tbody>
            <tr>
                <td width="25%"><label  class="muted pull-right marginRight10px">{vtranslate('LBL_URL', 'EMAILMaker')}:</label></td>
                <td style="border-left: none;"><div class="pull-left" id="vatid_label">{$URL}</div></td>
            </tr>
            <tr>
                <td width="25%"><label  class="muted pull-right marginRight10px">{vtranslate('LBL_LICENCEKEY', 'EMAILMaker')}:</label></td>
                <td style="border-left: none;">
                    
                    {if $STEP neq ""}
                        <input type="text" class="input-large" id="licensekey" name="licensekey" data-validation-engine="validate[required]"/>
                        <button type="subbmit" id="validate_button" class="btn btn-success"/><strong>{vtranslate('LBL_VALIDATE','EMAILMaker')}</strong></button>&nbsp;&nbsp;
                        <button type="button" id="order_button" class="btn btn-info" onclick="window.location.href='http://www.its4you.sk/en/vtiger-shop.html'"/>{vtranslate('LBL_ORDER_NOW','EMAILMaker')}</button>
                    {else}
                        <div class="pull-left" id="license_key_label">{$LICENSE}&nbsp;&nbsp;</div>
                        <div id="divgroup1" class="btn-group pull-left paddingLeft10px" {if $VERSION_TYPE eq "basic" || $VERSION_TYPE eq "professional"}style="display:none"{/if}>
                            <button id="activate_license_btn"  class="btn addButton" title="{vtranslate('LBL_ACTIVATE_KEY_TITLE','EMAILMaker')}" type="button"><strong>{vtranslate('LBL_ACTIVATE_KEY','EMAILMaker')}</strong></button>
                        </div>
                        <div id="divgroup2" class="pull-left paddingLeft10px" {if $VERSION_TYPE neq "basic" && $VERSION_TYPE neq "professional"}style="display:none"{/if}>
                            <button id="reactivate_license_btn"  class="btn btn-success" title="{vtranslate('LBL_REACTIVATE_DESC','EMAILMaker')}" type="button">{vtranslate('LBL_REACTIVATE','EMAILMaker')}</button>
                            <button id="deactivate_license_btn" type="button" class="btn btn-danger marginLeftZero">{vtranslate('LBL_DEACTIVATE','EMAILMaker')}</button>
                        </div>
                    {/if}
                </td>
            </tr>
     </tbody>
</table>