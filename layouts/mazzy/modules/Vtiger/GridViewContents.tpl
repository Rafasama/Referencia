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
<input type="hidden" id="view" value="{$VIEW}" />
<input type="hidden" id="pageStartRange" value="{$PAGING_MODEL->getRecordStartRange()}" />
<input type="hidden" id="pageEndRange" value="{$PAGING_MODEL->getRecordEndRange()}" />
<input type="hidden" id="previousPageExist" value="{$PAGING_MODEL->isPrevPageExists()}" />
<input type="hidden" id="nextPageExist" value="{$PAGING_MODEL->isNextPageExists()}" />
<input type="hidden" id="alphabetSearchKey" value= "{$MODULE_MODEL->getAlphabetSearchField()}" />
<input type="hidden" id="Operator" value="{$OPERATOR}" />
<input type="hidden" id="alphabetValue" value="{$ALPHABET_VALUE}" />
<input type="hidden" id="totalCount" value="{$LISTVIEW_COUNT}" />
<input type='hidden' value="{$PAGE_NUMBER}" id='pageNumber'>
<input type='hidden' value="{$PAGING_MODEL->getPageLimit()}" id='pageLimit'>
<input type="hidden" value="{$LISTVIEW_ENTRIES_COUNT}" id="noOfEntries">

{assign var = ALPHABETS_LABEL value = vtranslate('LBL_ALPHABETS', 'Vtiger')}
{assign var = ALPHABETS value = ','|explode:$ALPHABETS_LABEL}

<div class="alphabetSorting noprint">
	
<div id="alphabettable">
<div class="table-responsive">
	<table width="100%">
		<tbody>
			<tr>
			{foreach item=ALPHABET from=$ALPHABETS}
				<td class="alphabetSearch textAlignCenter cursorPointer {if $ALPHABET_VALUE eq $ALPHABET} highlightBackgroundColor {/if}" ><a id="{$ALPHABET}" href="#">{$ALPHABET}</a></td>
			{/foreach}
			</tr>
		</tbody>
	</table>
</div>
</div>
<!-- alphabetpicklist -->
<div id="alphabetpicklist">
	<span class="btn-group pull-right">
<button class="btn dropdown-togglealpha span3" style="text-align: center" data-toggle="dropdown" href="javascript:void(0);"><strong> Alphabet</strong>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></button>
<ul class="dropdown-menu">
{foreach item=ALPHABET from=$ALPHABETS}
				<li class="alphabetSearch textAlignCenter cursorPointer {if $ALPHABET_VALUE eq $ALPHABET} highlightBackgroundColor {/if}" style="padding : 0px !important"><a id="{$ALPHABET}" href="#">{$ALPHABET}</a></li>
			{/foreach}
		</ul>
	</span>
</div>
<!-- alphabetpicklist end -->
</div>
<div class="clearfix"></div>


<div id="selectAllMsgDiv" class="alert-block msgDiv noprint">
	<strong><a id="selectAllMsg">{vtranslate('LBL_SELECT_ALL',$MODULE)}&nbsp;{vtranslate($MODULE ,$MODULE)}&nbsp;(<span id="totalRecordsCount"></span>)</a></strong>
</div>
<div id="deSelectAllMsgDiv" class="alert-block msgDiv noprint">
	<strong><a id="deSelectAllMsg">{vtranslate('LBL_DESELECT_ALL_RECORDS',$MODULE)}</a></strong>
</div>
<!--
<div class="contents-topscroll noprint">
	<div class="topscroll-div">
		&nbsp;
	 </div>
</div>
-->




<div class="listViewEntriesDiv">
	<div class="bottomscroll-divs">
	<input type="hidden" value="{$ORDER_BY}" id="orderBy">
	<input type="hidden" value="{$SORT_ORDER}" id="sortOrder">
	<span class="listViewLoadingImageBlock hide modal noprint" id="loadingListViewModal">
		<img class="listViewLoadingImage" src="{vimage_path('loading.gif')}" alt="no-image" title="{vtranslate('LBL_LOADING', $MODULE)}"/>
		<p class="listViewLoadingMsg">{vtranslate('LBL_LOADING_LISTVIEW_CONTENTS', $MODULE)}........</p>
	</span>
	{assign var=WIDTHTYPE value=$CURRENT_USER_MODEL->get('rowheight')}
	
<hr>

<style>
	.grid-element{
		border: 1px solid lightgray;
		padding: 10px;
	}
	
	.grid-detail-btn{
		height: 33%;
		background-color: green;
		color: white;
	}
	
	.grid-edit-btn{
		height: 33%;
		background-color: yellow;
		color: white;
	}
	.grid-delete-btn{
		height: 33%;
		background-color: red;
		color: white;
	}
	.listViewEntryValue{
		padding: 0px !important;
	}
	.gridRow{
		margin-bottom: 15px;
	}
	.gridViewEntries{
		margin:2px!important;
		vertical-align:top; 
		width: 32.5%; 
		height:100%;
		display: inline-block;
	}
	
	@media (min-width: 1440px){
		.gridViewEntries{
			width: 24.5%; 
		}
	}
	@media (min-width: 1920px){
		.gridViewEntries{
			width: 19.5%; 
		}
	}
	@media (max-width: 800px){
		.gridViewEntries{
			width: 49%; 
		}
	}
	@media (max-width: 500px){
		.gridViewEntries{
			display:block;
			width: 100%;
		}
	}
	
	.listViewEntries{		
		position: absolute;
		width: 0;
		height: 0; 
		border-left: 25px solid;
		border-bottom: 25px solid;
		border-bottom-color: #fff; 
		border-left-color: transparent;
	}
	
	.listViewEntriesTitle{
		margin-left:30px;		
	}
	
	.gridViewEntriesTable{
		max-width: 100% !important;
	}
</style>

<div class="listViewEntriesTable gridViewEntriesTable">

<div style="padding-bottom:20px;">
		
			<div class="listViewHeaders">
				
				
				
				<div class="btn-group"  style="float:left">
				<a class="btn dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort"></i>&nbsp;<strong>{vtranslate('LBL_BY', $MODULE )}</strong>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></a>
				<ul class="dropdown-menu">
					
				
				{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}
					<li><a href="javascript:void(0);" class="listViewHeaderValues" data-nextsortorderval="{if $COLUMN_NAME eq $LISTVIEW_HEADER->get('column')}{$NEXT_SORT_ORDER}{else}ASC{/if}" data-columnname="{$LISTVIEW_HEADER->get('column')}">{vtranslate($LISTVIEW_HEADER->get('label'), $MODULE)}
						&nbsp;&nbsp;{if $COLUMN_NAME eq $LISTVIEW_HEADER->get('column')}<img class="{$SORT_IMAGE} icon-white">{/if}</a></li>
				{/foreach}
				
				</ul>
				
				</div>
				
				<div class="btn-group" style="float:left" >
				<a class="btn" id="listViewEntriesMainCheckBoxTrigger"><i class="fa fa-square-o"></i>&nbsp;<strong>{vtranslate('LBL_SELECT_ALL', $MODULE )}</strong></a>
				<input type="checkbox" style="display:none;" class="form-control" id="listViewEntriesMainCheckBox" />
				</div>
				
				{if $MODULE_MODEL->isQuickSearchEnabled()}
		        <div class="btn-group"  style="float:left"  >
		        	<div style="float:left">
					<strong style="">{vtranslate('LBL_SEARCH_IN', $MODULE )}: </strong>			
					<select class="chzn-select" id="mycQuickSearchField" >
						
					{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}					
		             <option value="{$LISTVIEW_HEADER->getName()}">{vtranslate($LISTVIEW_HEADER->get('label'))}</option>
					{/foreach}
					
					</select>
		        	</div>
					<div style="float:right;">
					{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS name=mycQSFI}
										
		             <div style="{if !$smarty.foreach.mycQSFI.first}display:none;{/if}float:left; " class="mycQuickSearch" id="mycQuickSearch_{$LISTVIEW_HEADER->getName()}">
		                {assign var=FIELD_UI_TYPE_MODEL value=$LISTVIEW_HEADER->getUITypeModel()}
		                {include file=vtemplate_path($FIELD_UI_TYPE_MODEL->getListSearchTemplateName(),$MODULE_NAME)
		                    FIELD_MODEL= $LISTVIEW_HEADER SEARCH_INFO=$SEARCH_DETAILS[$LISTVIEW_HEADER->getName()] USER_MODEL=$CURRENT_USER_MODEL}
		             </div>
					{/foreach}
					
					<button  style="float:right;" class="btn mycQuickSearchBtn" data-trigger="listSearch">{vtranslate('LBL_SEARCH', $MODULE )}</button>
					</div>
					
		        </div>
		        {/if}
        
				
				
				
				<br>
				
				

				</div>
</div>

<div class="row-fluid gridRow">
	<div class="mycQuickSearchFieldsTags" style="width: 100%;display:none">
	<h5 style="float:left;" id="">{vtranslate('LBL_FILTER_CONDITIONS', $MODULE )}: &nbsp;&nbsp;&nbsp;</h5>
	{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}					
		    <span class="mycQsFieldLabel" style="display:none" id="mycQsField_{$LISTVIEW_HEADER->getName()}">&nbsp;<span class="label label-primary">{vtranslate($LISTVIEW_HEADER->get('label'))}: <span class="sFieldVal"></span>&nbsp;&nbsp;&nbsp;|&nbsp;<i class="fa fa-times" onclick="$('#mycQuickSearch_{$LISTVIEW_HEADER->getName()} input, #mycQuickSearch_{$LISTVIEW_HEADER->getName()} select').val(''); $('.mycQuickSearchBtn').trigger('click')"></i></span></span>	             
	{/foreach}
					
				</div>
</div>

<div class="row-fluid gridRow">


{foreach item=LISTVIEW_ENTRY from=$LISTVIEW_ENTRIES name=listview}


	
		<div class="gridViewEntries" data-id='{$LISTVIEW_ENTRY->getId()}' data-recordUrl='{$LISTVIEW_ENTRY->getDetailViewUrl()}' id="{$MODULE}_listView_row_{$smarty.foreach.listview.index+1}">
            <div class="grid-element">
            
			<div class="row-fluid">	
				<div class="pull-right">
				<input type="checkbox" value="{$LISTVIEW_ENTRY->getId()}" class="listViewEntriesCheckBox"/>
			</div>	
			<div class="">
				
				{assign var=NAME_FIELDS value=$MODULE_MODEL->getNameFields()}
				
				<a href="{$LISTVIEW_ENTRY->getDetailViewUrl()}">
				<div class="listViewEntries" data-id='{$LISTVIEW_ENTRY->getId()}' style=""></div>
				<h3 class="listViewEntriesTitle"> {foreach item=NAME_FIELD from=$NAME_FIELDS}
				{if $LISTVIEW_HEADERS[$NAME_FIELD]}
				<small>{vtranslate($LISTVIEW_HEADERS[$NAME_FIELD]->get('label'))}: </small>{$LISTVIEW_ENTRY->get($NAME_FIELD)}
				{/if}
				<br>
				{/foreach}	
				</h3></a>
				
				
            	
				<div style="text-align:center" class="btn-toolbar">
            
            
			
			
				<div class="actions btn-group" id="mycactions">
					<span class="actionImages">
						<a class="btn btn-xs btn-black tooltips" data-toggle="tooltip" data-placement="bottom" title="{vtranslate('LBL_SHOW_FULL_DETAILS')}" href="{$LISTVIEW_ENTRY->getFullDetailViewUrl()}"><i class="fa fa-list"></i></a>
						{if $MODULE_MODEL->isCommentEnabled()}
							<a class="btn btn-xs btn-cyan tooltips" data-toggle="tooltip" data-placement="bottom" title="{vtranslate('ModComments')}" href="{$LISTVIEW_ENTRY->getFullDetailViewUrl()}&mode=showAllComments&tab_label=ModComments"><i class="fa fa-comments"></i></a>
						{/if}
						{if $MODULE_MODEL->isTrackingEnabled()}
							<a class="btn btn-xs btn-peas tooltips" data-toggle="tooltip" data-placement="bottom" title="{vtranslate('LBL_UPDATES')}" href="{$LISTVIEW_ENTRY->getFullDetailViewUrl()}&mode=showRecentActivities&page=1&tab_label=LBL_UPDATES"><i class="fa fa-refresh"></i></a>
						{/if}
						{if $IS_MODULE_EDITABLE}
							<a class="btn btn-xs btn-yellow tooltips"  data-toggle="tooltip" data-placement="bottom" title="{vtranslate('LBL_EDIT')}" href='{$LISTVIEW_ENTRY->getEditViewUrl()}'><i class="fa fa-pencil"></i></a>
						{/if}
						{if $IS_MODULE_DELETABLE}
							<a class="btn btn-xs btn-red tooltips deleteRecordButton"  data-toggle="tooltip" data-placement="bottom" title="{vtranslate('LBL_DELETE')}"><i class="fa fa-trash"></i></a>
						{/if}
					</span>
					
				</div>
	<div class="btn-group" >
  <button type="button" class="btn btn-mazzy btn-xs dropdown-toggle gridrelated" style="width:100%;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <i class="fa fa-paperclip"></i>
  </button>
  <ul class="dropdown-menu related gridrelatedul" {if $smarty.foreach.listview.iteration is div by 3}style="right:0;left:auto;"{/if}>
    {assign var="SELECTED_TAB_LABEL" value=$smarty.get.tab_label}

						
						
						{foreach item=RELATED_LINK from=$RELATION_LINKS}
				
							{* Assuming most of the related link label would be module name - we perform dual translation *}
							{assign var="DETAILVIEWRELATEDLINKLBL" value= vtranslate($RELATED_LINK['linklabel'], $RELATED_LINK['relatedModuleName'])}
						<li><a href="index.php?module={$MODULE}&relatedModule={$RELATED_LINK['relatedModuleName']}&view=Detail&record={$LISTVIEW_ENTRY->getId()}&mode=showRelatedList&tab_label={$RELATED_LINK['linklabel']}" class="mycrelatedtab {if $RELATED_LINK['linklabel']==$SELECTED_TAB_LABEL}active{/if} label-mazzy" data-url="module={$MODULE}&relatedModule={$RELATED_LINK['relatedModuleName']}&view=Detail&record={$LISTVIEW_ENTRY->getId()}&mode=showRelatedList&tab_label={$RELATED_LINK['linklabel']}" class="mycrelatedtab {if $RELATED_LINK['linklabel']==$SELECTED_TAB_LABEL}active{/if}" data-recordid="{$LISTVIEW_ENTRY->getId()}" data-label-key="{$RELATED_LINK['linklabel']}" style="width:auto" title="{$DETAILVIEWRELATEDLINKLBL}"><strong>
						{if vimage_path($RELATED_LINK['relatedModuleName']|cat:'.png') != false}
									<img  class="alignMiddle" src="{vimage_path($RELATED_LINK['relatedModuleName']|cat:'.png')}" alt="{vtranslate($RELATED_LINK['linklabel'], $RELATED_LINK['linklabel'])}" title="{vtranslate($RELATED_LINK['linklabel'], $RELATED_LINK['linklabel'])}"/>
								{else}
									<img  class="alignMiddle" src="{vimage_path('DefaultModule.png')}" alt="{vtranslate($RELATED_LINK['linklabel'], $RELATED_LINK['linklabel'])}" title="{vtranslate($RELATED_LINK['linklabel'], $RELATED_LINK['linklabel'])}"/>
								{/if}
								&nbsp;&nbsp;
								
						{$DETAILVIEWRELATEDLINKLBL}</strong></a></li>
						
						{/foreach}
  </ul>
</div>

			<div id="mycaction" class="btn-group  actionImages actions tooltips">
			  <a class="btn btn-xs dropdown-toggle tooltips actionsdd" data-toggle="dropdown" onclick="">
			    <i class="fa fa-cogs"></i>
			  </a>
			  <ul class="dropdown-menu">
			    <li><a href="{$LISTVIEW_ENTRY->getFullDetailViewUrl()}"><i class="fa fa-list"></i>&nbsp;{vtranslate('LBL_SHOW_COMPLETE_DETAILS', $MODULE)}</a></li>
			    {if $IS_MODULE_EDITABLE}
			    <li><a href="{$LISTVIEW_ENTRY->getEditViewUrl()}"><i class="fa fa-edit"></i>&nbsp;{vtranslate('LBL_EDIT', $MODULE)}</a></li>
			    {/if}
			    {if $MODULE_MODEL->isTrackingEnabled()}<li>
							<a href="{$LISTVIEW_ENTRY->getFullDetailViewUrl()}&mode=showRecentActivities&page=1&tab_label=LBL_UPDATES"><i class="fa fa-refresh"></i>&nbsp;{vtranslate('LBL_UPDATES', $MODULE)}</a>
						</li>{/if}
						{if $MODULE_MODEL->isCommentEnabled()}
						<li>
							<a href="{$LISTVIEW_ENTRY->getFullDetailViewUrl()}&mode=showAllComments&tab_label=ModComments"><i class="fa fa-comments"></i>&nbsp;{vtranslate('ModComments', $MODULE)}</a>
						</li>{/if}
				{if $IS_MODULE_DELETABLE}
				<li><a class="deleteRecordButton"><i class="fa fa-trash"></i>&nbsp;{vtranslate('LBL_DELETE', $MODULE)}</a></li>
			    {/if}
			  </ul>
			</div>
			</div>
			<div class="clearfix"></div>
				<hr>
						
					{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}
					{if $LISTVIEW_HEADER->isNameField() neq true}
			{assign var=LISTVIEW_HEADERNAME value=$LISTVIEW_HEADER->get('name')}
			<div class="listViewEntryValue {$WIDTHTYPE}" data-field-type="{$LISTVIEW_HEADER->getFieldDataType()}" nowrap>
				{if $LISTVIEW_HEADER->isNameField() neq true}
				<b>{vtranslate($LISTVIEW_HEADER->get('label'), $MODULE)}: </b>&nbsp;
				{/if}
				{if ($LISTVIEW_HEADER->isNameField() eq true or $LISTVIEW_HEADER->get('uitype') eq '4') and $MODULE_MODEL->isListViewNameFieldNavigationEnabled() eq true }
					<a href="{$LISTVIEW_ENTRY->getDetailViewUrl()}">{$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}</a>
			
				{else if $LISTVIEW_HEADER->get('uitype') eq '72'}
					{assign var=CURRENCY_SYMBOL_PLACEMENT value={$CURRENT_USER_MODEL->get('currency_symbol_placement')}}
					{if $CURRENCY_SYMBOL_PLACEMENT eq '1.0$'}
						{$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}{$LISTVIEW_ENTRY->get('currencySymbol')}
					{else}
						{$LISTVIEW_ENTRY->get('currencySymbol')}{$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}
					{/if}
                                {else if $LISTVIEW_HEADER->get('uitype') eq '11'}
                                        {assign var=PBXMANAGER_MODULE value='PBXManager'}
                                        {assign var=MODULEMODEL value=Vtiger_Module_Model::getInstance($PBXMANAGER_MODULE)}
                                        {if $MODULEMODEL}
                                            {assign var=PERMISSION value=PBXManager_Server_Model::checkPermissionForOutgoingCall()}
                                            {if $PERMISSION}
                                                {assign var=PHONE_FIELD_VALUE value=$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}
                                                {assign var=PHONE_NUMBER value=$PHONE_FIELD_VALUE|regex_replace:"/[-()\s]/":""}
                                                <a class="phoneField" data-value="{$PHONE_NUMBER}" record="{$LISTVIEW_ENTRY->getId()}" onclick="Vtiger_PBXManager_Js.registerPBXOutboundCall('{$PHONE_NUMBER}',{$LISTVIEW_ENTRY->getId()})">{$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}</a>
                                            {else}
                                                {$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}
                                            {/if}
                                        {else}
                                            {$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}
                                        {/if}
				{else}
                    {if $LISTVIEW_HEADER->getFieldDataType() eq 'double'}
                        {decimalFormat($LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME))}
                    {else if $LISTVIEW_HEADER->get('uitype') eq '9'}
                    	{assign var=PROGRESS value=$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)|replace:"<span align='right'>":''|replace:'</div>':''}
                    	
                    	{if $PROGRESS eq ""}0{else}{$PROGRESS}{/if}%
                    	
                    	{if $PROGRESS eq ""}
                    		{assign var=PROGRESS value=0}
                    	{else if $PROGRESS >= 100}
                    		{assign var=PROGRESS value=100}
							{assign var=PROGRESSCOLOR value="green"}
                    	{else if $PROGRESS > 60}
							{assign var=PROGRESSCOLOR value="blue"}
                    	{else if $PROGRESS > 30}
							{assign var=PROGRESSCOLOR value="orange"}
                    	{else}
                    		{assign var=PROGRESSCOLOR value="red"}
                    	{/if}
                    	
                    	<div class="myc-progressbar myc-progressbar-{$PROGRESSCOLOR}">
							<span style="width: {$PROGRESS}%"></span>
						</div>
						<p style="height: 5px">&nbsp;</p>
                    {else}
                        {$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)|replace:"<span align='right'>":''|replace:'</div>':''}
                    {/if}
				{/if}				
				{if $LISTVIEW_HEADER@last}
				
				{/if}
			</div>
			{/if}
			{/foreach}
				

					
			</div>
			</div>
            </div>
            
		</div>
		
	<!--	{if $smarty.foreach.listview.iteration is div by 3} 
</div><div class="row gridRow">
{/if}-->

		{/foreach}

</div>
	
</div>

<hr>	
	


<!--added this div for Temporarily -->
{if $LISTVIEW_ENTRIES_COUNT eq '0'}
<div class="table-responsive">
	<table class="emptyRecordsDiv">
		<tbody>
			<tr>
				<td>
					{assign var=SINGLE_MODULE value="SINGLE_$MODULE"}
					{vtranslate('LBL_NO')} {vtranslate($MODULE, $MODULE)} {vtranslate('LBL_FOUND')}.{if $IS_MODULE_EDITABLE} {vtranslate('LBL_CREATE')} <a href="{$MODULE_MODEL->getCreateRecordUrl()}">{vtranslate($SINGLE_MODULE, $MODULE)}</a>{/if}
				</td>
			</tr>
		</tbody>
	</table>
</div>
{/if}




<div class="row-fluid">
	<div class="span9">&nbsp;</div>
	<div class="span3" style="text-align:right">
		
		
		
		{strip}
		<div class="listViewActions pull-right">
        {if (method_exists($MODULE_MODEL,'isPagingSupported') && ($MODULE_MODEL->isPagingSupported()  eq true)) || !method_exists($MODULE_MODEL,'isPagingSupported')}
			<div class="pageNumbers alignTop {if $LISTVIEW_LINKS['LISTVIEWSETTING']|@count gt 0}{else}{/if}">
					<span>
						<span class="pageNumbersText" style="padding-right:5px">{if $LISTVIEW_ENTRIES_COUNT}{$PAGING_MODEL->getRecordStartRange()} {vtranslate('LBL_to', $MODULE)} {$PAGING_MODEL->getRecordEndRange()}{else}<span>&nbsp;</span>{/if}</span>
						<span class="fa fa-refresh pull-right totalNumberOfRecords cursorPointer{if !$LISTVIEW_ENTRIES_COUNT} hide{/if}"></span>
					</span>
			</div>
			<div class="btn-group alignTop margin0px">
				<span class="pull-right">
					<span class="btn-groups">
					
						{if $PAGING_MODEL->isPrevPageExists()}<a class="btn listViewPreviousPageButton"  ><span class="fa fa-chevron-left"></span></a>{/if}
							
							{if $PAGING_MODEL->isNextPageExists() and ($PAGE_COUNT neq 1)}
						<a class="btn listViewNextPageButton"   ><span class="fa fa-chevron-right"></span></a>{/if}
					</span>
				</span>	
			</div>
        {/if}

	</div>
	<div class="clearfix"></div>
{/strip}
		
		
		
		
	</div>
</div>



</div>
</div>







<script>
			$(function(){
				$(".listViewContentDiv").ready(function(){
					$(".actionsdd").dropdown();
					$(".actionsdd").bind("click", function(e){
						
						$(this).dropdown();
						return false;						
					});
				});
			});
</script>
{/strip}
