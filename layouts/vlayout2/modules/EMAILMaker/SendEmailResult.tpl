{*<!--
/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
-->*}
{if $SUCCESS}
<div class="contentsBackground" style='height:800px'>
    <span class="modal noprint" id="loadingListViewModal">
        <div id="popupinfo1" class="modal-header textAlignCenter">
                <h3>{vtranslate('LBL_PLEASE_DONT_CLOSE_WINDOW','EMAILMaker')}</h3>
        </div>
        <div class="modal-body">
            <div id="popupinfo2" class="fieldInfo textAlignCenter"><i class="icon-info-sign alignMiddle"></i> {vtranslate('LBL_POPUP_WILL_BE_CLOSED_AUT','EMAILMaker')}</div>
            <img id="popupinfo3" class="listViewLoadingImage paddingTop20" src="{vimage_path('loading.gif')}" alt="no-image" title="{vtranslate('LBL_LOADING', $MODULE)}"/>
            <div class="padding5per">
                <div class="summaryWidgetContainer paddingTop20 ">
                    <div class="widgetContainer_1">
                        <div class="widget_header row-fluid">
                            <div class="marginBottom10px"><h4 id="popup_notifi_title">{$MESSAGE.title}</h4>
                            </div>
                         </div>
                         <div class="widget_contents" id="popup_notifi_content">{$MESSAGE.content}</div>
                    </div> 
                </div> 
            </div>
        </div>
    </span>
</div>     
<script language="Javascript" type="text/javascript">                    
jQuery(document).ready(function() {	
    var EMAILMakerSendEmailJsInstance = new EMAILMaker_SendEmail_Js();
    EMAILMakerSendEmailJsInstance.runProcess('{$MESSAGE.id}');
});                    
</script>                    
{else}
<table border='0' cellpadding='5' cellspacing='0' width='100%' height='600px'>
	<tr>
		<td align='center'>
			<div style='border: 3px solid rgb(153, 153, 153); background-color: rgb(255, 255, 255); width: 75%; position: relative; z-index: 100000020;'>
				<table border='0' cellpadding='5' cellspacing='0' width='98%'>
					<tr>
						<td rowspan='2' width='11%'><img src="{vimage_path('denied.gif')}" ></td>
						<td style='border-bottom: 1px solid rgb(204, 204, 204);' nowrap='nowrap' width='70%'>
							<span class='genHeaderSmall'>{vtranslate($MESSAGE)}</span></td>
					</tr>
					<tr>
						<td class='small' align='right' nowrap='nowrap'>
							<a href='javascript:window.history.back();'>{vtranslate('LBL_GO_BACK')}</a><br>
						</td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
</table>
{/if}
{include file='JSResources.tpl'|@vtemplate_path}