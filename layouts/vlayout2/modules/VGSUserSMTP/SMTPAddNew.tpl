{*
/**
 * VGS Users SMTP Module
 *
 *
 * @package        VGSUserSMTP Module
 * @author         Conrado Maggi - www.vgsglobal.com
 * @license        vTiger Public License.
 * @version        Release: 1.0
 */
*}
<div style="width: 65%;margin: auto;margin-top: 2em;padding: 2em;">
    <input type="hidden" id="parent_view" value="{$PARENT_MODULE}">
    <h3 style="padding-bottom: 1em;text-align: center">{vtranslate('VGS One STMP per User', $MODULE)}</h3>
    
    <div>
        <table class="table table-bordered table-condensed themeTableColor" style="margin-top: 1em;">
            <tbody>
                {if $PARENT_MODULE eq 'Settings'}
                 <tr>
                    <td width="50%" colspan="2"><label class="muted pull-right marginRight10px">{vtranslate('User Name', $MODULE)}</label></td>
                    <td colspan="2" style="border-left: none;">
                        <select name='user_id' class="chzn-select">
                                <option value=""></option>
                            {foreach $USER_LIST item=USER_NAME key=USER_ID}
                                <option value="{$USER_ID}">{$USER_NAME}</option>
                            {/foreach}    
                        </select>
                    </td>
                </tr>
                {else}
                    <input type="hidden" name='user_id' value="{$CURRENT_USER_ID}">

                {/if}
                <tr>
                    <td width="50%" colspan="2"><label class="muted pull-right marginRight10px">{vtranslate('SMTP Server', $MODULE)}</label></td>
                    <td colspan="2" style="border-left: none;">
                        <input type="text" name="server_name" id="server_name" value="" style="width:90%;">
                    </td>
                </tr>
                <tr>
                    <td width="50%" colspan="2"><label class="muted pull-right marginRight10px">{vtranslate('SMTP User', $MODULE)}</label></td>
                    <td colspan="2" style="border-left: none;">
                        <input type="text" name="user_name" id="user_name" value="" style="width:90%;">
                    </td>
                </tr>
                   <tr>
                    <td width="50%" colspan="2"><label class="muted pull-right marginRight10px">{vtranslate('Password', $MODULE)}</label></td>
                    <td colspan="2" style="border-left: none;">
                        <input type="password" name="password" id="password" value="" style="width:90%;">
                    </td>
                </tr>
                <tr>
                    <td width="50%" colspan="2"><label class="muted pull-right marginRight10px">{vtranslate('From Name', $MODULE)}</label></td>
                    <td colspan="2" style="border-left: none;">
                        <input type="text" name="email_from" id="email_from" value="" style="width:90%;">
                    </td>
                </tr>
                <tr>
                    <td width="50%" colspan="2"><label class="muted pull-right marginRight10px">{vtranslate('From Address', $MODULE)}</label></td>
                    <td colspan="2" style="border-left: none;">
                        <input type="text" name="from_name" id="from_name" value="" style="width:90%;">
                    </td>
                </tr>
                <tr>
                    <td width="50%" colspan="2"><label class="muted pull-right marginRight10px">{vtranslate('Auth', $MODULE)}</label></td>
                    <td colspan="2" style="border-left: none;">
                        <input type="checkbox" name="smtp_auth" id="smtp_auth" value="" style="width:90%;">
                    </td>
                </tr> 
            </tbody>
        </table>
       
        <br><br>
        <button class="btn pull-right" style="margin-bottom: 0.5em;" id="add_entry">{vtranslate('Save', $MODULE)}</button>
        <a class="pull-right" style="margin-right: 2%;" href="javascript:history.go(-1)">{vtranslate('Cancel', $MODULE)}</a>
     
    </div>
</div>
