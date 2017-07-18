{*
/*********************************************************************************
 * This file will list the records in widget as per module selection from CRM setting
 * All Rights Reserved.
 ********************************************************************************/
*}
<div  class="row-fluid">
	<div>
        <ul class="nav nav-list" >
			<li style="overflow-x:auto;overflow-y:auto;">
				<table class="table table-bordered equalSplit detailview-table">
					<thead>
						<tr>
							<th colspan="4" class="blockHeader">
								<b>{vtranslate('Incoming', 'Accounting')}</b>
								<a href="index.php?module=Accounting&view=Edit&paymenttype=Income{$relation_module}">
									<i class="btn btn-xs btn-yellow fa fa-plus" title="{vtranslate('Add Incoming', 'Accounting')}"></i>
								</a>
							</th>
						</tr>
					</thead>
                    <tbody>
					<tr>
						<th style="color:#000000;">
                            <b>{vtranslate($HEADER['accounting'], 'Accounting')}</b>
                        </th>
						<th style="color:#000000;">
                            <b>{vtranslate($HEADER['total'], 'Accounting')}({$CURRENCY_SYMBOL})</b>
                        </th>
                    </tr>
			{if $INCOME_RECORDS}
				{foreach item=LISTVIEW_ENTRY1 from=$INCOME_RECORDS }
					<tr style="background-color:{$LISTVIEW_ENTRY1['COLOR_CODE']}" >
						<td class="fieldValue medium">
							<span class="value" data-field-type="reference">
								<a style="padding-left: 0px; overflow: hidden; max-width: 62px; white-space: nowrap; text-overflow: ellipsis; display: table-cell;" data-original-title="Accounting" href="index.php?module=Accounting&view=Detail&record={$LISTVIEW_ENTRY1['ACCOUNTINGID']}" style="padding-left: 0px;">{$LISTVIEW_ENTRY1['accounting']}</a>
							</span>
						</td>
						<td class="fieldValue medium" style="overflow: hidden; max-width: 62px; white-space: nowrap; text-overflow: ellipsis;">
							{if $CURRENCY_PLACE eq 1 }{$CURRENCY_SYMBOL} {$LISTVIEW_ENTRY1['total']}{else}{$LISTVIEW_ENTRY1['total']} {$CURRENCY_SYMBOL}{/if}
						</td>
					</tr>
				{/foreach}
			{/if}
					</tbody>
				</table>
            </li>
		{if $INCOME_RECORDS}
			<li>
				<br/><span><b>{vtranslate($HEADER['total'], 'Accounting')} {vtranslate('Incoming', 'Accounting')} : </b>{if $CURRENCY_PLACE eq 1 }{$CURRENCY_SYMBOL} {$TOTAL_INCOME}{else}{$TOTAL_INCOME} {$CURRENCY_SYMBOL}{/if}</span>
			</li>
		{/if}
		</ul>
		<br/>
	</div>
	<div>
        <ul class="nav nav-list" >
			<li style="overflow-x:auto;overflow-y:auto;">
				<table class="table table-bordered equalSplit detailview-table" width="100% !important">
					<thead>
						<tr>
							<th colspan="4" class="blockHeader">
								<b>{vtranslate('Expense', 'Accounting')}</b>
								<a href="index.php?module=Accounting&view=Edit&paymenttype=Expense{$relation_module}">
									<i class="btn btn-xs btn-yellow fa fa-plus" title="Add Expense"></i>
								</a>
							</th>
						</tr>
					</thead>
                    <tbody>
					<tr>
						<th style="color:#000000;">
                            <b>{vtranslate($HEADER['accounting'], 'Accounting')}</b>
                        </th>
						<th style="color:#000000;">
                            <b>{vtranslate($HEADER['total'], 'Accounting')}({$CURRENCY_SYMBOL})</b>
                        </th>
                    </tr>
			{if $EXPENSE_RECORDS}
				{foreach item=LISTVIEW_ENTRY from=$EXPENSE_RECORDS name=listview}
					<tr style="background-color:{$LISTVIEW_ENTRY['COLOR_CODE']}" >
						<td class="fieldValue medium">
							<span class="value" data-field-type="reference">
								<a style="padding-left: 0px; overflow: hidden; max-width: 62px; white-space: nowrap; text-overflow: ellipsis; display: table-cell;" data-original-title="Accounting" href="index.php?module=Accounting&view=Detail&record={$LISTVIEW_ENTRY['ACCOUNTINGID']}" style="padding-left: 0px;">{$LISTVIEW_ENTRY['accounting']}</a>
							</span>
						</td>
						<td class="fieldValue medium" style="overflow: hidden; max-width: 62px; white-space: nowrap; text-overflow: ellipsis;">
							{if $CURRENCY_PLACE eq 1 }{$CURRENCY_SYMBOL} {$LISTVIEW_ENTRY['total']}{else}{$LISTVIEW_ENTRY['total']} {$CURRENCY_SYMBOL}{/if}
						</td>
					</tr>
				{/foreach}
			{/if}
					</tbody>
				</table>
            </li>
			{if $EXPENSE_RECORDS}
				<li>
					<br/><span><b>{vtranslate($HEADER['total'], 'Accounting')} {vtranslate('Expense', 'Accounting')} : </b>{if $CURRENCY_PLACE eq 1 }{$CURRENCY_SYMBOL} {$TOTAL_EXPENSE}{else}{$TOTAL_EXPENSE} {$CURRENCY_SYMBOL}{/if} </span>	
				</li>
			{/if}
		</ul>
		<br/>
	</div>

</div>
{literal}
<script>
jQuery(document).ready(function() {
	var references = jQuery.merge(jQuery('[data-field-type="reference"] > a'), jQuery('[data-field-type="multireference"] > a'));
	var lastPopovers = [];

	// Fetching reference fields often is not a good idea on a given page.
	// The caching is done based on the URL so we can reuse.
	var CACHE_ENABLED = true; // TODO - add cache timeout support.

	function prepareAndShowTooltipView() {
		hideAllTooltipViews();

		var el = jQuery(this);
		var url = el.attr('href')? el.attr('href') : '';
		if (url == '') {
			return;
		}

		// Rewrite URL to retrieve Tooltip view.
		url = url.replace('view=', 'xview=') + '&view=TooltipAjax';

		var cachedView = CACHE_ENABLED ? jQuery('[data-url-cached="'+url+'"]') : null;
		if (cachedView && cachedView.length) {
			showTooltip(el, cachedView.html());
		} else {
			AppConnector.request(url).then(function(data){
				cachedView = jQuery('<div>').css({display:'none'}).attr('data-url-cached', url);
				cachedView.html(data);
				jQuery('body').append(cachedView);
				showTooltip(el, data);
			});
		}
	}

	function showTooltip(el, data) {
		el.popover({
			//title: '', - Is derived from the Anchor Element (el).
			trigger: 'manual',
			content: data,
			animation: false,
			template: '<div class="popover popover-tooltip"><div class="arrow"></div><div class="popover-inner"><button name="vtTooltipClose" class="close" style="color:white;opacity:1;font-weight:lighter;position:relative;top:3px;right:3px;">x</button><h3 class="popover-title"></h3><div class="popover-content"><div></div></div></div></div>'
		});
		lastPopovers.push(el.popover('show'));
		registerToolTipDestroy();
	}

	function hideAllTooltipViews() {
		// Hide all previous popover
		var lastPopover = null;
		while (lastPopover = lastPopovers.pop()) {
			lastPopover.popover('hide');
		}
	}

	references.each(function(index, el){
		jQuery(el).hoverIntent({
			interval: 100,
			sensitivity: 7,
			timeout: 10,
			over: prepareAndShowTooltipView,
			out: hideAllTooltipViews
		});
	});

	function registerToolTipDestroy() {
		jQuery('button[name="vtTooltipClose"]').on('click', function(e){
			var lastPopover = lastPopovers.pop();
			lastPopover.popover('hide');
		});
	}
});
</script>
{/literal}
