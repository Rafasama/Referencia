
google.load("visualization", "1", {packages:["corechart"]});


function GraphSelectHandler(selection){
	console.log(selection);
	alert("selected");
}

var defaultrightsidebarstatus;



function switchSkin(skinName) {
	
  			$('#themeContainer').hide();
  			$('.mazzyMobileModalBody').html("Switching . . . ");
			var progressElement = $('.progressSwithing');
			progressElement.progressIndicator();
			
			var params = {
				'module' : 'Users',
				'action' : 'SaveAjax',
				'record' : $('#current_user_id').val(),
				'field'	 : 'theme',
				'value'	 : skinName
			}
			AppConnector.request(params).then(function(data) {
				if(data.success && data.result) {
					progressElement.progressIndicator({'mode':'hide'});
					$('.settingIcons').removeClass('open');
					window.location.reload();
				}
			},
			function(error,err){
			});
			
			
}

$(function(){

	
	var references = jQuery.merge(jQuery('[data-field-type="reference"] > a'), jQuery('[data-field-type="multireference"] > a'));
	references.each(function(index, el){
			jQuery(el).mouseover(function(){
				jQuery(el).css("font-size","22px");
			});
			jQuery(el).mouseout(function(){
				jQuery(el).css("font-size","14px");
			});
	});
	
	$(".bodyContents").css("max-height",($(window).height()-75)+"px");
	$(".gridViewEntriesTable").css("max-width",($(window).width()-75)+"px");
	
	var gridsterM = false;
	
	if($(window).width()<1024 && $("#loginDiv").length == 0){
		hideRightSidebar();
		if($(".gridster ul").length) {
			var gridsterM = $('.gridster ul').gridster({
						widget_margins: [7, 7],
						widget_base_dimensions: [100, 300],
						min_cols: 6,
						min_rows: 20,
			}).data('gridster').disable();
		}
	}
	
	else {
		if($("#mazzy-sidebar-right").hasClass("hide")===false || $("#mazzy-sidebar-right").css('display')=="block")
			$(".bodyContents").css("right","200px");
	}
	
	
	
	$(window).resize(function() {
	
	  $(".bodyContents").css("max-height",($(window).height()-75)+"px");
	  $(".gridViewEntriesTable").css("max-width",($(window).width()-75)+"px");
	  
	  if($(window).width()<=800 && $("#loginDiv").length == 0){
		  hideRightSidebar(); 
		  $(".mazzymenutext").css("display","none");
		  if(gridsterM) gridsterM.disable();
	  }
	  else {
	  	if($(window).width()<1024 && $("#loginDiv").length == 0) hideRightSidebar();   		
	  	$("#mazzy-sidebar-left").removeAttr("style");
	  	$(".bodyContents").css("left","50px");
	  	if(gridsterM) gridsterM.enable();
	  }
	});
	
	
	
	$(".mazzy-module-link.selected").parent().show();
	
	
	$("#mazzy-sidebar-right .mazzy-show-child-modules").on("click",function(){
		
		if($("#mazzy-child-modules-"+$(this).attr("mazzy-childmodules")).css('display')!="block"){
			$("#mazzy-sidebar-right .mazzy-child-modules").hide();
			$("#mazzy-child-modules-"+$(this).attr("mazzy-childmodules")).show();
		}
		else $(".mazzy-child-modules").hide();
		
	});
	
	$("#mazzy-sidebar-left .mazzy-show-child-modules").on("click",function(){
		
		if($("#mazzy-child-modules-"+$(this).attr("mazzy-childmodules")).css('display')!="block"){
			$("#mazzy-sidebar-left .mazzy-child-modules").hide();
			$("#mazzy-child-modules-"+$(this).attr("mazzy-childmodules")).show();
		}
		else $(".mazzy-child-modules").hide();
		
	});
	
	
	
	$( "#mazzy-sidebar-left-toggle").mouseenter(function() {
		if($(window).width()>800){
			if(defaultrightsidebarstatus=="shown"){
				hideLeftSidebar(); updateSidebarStatus();
				$("#page, #mazzy-sidebar-right").unbind('mouseenter');
				//$( "#mazzy-sidebar-left-toggle").show();
			}
			else {
			    showLeftSidebar(); updateSidebarStatus();
			    $("#page, #mazzy-sidebar-right").mouseenter(function() {
					hideLeftSidebar(); updateSidebarStatus();
					$("#page, #mazzy-sidebar-right").unbind('mouseenter');
				})
			    
			    //$( "#mazzy-sidebar-left-toggle").hide();
		    }
	    }
	});
	
	$('#mazzy-sidebar-left a ').on("touchstart", function (e) {
		if($(window).width()>800){		
		    'use strict'; //satisfy code inspectors
		    var link = $(this); //preselect the link
		    if ($("#mazzy-sidebar-left").hasClass('hover')) {
		        return true;
		    } else {
		        $("#mazzy-sidebar-left").addClass('hover');
		        $("#mazzy-sidebar-left").css("width", "200px");
				$(".mazzymenutext").css("display","block");
				$(".mycgridsidebarbtn").css("display","block");
		        e.preventDefault();
		        return false; //extra, and to make sure the function has consistent return points
		    }
	    }
	});
	
	$(".bodyContents, .companyLogo, .mazzy-nav").on("click", function(){ 
		if($(window).width()>800 && $("#mazzy-sidebar-left").hasClass('hover')){
			$("#mazzy-sidebar-left").removeClass('hover');
			$("#mazzy-sidebar-left").css("width", "50px");
			$(".mazzymenutext").css("display","none");
			$(".mycgridsidebarbtn").css("display","none");
			e.preventDefault();
		    return false;
		}
	});
	
	
	$("#mazzy-sidebar-left a ").mouseenter(function(){
		if($(window).width()>800){
			$("#mazzy-sidebar-left").css("width", "200px");
			$(".mazzymenutext").css("display","block");
			$(".mycgridsidebarbtn").css("display","block");
		}
	});
	
	$("#mazzy-sidebar-left a ").mouseleave(function(){
		if($(window).width()>800){
			$(".mycgridsidebarbtn").css("display","none");
			$("#mazzy-sidebar-left").css("width", "50px");
			$(".mazzymenutext").css("display","none");
		}
	});
	
	
	
	$(".mazzy-hide-left-sidebar").on("click", function(){ hideLeftSidebar(); updateSidebarStatus(); });
	$(".mazzy-show-left-sidebar").on("click", function(){ showLeftSidebar(); updateSidebarStatus(); });
	$(".mazzy-hide-right-sidebar").on("click", function(){ hideRightSidebar() });
	$(".mazzy-show-right-sidebar").on("click", function(){ showRightSidebar() });
	
	$( ".slideThreeChk" ).change(function() {
	  keepSidebarLeft();
	});

	$(".mycloaderbg").hide();

});



function updateSidebarStatus(){
	if($("#mazzy-sidebar-left").hasClass("hide")===false || $("#mazzy-sidebar-left").css('display')=="block")
		defaultrightsidebarstatus="shown";
	else  defaultrightsidebarstatus="hidden";
}


function keepSidebarLeft(){
	if($('.slideThreeChk').is(':checked'))
		var targetStatus=1;
	else var targetStatus=0;
	var params = {
                'module' : 'Users',
                'action' : 'IndexAjax',
                'mode' : 'toggleLeftPanel',
                'showPanel' : targetStatus
            }
   //$.get( "index.php", params );
    AppConnector.request(params);
}

function showLeftSidebar(){	

			if($(window).width()<=800 && $("#loginDiv").length == 0){
				hideRightSidebar();
            }
            
            $("#mazzy-sidebar-left").show();
			$("#page, .navbar-fixed-top").css("margin-left","200px");
			$("#page, .navbar-fixed-top").css("margin-right","-200px");
			$(".bodyContents").css("left","200px").css("right","-200px");
			$(".mazzy-show-left-sidebar").hide();
			$(".mazzy-hide-left-sidebar").show();
			$("#mazzy-sidebar-left").css('left',"0px").attr("style","width:200px!important");
			
			$(".bodyContents, .companyLogo").on("click", function(){ hideLeftSidebar(); });
			$(".mycgridsidebarbtn").css("display","block");
}

function showRightSidebar(){	

            if($(window).width()<=800 && $("#loginDiv").length == 0){
				hideLeftSidebar();
				$("#page, .navbar-fixed-top").css("margin-left","-200px");
				$(".bodyContents").css("left","-200px");
			}
				
            $("#mazzy-sidebar-right").show();			
			$("#page, .navbar-fixed-top").css("margin-right","200px");
			$(".bodyContents").css("right","200px");
			$(".mazzy-show-right-sidebar").hide();
			$(".mazzy-hide-right-sidebar").show();
			$("#mazzy-sidebar-right").css('right',"0px");
			$(".bodyContents, .qCreate").on("click", function(){ hideRightSidebar(); });
		
}


function hideLeftSidebar(){
	
	

   $("#mazzy-sidebar-left").hide();
   $("#page, .navbar-fixed-top").css("margin-left","0px");
   $("#page, .navbar-fixed-top").css("margin-right","0px");
   $(".bodyContents").css("left","0px").css("right","0px").attr("style","");
   $(".mazzy-hide-left-sidebar").hide();
   $(".mazzy-show-left-sidebar").show(); 
   $(".mycgridsidebarbtn").css("display","none");  

}



function hideRightSidebar(){
	
   
   $("#mazzy-sidebar-right").hide();
   
   if($(window).width()<=800 && $("#loginDiv").length == 0) var leftMargin = 0;
   else var leftMargin = 50;
   
   $("#page, .navbar-fixed-top").css("margin-left",leftMargin+"px");
   		
   $("#page, .navbar-fixed-top").css("margin-right","0px");
   $(".bodyContents").css("left",leftMargin+"px").css("right","0px");
   $(".mazzy-hide-right-sidebar").hide();
   $(".mazzy-show-right-sidebar").show();   
   
}


        function MYCupdateNavCount(){
        	 if($('.nav-pills li').length) var relElm = $('.nav-pills li');
        	 else relElm = $('.related a');
             relElm.each(function(n,item){
                var url=$(item).attr("data-url");
                requestdata=url.split("&").reduce(function(s,c){var t=c.split('=');s[t[0]]=t[1];return s;},{})
                if (requestdata['mode'] && requestdata['mode']=="showRelatedList"){
                        var params={};
                        params['record'] = requestdata['record'];
                        params['action'] = 'RelationAjax';
                        params['module'] = app.getModuleName;
                        params['relatedModule'] = requestdata['relatedModule'];
                        params['mode'] = 'getRelatedListPageCount';
                        AppConnector.request(params).then(
                        function(response){
                                if(response.success){
					//if there is a count we update it
					if($(item).find('.count').length){
						$(item).find('.count').text(response.result.numberOfRecords);
					}else{
                                        	$(item).find('strong').append("<span class='count'>"+response.result.numberOfRecords+"</span>");
					}
                                }
                        }
                );

                }
        });
	}
$(function(){
	view=$('#view').attr("value");
	if (view=="Detail"){
		MYCupdateNavCount();
	        //when the user adds stuff to a related list we need to update our count
	        var header=Vtiger_Header_Js.getInstance();
		header.registerQuickCreateCallBack(MYCupdateNavCount);
	}
})
