{*<!--
/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
-->*}
{strip}
    <div class="relatedContainer">
        <input type="hidden" name="currentPageNum" value="{$PAGING->getCurrentPage()}" />
        <input type="hidden" value="{$ORDER_BY}" id="orderBy">
        <input type="hidden" value="{$SORT_ORDER}" id="sortOrder">
        <input type="hidden" value="{$RECIPIENTS_ENTIRES_COUNT}" id="noOfEntries">
        <input type='hidden' value="{$PAGING->getPageLimit()}" id='pageLimit'>
        <input type='hidden' value="{$TOTAL_ENTRIES}" id='totalCount'>
        <div class="relatedHeader ">
            <div class="btn-toolbar row-fluid">
                <div class="span6">
                &nbsp;
                </div>
                <div class="span6">
                    <div class="pull-right">
                        <span class="pageNumbers">
                            <span class="pageNumbersText">{$PAGING->getRecordStartRange()} {vtranslate('LBL_to', $RELATED_MODULE_NAME)} {$PAGING->getRecordEndRange()}</span>
                            <span class="icon-refresh pull-right totalNumberOfRecords cursorPointer{if empty($RELATED_RECORDS)} hide{/if}"></span>
                        </span>
                        <span class="btn-group">
                            <button class="btn" id="relatedListPreviousPageButton" {if !$PAGING->isPrevPageExists()} disabled {/if} type="button"><span class="icon-chevron-left"></span></button>
                            <button class="btn dropdown-toggle" type="button" id="relatedListPageJump" data-toggle="dropdown" {if $PAGE_COUNT eq 1} disabled {/if}>
                                <i class="vtGlyph vticon-pageJump" title="{vtranslate('LBL_LISTVIEW_PAGE_JUMP',$MODULE_NAME)}"></i>
                            </button>
                            <ul class="listViewBasicAction dropdown-menu" id="relatedListPageJumpDropDown">
                                <li>
                                    <span class="row-fluid">
                                        <span class="span3"><span class="pull-right">{vtranslate('LBL_PAGE',$MODULE_NAME)}</span></span>
                                        <span class="span4">
                                            <input type="text" id="pageToJump" class="listViewPagingInput" value="{$PAGING->getCurrentPage()}"/>
                                        </span>
                                        <span class="span2 textAlignCenter">
                                            {vtranslate('LBL_OF',$MODULE_NAME)}
                                        </span>
                                        <span class="span3" id="totalPageCount">{$PAGE_COUNT}</span>
                                    </span>
                                </li>
                            </ul>
                            <button class="btn" id="relatedListNextPageButton" {if (!$PAGING->isNextPageExists()) or ($PAGE_COUNT eq 1)} disabled {/if} type="button"><span class="icon-chevron-right"></span></button>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="contents-topscroll">
            <div class="topscroll-div">
                &nbsp;
            </div>
        </div>
        <div class="relatedContents contents-bottomscroll">
            <div class="bottomscroll-div">
                                {assign var=WIDTHTYPE value=$CURRENT_USER_MODEL->get('rowheight')}
                <table class="table table-bordered listViewEntriesTable">
                    <thead>
                        <tr class="listViewHeaders">
                            {foreach item=HEADER_DATA from=$HEADER_FIELDS}
                                <th class="{$WIDTHTYPE}">
                                    {vtranslate($HEADER_DATA.label,$MODULE_NAME)}
                                </th>
                            {/foreach}
                        </tr>
                    </thead>
                    {foreach item=RECIPIENT_RECORD from=$RECIPIENTS}
                        <tr class="listViewEntries" data-id='{$RECIPIENT_RECORD->getId()}' name="emailsRelatedRecord">
                            {foreach key=HEADERNAME item=HEADER_DATA from=$HEADER_FIELDS}
                                    {assign var=HEADER_FIELD value=$HEADER_DATA.field}
                                    <td class="{$WIDTHTYPE}">
                                    {*if $HEADER_FIELD->isNameField() eq true or $HEADER_FIELD->get('uitype') eq '4'}
                                        <a>{$RECIPIENT_RECORD->getDisplayValue($HEADERNAME)}</a>*}
                                    {if $HEADERNAME eq 'access_count'}
                                        {$RECIPIENT_RECORD->getAccessCountValue($RECIPIENT_RECORD->get('pid'))}
                                    {elseif $HEADERNAME eq 'date_start' || $HEADERNAME eq 'time_start'}
                                        {if $RECIPIENT_RECORD->get('activityid') neq ""}
                                            {$RECIPIENT_RECORD->getDisplayValue($HEADERNAME)}
                                        {/if}
                                    {elseif $HEADERNAME eq 'parent_id'}
                                        {assign var=REFERENCE_RECORD value=$RECIPIENT_RECORD->get('pid')}
                                        {assign var=REFERENCE_MODULE value=$RECIPIENT_RECORD->get('pmodulemodel')}
                                        {assign var=REFERENCE_MODULE_NAME value=$RECIPIENT_RECORD->get('pmodule')}
                                        {assign var=REFERENCE_RECORD_ENTIYNAME_LIST value=getEntityName($REFERENCE_MODULE_NAME,$REFERENCE_RECORD)}
                                        <a href="index.php?module={$REFERENCE_MODULE_NAME}&view={$REFERENCE_MODULE->getDetailViewName()}&record={$REFERENCE_RECORD}"
                                           title="{vtranslate($REFERENCE_MODULE_NAME, $REFERENCE_MODULE_NAME)}"
                                           onclick="if(event.stopPropagation){ldelim}event.stopPropagation();{rdelim}else{ldelim}event.cancelBubble=true;{rdelim}">
                                            {$REFERENCE_RECORD_ENTIYNAME_LIST.$REFERENCE_RECORD}
                                        </a>
                                    {elseif $HEADERNAME eq 'subject'}
                                        <a href="javascript:;" onclick="window.open('index.php?module=Emails&view=ComposeEmail&mode=emailPreview&record={$RECIPIENT_RECORD->get('activityid')}&parentId={$RECIPIENT_RECORD->get('pid')}', 'EmailPreview', 'width=1230,height=700,scrollbars=yes');">
                                           {$RECIPIENT_RECORD->get($HEADERNAME)}
                                        </a>
                                    {else if $HEADERNAME eq 'email_address'}    
                                        {$RECIPIENT_RECORD->get($HEADERNAME)}
                                    {else if $HEADERNAME eq 'status'}    
                                        {if $RECIPIENT_RECORD->get('error') neq ""}
                                            {$RECIPIENT_RECORD->get('error')}
                                        {else}
                                            {$RECIPIENT_RECORD->get('status')}
                                        {/if}
                                    {else}
                                        {$RECIPIENT_RECORD->getDisplayValue($HEADERNAME)}
                                    {/if}
                                   
                                </td>
                            {/foreach}
                        </tr>
                    {/foreach}
                </table>
            </div>
        </div>
                
    </div>
{/strip}
