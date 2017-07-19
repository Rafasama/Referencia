{*<!--
/*********************************************************************************
* The content of this file is subject to the EMAIL Maker license.
* ("License"); You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
* Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
* All Rights Reserved.
********************************************************************************/
-->*}
<div class="listViewTopMenuDiv">
    <div class="listViewActionsDiv row-fluid">
        <span class="btn-toolbar span8">
            {if $EDIT eq 'permitted'}
                {if $IS_DELAY_ACTIVE neq "1"}
                    <span class="redColor ">{vtranslate("LBL_WORKFLOW_NOTE_CRON_CONFIG","EMAILMaker")}</span><br>
                        <a href="https://wiki.vtiger.com/index.php/Cron" class="btn" target="_new" style="margin-top:10px;">{vtranslate("LBL_SETUP_CRON_JOB_INSTRUCTIONS","EMAILMaker")}</a>
                {else}    
                    <span class="btn-group"><button class="btn addButton createEmailCampaign" type="button"><i class="icon-plus icon-white"></i>&nbsp;<strong>{vtranslate("LBL_NEW_EMAIL_CAMPAIGN","EMAILMaker")}</strong></button></span>
                {/if}
            {/if}
        </span>
        <span class="span4 btn-toolbar">
                {include file='ListMEActions.tpl'|vtemplate_path:'EMAILMaker'}
        </span>
    </div>
</div>