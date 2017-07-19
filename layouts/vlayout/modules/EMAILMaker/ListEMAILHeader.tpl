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
        <span class="btn-toolbar span{if $VERSION_TYPE eq "deactivate" || $VERSION_TYPE eq ""}3{else}4{/if}">
            <span class="btn-group listViewMassActions">
                    {if count($LISTVIEW_MASSACTIONS) gt 0 || $LISTVIEW_LINKS['LISTVIEW']|@count gt 0}
                            <button class="btn dropdown-toggle" data-toggle="dropdown"><strong>{vtranslate('LBL_ACTIONS', $MODULE)}</strong>&nbsp;&nbsp;<i class="caret"></i></button>
                            <ul class="dropdown-menu">
                                    {if count($LISTVIEW_MASSACTIONS) gt 0}
                                        {foreach item="LISTVIEW_MASSACTION" from=$LISTVIEW_MASSACTIONS}
                                                <li id="{$MODULE}_listView_massAction_{Vtiger_Util_Helper::replaceSpaceWithUnderScores($LISTVIEW_MASSACTION->getLabel())}"><a href="javascript:void(0);" {if stripos($LISTVIEW_MASSACTION->getUrl(), 'javascript:')===0}onclick='{$LISTVIEW_MASSACTION->getUrl()|substr:strlen("javascript:")};'{else} onclick="Vtiger_List_Js.triggerMassAction('{$LISTVIEW_MASSACTION->getUrl()}')"{/if} >{vtranslate($LISTVIEW_MASSACTION->getLabel(), $MODULE)}</a></li>
                                        {/foreach}
                                        
                                        {if $LISTVIEW_LINKS['LISTVIEW']|@count gt 0}<li class="divider"></li> {/if}
                                    {/if}
                                    
                                    {if $LISTVIEW_LINKS['LISTVIEW']|@count gt 0}
                                            {foreach item=LISTVIEW_ADVANCEDACTIONS from=$LISTVIEW_LINKS['LISTVIEW']}
                                                    <li id="{$MODULE}_listView_advancedAction_{Vtiger_Util_Helper::replaceSpaceWithUnderScores($LISTVIEW_ADVANCEDACTIONS->getLabel())}"><a {if stripos($LISTVIEW_ADVANCEDACTIONS->getUrl(), 'javascript:')===0} href="javascript:void(0);" onclick='{$LISTVIEW_ADVANCEDACTIONS->getUrl()|substr:strlen("javascript:")};'{else} href='{$LISTVIEW_ADVANCEDACTIONS->getUrl()}' {/if}>{vtranslate($LISTVIEW_ADVANCEDACTIONS->getLabel(), $MODULE)}</a></li>
                                            {/foreach}
                                    {/if}
                            </ul>
                    {/if}  
            </span>
            {if $EDIT eq 'permitted'}
                <span class="btn-group"><button class="btn addButton" type="submit" onclick="this.form.view.value = 'Select';"><i class="icon-plus icon-white"></i>&nbsp;<strong>{vtranslate("LBL_ADD_TEMPLATE","EMAILMaker")}</strong></button></span>
                <span class="btn-group"><button class="btn addButton" type="submit" onclick="this.form.view.value = 'Edit';this.form.theme.value = 'new';this.form.mode.value = 'EditTheme';"><i class="icon-plus icon-white"></i>&nbsp;<strong>{vtranslate("LBL_ADD_THEME","EMAILMaker")}</strong></button></span>
            {/if}
            {foreach item=LISTVIEW_BASICACTION from=$LISTVIEW_LINKS['LISTVIEWBASIC']}
                    <span class="btn-group">
                            <button id="{$MODULE}_listView_basicAction_{Vtiger_Util_Helper::replaceSpaceWithUnderScores($LISTVIEW_BASICACTION->getLabel())}" class="btn addButton" {if stripos($LISTVIEW_BASICACTION->getUrl(), 'javascript:')===0} onclick='{$LISTVIEW_BASICACTION->getUrl()|substr:strlen("javascript:")};'{else} onclick='window.location.href="{$LISTVIEW_BASICACTION->getUrl()}"'{/if}><i class="icon-plus icon-white"></i>&nbsp;<strong>{vtranslate($LISTVIEW_BASICACTION->getLabel(), $MODULE)}</strong></button>
                    </span>
            {/foreach}
        </span>
        <span class="btn-toolbar span{if $VERSION_TYPE eq "deactivate" || $VERSION_TYPE eq ""}5{else}4{/if}">
            <span class="customFilterMainSpan btn-group">
                {if $VERSION_TYPE eq "deactivate" || $VERSION_TYPE eq ""} 
                    <span class="btn-group">
                    {if $IS_ADMIN eq "1"}
                        <a href='index.php?module=EMAILMaker&view=License'>
                        <span class="btn btn-danger">
                            {vtranslate("LBL_ACTIVATE_BTN","EMAILMaker")}
                        </span>
                        </a>
                    {else}
                        <div class='alert alert-danger margin0px'>
                            {vtranslate("LBL_ACTIVATE_BTN","EMAILMaker")}
                        </div>
                    {/if} 
                    </span>
                {/if} 
              </span>
        </span>
        <span class="hide filterActionImages pull-right">
                <i title="{vtranslate('LBL_DENY', $MODULE)}" data-value="deny" class="icon-ban-circle alignMiddle denyFilter filterActionImage pull-right"></i>
                <i title="{vtranslate('LBL_APPROVE', $MODULE)}" data-value="approve" class="icon-ok alignMiddle approveFilter filterActionImage pull-right"></i>
                <i title="{vtranslate('LBL_DELETE', $MODULE)}" data-value="delete" class="icon-trash alignMiddle deleteFilter filterActionImage pull-right"></i>
                <i title="{vtranslate('LBL_EDIT', $MODULE)}" data-value="edit" class="icon-pencil alignMiddle editFilter filterActionImage pull-right"></i>
        </span>
        <span class="span4 btn-toolbar">
                {include file='ListEMAILActions.tpl'|@vtemplate_path:'EMAILMaker'}
        </span>
    </div>
</div>