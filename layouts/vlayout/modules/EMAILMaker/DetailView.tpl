{*<!--
/*********************************************************************************
* The content of this file is subject to the EMAIL Maker license.
* ("License"); You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
* Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
* All Rights Reserved.
********************************************************************************/
-->*}
<div style="position: relative;">
        <table class="table table-bordered equalSplit detailview-table">
            <thead>
                <tr>
                    <th class="blockHeader" colspan=" {if $IS_MASSEMAIL eq "yes"}4{else}2{/if}">{vtranslate('LBL_PROPERTIES','EMAILMaker')}</th>
                </tr>
            </thead>
            <tbody>
                {if $IS_MASSEMAIL neq "yes"}
                    <tr>
                        <td class="fieldLabel narrowWidthType" style="width:25%;"><label class="muted pull-right marginRight10px">{vtranslate('LBL_EMAIL_NAME','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType" style="width:75%;">{$TEMPLATENAME}</td>
                    </tr>
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_DESCRIPTION','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType" valign=top>{$DESCRIPTION}</td>
                    </tr>
                    {if $MODULENAME neq ""}
                        <tr>
                            <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_MODULENAMES','EMAILMaker')}</label></td>
                            <td class="fieldValue narrowWidthType" valign=top>{$MODULENAME}</td>
                        </tr>
                    {/if}
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('Status')}</label></td>
                        <td class="fieldValue narrowWidthType" valign=top>{$IS_ACTIVE}</td>
                    </tr>
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_SETASDEFAULT','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType" valign=top>{$IS_DEFAULT}</td>
                    </tr>
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_EMAIL_SUBJECT','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType" valign=top>{$SUBJECT}</td>
                    </tr>
                {/if} 
                
                {if $IS_MASSEMAIL eq "yes"}
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_EMAIL_SUBJECT','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->get("me_subject")}</td>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_LIST_NAME','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->getFilterLink()}</td>                    
                    </tr>
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_FROM_NAME','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->get("from_name")}</td>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_COLUMN','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->get("email_fieldname_label")}</td>
                    </tr>
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_FROM_EMAIL','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->get("from_email")}</td>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('Status','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{vtranslate($MASSEMAILRECORDMODEL->get("status"),'EMAILMaker')}</td>
                    </tr>
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_EMAIL_LANGUAGE','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->get("language_label")}</td>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_START_OF','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->get("start_of")}</td>
                    </tr>
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_EMAIL_NAME','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->getTemplateName()}</td>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_LIMIT','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->get("max_limit")}</td>
                    </tr>
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_DESCRIPTION','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType" colspan="3">{$MASSEMAILRECORDMODEL->get("description")}</td>
                    </tr>
                {/if}    
            </tbody>
        </table>
        {if $IS_MASSEMAIL eq "yes"}
            {if $CHARTDATA1 neq ""}
                <br><br>
                <div id="EmailCampaignCharts" class="row-fluid">
                    <input class="chartData1" type=hidden value='{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($CHARTDATA1))}' />
                    <input class="chartData2" type=hidden value='{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($CHARTDATA2))}' />
                    <div class="row-fluid">
                        <div class="span6">
                            <div class="row-fluid">
                                <table class="table table-bordered equalSplit detailview-table">
                                    <thead>
                                        <tr>
                                            <th class="blockHeader" colspan="2">{vtranslate("LBL_GRAPH1_TITLE","EMAILMaker")} {$TOTAL_ENTRIES}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {foreach item=chdata from=$CHARTDATA1}
                                            <tr>
                                                <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate($chdata.label,'EMAILMaker')}</label></td>
                                                <td class="fieldValue narrowWidthType">{$chdata.value}</td>                    
                                            </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="span6">
                            <div class="row-fluid">
                                {if $CHARTDATA2 neq ""}
                                    <table class="table table-bordered equalSplit detailview-table">
                                        <thead>
                                            <tr>
                                                <th class="blockHeader" colspan="2">{vtranslate("LBL_OPEN_EMAILS_TITLE","EMAILMaker")}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {foreach item=chdata from=$CHARTDATA2}
                                                <tr>
                                                    <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate($chdata.label,'EMAILMaker')}</label></td>
                                                    <td class="fieldValue narrowWidthType">{$chdata.value}</td>                    
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                {/if}    
                            </div>
                        </div> 
                    </div>
                </div>
            {/if}   
        {else}    
            <table class="table table-bordered equalSplit detailview-table">
                <thead>
                    <tr>
                        <th class="blockHeader">{vtranslate('LBL_EMAIL_TEMPLATE','EMAILMaker')}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><div id="previewcontent" class="hide">{$BODY}</div>           
                        <iframe id="preview" class="row-fluid" style="height:1200px;"></iframe>
                        <script type="text/javascript">
                        //var previewcontent =  document.getElementById('previewcontent').innerHTML;
                        var previewcontent =  jQuery('#previewcontent').html();
                        var previewFrame = document.getElementById('preview');
                        var preview =  previewFrame.contentDocument ||  previewFrame.contentWindow.document;
                        preview.open();
                        preview.write(previewcontent);
                        preview.close(); 
                        jQuery('#previewcontent').html('');
                        </script>
                        </td>
                    </tr>
                </tbody>
            </table>
        {/if}
        
</div>