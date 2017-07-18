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
{assign var=CURRENT_USER_MODEL value=Users_Record_Model::getCurrentUserModel()}
{assign var=LEFTPANELHIDE value=$CURRENT_USER_MODEL->get('leftpanelhide')}

<div class="navbar navbar-fixed-top mazzy-nav navbar-inverse noprint" style="{if $LEFTPANELHIDE eq '1'} margin-right:200px;{/if}" >
{include file='MenuBar.tpl'|@vtemplate_path}
</div>
{/strip}