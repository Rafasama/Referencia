{*<!--
/*********************************************************************************
* The content of this file is subject to the EMAIL Maker license.
* ("License"); You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
* Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
* All Rights Reserved.
********************************************************************************/
-->*}
{include file='JSResources.tpl'|@vtemplate_path}
<div class='editViewContainer'>
    <form class="form-horizontal recordEditView" id="EditView" name="EditView" method="post" action="index.php" enctype="multipart/form-data">
    <input type="hidden" name="module" value="EMAILMaker">
    <input type="hidden" name="parenttab" value="{$PARENTTAB}">
    <input type="hidden" name="templateid" value="{$SAVETEMPLATEID}">
    <input type="hidden" name="action" value="SaveEMAILTemplate">
    <input type="hidden" name="redirect" value="true">
    <br>
    <label class="pull-left themeTextColor font-x-x-large">{vtranslate('LBL_THEME_LIST','EMAILMaker')}</label>
    <br clear="all">
    <hr>
    <div class="row-fluid">
        <label class="fieldLabel"><strong>{vtranslate('LBL_THEME_GENERATOR_DESCRIPTION','EMAILMaker')}</strong></label><br>
    </div>
<br>
<table border=0 cellspacing=0 cellpadding=10 width=100% >
    <tr>
        <td>
            <table border=0 cellspacing=0 cellpadding=5 width=100% class="tableHeading">
            <tr>
                <td class="big"><strong>{vtranslate('LBL_SELECT_THEME','EMAILMaker')}</strong></td>
                <td class="small" align=right>&nbsp;</td>
            </tr>
            </table>

            <div style="float:left;margin:5px;">
                <div style="float:left;border:1px solid #000000;width:140px;height:185px;">
                    <div class="tableHeading" style="border-bottom:1px solid #000000;padding:5px;text-align:center;font-weight:bold">
                    <a href="index.php?module=EMAILMaker&view=Edit&return_module=EMAILMaker&return_view=Select">Blank</a>
                    </div>
                    <a href="index.php?module=EMAILMaker&view=Edit&return_module=EMAILMaker&return_view=Select"><img src="modules/EMAILMaker/templates/blank.png" border="0"></a>
            	</div>
            </div>
            {foreach item=templatename key=templatenameid from=$EMAILTEMPLATES}
                <div style="float:left;margin:5px;">
                    <div style="float:left;border:1px solid #000000;width:140px;height:185px;">
                	<div class="tableHeading" style="border-bottom:1px solid #000000;padding:5px;text-align:center;font-weight:bold" border="1">
                    <a href="index.php?module=EMAILMaker&view=Edit&theme={$templatename}&return_module=EMAILMaker&return_view=Select">{$templatename}</a>
                    </div>
                    <a href="index.php?module=EMAILMaker&view=Edit&theme={$templatename}&return_module=EMAILMaker&return_view=Select"><img src="modules/EMAILMaker/templates/{$templatename}/image.png" border="0"></a>
                	</div>
                </div>
            {/foreach}             
            {foreach item=theme name=themes from=$EMAILTHEMES}
                <div style="float:left;margin:5px;" >
                    <div style="float:left;border:1px solid #000000;width:140px;height:185px;" class="">
                    	<div style="height:1{if $theme.edit neq ""}6{else}8{/if}0px;overflow:auto;">
                            <div class="tableHeading cursorPointer" style="border-bottom:1px solid #000000;" border="1">
                                <div style="padding:5px;text-align:center;font-weight:bold;">
                                <a href="index.php?module=EMAILMaker&view=Edit&themeid={$theme.themeid}&return_module=EMAILMaker&return_view=Select" title="{$theme.themename}">{$theme.themename}</a>
                                </div>
                            </div>
                            <div style="padding:2px">{$theme.description}</div>
                        </div>
                        {if $theme.edit neq ""}
                        <center>
                        <div class="actions">
                            <span class="textAlignCenter">{$theme.edit}</span>
                        </div>
                        </center>
                        {/if}   
                	</div>
                </div>
            {/foreach}
            <div style="float:left;margin:5px;" onClick="window.location.href = 'index.php?module=EMAILMaker&view=Edit&theme=new&mode=EditTheme&return_module=EMAILMaker&return_view=Select';">
                <div style="float:left;border:1px solid #000000;width:140px;height:185px;" class="contentsBackground cursorPointer">
                <div class="addButton" style="border-bottom:1px solid #000000;padding:5px;text-align:center;font-weight:bold">
                <i class="icon-plus icon-white"></i>{vtranslate('LBL_ADD_THEME','EMAILMaker')}
                </div>
                <div class="padding5per">{vtranslate('LBL_ADD_THEME_INFO','EMAILMaker')}</div>
                </div>
            </div>  
        </td>
    </tr>
</table>
<div align="center" class="small" style="color: rgb(153, 153, 153);">{vtranslate('EMAIL_MAKER','EMAILMaker')} {$VERSION} {vtranslate('COPYRIGHT','EMAILMaker')}</div>
</form>
</div>