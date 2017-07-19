/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_List_Js("EMAILMaker_ListME_Js",{},{
	
        getContentHolder : function() {
                if(this.detailViewContentHolder == false) {
                        this.detailViewContentHolder = jQuery('div.contents');
                 }
                return this.detailViewContentHolder;
        },  
        
        getSelectedTab : function() {
		var tabContainer = this.getTabContainer();
		return tabContainer.find('li.active');
	},

	getTabContainer : function(){
		return jQuery('div.related');
	},
        
	getDefaultParams : function() {
		var pageNumber = jQuery('#pageNumber').val();
		var module = app.getModuleName();
		var parent = app.getParentModuleName();
		var orderBy = jQuery('#orderBy').val();
		var sortOrder = jQuery("#sortOrder").val();
                
                var view = jQuery("#showview").val();
                if (view == "") view = "ListME";
                
		var params = {
			'module': module,
			'parent' : parent,
			'page' : pageNumber,
			'view' : view,
			'orderby' : orderBy,
			'sortorder' : sortOrder
		}
		return params;
	},        
        deleteRecord : function(recordId) {
                var thisInstance = this;
		var message = app.vtranslate('LBL_DELETE_CONFIRMATION');
		Vtiger_Helper_Js.showConfirmationBox({'message' : message}).then(
			function(e) {
				var module = app.getModuleName();
				var postData = {
					"module": module,
					"action": "IndexAjax",
                                        "mode": "DeleteME",
					"record": recordId,
					"parent": app.getParentModuleName()
				}
				var deleteMessage = app.vtranslate('JS_RECORD_GETTING_DELETED');
				var progressIndicatorElement = jQuery.progressIndicator({
					'message' : deleteMessage,
					'position' : 'html',
					'blockInfo' : {
						'enabled' : true
					}
				});
				AppConnector.request(postData).then(
					function(data){
						progressIndicatorElement.progressIndicator({
							'mode' : 'hide'
						})
						if(data.success) {
							var orderBy = jQuery('#orderBy').val();
							var sortOrder = jQuery("#sortOrder").val();
							var urlParams = {
								"orderby": orderBy,
								"sortorder": sortOrder
							}
							jQuery('#recordsCount').val('');
							jQuery('#totalPageCount').text('');
							thisInstance.getListViewRecords(urlParams).then(function(){
								thisInstance.updatePagination();
							});
						} else {
							var  params = {
								text : app.vtranslate(data.error.message),
								title : app.vtranslate('JS_LBL_PERMISSION')
							}
							Vtiger_Helper_Js.showPnotify(params);
						}
					}
				);
			}
		);
	},
        registerDeleteRecordClickEvent: function(){
		var thisInstance = this;
		var listViewContentDiv = this.getListViewContentContainer();
		listViewContentDiv.on('click','.deleteRecordButton',function(e){
			var elem = jQuery(e.currentTarget);
			var recordId = elem.closest('tr').data('id');
			thisInstance.deleteRecord(recordId);
			e.stopPropagation();
		});
	},
	getListViewRecords : function(urlParams) {
		var aDeferred = jQuery.Deferred();
		if(typeof urlParams == 'undefined') {
			urlParams = {};
		}
		var thisInstance = this;
		var loadingMessage = jQuery('.listViewLoadingMsg').text();
		var progressIndicatorElement = jQuery.progressIndicator({
			'message' : loadingMessage,
			'position' : 'html',
			'blockInfo' : {
				'enabled' : true
			}
		});
		var defaultParams = this.getDefaultParams();
		var urlParams = jQuery.extend(defaultParams, urlParams);
		AppConnector.requestPjax(urlParams).then(
			function(data){
				progressIndicatorElement.progressIndicator({
					'mode' : 'hide'
				})
                jQuery('#listViewContents').html(data);
				thisInstance.calculatePages().then(function(data){
					Vtiger_Helper_Js.showHorizontalTopScrollBar();
					aDeferred.resolve(data);
					// Let listeners know about page state change.
					app.notifyPostAjaxReady();
				});
			},
			function(textStatus, errorThrown){
				aDeferred.reject(textStatus, errorThrown);
			}
		);
		return aDeferred.promise();
	},
        
        registerRowClickEvent: function(){
		var thisInstance = this;
		var listViewContentDiv = this.getListViewContentContainer();
		listViewContentDiv.on('click','.listViewEntries',function(e){
			if(jQuery(e.target, jQuery(e.currentTarget)).is('td:last-child')) return;
			var elem = jQuery(e.currentTarget);
			var recordUrl = elem.data('recordmeurl');
                        if(typeof recordUrl == 'undefined') {
                            return;
                        }
			window.location.href = recordUrl;
		});
	},        
        registerHeaderClickEvent: function(){
		var thisInstance = this;
		var listViewContentDiv = this.getListViewContentContainer();
		listViewContentDiv.on('click','.listViewHeader',function(e){
			var elem = jQuery(e.currentTarget);
        		var sort = elem.data('sort');
                        if(sort != 'yes') {
                            return;
                        }
                        var orderby_type = elem.data('orderby');
                        var sortorder_type = elem.data('sortorder');
                        redirectUrl = "index.php?module=EMAILMaker&view=ListME&orderby="+orderby_type+"&sortorder="+sortorder_type;
			window.location.href = redirectUrl;
		});
	},        
        registerNewEmailCampaignButton: function(){
		var thisInstance = this;

		jQuery('.createEmailCampaign').on('click',function(e){
			window.location.href = "index.php?module=EMAILMaker&view=EditME";
		});
	},        
	registerEvents : function(){
                this.registerNewEmailCampaignButton();
                this.registerRowClickEvent();
                this.registerHeaderClickEvent();
                this.registerDeleteRecordClickEvent();
		this.registerPageNavigationEvents();
		this.registerEventForTotalRecordsCount();
		jQuery('.pageNumbers').tooltip();
	}
})