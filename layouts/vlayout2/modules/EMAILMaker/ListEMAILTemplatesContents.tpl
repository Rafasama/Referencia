{*<!--
/*********************************************************************************
* The content of this file is subject to the EMAIL Maker license.
* ("License"); You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
* Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
* All Rights Reserved.
********************************************************************************/
-->*}
{if $DIR eq 'asc'}
    {assign var="dir_img" value='<img src="layouts/vlayout/skins/images/upArrowSmall.png" border="0" />'}
{else}
    {assign var="dir_img" value='<img src="layouts/vlayout/skins/images/downArrowSmall.png" border="0" />'}
{/if}

{assign var="name_dir" value="asc"}
{assign var="module_dir" value="asc"}
{assign var="description_dir" value="asc"}
{assign var="order_dir" value="asc"}

{if $ORDERBY eq 'templatename' && $DIR eq 'asc'}
    {assign var="name_dir" value="desc"}
{elseif $ORDERBY eq 'module' && $DIR eq 'asc'}
    {assign var="module_dir" value="desc"}
{elseif $ORDERBY eq 'description' && $DIR eq 'asc'}
    {assign var="description_dir" value="desc"}
{elseif $ORDERBY eq 'order' && $DIR eq 'asc'}
    {assign var="order_dir" value="desc"}
{elseif $ORDERBY eq 'sharingtype' && $DIR eq 'asc'}
    {assign var="sharingtype_dir" value="desc"}  
{elseif $ORDERBY eq 'category' && $DIR eq 'asc'}
    {assign var="category_dir" value="desc"}  
{/if}

<div class="listViewEntriesDiv">
        <table border=0 cellspacing=0 cellpadding=5 width=100% class="table table-bordered listViewEntriesTable">
            <thead>
                <tr class="listViewHeaders">
                    <th width="2%" class="narrowWidthType">#</th>
                    <th width="3%" class="narrowWidthType">{vtranslate("LBL_LIST_SELECT","EMAILMaker")}</th>
                    <th width="20%" class="narrowWidthType"><a href="index.php?module=EMAILMaker&view=List&orderby=name&dir={$name_dir}">{vtranslate("LBL_EMAIL_NAME","EMAILMaker")}{if $ORDERBY eq 'templatename'}{$dir_img}{/if}</a></th>
                    {*<th width="14%" class="narrowWidthType">{vtranslate("LBL_EMAIL_SUBJECT","EMAILMaker")}</th>*}
                    <th width="10%" class="narrowWidthType"><a href="index.php?module=EMAILMaker&view=List&orderby=module&dir={$module_dir}">{vtranslate("LBL_MODULENAMES","EMAILMaker")}{if $ORDERBY eq 'module'}{$dir_img}{/if}</a></th>
                    <th width="10%" class="narrowWidthType"><a href="index.php?module=EMAILMaker&view=List&orderby=category&dir={$category_dir}">{vtranslate("Category","EMAILMaker")}{if $ORDERBY eq 'category'}{$dir_img}{/if}</a></th>
                    <th width="20%" class="narrowWidthType"><a href="index.php?module=EMAILMaker&view=List&orderby=description&dir={$description_dir}">{vtranslate("LBL_DESCRIPTION","EMAILMaker")}{if $ORDERBY eq 'description'}{$dir_img}{/if}</a></th>
                    {*<th width="6%" class="narrowWidthType" nowrap><a href="index.php?module=EMAILMaker&view=List&orderby=order&dir={$order_dir}">{vtranslate("LBL_ORDER","EMAILMaker")}{if $ORDERBY eq 'order'}{$dir_img}{/if}</a>&nbsp;&nbsp;<a href="#" onclick="return SaveTemplatesOrder();"><img src="layouts/vlayout/skins/images/SaveAs.png" width="15" border="0" alt="Save" title="{vtranslate("LBL_SAVE_ORDER","EMAILMaker")}" /></a></td>*}
                    <th width="5%" class="narrowWidthType"><a href="index.php?module=EMAILMaker&view=List&orderby=sharingtype&dir={$sharingtype_dir}">{vtranslate("LBL_SHARING_TAB","EMAILMaker")}{if $ORDERBY eq 'sharingtype'}{$dir_img}{/if}</a></th>
                    <th width="5%" class="narrowWidthType" nowrap>{vtranslate("LBL_TEMPLATE_OWNER","EMAILMaker")}</th>
                    <th width="5%" class="narrowWidthType">{vtranslate("LBL_WORKFLOW","EMAILMaker")}</th>
                    {if $VERSION_TYPE neq 'deactivate'}<th width="5%" class="narrowWidthType">{vtranslate("Status")}</th>
                    <th width="11%" class="narrowWidthType">{vtranslate("LBL_ACTION","EMAILMaker")}</th>{/if}
                </tr>
            </thead>
            <tr>
                <td></td>
                <td></td>
                <td><input type="text" class="listSearchContributor" name="search_templatename" value="{$SEARCHTEMPLATENAMEVAL}"></td>
                <td>
                    <select class="chzn-select span2 listSearchContributor" name="search_module">
                        <option value=""></option>
                        {html_options  options=$SEARCHSELECTBOXDATA.modules selected=$SEARCHMODULEVAL}
                    </select>
                </td>
                <td><input type="text" class="listSearchContributor span2" name="search_category" value="{$SEARCHCATEGORYVAL}"></td>
                <td><input type="text" class="listSearchContributor" name="search_description" value="{$SEARCHDESCRIPTIONVAL}"></td>
                <td>
                    <select class="chzn-select span1 listSearchContributor" name="search_sharingtype">
                        {html_options  options=$SHARINGTYPES selected=$SEARCHSHARINGTYPEVAL}
                    </select>
                </td>
                <td>
                    <select class="chzn-select listSearchContributor" name="search_owner">
                        <option value=""></option>
                        {html_options  options=$SEARCHSELECTBOXDATA.owners selected=$SEARCHOWNERVAL}
                    </select>
                </td>
                <td>
                    <select class="chzn-select span1 listSearchContributor" name="search_workflow">
                        <option value=""></option>
                        {html_options  options=$WFOPTIONS selected=$SEARCHWORKFLOWVAL}
                    </select>
                </td>
                <td>
                    <select class="chzn-select span1 listSearchContributor" name="search_status">
                        <option value=""></option>
                        {html_options  options=$STATUSOPTIONS selected=$SEARCHSTATUSVAL}
                    </select>
                </td>
                <td>
                    <button class="btn" data-trigger="listSearch">{vtranslate('LBL_SEARCH',"EMAILMaker")}</button>
                </td>
            </tr>
            <tbody>
            {foreach item=template name=mailmerge from=$EMAILTEMPLATES}
                <tr class="listViewEntries" {if $template.status eq 0} style="font-style:italic;" {/if} data-id="{$template.templateid}" data-recordurl="index.php?module=EMAILMaker&view=Detail&record={$template.templateid}" id="EMAILMaker_listView_row_{$template.templateid}">
                    <td class="narrowWidthType" valign=top>{$smarty.foreach.mailmerge.iteration}</td>
                    <td class="narrowWidthType" valign=top><input type="checkbox" class=small name="selected_id" value="{$template.templateid}"></td>
                    <td class="narrowWidthType" valign=top>{$template.templatename}</td>
                    
                    {*<td class="narrowWidthType" valign=top {if $template.status eq 0} style="color:#888;" {/if}>{$template.subject}</td>*}
                    <td class="narrowWidthType" valign=top {if $template.status eq 0} style="color:#888;" {/if}>{$template.module}</a></td>
                    <td class="narrowWidthType" valign=top {if $template.status eq 0} style="color:#888;" {/if}>{$template.category}</a></td>
                    <td class="narrowWidthType" valign=top {if $template.status eq 0} style="color:#888;" {/if}>{$template.description}&nbsp;</td>
                    <td class="narrowWidthType" valign=top {if $template.status eq 0} style="color:#888;" {/if}>{$template.sharingtype}&nbsp;</td>
                    <td class="narrowWidthType" valign=top {if $template.status eq 0} style="color:#888;" {/if} nowrap>{$template.owner}&nbsp;</td>                    
                    {*<td class="narrowWidthType" valign=top align=center><input {if $template.status eq 0}disabled="disabled"{/if} type="text" class="txtBox" style="width:30px;z-index:10;" maxlength="4" name="tmpl_order_{$template.templateid}" value="{$template.order}"/></td>*}
                    <td class="narrowWidthType" valign=top {if $template.status eq 0} style="color:#888;" {/if}>{if in_array($template.templateid, $WTEMPLATESIDS)}{vtranslate("LBL_YES")}{else}{vtranslate("LBL_NO")}{/if}</td>
                    {if $VERSION_TYPE neq 'deactivate'}<td class="narrowWidthType" valign=top {if $template.status eq 0} style="color:#888;" {/if}>{$template.status_lbl}&nbsp;</td>
                    <td class="narrowWidthType" valign=top nowrap>{$template.edit}</td>{/if}
                </tr>
            {foreachelse}   
            </tbody>
        </table>    
        <table class="emptyRecordsDiv">
         <tbody>
            <tr>
            <td>
                {vtranslate("LBL_NO")} {vtranslate("LBL_TEMPLATE","EMAILMaker")} {vtranslate("LBL_FOUND","EMAILMaker")}
                &nbsp;&nbsp;-<a href="index.php?module=EMAILMaker&view=Select">{vtranslate("LBL_CREATE_NEW")} {vtranslate("LBL_TEMPLATE","EMAILMaker")}</a><br>
            </td>
        </tr>  
            {/foreach}
            </tbody>
        </table>
</div> {*listViewEntriesDiv contents-bottomscroll*}
<br>
<div align="center" class="small" style="color: rgb(153, 153, 153);">{vtranslate("EMAIL_MAKER","EMAILMaker")} {$VERSION} {vtranslate("COPYRIGHT","EMAILMaker")}</div>