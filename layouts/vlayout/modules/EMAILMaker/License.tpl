{*<!--
/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
-->*}
<script type="text/javascript" src="layouts/vlayout/modules/EMAILMaker/resources/License.js"></script>
<div class="container-fluid" id="licenseContainer">
    <form name="profiles_privilegies" action="index.php" method="post" class="form-horizontal">
    <br>
    <label class="pull-left themeTextColor font-x-x-large">{vtranslate('LICENSE_SETTINGS','EMAILMaker')}</label>
    <br clear="all">
    <hr>
    <input type="hidden" name="module" value="EMAILMaker" />
    <input type="hidden" name="view" value="" />
    <input type="hidden" name="license_key_val" id="license_key_val" value="{$LICENSE}" />
     <br />
    <div class="row-fluid">
        {include file='LicenseDetails.tpl'|@vtemplate_path:'EMAILMaker'}
        <br /> 
    </div>
    {if $MODE eq "edit"}        
        <div class="pull-right">
            <button class="btn btn-success" type="submit">{vtranslate('LBL_SAVE',$MODULE)}</button>
            <a class="cancelLink" onclick="javascript:window.history.back();" type="reset">{vtranslate('LBL_CANCEL',$MODULE)}</a>
        </div> 
    {/if}
    </form>
</div>      
{literal}
<script language="javascript" type="text/javascript">
EMAILMaker_License_Js.registerEvents();
</script>
{/literal}    