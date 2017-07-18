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
<div class="recordNamesList">
	<div class="row-fluid">
		<div class="">
			<table class="recordlist">
				{foreach item=recordsModel from=$RECORDS}
				<tr><td style="padding:4px!important">
					<i class="mazzy-ico fa fa-circle"></i><a data-id={$recordsModel->getId()} href="{$recordsModel->getDetailViewUrl()}" title="{decode_html($recordsModel->getName())}">{decode_html($recordsModel->getName())}</a>
				</td></tr>
				{foreachelse}
					<tr><td style="text-align:center">{vtranslate('LBL_NO_RECORDS', $MODULE)}
					</td></tr>
				{/foreach}

			</table>
		</div>
	</div>
</div>
{/strip}