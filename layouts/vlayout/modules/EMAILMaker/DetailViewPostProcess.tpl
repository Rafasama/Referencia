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
</div></form></div>
{literal}
    <script type="text/javascript">
        function deleteRecord(deleteRecordActionUrl){
            var message = app.vtranslate('LBL_DELETE_CONFIRMATION');
            Vtiger_Helper_Js.showConfirmationBox({'message': message}).then(function(data){
                AppConnector.request(deleteRecordActionUrl + '&ajaxDelete=true').then(
                        function(data){
                            if (data.success == true){
                                window.location.href = 'index.php?module=EMAILMaker&view=List';
                            } else {
                                Vtiger_Helper_Js.showPnotify(data.error.message);
                            }
                        });
            },
                    function(error, err){
                    }
            );
        }
    </script>
{/literal}
    <div class="related span2 marginLeftZero">
		<div class="">
			<ul class="nav nav-stacked nav-pills">
				{foreach item=RELATED_LINK from=$DETAILVIEW_LINKS['DETAILVIEWTAB']}
				<li class="{if $RELATED_LINK->getLabel()==$SELECTED_TAB_LABEL}active{/if}" data-url="{$RELATED_LINK->getUrl()}&tab_label={$RELATED_LINK->getLabel()}" data-label-key="{$RELATED_LINK->getLabel()}" data-link-key="{$RELATED_LINK->get('linkKey')}" >
					<a href="javascript:void(0);" class="textOverflowEllipsis" style="width:auto" title="{vtranslate($RELATED_LINK->getLabel(),{$MODULE_NAME})}"><strong>{vtranslate($RELATED_LINK->getLabel(),{$MODULE_NAME})}</strong></a>
				</li>
				{/foreach}
				{foreach item=RELATED_LINK from=$DETAILVIEW_LINKS['DETAILVIEWRELATED']}
				<li class="{if $RELATED_LINK->getLabel()==$SELECTED_TAB_LABEL}active{/if}" data-url="{$RELATED_LINK->getUrl()}&tab_label={$RELATED_LINK->getLabel()}" data-label-key="{$RELATED_LINK->getLabel()}" >
					{* Assuming most of the related link label would be module name - we perform dual translation *}
					{assign var="DETAILVIEWRELATEDLINKLBL" value= vtranslate($RELATED_LINK->getLabel(), $RELATED_LINK->getLabel())}
					<a href="javascript:void(0);" class="textOverflowEllipsis" style="width:auto" title="{vtranslate($RELATED_LINK->getLabel(),{$MODULE_NAME})}"><strong>{$DETAILVIEWRELATEDLINKLBL}</strong></a>
				</li>
				{/foreach}
			</ul>
		</div>
	</div>
</div>
</div>
<center style="color: rgb(153, 153, 153);">{vtranslate('EMAIL_MAKER','EMAILMaker')} {$VERSION} {vtranslate('COPYRIGHT','EMAILMaker')}</center>
{/strip}