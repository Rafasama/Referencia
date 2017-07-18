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
	{assign var="topMenus" value=$MENU_STRUCTURE->getTop()}
	{assign var="moreMenus" value=$MENU_STRUCTURE->getMore()}
	{assign var=NUMBER_OF_PARENT_TABS value = count(array_keys($moreMenus))}
	{assign var=CURRENT_USER_MODEL value=Users_Record_Model::getCurrentUserModel()}
	{assign var=LEFTPANELHIDE value=$CURRENT_USER_MODEL->get('leftpanelhide')}
	
	  <div class="navbar-inner" >
 		
 		<ul class="nav span1">
	      <li class="active">
	      <span class="dropdown span settingIcons">	      
	      <a class="dropdown-toggle btn-navbar mazzy-hide-left-sidebar mazzy-sidebar-toggle-button" style='display:none;' href="#">
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
		  </a>
		  <a class="dropdown-toggle btn-navbar mazzy-show-left-sidebar mazzy-sidebar-toggle-button" href="#">
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
		  </a>
	      </span>		
	      </li>
	    </ul>
	    
	    <div class="span2">
                <span class="companyLogo"><img src="{$COMPANY_LOGO->get('imagepath')}" title="{$COMPANY_LOGO->get('title')}" alt="{$COMPANY_LOGO->get('alt')}"/>&nbsp;</span>
            </div>
	  <div class="span8 searchElementContainer">
                <div class="row-fluid">
                    <div class="searchElement span7">
                        <div class="select-search pull-left">
                            <select class="chzn-select" id="basicSearchModulesList" style="width:120px;">
                                <option value="" class="globalSearch_module_All">{vtranslate('LBL_ALL_RECORDS', $MODULE_NAME)}</option>
                                {foreach key=MODULE_NAME item=fieldObject from=$SEARCHABLE_MODULES}
                                    {if isset($SEARCHED_MODULE) && $SEARCHED_MODULE eq $MODULE_NAME && $SEARCHED_MODULE !== 'All'}
                                        <option value="{$MODULE_NAME}" class="globalSearch_module_{$MODULE_NAME}" selected>{vtranslate($MODULE_NAME,$MODULE_NAME)}</option>
                                    {else}
                                        <option value="{$MODULE_NAME}" class="globalSearch_module_{$MODULE_NAME}">{vtranslate($MODULE_NAME,$MODULE_NAME)}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </div>
                        <div class="input-append searchBar">
                            <input type="text" class="" id="globalSearchValue" placeholder="{vtranslate('LBL_GLOBAL_SEARCH')}" results="10" />
                            <span style="background-color:#fff" id="searchIcon" class="add-on search-icon"><i class="fa fa-search"></i></span>
                            <span style="background-color:#fff" class="adv-search  pull-left add-on search-icon">
                                <a id="globalSearch"><i class="fa fa-search"></i>&nbsp;<i class="fa fa-plus"></i></a>
                            </span>
                        </div>

                    </div>   
                    
                    {assign var="announcement" value=$ANNOUNCEMENT->get('announcement')}	
					{if !empty($announcement)}
						<div class="myctopannouncement span4" id="" style="display:block;" style="width:100px;">
						<marquee direction="left" scrolldelay="10" scrollamount="3" behavior="scroll" class="marStyle" onmouseover="javascript:stop();" onmouseout="javascript:start();">{if !empty($announcement)}{$announcement}{else}{vtranslate('LBL_NO_ANNOUNCEMENTS',$MODULE)}{/if}</marquee>
						</div>
					 {/if}
                                   
                    
                    
                        
                    
                </div>
            </div>
	
	
	

                        
                        

	<div class="span3 marginLeftZero pull-right" id="headerLinks" style="max-width:20%;">
				
	
				
					
					<span id="headerLinksBig" class="pull-right headerLinksContainer">
				       
						<span class="dropdown span settingIcons qCreate cursorPointer">
							<i class="fa fa-plus btn-navbar mazzy-sidebar-toggle-button" data-toggle="dropdown"/></i>
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
						
						
							
						
						<span class="dropdown span settingIcons">
							<a class="dropdown-toggle btn-navbar mazzy-show-right-sidebar mazzy-sidebar-toggle-button" href="#"  {if $LEFTPANELHIDE eq '1'}style='display:none;'{/if}>
								<i class="fa fa-bars"></i>
							</a>
							<a class="dropdown-toggle btn-navbar mazzy-hide-right-sidebar mazzy-sidebar-toggle-button" href="#"  {if $LEFTPANELHIDE neq '1'}style='display:none;'{/if}>
								<i class="fa fa-bars"></i>
							</a>
						</span>
						
						
					</span>
					<div id="headerLinksCompact" >
						
						<span class="btn-group dropdown qCreate cursorPointer" style="display:none">
							<img style="width:13px;" src="{vimage_path('btnAdd_white.png')}" class="btn-navbar mazzy-sidebar-toggle-button" alt="{vtranslate('LBL_QUICK_CREATE',$MODULE)}" title="{vtranslate('LBL_QUICK_CREATE',$MODULE)}" data-toggle="dropdown"/>
							<ul class="dropdown-menu dropdownStyles pull-right commonActionsButtonDropDown">
								<li class="title"><strong>{vtranslate('Quick Create',$MODULE)}</strong></li><hr/>
								<li id="compactquickCreate">
									<div class="CompactQC"  id="quickCreateModules">
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
						<span  class="dropdown">
							<a class="dropdown-toggle btn-navbar mazzy-show-right-sidebar mazzy-sidebar-toggle-button" href="#" style="display:none;">
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</a>
							<a class="dropdown-toggle btn-navbar mazzy-hide-right-sidebar mazzy-sidebar-toggle-button" href="#">
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</a>
						</span>
					</div>
					<div class="notificationMessageHolder span12">

                    </div>
                    <!-- {if !empty($announcement)}
                                <div class="btn-group cursorPointer">
                                    <img class='alignMiddle' src="{vimage_path('btnAnnounceOff.png')}" alt="{vtranslate('LBL_ANNOUNCEMENT',$MODULE)}" title="{vtranslate('LBL_ANNOUNCEMENT',$MODULE)}" id="announcementBtn" />
                                </div>&nbsp;
                            {/if} -->
                            
	{assign var="announcement" value=$ANNOUNCEMENT->get('announcement')}
	
	<input type='hidden' value="{$MODULE}" id='module' name='module'/>
	<input type="hidden" value="{$PARENT_MODULE}" id="parent" name='parent' />
	<input type='hidden' value="{$VIEW}" id='view' name='view'/>

	</div>
	</div>
	<div class="clearfix"></div>
	
{if !empty($announcement)}
		<div class="announcement noprint mycmobileannouncement" >
		<marquee direction="left" scrolldelay="10" scrollamount="3" behavior="scroll" class="marStyle" onmouseover="javascript:stop();" onmouseout="javascript:start();">{if !empty($announcement)}{$announcement}{else}{vtranslate('LBL_NO_ANNOUNCEMENTS',$MODULE)}{/if}</marquee>
		</div>
	 {/if}	
{/strip}
