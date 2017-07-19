{*
/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
*}
<div id="EMAILMakerContainer" class="modelContainer">
	<div class="modal-header">
		<button data-dismiss="modal" class="close" title="{vtranslate('LBL_CLOSE')}">x</button>
		<h3>{vtranslate('LBL_EMAIL_ACTIONS','EMAILMaker')}</h3>
	</div>
	<form class="form-horizontal contentsBackground" id="massSave" method="post" action="index.php">
		<input type="hidden" name="module" value="EMAILMaker" />
		<input type="hidden" name="relmodule" value="{$relmodule}" />
		<input type="hidden" name="action" value="CreateEMAILFromTemplate" />
		<input type="hidden" name="idslist" value="{$idslist}">
		<div class="modal-body tabbable">
                    {if $CRM_TEMPLATES_EXIST eq '0'}
                    <li>
                        <select name="use_common_email_template" id="use_common_email_template" class="detailedViewTextBox" style="width:130%;" size="5">
                            {foreach from=$CRM_TEMPLATES["1"] item="options" key="category_name"}
                                <optgroup label="{$category_name}">
                                    {foreach from=$options item="option"}
                                    <option value="{$option.value}" {if $option.title neq ""}title="{$option.title}"{/if} {if $option.value eq $DEFAULT_TEMPLATE}selected{/if}>{$option.label}</option>   
                                    {/foreach}
                                </optgroup>
                            {/foreach}
                            {foreach from=$CRM_TEMPLATES["0"] item="option"}
                                <option value="{$option.value}" {if $option.title neq ""}title="{$option.title}"{/if} {if $option.value eq $DEFAULT_TEMPLATE}selected{/if}>{$option.label}</option>    
                            {/foreach}
                        </select>        
                    </li>
                    {/if}
                    <br /><br />
                    {$languages_select}
		</div>
		<div class="modal-footer">
			<div class=" pull-right cancelLinkContainer">
				<a class="cancelLink" type="reset" data-dismiss="modal">{vtranslate('LBL_CLOSE')}</a>
			</div>
			<button class="btn btn-success" data-dismiss="modal" type="submit" name="saveButton" onclick="document.location.href='index.php?module=EMAILMaker&relmodule={$relmodule}&action=CreateEMAILFromTemplate&idslist={$idslist}&commontemplateid='+EMAILMaker_Actions_Js.getSelectedTemplates()+'&language='+document.getElementById('template_language').value;return false;"><strong>{vtranslate('LBL_EXPORT_TO_PDF','EMAILMaker')}</strong></button>
		</div>
	</form>
</div>