{*<!--
/*********************************************************************************
* The content of this file is subject to the EMAIL Maker license.
* ("License"); You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
* Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
* All Rights Reserved.
********************************************************************************/
-->*}
{if $SORT_ORDER eq 'asc'}
    {assign var="name_sortorder" value="desc"}
{else}
    {assign var="name_sortorder" value="asc"}
{/if}
<input type="hidden" id="totalCount" value="{$LISTVIEW_COUNT}" />
<input type="hidden" id="showview" value="ListWF" />

<input type="hidden" value="{$ORDER_BY}" id="orderBy">
<input type="hidden" value="{$SORT_ORDER}" id="sortOrder">
<input type='hidden' value="{$PAGE_NUMBER}" id='pageNumber'>
<input type="hidden" value="{$LISTVIEW_ENTIRES_COUNT}" id="noOfEntries">
<input type="hidden" value="{$TEMPLATEID}" id="templateid">
{if $SORT_ORDER eq 'asc'}
    {assign var="sortorder_img" value='&nbsp;&nbsp;<img class="icon-chevron-down icon-white" />'}
{else}
    {assign var="sortorder_img" value='&nbsp;&nbsp;<img class="icon-chevron-up icon-white" />'}
{/if}
<div class="listViewEntriesDiv contents-bottomscroll">
    <div class="bottomscroll-div">
        <table class="table table-bordered listViewEntriesTable">
            <thead>
                <tr class="listViewHeaders">
                    {foreach item=header_lang key=header_type from=$HEADER_VALUES}
                        {if $header_type eq "list_name" OR $header_type eq "status"}
                            <th class="narrowWidthType listViewHeader" data-sort="no">
                        {else}
                            <th class="narrowWidthType listViewHeader cursorPointer" data-orderby="{$header_type}" data-sortorder="{$name_sortorder}" data-sort="yes">    
                        {/if}    
                            {vtranslate($header_lang,"EMAILMaker")}
                            {if $ORDER_BY eq $header_type}{$sortorder_img}{/if}
                        </th>
                    {/foreach}
                    <th width="10%" class="narrowWidthType"></th>
                </tr>
            </thead>
            <tbody>
            {foreach item=LISTVIEW_ENTRY name=mailmerge from=$WORKFLOW_ENTRIES}
                <tr class="listViewEntries" data-id="{$LISTVIEW_ENTRY->get("workflow_id")}" data-recordmeurl="{$LISTVIEW_ENTRY->getEditViewUrl()}" id="EMAILMaker_listView_row_{$LISTVIEW_ENTRY->get("workflow_id")}">
                    {foreach item=header_lang key=header_type from=$HEADER_VALUES}
                    <td class="listViewEntryValue medium" {if $header_type eq "me_subject"}title="{$LISTVIEW_ENTRY->get("description")}"{/if}>
                        {if $header_type eq "list_name"}
                            {$LISTVIEW_ENTRY->getFilterLink()} 
                        {else}    
                            {$LISTVIEW_ENTRY->get($header_type)} 
                        {/if}                        
                        {if $header_lang@last}
				</td><td nowrap>
				<div class="actions pull-right">
					<span class="actionImages">
						{if $EDIT eq "permitted"}
							<a href='{$LISTVIEW_ENTRY->getEditViewUrl()}'><i title="{vtranslate('LBL_EDIT', $MODULE)}" class="icon-pencil alignMiddle"></i></a>&nbsp;
						{/if}
						{*if $DELETE eq "permitted"}
							<a class="deleteRecordButton"><i title="{vtranslate('LBL_DELETE', $MODULE)}" class="icon-trash alignMiddle"></i></a>
						{/if*}
					</span>
				</div></td>
				{/if}
			</td>
                    {/foreach}
                </tr>
            {foreachelse}   
            </tbody>
        </table>    
        <table class="emptyRecordsDiv">
         <tbody>
            <tr>
                <td>
                    {vtranslate("LBL_NO")} {vtranslate("LBL_EMAIL_WORKFLOWS_LIST","EMAILMaker")} {vtranslate("LBL_FOUND","EMAILMaker")}
                </td>
            </tr>  
            {/foreach}
            </tbody>
        </table>
     </div> {*bottomscroll-div*}
</div> {*listViewEntriesDiv contents-bottomscroll*}
