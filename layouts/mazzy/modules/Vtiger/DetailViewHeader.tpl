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

	{assign var="MODULE_NAME" value=$MODULE_MODEL->get('name')}

	<input id="recordId" type="hidden" value="{$RECORD->getId()}" />
	<div class="detailViewContainer">
		<div class="row-fluid detailViewTitle">
			<div class="{if $NO_PAGINATION} span12 {else} span10 {/if}">
				<div class="row">
					<div class="span4">
						<div class="row-fluid">
							<div class="span1"><a class="btn btn-mazzy btn-xs" onclick="window.history.back();"><i class="fa fa-arrow-left"></i></a></div>
							
							{include file="DetailViewHeaderTitle.tpl"|vtemplate_path:$MODULE}
						</div>
					</div>

					<div class="span5">
						<div class="pull-right detailViewButtoncontainer">
							<div class="btn-toolbar">
							{foreach item=DETAIL_VIEW_BASIC_LINK from=$DETAILVIEW_LINKS['DETAILVIEWBASIC']}
							<span class="btn-group">
								<button class="btn btn-mazzy" id="{$MODULE_NAME}_detailView_basicAction_{Vtiger_Util_Helper::replaceSpaceWithUnderScores($DETAIL_VIEW_BASIC_LINK->getLabel())}"
									{if $DETAIL_VIEW_BASIC_LINK->isPageLoadLink()}
										onclick="window.location.href='{$DETAIL_VIEW_BASIC_LINK->getUrl()}'"
									{else}
										onclick={$DETAIL_VIEW_BASIC_LINK->getUrl()}
									{/if}>
									{if Vtiger_Util_Helper::replaceSpaceWithUnderScores($DETAIL_VIEW_BASIC_LINK->getLabel()) eq "LBL_EDIT"}<i class="fa fa-pencil"></i>&nbsp;{/if}
									{if Vtiger_Util_Helper::replaceSpaceWithUnderScores($DETAIL_VIEW_BASIC_LINK->getLabel()) eq "LBL_SEND_EMAIL"}<i class="fa fa-envelope"></i>&nbsp;{/if}
									<strong>{vtranslate($DETAIL_VIEW_BASIC_LINK->getLabel(), $MODULE_NAME)}</strong>
								</button>
							</span>
							{/foreach}
							{if $DETAILVIEW_LINKS['DETAILVIEW']|@count gt 0}
							<span class="btn-group">
								<button class="btn dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
									<i class="fa fa-th-list"></i>&nbsp;<strong>{vtranslate('LBL_MORE', $MODULE_NAME)}</strong>&nbsp;&nbsp;<i class="fa fa-caret-down"></i>
								</button>
								<ul class="dropdown-menu pull-left">
									{foreach item=DETAIL_VIEW_LINK from=$DETAILVIEW_LINKS['DETAILVIEW']}
									{if $DETAIL_VIEW_LINK->getLabel() eq ""} 
										<li class="divider"></li>	
									{else}
									<li id="{$MODULE_NAME}_detailView_moreAction_{Vtiger_Util_Helper::replaceSpaceWithUnderScores($DETAIL_VIEW_LINK->getLabel())}">
										<a href={$DETAIL_VIEW_LINK->getUrl()} >{vtranslate($DETAIL_VIEW_LINK->getLabel(), $MODULE_NAME)}</a>
									</li>
									{/if}
									{/foreach}
								</ul>
							</span>
							{/if}
							{if $DETAILVIEW_LINKS['DETAILVIEWSETTING']|@count gt 0}
								<span class="btn-group">
									<button class="btn dropdown-toggle" href="#" data-toggle="dropdown"><i class="fa fa-cog" alt="{vtranslate('LBL_SETTINGS', $MODULE_NAME)}" title="{vtranslate('LBL_SETTINGS', $MODULE_NAME)}"></i>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></button>
									<ul class="dropdown-menu pull-left">
										{foreach item=DETAILVIEW_SETTING from=$DETAILVIEW_LINKS['DETAILVIEWSETTING']}
											<li><a href={$DETAILVIEW_SETTING->getUrl()}>{vtranslate($DETAILVIEW_SETTING->getLabel(), $MODULE_NAME)}</a></li>
										{/foreach}
									</ul>
								</span>
							{/if}
					
	

							
							</div>
						</div>
					</div>

				</div>
			</div>

			{if !{$NO_PAGINATION}}
				<div class="span2 detailViewPagingButton">
					<span class="btn-group pull-right">
						<button class="btn" id="detailViewPreviousRecordButton" {if empty($PREVIOUS_RECORD_URL)} disabled="disabled" {else} onclick="window.location.href='{$PREVIOUS_RECORD_URL}'" {/if}><i class="fa fa-chevron-left"></i></button>
						<button class="btn" id="detailViewNextRecordButton" {if empty($NEXT_RECORD_URL)} disabled="disabled" {else} onclick="window.location.href='{$NEXT_RECORD_URL}'" {/if}><i class="fa fa-chevron-right"></i></button>
					</span>
				</div>
			{/if}
<div class="clearfix"></div>
					<div class="mycrelated" style="    margin: 20px 0px;">				
							<div class="related" style="margin-left: -10px!important; margin-top: 10px; margin-bottom:10px;">
						{assign var="SELECTED_TAB_LABEL" value=$smarty.get.tab_label}

						{foreach item=RELATED_LINK from=$DETAILVIEW_LINKS['DETAILVIEWTAB'] name="detlink"}

		
							<a href="javascript:void(0);" class="label label-mazzy {if $RELATED_LINK->getLabel()==$SELECTED_TAB_LABEL || ($SELECTED_TAB_LABEL=="" && $smarty.foreach.detlink.iteration==1)}active{/if}" data-url="{$RELATED_LINK->getUrl()}&tab_label={$RELATED_LINK->getLabel()}" data-label-key="{$RELATED_LINK->getLabel()}" data-link-key="{$RELATED_LINK->get('linkKey')}" style="width:auto" title="{vtranslate($RELATED_LINK->getLabel(),{$MODULE_NAME})}"><strong>{vtranslate($RELATED_LINK->getLabel(),{$MODULE_NAME})} 
								</strong>
							</a>&nbsp;
						{/foreach}
						<hr>
						{foreach item=RELATED_LINK from=$DETAILVIEW_LINKS['DETAILVIEWRELATED']}
							
							{* Assuming most of the related link label would be module name - we perform dual translation *}
							{assign var="DETAILVIEWRELATEDLINKLBL" value= vtranslate($RELATED_LINK->getLabel(), $RELATED_LINK->getRelatedModuleName())}
							<a href="javascript:void(0);" class="label label-mazzy {if $RELATED_LINK->getLabel()==$SELECTED_TAB_LABEL}active{/if}" data-url="{$RELATED_LINK->getUrl()}&tab_label={$RELATED_LINK->getLabel()}" data-label-key="{$RELATED_LINK->getLabel()}" style="width:auto" title="{$DETAILVIEWRELATEDLINKLBL}" data-toggle="tooltip" data-placement="top" ><strong>
							
{if vimage_path($RELATED_LINK->get("relatedModuleName")|cat:'.png') != false}
									<img  class="alignMiddle" src="{vimage_path($RELATED_LINK->get("relatedModuleName")|cat:'.png')}" alt="{vtranslate($RELATED_LINK->getLabel(), $RELATED_LINK->getLabel())}" title="{vtranslate($RELATED_LINK->getLabel(), $RELATED_LINK->getLabel())}"/>
								{else}
									<img  class="alignMiddle" src="{vimage_path('DefaultModule.png')}" alt="{vtranslate($RELATED_LINK->getLabel(), $RELATED_LINK->getLabel())}" title="{vtranslate($RELATED_LINK->getLabel(), $RELATED_LINK->getLabel())}"/>
								{/if}

								</strong>
							</a>&nbsp;&nbsp;&nbsp;
						
						{/foreach}
					

</div>
</div>
	<!-- Related mobile -->
<div class="mycrelatedmobile">
<div class="span4" style=" margin-top: 10px; margin-bottom:10px;">

<div class="btn-group">
  <button type="button" class="btn btn-default dropdown-toggle" style="width:200px!important;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <i class="fa fa-paperclip"></i>Related Module <i class="fa fa-caret-down"></i>
  </button>
  <ul class="dropdown-menu related">
    {assign var="SELECTED_TAB_LABEL" value=$smarty.get.tab_label}

						{foreach item=RELATED_LINK from=$DETAILVIEW_LINKS['DETAILVIEWTAB'] name="detlink"}
<li href="javascript:void(0);" class="mycrelatedtab {if $RELATED_LINK->getLabel()==$SELECTED_TAB_LABEL || ($SELECTED_TAB_LABEL=="" && $smarty.foreach.detlink.iteration==1)}active{/if}" data-url="{$RELATED_LINK->getUrl()}&tab_label={$RELATED_LINK->getLabel()}" data-label-key="{$RELATED_LINK->getLabel()}" data-link-key="{$RELATED_LINK->get('linkKey')}" style="width:auto" title="{vtranslate($RELATED_LINK->getLabel(),{$MODULE_NAME})}"><strong>{vtranslate($RELATED_LINK->getLabel(),{$MODULE_NAME})}</strong>
						</li>
						{/foreach}
						
						{foreach item=RELATED_LINK from=$DETAILVIEW_LINKS['DETAILVIEWRELATED']}
				
							{* Assuming most of the related link label would be module name - we perform dual translation *}
							{assign var="DETAILVIEWRELATEDLINKLBL" value= vtranslate($RELATED_LINK->getLabel(), $RELATED_LINK->getRelatedModuleName())}
						<li href="javascript:void(0);" class="mycrelatedtab {if $RELATED_LINK->getLabel()==$SELECTED_TAB_LABEL}active{/if}" data-url="{$RELATED_LINK->getUrl()}&tab_label={$RELATED_LINK->getLabel()}" data-label-key="{$RELATED_LINK->getLabel()}" style="width:auto" title="{$DETAILVIEWRELATEDLINKLBL}"><strong>{$DETAILVIEWRELATEDLINKLBL}</strong></li>
						
						{/foreach}
  </ul>
</div>
</div></div>
	<!-- / Related mobile -->

		</div>
		
		<div class="detailViewInfo row-fluid">
			<div class="{if $NO_PAGINATION} span12 {else} span12 {/if} {if !empty($DETAILVIEW_LINKS['DETAILVIEWTAB']) || !empty($DETAILVIEW_LINKS['DETAILVIEWRELATED']) } details {/if}">
				<form id="detailView" data-name-fields='{ZEND_JSON::encode($MODULE_MODEL->getNameFields())}' method="POST">
                                    {if !empty($PICKLIST_DEPENDENCY_DATASOURCE)} 
                                        <input type="hidden" name="picklistDependency" value="{Vtiger_Util_Helper::toSafeHTML($PICKLIST_DEPENDENCY_DATASOURCE)}"> 
                                    {/if} 
					<div class="relcontents"></div>
					
					<div class="contents">
								<script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip(); 
});
</script>
{/strip}
