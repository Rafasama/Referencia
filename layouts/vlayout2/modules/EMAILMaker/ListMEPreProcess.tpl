{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
*
 ********************************************************************************/
-->*}
{strip}
{include file="Header.tpl"|vtemplate_path:$MODULE}
{include file="BasicHeader.tpl"|vtemplate_path:$MODULE}
<div class="bodyContents">
	<div class="mainContainer row-fluid">
		{assign var=LEFTPANELHIDE value=$CURRENT_USER_MODEL->get('leftpanelhide')}
		<div class="span2 row-fluid {if $LEFTPANELHIDE eq '1'} hide {/if}" id="leftPanel">
			{include file="ListViewSidebar.tpl"|vtemplate_path:$MODULE}
		</div>
		<div class="contentsDiv {if $LEFTPANELHIDE neq '1'} span10 {/if}marginLeftZero" id="rightPanel">
			<div id="toggleButton" class="toggleButton" title="Left Panel Show/Hide"> 
				<i id="tButtonImage" class="{if $LEFTPANELHIDE neq '1'}icon-chevron-left{else}icon-chevron-right{/if}"></i>
			</div>
                <div class="listViewPageDiv">
                    <input name="idlist" type="hidden">
                    <input name="module" type="hidden" value="EMAILMaker">
                    <input name="parenttab" type="hidden" value="Tools">
                    <input name="view" type="hidden" value="">
                    <input name="action" type="hidden" value="">    
                    <input name="return_module" type="hidden" value="EMAILMaker">
                    <input name="return_view" type="hidden" value="ListME">
                    <input name="theme" type="hidden" value="">
                    <input name="mode" type="hidden" value="">
                    {include file="ListMEHeader.tpl"|vtemplate_path:'EMAILMaker'}
                    <div class="listViewContentDiv" id="listViewContents">
{/strip}