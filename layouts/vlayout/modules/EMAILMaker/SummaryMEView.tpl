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
                    <th class="blockHeader" colspan="4">{vtranslate('LBL_PROPERTIES','EMAILMaker')}</th>
                </tr>
            </thead>
            <tbody>
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_EMAIL_SUBJECT','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->get("me_subject")}</td>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_LIST_NAME','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->getFilterLink()}</td>                    
                    </tr>
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_FROM_NAME','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->get("from_name")}</td>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_NUMBER_OF_RECIPIENTS','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$RECIPIENTS_COUNT}</td>
                    </tr>
                    <tr>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_FROM_EMAIL','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->get("from_email")}</td>
                        <td class="fieldLabel narrowWidthType"><label class="muted pull-right marginRight10px">{vtranslate('LBL_COLUMN','EMAILMaker')}</label></td>
                        <td class="fieldValue narrowWidthType">{$MASSEMAILRECORDMODEL->get("email_fieldname_label")}</td>
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

            </tbody>
        </table>
</div>