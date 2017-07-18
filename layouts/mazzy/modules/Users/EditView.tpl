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
<div class="container-fluid editViewContainer">
	<form class="form-horizontal recordEditView detailViewInfo equalSplit" id="EditView" name="EditView" method="post" enctype="multipart/form-data" action="index.php">
		<input type="hidden" name="module" value="{$MODULE}" />
		<input type="hidden" name="action" value="Save" />
		<input type="hidden" name="record" value="{$RECORD_ID}" />
		<input type="hidden" name="isPreference" value="{$IS_PREFERENCE}" />
		<input type=hidden name="timeFormatOptions" data-value='{$DAY_STARTS}' />
		{if $IS_RELATION_OPERATION }
			<input type="hidden" name="sourceModule" value="{$SOURCE_MODULE}" />
			<input type="hidden" name="sourceRecord" value="{$SOURCE_RECORD}" />
			<input type="hidden" name="relationOperation" value="{$IS_RELATION_OPERATION}" />
		{/if}
		{assign var=WIDTHTYPE value=$USER_MODEL->get('rowheight')}
		<div class="contentHeader row-fluid">
		{assign var=SINGLE_MODULE_NAME value='Single_'|cat:$MODULE}
		{if $RECORD_ID neq ''}
			<h3 class="span8 textOverflowEllipsis marginLeftZero" title='{vtranslate('LBL_EDITING', $MODULE)} {vtranslate($SINGLE_MODULE_NAME, $MODULE)} "{$RECORD_STRUCTURE_MODEL->getRecordName()}"'>{vtranslate('LBL_EDITING', $MODULE)} {vtranslate($SINGLE_MODULE_NAME, $MODULE)} "{$RECORD_STRUCTURE_MODEL->getRecordName()}"</h3>
		{else}
			<h3 class="span8 textOverflowEllipsis marginLeftZero" title="{vtranslate('LBL_CREATING_NEW', $MODULE)} {vtranslate($SINGLE_MODULE_NAME, $MODULE)}">{vtranslate('LBL_CREATING_NEW', $MODULE)} {vtranslate($SINGLE_MODULE_NAME, $MODULE)}</h3>
		{/if}
				<span class="pull-right">
					<button class="btn btn-success" type="submit"><strong>{vtranslate('LBL_SAVE', $MODULE)}</strong></button>
					<a class="cancelLink btn btn-danger" type="reset" onclick="javascript:window.history.back();">{vtranslate('LBL_CANCEL', $MODULE)}</a>
				</span>
		</div>
		<div>
			{foreach key=BLOCK_LABEL item=BLOCK_FIELDS from=$RECORD_STRUCTURE}
				<div class="contents">
				{if $BLOCK_FIELDS|@count gt 0}
				<div class="row-fluid">
					<div class="span12 mycdivtitle">{vtranslate($BLOCK_LABEL, $MODULE)}</div>
				</div>
				<div class="row-fluid mycfluid">
				{assign var=COUNTER value=0}
				{foreach key=FIELD_NAME item=FIELD_MODEL from=$BLOCK_FIELDS name=blockfields}
					{assign var="isReferenceField" value=$FIELD_MODEL->getFieldDataType()}
					{assign var="refrenceList" value=$FIELD_MODEL->getReferenceList()}
					{assign var="refrenceListCount" value=count($refrenceList)}
					{if $COUNTER eq 2}
						</div><div class="row-fluid mycfluid">
						{assign var=COUNTER value=1}
					{else}
						{assign var=COUNTER value=$COUNTER+1}
					{/if}
					<div class="span2 mycdivlabel">
					{if {$isReferenceField} eq "reference"}
						{if $refrenceListCount > 1}
							<select style="width: 150px;" class="chzn-select" id="referenceModulesList">
								<optgroup>
									{foreach key=index item=value from=$refrenceList}
										<option value="{$value}">{$value}</option>
									{/foreach}
								</optgroup>
							</select>
						{/if}
						{vtranslate($FIELD_MODEL->get('label'), $MODULE)}
					{else}
						{vtranslate($FIELD_MODEL->get('label'), $MODULE)}
					{/if}
					{if $FIELD_MODEL->isMandatory() eq true} <span class="redColor">*</span> {/if}
					</div>
					<div class="span{if $FIELD_MODEL->get('uitype') eq '19'}10{else}4{/if} mycdivfield" {if $FIELD_MODEL->get('uitype') eq '19'} colspan="3" {assign var=COUNTER value=$COUNTER+1} {/if}>
						{include file=$FIELD_MODEL->getUITypeModel()->getTemplateName()|@vtemplate_path:$MODULE}
					</div>

				{/foreach}
				</div>
				{/if}
				</div>
                                <br>
			{/foreach}

			{* tag cloud starts *}
			<div class="contents">
				<div class="row-fluid">
					<div class="span12 mycdivtitle">{vtranslate('LBL_TAG_CLOUD_DISPLAY', $MODULE)}</div>
				</div>
				<div class="row-fluid mycfluid">
					<div class="span2 mycdivlabel">{vtranslate('LBL_TAG_CLOUD', $MODULE)}</div>
					<div class="span8 {$WIDTHTYPE}">
						<label><input type="checkbox" name="tagcloudview" {if $TAG_CLOUD} checked {/if} /></label>
					</div>
				</div>
			</div>
                        <br>
			{* tag cloud ends *}

			<div class='pull-right'>
				<button class="btn btn-success" type="submit"><strong>{vtranslate('LBL_SAVE', $MODULE)}</strong></button>
				<a class="cancelLink btn btn-danger" type="reset" onclick="javascript:window.history.back();">{vtranslate('LBL_CANCEL', $MODULE)}</a>
			</div>
			<br><br><br><br><br>
		</div>
    </form>
</div>
{/strip}