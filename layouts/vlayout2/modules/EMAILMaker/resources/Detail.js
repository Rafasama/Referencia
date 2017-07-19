/*********************************************************************************
 * The content of this file is subject to the EMAIL Maker license.
 * ("License"); You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is IT-Solutions4You s.r.o.
 * Portions created by IT-Solutions4You s.r.o. are Copyright(C) IT-Solutions4You s.r.o.
 * All Rights Reserved.
 ********************************************************************************/

jQuery.Class("EMAILMaker_Detail_Js",{
    changeActiveOrDefault : function(templateid, type){
        if (templateid != ""){
            var url = 'index.php?module=EMAILMaker&action=IndexAjax&mode=ChangeActiveOrDefault&templateid='+ templateid + '&subjectChanged=' + type;
            AppConnector.request(url).then(function(data){
                location.reload(true);
            });
        }
    }
    },{
    detailViewContentHolder : false,
    reportsColumnsList : false,
    advanceFilterInstance : false,
    detailInstance : false,
    getInstance: function(){
        if( Vtiger_Detail_Js.detailInstance == false ){
            var module = app.getModuleName();
            var moduleClassName = module+"_Detail_Js";
            var fallbackClassName = Vtiger_Detail_Js;
            if(typeof window[moduleClassName] != 'undefined'){
                var instance = new window[moduleClassName]();
            }else{
                var instance = new fallbackClassName();
            }
            Vtiger_Detail_Js.detailInstance = instance;
        }
        return Vtiger_Detail_Js.detailInstance;
    },
    showContent: function(){
    },
    fill_module_lang_array: function(module){
        var ajax_url = 'index.php?module=EMAILMaker&action=AjaxRequestHandle&handler=fill_lang&langmod=' + module;
        jQuery.ajax(ajax_url).success(function(response) {
        }).error(function() {
            alert('error');
        });
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
    getRecordId : function(){
           var newr = "t" + jQuery('#templateid').val();
       return newr; 
    },
    getRelatedModuleName : function() {
           return jQuery('#relatedModuleName').val();
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
            app.registerEventForDatePickerFields(detailContentsHolder);
            app.registerEventForTimeFields(detailContentsHolder);
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
                                    Vtiger_Helper_Js.showHorizontalTopScrollBar();
                                    element.progressIndicator({'mode': 'hide'});
                                    if(typeof callBack == 'function'){
                                            callBack(data);
                                    }
                                    if(tabElement.data('linkKey') == thisInstance.detailViewSummaryTabLabel) {
                                            thisInstance.loadWidgets();
                                            thisInstance.registerSummaryViewContainerEvents(detailContentsHolder);
                                    }
                                    app.notifyPostAjaxReady();
                            },
                            function (){
                                    element.progressIndicator({'mode': 'hide'});
                            }
                    );
            });
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

                            aDeferred.resolve(responseData);
                    },
                    function(){

                    }
            );
            return aDeferred.promise();
    },
    registerEventForRelatedList : function(){
            var thisInstance = this;
            var detailContentsHolder = this.getContentHolder();
            detailContentsHolder.on('click','.relatedListHeaderValues',function(e){
                    var element = jQuery(e.currentTarget);
                    var selectedTabElement = thisInstance.getSelectedTab();
                    var relatedModuleName = thisInstance.getRelatedModuleName();
                    var relatedController = new Vtiger_RelatedList_Js(thisInstance.getRecordId(), app.getModuleName(), selectedTabElement, relatedModuleName);
                    relatedController.sortHandler(element);
            });
            detailContentsHolder.on('click', 'button.selectRelation', function(e){
                    var selectedTabElement = thisInstance.getSelectedTab();
                    var relatedModuleName = thisInstance.getRelatedModuleName();
                    var relatedController = new Vtiger_RelatedList_Js(thisInstance.getRecordId(), app.getModuleName(), selectedTabElement, relatedModuleName);
                    relatedController.showSelectRelationPopup().then(function(data){
                            var emailEnabledModule = jQuery(data).find('[name="emailEnabledModules"]').val();
                            if(emailEnabledModule){
                                    thisInstance.registerEventToEditRelatedStatus();
                            }
                    });
            });
            detailContentsHolder.on('click', 'button.addRelation', function(e){
                    var selectedTabElement = thisInstance.getSelectedTab();
                    var relatedModuleName = thisInstance.getRelatedModuleName();
                    var sourceRecord = thisInstance.getRecordId();
                    var sourceModuleName = app.getModuleName();
                    window.location.href = "index.php?module="+relatedModuleName+"&view=Edit&sourceModule="+sourceModuleName+"&sourceRecord="+sourceRecord+"&relationOperation=true";
            });
            detailContentsHolder.on('click', 'a.relationDelete', function(e){
                    e.stopImmediatePropagation();
                    var element = jQuery(e.currentTarget);
                    var message = app.vtranslate('LBL_DELETE_CONFIRMATION');
                    Vtiger_Helper_Js.showConfirmationBox({'message' : message}).then(
                            function(e) {
                                    var row = element.closest('tr');
                                    var relatedRecordid = row.data('id');
                                    var selectedTabElement = thisInstance.getSelectedTab();
                                    var relatedModuleName = thisInstance.getRelatedModuleName();
                                    var relatedController = new Vtiger_RelatedList_Js(thisInstance.getRecordId(), app.getModuleName(), selectedTabElement, relatedModuleName);
                                    relatedController.deleteRelation([relatedRecordid]).then(function(response){
                                            relatedController.loadRelatedList();
                                    });
                            }
                    );
            });            
            detailContentsHolder.on('click','button.createEmailCampaign',function(e){
                    var record = jQuery('#templateid').val();
                    window.location.href = "index.php?module=EMAILMaker&view=EditME&templateid=" + record;
            });            
            detailContentsHolder.on('click','.listViewEntries',function(e){
                    if(jQuery(e.target, jQuery(e.currentTarget)).is('td:last-child')) return;
                    var elem = jQuery(e.currentTarget);
                    var recordUrl = elem.data('recordmeurl');
                    if(typeof recordUrl == 'undefined') {
                        return;
                    }
                    window.location.href = recordUrl;
            });
            var instanceListME = new window["EMAILMaker_ListME_Js"]();
            detailContentsHolder.on('click','.listViewHeader',function(e){
			var elem = jQuery(e.currentTarget);
                        var sort = elem.data('sort');
                        if(sort != 'yes') {
                            return;
                        }
                        var orderby_type = elem.data('orderby');
                        var sortorder_type = elem.data('sortorder');
                        var record = jQuery('#templateid').val();
                                        var urlParams = {
                                                "orderby": orderby_type,
                                                "sortorder": sortorder_type,
                                                "record": record
                                        }
                                        instanceListME.getListViewRecords(urlParams).then(
					function(data){
						instanceListME.updatePagination();
						aDeferred.resolve();
					},
					function(textStatus, errorThrown){
						aDeferred.reject(textStatus, errorThrown);
					}
				);
            });
            detailContentsHolder.on('click','#listViewNextPageButton',function(){
			var pageLimit = jQuery('#pageLimit').val();
			var noOfEntries = jQuery('#noOfEntries').val();
			if(noOfEntries == pageLimit){
				var record = jQuery('#templateid').val();
                                var orderBy = jQuery('#orderBy').val();
				var sortOrder = jQuery("#sortOrder").val();
				var urlParams = {
					"orderby": orderBy,
					"sortorder": sortOrder,
                                        "record": record
				}
				var pageNumber = jQuery('#pageNumber').val();
				var nextPageNumber = parseInt(parseFloat(pageNumber)) + 1;
				jQuery('#pageNumber').val(nextPageNumber);
				jQuery('#pageToJump').val(nextPageNumber);
				instanceListME.getListViewRecords(urlParams).then(
					function(data){
						instanceListME.updatePagination();
						aDeferred.resolve();
					},

					function(textStatus, errorThrown){
						aDeferred.reject(textStatus, errorThrown);
					}
				);
			}
			return aDeferred.promise();
		});
		detailContentsHolder.on('click','#listViewPreviousPageButton',function(){
			var aDeferred = jQuery.Deferred();
			var pageNumber = jQuery('#pageNumber').val();
			if(pageNumber > 1){
				var record = jQuery('#templateid').val();
                                var orderBy = jQuery('#orderBy').val();
				var sortOrder = jQuery("#sortOrder").val();
				var urlParams = {
					"orderby": orderBy,
					"sortorder": sortOrder,
                                        "record": record
				}
				var previousPageNumber = parseInt(parseFloat(pageNumber)) - 1;
				jQuery('#pageNumber').val(previousPageNumber);
				jQuery('#pageToJump').val(previousPageNumber);
				instanceListME.getListViewRecords(urlParams).then(
					function(data){
						instanceListME.updatePagination();
						aDeferred.resolve();
					},
					function(textStatus, errorThrown){
						aDeferred.reject(textStatus, errorThrown);
					}
				);
			}
		});
                detailContentsHolder.on('click','#listViewPageJump',function(e){
			jQuery('#pageToJump').validationEngine('hideAll');
			var element = jQuery('#totalPageCount');
			var totalPageNumber = element.text();
			if(totalPageNumber == ""){
				var totalRecordCount = jQuery('#totalCount').val();
				if(totalRecordCount != '') {
					var recordPerPage = jQuery('#noOfEntries').val();
					if(recordPerPage == '0') recordPerPage = 1;
					pageCount = Math.ceil(totalRecordCount/recordPerPage);
					if(pageCount == 0){
						pageCount = 1;
					}
					element.text(pageCount);
					return;
				}
				element.progressIndicator({});
				instanceListME.getPageCount().then(function(data){
					var pageCount = data['result']['page'];
					if(pageCount == 0){
						pageCount = 1;
					}
					element.text(pageCount);
					element.progressIndicator({'mode': 'hide'});
                                });
                        }
		})
		detailContentsHolder.on('click','li','#listViewPageJumpDropDown',function(e){
			e.stopImmediatePropagation();
		}).on('keypress','#pageToJump',function(e){
			if(e.which == 13){
				e.stopImmediatePropagation();
				var element = jQuery(e.currentTarget);
				var response = Vtiger_WholeNumberGreaterThanZero_Validator_Js.invokeValidation(element);
				if(typeof response != "undefined"){
					element.validationEngine('showPrompt',response,'',"topLeft",true);
				} else {
					element.validationEngine('hideAll');
					var currentPageElement = jQuery('#pageNumber');
					var currentPageNumber = currentPageElement.val();
					var newPageNumber = parseInt(jQuery(e.currentTarget).val());
					var totalPages = parseInt(jQuery('#totalPageCount').text());
					if(newPageNumber > totalPages){
						var error = app.vtranslate('JS_PAGE_NOT_EXIST');
						element.validationEngine('showPrompt',error,'',"topLeft",true);
						return;
					}
					if(newPageNumber == currentPageNumber){
						var message = app.vtranslate('JS_YOU_ARE_IN_PAGE_NUMBER')+" "+newPageNumber;
						var params = {
							text: message,
							type: 'info'
						};
						Vtiger_Helper_Js.showMessage(params);
						return;
					}
					currentPageElement.val(newPageNumber);
                                        var record = jQuery('#templateid').val();
                                        var orderBy = jQuery('#orderBy').val();
                                        var sortOrder = jQuery("#sortOrder").val();
                                        var urlParams = {
                                                "orderby": orderBy,
                                                "sortorder": sortOrder,
                                                "record": record
                                        }
					instanceListME.getListViewRecords(urlParams).then(
						function(data){
							instanceListME.updatePagination();
							element.closest('.btn-group ').removeClass('open');
						},
						function(textStatus, errorThrown){
						}
					);
				}
				return false;
			}
		});
    },
    registerEvents : function(){
        var thisInstance = this;
        this.registerEventForRelatedTabClick();
        this.registerEventForRelatedList();
    }
});  
Vtiger_Detail_Js("EMAILMaker_DetailME_Js",{
   instance : {} 
},{
	currentInstance : false,
	massemailContainer : false,
	init : function() {
		this.initiate();
	},
	initiate : function(container){
	},
        getContainer : function() {
		return this.container;
	},
	setContainer : function(element) {
		this.container = element;
		return this;
	},
	registerEvents : function(){
	}
});