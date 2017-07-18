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
<div class="row">
	<ul class="pagination">
			{foreach item=ALPHABET from=$ALPHABETS}
				<li class="textAlignCenter cursorPointer {if $ALPHABET_VALUE eq $ALPHABET} active {/if}" ><a id="{$ALPHABET}" href="#">{$ALPHABET}</a></li>
			{/foreach}
</div>
</div>
<!-- alphabetpicklist -->
<div id="alphabetpicklist">
	
	<div class="btn-group pull-right">
<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><strong> Alphabet</strong> <i class="caret"></i></button>
<ul class="dropdown-menu pager">
{foreach item=ALPHABET from=$ALPHABETS}
				<li class="textAlignCenter cursorPointer {if $ALPHABET_VALUE eq $ALPHABET} active {/if}" style="padding : 0px !important"><a id="{$ALPHABET}" href="#">{$ALPHABET}</a></li>
			{/foreach}
		</ul>
	</div>

</div><!-- alphabetpicklist end -->
</div> <!-- alphabetSorting end -->

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
<div class="span12">
			<div class="row">
				<div class="span1">
					<input type="checkbox" id="listViewEntriesMainCheckBox" />
				</div>
				<div class="span2">&nbsp;</div>

				{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}
				<div class="span1" {if $LISTVIEW_HEADER@last} colspan="2" {/if}>
					<a href="javascript:void(0);" class="listViewHeaderValues" data-nextsortorderval="{if $COLUMN_NAME eq $LISTVIEW_HEADER->get('column')}{$NEXT_SORT_ORDER}{else}ASC{/if}" data-columnname="{$LISTVIEW_HEADER->get('column')}">{vtranslate($LISTVIEW_HEADER->get('label'), $MODULE)}
						&nbsp;&nbsp;{if $COLUMN_NAME eq $LISTVIEW_HEADER->get('column')}<img class="{$SORT_IMAGE} icon-white">{/if}</a>
				</div>
				{/foreach}
			</div>
        {if $MODULE_MODEL->isQuickSearchEnabled()}
        <div class="row">

            <div class="span1">&nbsp;</div>
            <div class="span2">
				<button class="btn" data-trigger="listSearch">{vtranslate('LBL_SEARCH', $MODULE )}</button>
			</div>
			{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}
             <div class="span1">
                 {assign var=FIELD_UI_TYPE_MODEL value=$LISTVIEW_HEADER->getUITypeModel()}
                {include file=vtemplate_path($FIELD_UI_TYPE_MODEL->getListSearchTemplateName(),$MODULE_NAME)
                    FIELD_MODEL= $LISTVIEW_HEADER SEARCH_INFO=$SEARCH_DETAILS[$LISTVIEW_HEADER->getName()] USER_MODEL=$CURRENT_USER_MODEL}
             </div>
			{/foreach}
			
        </div>
        {/if}
		{foreach item=LISTVIEW_ENTRY from=$LISTVIEW_ENTRIES name=listview}
		<div class="row" data-id='{$LISTVIEW_ENTRY->getId()}' data-recordUrl='{$LISTVIEW_ENTRY->getDetailViewUrl()}' id="{$MODULE}_listView_row_{$smarty.foreach.listview.index+1}">
            <div class="span1">
				<input type="checkbox" value="{$LISTVIEW_ENTRY->getId()}" class="listViewEntriesCheckBox"/>
			</div>
			<div class="span2">
				<div class="actions">
					<span class="actionImages">
						<a class="btn btn-xs btn-black tooltips" href="{$LISTVIEW_ENTRY->getFullDetailViewUrl()}"><i class="icon-list"></i></a>&nbsp;
						{if $IS_MODULE_EDITABLE}
							<a class="btn btn-xs btn-yellow tooltips" href='{$LISTVIEW_ENTRY->getEditViewUrl()}'><i class="icon-pencil"></i></a>&nbsp;
						{/if}
						{if $IS_MODULE_DELETABLE}
							<a class="btn btn-xs btn-red tooltips deleteRecordButton" ><i class="icon-trash"></i></a>
						{/if}
					</span>
				</div></div>
			{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}
			{assign var=LISTVIEW_HEADERNAME value=$LISTVIEW_HEADER->get('name')}
			<div class="span1" data-field-type="{$LISTVIEW_HEADER->getFieldDataType()}" nowrap>
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
                    {else}
                        {$LISTVIEW_ENTRY->get($LISTVIEW_HEADERNAME)}
                    {/if}
				{/if}
				
			</div>
			{/foreach}
		</div>
		{/foreach}
</div><!--end span12-->

<!--added this div for Temporarily -->
{if $LISTVIEW_ENTRIES_COUNT eq '0'}
<div class="span12">
			<div class="row">
				<div class="span12">
					{assign var=SINGLE_MODULE value="SINGLE_$MODULE"}
					{vtranslate('LBL_NO')} {vtranslate($MODULE, $MODULE)} {vtranslate('LBL_FOUND')}.{if $IS_MODULE_EDITABLE} {vtranslate('LBL_CREATE')} <a href="{$MODULE_MODEL->getCreateRecordUrl()}">{vtranslate($SINGLE_MODULE, $MODULE)}</a>{/if}
				</div>
			</div>
</div>
{/if}
</div>
</div>
{/strip}
