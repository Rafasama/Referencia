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
<span class="span1">
		{assign var=moduleName value=$MODULE_MODEL->getName()}
		{if vimage_path($moduleName|cat:'_big.png') != false}
									<img  class="mazzyiconimg alignMiddle" src="{vimage_path($moduleName|cat:'_big.png')}" alt="{vtranslate($moduleName, $moduleName)}" title="{vtranslate($moduleName, $moduleName)}"/>
								{elseif vimage_path($moduleName|cat:'.png') != false}
									<img  class="mazzyiconimg alignMiddle" src="{vimage_path($moduleName|cat:'.png')}" alt="{vtranslate($moduleName, $moduleName)}" title="{vtranslate($moduleName, $moduleName)}"/>
								
								{else}
									<img  class="mazzyiconimg alignMiddle" src="{vimage_path('DefaultModule.png')}" alt="{vtranslate($moduleName, $moduleName)}" title="{vtranslate($moduleName, $moduleName)}"/>
								{/if}
	</span>
	<span class="span9 margin0px">
		<span class="row-fluid">
			<span class="recordLabel font-x-x-large span" title="{$RECORD->getName()}">
				{foreach item=NAME_FIELD from=$MODULE_MODEL->getNameFields()}
					{assign var=FIELD_MODEL value=$MODULE_MODEL->getField($NAME_FIELD)}
						{if $FIELD_MODEL->getPermissions()}
							<h3 class="{$NAME_FIELD}">{$RECORD->get($NAME_FIELD)}</h3>&nbsp;
						{/if}
				{/foreach}
			</span>
		</span>
	</span>
{/strip}