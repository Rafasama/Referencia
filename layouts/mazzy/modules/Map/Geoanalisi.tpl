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
<style>
#map-canvas {
	height: 450px; 
	max-width: 100%; 
	margin: 0; 
	padding: 0;
	border: 1px solid #DDD;
}
#map-canvas img {
	max-width: none !important;
} 
.modal{
	width:'auto'  !important;
	max-height:90% !important;
	margin-top: -350px !important;
}
.custom-class {
	width:80%;
	left: 10%;
	margin-left:auto;
	margin-right:auto;         
}
.modal .modal-body {
    height: 90%;
}    
#modalMapContainer{
	z-index: 9999999;
}

</style>
<script type="text/javascript">
	var anyPresetFilter = "{$ANY_PRESET_FILTER}";
	var prefRows = "{$PREF_ROWS}";
	var rownum = 0;
	if(anyPresetFilter){
		rownum = {$PREF_ROWS|@count}-1;
	}
	var isPopupMap = true;
</script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&callback=initializeOnReadyMapCanvas"></script>
<script type="text/javascript" src="layouts/begbie/modules/Map/resources/Geoanalisi.js"></script>


<div class="modal fade custom-class" id="modalMapContainer" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <button type="button" class="close pull-right" data-dismiss="modal">&times;</button>
      <div class="modal-body">
			<div class="filterContainer">
				<div class="allConditionContainer conditionGroup contentsBackground well" width="100%">
					<div class="header">
					
						<table><tr>
							<td>
								<i id="collapseIcon" align="right"><img style="margin-right: 30%;" src="modules/Map/img/collapse_ico.png" /></i>
								<i id="expandIcon" align="right" style="display: none;"><img src="modules/Map/img/expand_ico.png" /></i>
							</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td><span><strong>{vtranslate('LBL_CUSTOMVIEWSCONTAINER_TITLE',"Map")}</strong></span></td>
						</tr></table>
					</div>
					<div id="customViewSelector" class="contents" height="100%" width="100%">
						<div id="customViewsContainer" class="conditionList">
							<div class="hide basic">
								<table>						
									<tr class="customViewRow">
										<td>
											<span class="span4">
												<select id="sourceModule" name="sourceModule" class="sourceModuleMap row-fluid">
													<option value="none" selected>{vtranslate('LBL_SELECT_MODULE',"Map")}</option>
													{foreach item="MODULE" from=$AVAILABLE_MODULES}
														<option id="{$MODULE}" value="{$MODULE}" >{vtranslate($MODULE,$MODULE)}</option>
													{/foreach}
												</select>
											</span>
										</td>
										<td>&nbsp;</td>
										<td>
											<span class="span3">
												<select id="picklistFields" name="picklistFields" class="picklistFieldsMap row-fluid">
													<option value="none">{vtranslate('LBL_SELECT_MODULE_FIRST',"Map")}</option>
												</select>
											</span>
										</td>
										<td>&nbsp;</td>
										<td>
											<span class="span4">
												<select id="markerStyle" name="markerStyle" class="markerStyleMap row-fluid">
													<option value="{vtranslate('LBL_DEFAULT','Map')}" selected>{vtranslate('LBL_DEFAULT',"Map")}</option>
													{foreach item="MARKERSYTLE" from=$AVAILABLE_MARKERSTYLES}
														<option value="{$MARKERSYTLE}">{vtranslate($MARKERSYTLE,"Map")}</option>
													{/foreach}
												</select>
											</span>
										</td>
										<td>&nbsp;</td>
										<td>
											<span class="span1" style="vertical-align: middle; horizontal-align:middle;">
												&nbsp;
												<i class="showCVMap alignMiddle" title="Mostra marcatori" style="vertical-align: middle; horizontal-align:middle;"><img src="modules/Map/img/showCVico.png" /></i>
												&nbsp;&nbsp;
												<i id="deleteRow" class="deleteCondition icon-trash alignMiddle" title="{vtranslate('LBL_DELETE', $MODULE)}" style="vertical-align: middle; horizontal-align:middle;"></i>
											</span>
										</td>
									</tr>
								</table>
							</div>
							<form id="mapPreferences">
							<table id="customViewsTable" border="0">
								{if $ANY_PRESET_FILTER}
									{foreach key=PREFINDEX item=PREFROW from=$PREF_ROWS}
										<tr class="customViewRow">
										<td>
											<span class="span4">
												<select id="{"sourceModule"|cat:$PREFINDEX}" name="{"sourceModule"|cat:$PREFINDEX}" class="sourceModuleMap row-fluid">
													<option value="none">{vtranslate('LBL_SELECT_MODULE',"Map")}</option>
													{foreach item="MODULE" from=$AVAILABLE_MODULES}
														<option id="{$MODULE}" value="{$MODULE}" {if $MODULE == $PREFROW['module']}selected{/if} >{vtranslate($MODULE,$MODULE)}</option>
													{/foreach}
												</select>
											</span>
										</td>
										<td>&nbsp;</td>
										<td>
											<span class="span3">
												<select id="{"picklistFields"|cat:$PREFINDEX}" name="{"picklistFields"|cat:$PREFINDEX}" class="picklistFieldsMap row-fluid">
													{foreach key="CVID" item="CVNAME" from=$PREFROW['customviews']}
														<option value="{$CVID}" {if $CVID == $PREFROW['customview']}selected{/if} >{vtranslate($CVNAME,"Map")}</option>
													{/foreach}
												</select>
											</span>
										</td>
										<td>&nbsp;</td>
										<td>
											<span class="span4">
												<select id="{"markerStyle"|cat:$PREFINDEX}" name="{"markerStyle"|cat:$PREFINDEX}" class="markerStyleMap row-fluid">
													<option value="{vtranslate('LBL_DEFAULT','Map')}">{vtranslate('LBL_DEFAULT',"Map")}</option>
													{foreach item="MARKERSYTLE" from=$AVAILABLE_MARKERSTYLES}
														<option value="{$MARKERSYTLE}" {if $MARKERSYTLE == $PREFROW['marker']}selected{/if} >{vtranslate($MARKERSYTLE,"Map")}</option>
													{/foreach}
												</select>
											</span>
										</td>
										<td>&nbsp;</td>
										<td>
											<span class="span1" style="vertical-align: middle; horizontal-align:middle;">
												&nbsp;
												<i class="showCVMap alignMiddle" title="Mostra marcatori" style="vertical-align: middle; horizontal-align:middle;"><img src="modules/Map/img/showCVico.png" /></i>
												&nbsp;&nbsp;
												<i id="deleteRow0" class="deleteCondition icon-trash alignMiddle" title="{vtranslate('LBL_DELETE', $MODULE)}" style="vertical-align: middle; horizontal-align:middle;"></i>
											</span>
										</td>
									</tr>
									{/foreach}
								{else}
									<tr class="customViewRow">
										<td>
											<span class="span4">
												<select id="sourceModule0" name="sourceModule0" class="sourceModuleMap row-fluid">
													<option value="none" selected>{vtranslate('LBL_SELECT_MODULE',"Map")}</option>
													{foreach item="MODULE" from=$AVAILABLE_MODULES}
														<option id="{$MODULE}" value="{$MODULE}" >{vtranslate($MODULE,$MODULE)}</option>
													{/foreach}
												</select>
											</span>
										</td>
										<td>&nbsp;</td>
										<td>
											<span class="span3">
												<select id="picklistFields0" name="picklistFields0" class="picklistFieldsMap row-fluid">
													<option value="none">{vtranslate('LBL_SELECT_MODULE_FIRST',"Map")}</option>
												</select>
											</span>
										</td>
										<td>&nbsp;</td>
										<td>
											<span class="span4">
												<select id="markerStyle0" name="markerStyle0" class="markerStyleMap row-fluid">
													<option value="{vtranslate('LBL_DEFAULT','Map')}" selected>{vtranslate('LBL_DEFAULT',"Map")}</option>
													{foreach item="MARKERSYTLE" from=$AVAILABLE_MARKERSTYLES}
														<option value="{$MARKERSYTLE}">{vtranslate($MARKERSYTLE,"Map")}</option>
													{/foreach}
												</select>
											</span>
										</td>
										<td>&nbsp;</td>
										<td>
											<span class="span1" style="vertical-align: middle; horizontal-align:middle;">
												&nbsp;
												<i class="showCVMap alignMiddle" title="Mostra marcatori" style="vertical-align: middle; horizontal-align:middle;"><img src="modules/Map/img/showCVico.png" /></i>
												&nbsp;&nbsp;
												<i id="deleteRow0" class="deleteCondition icon-trash alignMiddle" title="{vtranslate('LBL_DELETE', $MODULE)}" style="vertical-align: middle; horizontal-align:middle;"></i>
											</span>
										</td>
									</tr>
								{/if}
							</table>
							<div>
								<table>
									<tr>
										<td><button type="submit" id="salvaPreferenze" class="btn"><strong>{vtranslate('LBL_SAVE_AS_DEFAULT',"Map")}</strong></button></td>
										<td>&nbsp;</td>
										<td><button type="button" id="aggiungiFiltro" class="btn"><strong>{vtranslate('LBL_ADD_FILTER',"Map")}</strong></button></td>
									</tr>
								</table>
							</div>
							</form>
						</div>
					</div>		
				</div>
			</div>      
      		<div id="map-canvas"></div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

{/strip}