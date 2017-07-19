{*
/*********************************************************************************
 * The content of this file is subject to the ListView Colors 4 You license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
*}
{strip}
    <div class="editContainer" style="padding-left: 3%;padding-right: 3%">
        <h3>
            {if $RECORDID eq ''}
                {vtranslate('LBL_NEW_EMAIL_CAMPAIGN',$QUALIFIED_MODULE)}
            {else}
                {vtranslate('LBL_EDITING_EMAIL_CAMPAIGN',$QUALIFIED_MODULE)}
            {/if}
        </h3>
        <hr>
        <div id="breadcrumb">
            <ul class="crumbs marginLeftZero">
                <li class="first step"  style="z-index:9" id="step1">
                    <a>
                        <span class="stepNum">1</span>
                        <span class="stepText">{vtranslate('LBL_CAMPAIGN_DETAILS',$QUALIFIED_MODULE)}</span>
                    </a>
                </li>
                <li style="z-index:8" class="step" id="step2">
                    <a>
                        <span class="stepNum">2</span>
                        <span class="stepText">{vtranslate('LBL_RECIPIENTS_LIST',$QUALIFIED_MODULE)}</span>
                    </a>
                </li>
                <li class="step" style="z-index:7" id="step3">
                    <a>
                        <span class="stepNum">3</span>
                        <span class="stepText">{vtranslate('LBL_EMAIL_TEMPLATE',$QUALIFIED_MODULE)}</span>
                    </a>
                </li>
                <li class="step" style="z-index:6" id="step4">
                    <a>
                        <span class="stepNum">4</span>
                        <span class="stepText">{vtranslate('LBL_ADD_PARAMETERS',$QUALIFIED_MODULE)}</span>
                    </a>
                </li>
                <li class="step last" style="z-index:5" id="step5">
                    <a>
                        <span class="stepNum">5</span>
                        <span class="stepText">{vtranslate('LBL_SUMMARY',$QUALIFIED_MODULE)}</span>
                    </a>
                </li>
            </ul>
        </div>
        <div class="clearfix"></div>
    </div>
{/strip}
