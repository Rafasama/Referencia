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
{assign var="moreMenus" value=$MENU_STRUCTURE->getMore()}
{assign var="topMenus" value=$MENU_STRUCTURE->getTop()}
{assign var=CURRENT_USER_MODEL value=Users_Record_Model::getCurrentUserModel()}
{assign var=LEFTPANELHIDE value=$CURRENT_USER_MODEL->get('leftpanelhide')}

<div id="mazzy-sidebar-left" class="">
<div class="mazzy-menu">

<div class="clearfix"></div>

	<!-- search mobile-->
	<div class="row-fluid" id ="searchmobile">
                    <div class="searchElement ">
                    <h3 style="font-weight:100; color:#fff!important;">Quick Search</h3>
                        
                       
  <div class="input-append ">
    <input id="globalSearchValue_mob" type="text" class="span2 search-query" placeholder="{vtranslate('LBL_GLOBAL_SEARCH')}" results="10">
    &nbsp;
    <a id="searchIcon_mob" class="btn btn-success searchbtn pull-left"><i class="fa fa-search"></i></a>
    <span class="dropdown span settingIcons qCreate cursorPointer" style="margin-left:0px;margin-top: -2px;">
    <a class="btn btn-success mazzy-sidebar-toggle-button" data-toggle="dropdown" ><i class="fa fa-plus"></i></a>
							<ul class="dropdown-menu dropdownStyles pull-right commonActionsButtonDropDown">
								<li class="title"><strong>{vtranslate('Quick Create',$MODULE)}</strong></li><hr/>
								<li id="compactquickCreate">
									<div class="CompactQC" id="quickCreateModules">
										{foreach key=moduleName item=moduleModel from=$MENUS}
											{if $moduleModel->isPermitted('EditView')}
												{assign var='quickCreateModule' value=$moduleModel->isQuickCreateSupported()}
												{assign var='singularLabel' value=$moduleModel->getSingularLabelKey()}
												{if $quickCreateModule == '1'}
													<a class="quickCreateModule" data-name="{$moduleModel->getName()}"
													   data-url="{$moduleModel->getQuickCreateUrl()}" href="javascript:void(0)">{vtranslate($singularLabel,$moduleName)}</a>
												{/if}
											{/if}
										{/foreach}
									</div>
								</li>
							</ul>
							
						</span>
  </div>

                    </div>                  
            
                  <hr>  
     
                </div>

<!--/ search mobile-->

	<div class="mazzy-menu-cat {if $MODULE eq 'Home'} selected {/if}">
	<a class="alignMiddle " href="{$HOME_MODULE_MODEL->getDefaultUrl()}" ><i class="fa fa-home fa-2x"></i><span class="mazzymenutext">{vtranslate('LBL_HOME',$moduleName)}</span><div class="clearfix"></div></a>
	</div>
	
	{foreach key=moduleName item=moduleModel from=$topMenus name=topmenu}
							{assign var='translatedModuleLabel' value=vtranslate($moduleModel->get('label'),$moduleName)}

							{assign var="topmenuClassName" value="tabs"}
							{* Make sure to keep selected + few menu persistently and rest responsive *}
							{if $MODULE eq $moduleName}
								{assign var="topmenuClassName" value="selected"}
							{/if}
<div class="mazzy-menu-cat {$topmenuClassName}">
	<a  {if $moduleModel->isEntityModule()}style="float:left; width:130px!important;"{/if} class="alignMiddle {$topmenuClassName}" href="{$moduleModel->getDefaultUrl()}">
	
	{if vimage_path($moduleName|cat:'.png') != false}
									<img  class="mazzyiconimg alignMiddle" src="{vimage_path($moduleName|cat:'.png')}" alt="{vtranslate($moduleName, $moduleName)}" title="{vtranslate($moduleName, $moduleName)}"/>
								{else}
									<img  class="mazzyiconimg alignMiddle" src="{vimage_path('DefaultModule.png')}" alt="{vtranslate($moduleName, $moduleName)}" title="{vtranslate($moduleName, $moduleName)}"/>
								{/if}
								
	<span class="mazzymenutext">{$translatedModuleLabel}</span></a>

	{if $moduleModel->isEntityModule()}
	<a class="mycgridsidebarbtn" style="float:left;width:20px;display:none;" href="index.php?module={$moduleName}&view=Grid"><i class="fa fa-th-large" style="font-size:16px;"></i></a>
	{/if}

	<div class="clearfix"></div>
	</div>
	{/foreach}
	
	
	{foreach key=parent item=moduleList from=$moreMenus name=more}
		<div class="mazzy-menu-cat">
		<a class="mazzy-show-child-modules" mazzy-childmodules="{$parent}"><i class="fa fa-{$parent}"></i><span class="mazzymenutext">{vtranslate("LBL_$parent",$moduleName)}</span><div class="clearfix"></div></a></div>
		
		<div class="mazzy-child-modules hide" id="mazzy-child-modules-{$parent}">
											{foreach key=moduleName item=moduleModel from=$moduleList}
											{if !isset($topMenus.{$moduleName})}
												{assign var='translatedModuleLabel' value=vtranslate($moduleModel->get('label'),$moduleName)}
												<div class="mazzy-module-link {if $MODULE eq $moduleName} selected {/if}" {if $moduleModel->isEntityModule()}style="float:left; width:85%!important;"{/if} ><a id="menubar_item_{$moduleName}"   class="alignMiddle {$topmenuClassName}" href="{$moduleModel->getDefaultUrl()}">{if vimage_path($moduleName|cat:'.png') != false}
									<img  class="mazzyiconimg alignMiddle" src="{vimage_path($moduleName|cat:'.png')}" alt="{vtranslate($moduleName, $moduleName)}" title="{vtranslate($moduleName, $moduleName)}"/>
								{else}
									<img  class="mazzyiconimg alignMiddle" src="{vimage_path('DefaultModule.png')}" alt="{vtranslate($moduleName, $moduleName)}" title="{vtranslate($moduleName, $moduleName)}"/>
								{/if}
								<span class="mazzymenutext">{$translatedModuleLabel}</span></a></div>
								{if $moduleModel->isEntityModule()}
								<a class="mycgridsidebarbtn" style="float:left;width:15%;height:100%;display:none;text-align:center" href="index.php?module={$moduleName}&view=Grid"><i class="fa fa-th-large"></i></a>
								{/if}
	<div class="clearfix"></div>
	
											{/if}
											{/foreach}
		</div>
		
	{/foreach}



</div>


</div>

<style>

#mazzy-sidebar-left .mazzy-menu{
	margin-top: 2px !important;
}

.mazzyiconimg{
	max-width: 20px;
	margin-right: 12px;
	float: left;
}

#mazzy-sidebar-left{
	width: 50px;
}

.mazzymenutext{
	display: none;
}

.mazzy-menu-cat a i{
	float: left;
}

.mazzy-module-link img{
	padding-left: 13px;
}
	
</style>
{/strip}
