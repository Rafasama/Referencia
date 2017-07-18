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
<div class="contents-topscroll noprint">
	<div class="topscroll-div">
		&nbsp;
	 </div>
</div>
<div class="listViewEntriesDiv contents-bottomscroll">
	<div class="bottomscroll-div">
	<input type="hidden" value="{$ORDER_BY}" id="orderBy">
	<input type="hidden" value="{$SORT_ORDER}" id="sortOrder">
	<span class="listViewLoadingImageBlock hide modal noprint" id="loadingListViewModal">
		<img class="listViewLoadingImage" src="{vimage_path('loading.gif')}" alt="no-image" title="{vtranslate('LBL_LOADING', $MODULE)}"/>
		<p class="listViewLoadingMsg">{vtranslate('LBL_LOADING_LISTVIEW_CONTENTS', $MODULE)}........</p>
	</span>
	{assign var=WIDTHTYPE value=$CURRENT_USER_MODEL->get('rowheight')}
	<div class="table-responsive">
<table class="table table-bordered listViewEntriesTable">
		<thead>
			<tr class="listViewHeaders">
				<th width="5%">
					<input type="checkbox" id="listViewEntriesMainCheckBox" />
				</th>
				<th width="5%">
				</th>
				{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}
				<th nowrap {if $LISTVIEW_HEADER@last} colspan="2" {/if}>
					<a href="javascript:void(0);" class="listViewHeaderValues" data-nextsortorderval="{if $COLUMN_NAME eq $LISTVIEW_HEADER->get('column')}{$NEXT_SORT_ORDER}{else}ASC{/if}" data-columnname="{$LISTVIEW_HEADER->get('column')}">{vtranslate($LISTVIEW_HEADER->get('label'), $MODULE)}
						&nbsp;&nbsp;{if $COLUMN_NAME eq $LISTVIEW_HEADER->get('column')}<img class="{$SORT_IMAGE} icon-white">{/if}</a>
				</th>
				{/foreach}
			</tr>
		</thead>
        <tr>
            <td></td>
            <td> 
             <button class="btn" data-trigger="listSearch">Search</button> 
         </td>
         {foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}
             <td>
                 {assign var=FIELD_UI_TYPE_MODEL value=$LISTVIEW_HEADER->getUITypeModel()}     
                {include file=vtemplate_path($FIELD_UI_TYPE_MODEL->getListSearchTemplateName(),$MODULE) 
                    FIELD_MODEL= $LISTVIEW_HEADER SEARCH_INFO=$SEARCH_DETAILS[$LISTVIEW_HEADER->getName()] USER_MODEL=$CURRENT_USER_MODEL}
             </td>
         {/foreach}
         
        </tr>
		{foreach item=LISTVIEW_ENTRY from=$LISTVIEW_ENTRIES name=listview}
			{assign var=CURRENT_USER_ID value=$CURRENT_USER_MODEL->getId()}
			{assign var=RAWDATA value=$LISTVIEW_ENTRY->getRawData()}
			{assign var=OWNER_ID value=$RAWDATA['smownerid']}
			{assign var=DETAIL_VIEW_URL value=$LISTVIEW_ENTRY->getDetailViewUrl()}
			{assign var=FULL_DETAIL_VIEW_URL value=$LISTVIEW_ENTRY->getFullDetailViewUrl()}
			{assign var=EDIT_VIEW_URL value=$LISTVIEW_ENTRY->getEditViewUrl()}
			{assign var=IS_DELETE value='true'}
			{assign var=visibility value='true'}
			{if in_array($OWNER_ID, $GROUPS_IDS)}
				{assign var=visibility value=false}
			{else if $OWNER_ID == $CURRENT_USER_ID}
				{assign var=visibility value=false}
			{/if}
			{if !$CURRENT_USER_MODEL->isAdminUser() && $LISTVIEW_ENTRY->get('activitytype') != 'Task' && $LISTVIEW_ENTRY->get('visibility') == 'Private' && $OWNER_ID && $visibility}
				{assign var=DETAIL_VIEW_URL value=''}
				{assign var=FULL_DETAIL_VIEW_URL value=''}
				{assign var=EDIT_VIEW_URL value=''}
				{assign var=IS_DELETE value=false}
			{/if}
		<tr class="listViewEntries" data-id='{$LISTVIEW_ENTRY->getId()}' 
			{if $DETAIL_VIEW_URL} data-recordUrl='{$DETAIL_VIEW_URL}' {/if} id="{$MODULE}_listView_row_{$smarty.foreach.listview.index+1}">
            <td  width="5%" class="{$WIDTHTYPE}">
				<input type="checkbox" value="{$LISTVIEW_ENTRY->getId()}" class="listViewEntriesCheckBox"/>
			</td>
			<td nowrap class="{$WIDTHTYPE}">
				<div class="actions pull-right" id="mycactions">
					<span class="actionImages">
                        {if $IS_MODULE_EDITABLE && $EDIT_VIEW_URL && $LISTVIEW_ENTRY->get('taskstatus') neq 'Held' && $LISTVIEW_ENTRY->get('taskstatus') neq 'Completed'}
                            <a class="btn btn-xs btn-cyan markAsHeld"><i title="{vtranslate('LBL_MARK_AS_HELD', $MODULE)}" class="fa fa-check"></i></a>&nbsp;
                        {/if}
                      {if $IS_MODULE_EDITABLE && $EDIT_VIEW_URL && $LISTVIEW_ENTRY->get('taskstatus') eq 'Held'}
							<a class="btn btn-xs btn-orange tooltips holdFollowupOn"><i class="fa fa-flag"></i></a>&nbsp;
						{/if}
						<a class="btn btn-xs btn-black tooltips" href="{$LISTVIEW_ENTRY->getFullDetailViewUrl()}"><i class="fa fa-list"></i></a>&nbsp;
						{if $IS_MODULE_EDITABLE}
							<a class="btn btn-xs btn-yellow tooltips" href='{$LISTVIEW_ENTRY->getEditViewUrl()}'><i class="fa fa-pencil"></i></a>&nbsp;
						{/if}
						{if $IS_MODULE_DELETABLE}
							<a class="btn btn-xs btn-red tooltips" class="deleteRecordButton"><i class="fa fa-trash"></i></a>
						{/if}
					  
					</span>
				</div>

				<div id="mycaction">
					<div class="btn-group  actionImages actions tooltips">
{if $IS_MODULE_EDITABLE && $EDIT_VIEW_URL && $LISTVIEW_ENTRY->get('taskstatus') neq 'Held' && $LISTVIEW_ENTRY->get('taskstatus') neq 'Completed'}
                            <a class="btn btn-sm btn-darkyellow markAsHeld"><i title="{vtranslate('LBL_MARK_AS_HELD', $MODULE)}" class="fa fa-check alignMiddle"></i></a>&nbsp;
                        {/if}
                        {if $IS_MODULE_EDITABLE && $EDIT_VIEW_URL && $LISTVIEW_ENTRY->get('taskstatus') eq 'Held'}
							<a class="btn btn-sm btn-orange holdFollowupOn"><i class="fa fa-flag"></i></a>&nbsp;
						{/if}
					</div>
					<div class="btn-group  actionImages actions tooltips alignTop">
			  <a class="btn dropdown-toggle tooltips actionsdd" data-toggle="dropdown" onclick="">
			    <i class="fa fa-cogs"></i>
			  </a>

			  <ul class="dropdown-menu">
			      <li><a href="{$LISTVIEW_ENTRY->getFullDetailViewUrl()}"><i class="fa fa-list"></i>&nbsp;{vtranslate('LBL_SHOW_COMPLETE_DETAILS', $MODULE)}</a></li>
			    {if $IS_MODULE_EDITABLE}
			    <li><a href="{$LISTVIEW_ENTRY->getEditViewUrl()}"><i class="fa fa-edit"></i>&nbsp;{vtranslate('LBL_EDIT', $MODULE)}</a></li>
			    {/if}
				{if $IS_MODULE_DELETABLE}
				<li><a class="deleteRecordButton"><i class="fa fa-trash"></i>&nbsp;{vtranslate('LBL_DELETE', $MODULE)}</a></li>
			    {/if}
			  </ul>
			</div></div>

			</td>
			{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}
			{assign var=LISTVIEW_HEADERNAME value=$LISTVIEW_HEADER->get('name')}
			<td class="listViewEntryValue {$WIDTHTYPE}" data-field-type="{$LISTVIEW_HEADER->getFieldDataType()}" nowrap>
				{if $LISTVIEW_HEADER->isNameField() eq true or $LISTVIEW_HEADER->get('uitype') eq '4'}
					<a href="{$LISTVIEW_ENTRY->getDetailViewUrl()}">{$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}</a>
				{else if $LISTVIEW_HEADER->get('uitype') eq '72'}
					{assign var=CURRENCY_SYMBOL_PLACEMENT value={$CURRENT_USER_MODEL->get('currency_symbol_placement')}}
					{if $CURRENCY_SYMBOL_PLACEMENT eq '1.0$'}
						{$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}{$LISTVIEW_ENTRY->get('currencySymbol')}
					{else}
						{$LISTVIEW_ENTRY->get('currencySymbol')}{$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}
					{/if}
				{else}
					{$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}
				{/if}
				{if $LISTVIEW_HEADER@last}
				</td>
				{/if}
			</td>
			{/foreach}
		</tr>
		{/foreach}
	</table>

<!--added this div for Temporarily -->
{if $LISTVIEW_ENTRIES_COUNT eq '0'}
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
{/if}
</div>
</div><!--/ table responsive-->
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