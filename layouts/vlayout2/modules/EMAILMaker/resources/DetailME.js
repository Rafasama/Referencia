/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/
Vtiger_Detail_Js("EMAILMaker_DetailME_Js",{    
   instance : {}     
},{
        detailViewContentHolder : false,
        currentInstance : false,
	massemailContainer : false,
	init : function() {
		this.initiate();
	},
	initiate : function(container){
	},
        getTabByLabel : function(tabLabel) {
		var tabs = this.getTabs();
		var targetTab = false;
		tabs.each(function(index,element){
			var tab = jQuery(element);
			var labelKey = tab.data('labelKey');
			if(labelKey == tabLabel){
				targetTab = tab;
				return false;
			}
		});
		return targetTab;
	},

	selectModuleTab : function(){
		var relatedTabContainer = this.getTabContainer();
		var moduleTab = relatedTabContainer.find('li.module-tab');
		this.deSelectAllrelatedTabs();
		this.markTabAsSelected(moduleTab);
	},

	deSelectAllrelatedTabs : function() {
		var relatedTabContainer = this.getTabContainer();
		this.getTabs().removeClass('active');
	},

	markTabAsSelected : function(tabElement){
		tabElement.addClass('active');
	},

	getSelectedTab : function() {
		var tabContainer = this.getTabContainer();
		return tabContainer.find('li.active');
	},

	getTabContainer : function(){
		return jQuery('div.related');
	},

	getTabs : function() {
		return this.getTabContainer().find('li');
	},

	getContentHolder : function() {
		if(this.detailViewContentHolder == false) {
			this.detailViewContentHolder = jQuery('div.details div.contents');
		}
		return this.detailViewContentHolder;
	},
        registerEventForRelatedTabClick : function(){
		var thisInstance = this;
		var detailContentsHolder = thisInstance.getContentHolder();
		var detailContainer = detailContentsHolder.closest('div.detailViewInfo');
		jQuery('.related', detailContainer).on('click', 'li', function(e, urlAttributes){
			var tabElement = jQuery(e.currentTarget);
			var element = jQuery('<div></div>');
			element.progressIndicator({
				'position':'html',
				'blockInfo' : {
					'enabled' : true,
					'elementToBlock' : detailContainer
				}
			});
			var url = tabElement.data('url');
			if(typeof urlAttributes != 'undefined'){
				var callBack = urlAttributes.callback;
				delete urlAttributes.callback;
			}
			thisInstance.loadContents(url,urlAttributes).then(
				function(data){
					thisInstance.deSelectAllrelatedTabs();
					thisInstance.markTabAsSelected(tabElement);
                                        app.registerEventForDatePickerFields(detailContentsHolder);
                                        //Attach time picker event to time fields
                                        app.registerEventForTimeFields(detailContentsHolder);
					Vtiger_Helper_Js.showHorizontalTopScrollBar();
					element.progressIndicator({'mode': 'hide'});
					if(typeof callBack == 'function'){
						callBack(data);
					}
					// Let listeners know about page state change.
					app.notifyPostAjaxReady();
				},
				function (){
					//TODO : handle error
					element.progressIndicator({'mode': 'hide'});
				}
			);
		});
	},
        getCurrentPageNum : function() {
		return jQuery('input[name="currentPageNum"]',this.relatedContentContainer).val();
	},
	
	setCurrentPageNumber : function(pageNumber){
		jQuery('input[name="currentPageNum"]').val(pageNumber);
	},
        nextPageHandler : function(){
		var aDeferred = jQuery.Deferred();
		var thisInstance = this;
		var pageLimit = jQuery('#pageLimit').val();
		var noOfEntries = jQuery('#noOfEntries').val();

		if(noOfEntries == pageLimit){
			var pageNumber = this.getCurrentPageNum();
			var nextPage = parseInt(pageNumber) + 1;
			var nextPageParams = {
				'page' : nextPage
			}
			thisInstance.loadRecipientsList(nextPageParams).then(
				function(data){
					thisInstance.setCurrentPageNumber(nextPage);
					aDeferred.resolve(data);
				},

				function(textStatus, errorThrown){
					aDeferred.reject(textStatus, errorThrown);
				}
			);
		}
		return aDeferred.promise();
	},
        previousPageHandler : function(){
		var aDeferred = jQuery.Deferred();
		var thisInstance = this;
                var pageNumber = this.getCurrentPageNum();
                var previousPage = parseInt(pageNumber) - 1;
                var previousPageParams = {
                        'page' : previousPage
                }
                thisInstance.loadRecipientsList(previousPageParams).then(
                        function(data){
                                thisInstance.setCurrentPageNumber(previousPage);
                                aDeferred.resolve(data);
                        },

                        function(textStatus, errorThrown){
                                aDeferred.reject(textStatus, errorThrown);
                        }
                );
		return aDeferred.promise();
	},
        pageJumpHandler: function (e) {
                var aDeferred = jQuery.Deferred();
                var thisInstance = this;
                if (e.which == 13) {
                    var element = jQuery(e.currentTarget);
                    var response = Vtiger_WholeNumberGreaterThanZero_Validator_Js.invokeValidation(element);
                    if (typeof response != "undefined") {
                        element.validationEngine('showPrompt', response, '', "topLeft", true);
                        e.preventDefault();
                    } else {
                        element.validationEngine('hideAll');
                        var jumpToPage = parseInt(element.val());
                        var totalPages = parseInt(jQuery('#totalPageCount').text());
                        if (jumpToPage > totalPages) {
                            var error = app.vtranslate('JS_PAGE_NOT_EXIST');
                            element.validationEngine('showPrompt', error, '', "topLeft", true);
                        }
                        var invalidFields = element.parent().find('.formError');
                        if (invalidFields.length < 1) {
                            var currentPage = jQuery('input[name="currentPageNum"]').val();
                            if (jumpToPage == currentPage) {
                                var message = app.vtranslate('JS_YOU_ARE_IN_PAGE_NUMBER') + " " + jumpToPage;
                                var params = {
                                    text: message,
                                    type: 'info'
                                };
                                Vtiger_Helper_Js.showMessage(params);
                                e.preventDefault();
                                return false;
                            }
                            var jumptoPageParams = {
                                'page': jumpToPage
                            }
                            this.loadRecipientsList(jumptoPageParams).then(
                                    function (data) {
                                        thisInstance.setCurrentPageNumber(jumpToPage);
                                        aDeferred.resolve(data);
                                    },
                                    function (textStatus, errorThrown) {
                                        aDeferred.reject(textStatus, errorThrown);
                                    }
                            );
                        } else {
                            e.preventDefault();
                        }
                    }
                }
                return aDeferred.promise();
        },
        loadRecipientsList : function(urlAttributes) {

                var thisInstance = this;
                var element = jQuery('<div></div>');
                
                var detailContentsHolder = thisInstance.getContentHolder();
		var detailContainer = detailContentsHolder.closest('div.detailViewInfo');
                
                element.progressIndicator({
                        'position':'html',
                        'blockInfo' : {
                                'enabled' : true,
                                'elementToBlock' : detailContainer
                        }
                });
                
                var selectedTabElement = thisInstance.getSelectedTab();
                var relatedModuleName = thisInstance.getRelatedModuleName();
                
                var url = selectedTabElement.data('url');
                if(typeof urlAttributes != 'undefined'){
                        var callBack = urlAttributes.callback;
                        delete urlAttributes.callback;
                }

                thisInstance.loadContents(url,urlAttributes).then(
                        function(data){
                                app.registerEventForDatePickerFields(detailContentsHolder);
                                //Attach time picker event to time fields
                                Vtiger_Helper_Js.showHorizontalTopScrollBar();
                                element.progressIndicator({'mode': 'hide'});
                                if(typeof callBack == 'function'){
                                        callBack(data);
                                }
                                // Let listeners know about page state change.
                                app.notifyPostAjaxReady();
                        },
                        function (){
                                //TODO : handle error
                                element.progressIndicator({'mode': 'hide'});
                        }
                );
        },
        loadContents : function(url,data) {
		var thisInstance = this;
		var aDeferred = jQuery.Deferred();

		var detailContentsHolder = this.getContentHolder();
		var params = url;
		if(typeof data != 'undefined'){
			params = {};
			params.url = url;
			params.data = data;
		}
		AppConnector.requestPjax(params).then(
			function(responseData){
				detailContentsHolder.html(responseData);
				responseData = detailContentsHolder.html();
				//thisInstance.triggerDisplayTypeEvent();
				thisInstance.registerBlockStatusCheckOnLoad();
				//Make select box more usability
				app.changeSelectElementView(detailContentsHolder);
				//Attach date picker event to date fields
				app.registerEventForDatePickerFields(detailContentsHolder);
				app.registerEventForTextAreaFields(jQuery(".commentcontent"));
				jQuery('.commentcontent').autosize();
				thisInstance.getForm().validationEngine();
				aDeferred.resolve(responseData);
			},
			function(){

			}
		);

		return aDeferred.promise();
	},
	registerEvents : function(){
            this.registerEventForRelatedTabClick();
            this.registerEventForRelatedListPagination();
	},
        registerEventForRelatedListPagination : function(){
            var thisInstance = this;
            var detailContentsHolder = this.getContentHolder();
            detailContentsHolder.on('click','#relatedListNextPageButton',function(e){
                    var element = jQuery(e.currentTarget);
                    if(element.attr('disabled') == "disabled"){
                            return;
                    }
                    thisInstance.nextPageHandler();
            });
            detailContentsHolder.on('click','#relatedListPreviousPageButton',function(){
                    thisInstance.previousPageHandler();
            });
            detailContentsHolder.on('click','#relatedListPageJumpDropDown > li',function(e){
                    e.stopImmediatePropagation();
            }).on('keypress','#pageToJump',function(e){
                    var selectedTabElement = thisInstance.getSelectedTab();
                    var relatedModuleName = thisInstance.getRelatedModuleName();
                    thisInstance.pageJumpHandler(e);
            });
	},
});
      