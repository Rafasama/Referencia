var mymap;
var mymap_markers = [];
var clat;
var clng;
var crad;
var leadCircle;
var firsttime = true;

jQuery.Class("Geoanalisi",{
	registerOpenGeoanalisiClick: function(record){
		var thisInstance = this;
		$(document).on("submit","#mapPreferences", function(e){
			e.preventDefault();
			
			var data = $("#mapPreferences").serializeFormData();
			var updatedFields = {};
			jQuery.each(data, function(key, value) {
				updatedFields[key] = value;
			})
			
			var formData = JSON.stringify(updatedFields);
			var params = {
				module 	: "Map",
				action 	: "saveAjax",
				formData 	: formData,
			};
			
			AppConnector.request(params).then(
				function(data) {
					if (data.success == true) {
						params = {
							animation: "show",
							type: 'info',
							text: data.result.caption
						};
						Vtiger_Helper_Js.showPnotify(params);
						
					}
				},
				function (jqXHR, textStatus, errorThrown) {
					//alert(textStatus);
				}
			);
		});
		
		
		$(document).on("click","#openGeoanalisi", function(e){
			var textElement = jQuery('#geoAnalisiRadius');
			var RadiusText = textElement.val();
			if(RadiusText == '' || !RadiusText.match(/^\d+(\.\d+)?$/)){
				textElement.validationEngine('showPrompt', app.vtranslate('JS_PLEASE_ENTER_INTEGER_VALUE') , 'error','bottomLeft',true);
				
					 $(".formError").fadeOut(2500, function() {
						 // remove prompt once invisible
						 $(this).parent('.formErrorOuter').remove();
						 $(this).remove();
					 });
				//jQuery('#geoAnalisiRadius').delay(1000).remove();
				e.preventDefault();
				return;
			}		
			
			e.preventDefault();
			
			var params = {
				module 	: "Map",
				action 	: "GetCVAjax",
				mode 	: "getCoordsByRecord",
				record 	: record,
			};
			
			AppConnector.request(params).then(
				function(data) {
					if(data){
						thisInstance.initializeMap(data.result);
						$('#modalMapContainer').modal('show');
						google.maps.event.trigger(mymap, "resize");
				        mymap.setCenter(new google.maps.LatLng(clat,clng));
						
						
				        /*
				        if(!firsttime){
				        	thisInstance.removeListeners();
				        }
				        thisInstance.addListeners();
				        */
				        firsttime = false;
					}
				},
				function (jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			);

		});
	},
	
	registerOnChangeEventOfSourceModule: function () {
        jQuery('.sourceModuleMap').on('change', function (e) {
            var cvPicklist = $(this).closest('tr').find('.picklistFieldsMap');
            cvPicklist.find('option').remove().end().append('<option value="--">--</option>').val('--');
            
            var element = jQuery(e.currentTarget);
            var params = {};
            var sourceModule = element.val();

            params = {
                'module': 'Map',
                'action': "GetCVAjax",
                'mode': "changeModule",
                'sourceModule': sourceModule
            };
			
            AppConnector.request(params).then(
				function (data) {
					if (data) {
						jQuery.each(data.result.options, function (i, item) {
							var o = new Option(item, i);
							jQuery(o).html(item);
							cvPicklist.append(o);
							cvPicklist.trigger('liszt:updated');
						});
					}
				},
				function (jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			);
        });
    },
	
	registerShowCVevent: function () {
		var thisInstance = this;
		jQuery('.showCVMap').on('click', function (e) {
			$('#loadingMapContents').modal('show');
			var cvRow = $(this).closest('tr');
			thisInstance.showMarkersByCvId(cvRow);
		});
	},
	
	showMarkersByCvId: function(cvRow) {
		var element = cvRow.find('.picklistFieldsMap');
        var params = {};
        var cvid = element.val();
		var module = cvRow.find('.sourceModuleMap').val();
		var iconColor = cvRow.find('.markerStyleMap').val();
		
		var rowname = cvRow.find(".sourceModuleMap").attr("id");
		var rowid = rowname.substr(rowname.indexOf("sourceModule") + 12);
		
		params = {
            'module': 'Map',
            'action': "GetCVAjax",
            'mode': "getGeoAnalisi",
			'sourceModule': module,
            'cvid': cvid,
            'lat': clat,
			'lng': clng,
			'rad': crad,
        };
		
		this.resetCurrentRowMarkers(rowid);
		
		AppConnector.request(params).then(
			function (data) {
				if (data) {
					jQuery.each(data.result, function (i, item) {
						var myLatlng = new google.maps.LatLng(item['coords']['lat'],item['coords']['lng']);
						var popupcontentCV = "<table class=\"table table-condensed table-striped table-bordered\"><tr><td colspan=\"2\"><strong>"+item['title']+"</strong>";
						//popupcontentCV += "<a href=\"https://www.google.com/maps/dir/" + (navigator.geolocation.getCurrentPosition) + "/" + item['coords']['lat'] + "," + item['coords']['lng'] + "\">";
						//popupcontentCV += "<a class=\"directionsLinkMap\" data-input-coords=\""+item['coords']['lat']+","+item['coords']['lng']+"\">Portami Qui!</a></td></tr>";
						popupcontentCV += "</td></tr>";
						
						jQuery.each(item['data'], function (label, value){
							popupcontentCV += "<tr><td>"+app.vtranslate(label,module)+"</td><td>"+value+"</td></tr>";
						});
						popupcontentCV += "</table>";
						
						var infowindow = new google.maps.InfoWindow({
							content: popupcontentCV,
							maxWidth: 315,
							maxHeight: 550
						});

						var marker = new google.maps.Marker({
							position: myLatlng,
							map: mymap,
							title: item['data']['title'],
							filternum: rowid
						});
						
						if(iconColor != "default"){
							marker.setIcon("modules/Map/img/"+module+"_"+iconColor+".png");
						}
						
						mymap_markers.push(marker);
						
						google.maps.event.addListener(marker, 'click', function() {
							infowindow.open(mymap,marker);
						});
					});
					$('#loadingMapContents').modal('hide'); 
				}
			},
			function (jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		);
	},
	
	registerAddFilterClick : function(){
		$(document).on('click', "#aggiungiFiltro", function (e) {
			rownum += 1;
			var container_element = jQuery('#customViewsContainer');
			var basicElement = jQuery('.basic',container_element);
			var newRowElement = basicElement.find('.customViewRow').clone(true,true);
			
			newRowElement.find("#sourceModule").attr("name","sourceModule"+rownum);
			newRowElement.find("#picklistFields").attr("name","picklistFields"+rownum);
			newRowElement.find("#markerStyle").attr("name","markerStyle"+rownum);
			newRowElement.find("#deleteRow").attr("name","deleteRow"+rownum);
			
			newRowElement.find("#sourceModule").attr("id","sourceModule"+rownum);
			newRowElement.find("#picklistFields").attr("id","picklistFields"+rownum);
			newRowElement.find("#markerStyle").attr("id","markerStyle"+rownum);
			newRowElement.find("#deleteRow").attr("id","deleteRow"+rownum);
			
			var conditionList = jQuery('#customViewsTable', container_element);
			conditionList.append(newRowElement);
			app.changeSelectElementView(newRowElement);
		});
	},
	
	registerDeleteFilterClick: function(){
		var thisInstance = this;
		$(document).on('click', ".deleteCondition", function(e){
			thisInstance.deleteConditionHandler(e);
		});
	},
	
	registerCollapseClick: function(){
		$(document).on('click', "#collapseIcon", function (e) {
			$("#collapseIcon").hide();
			$("#expandIcon").show();
			$("#customViewSelector").hide();
		});
	},
	
	registerExpandClick: function(){
		$(document).on('click', "#expandIcon", function (e) {
			$("#collapseIcon").show();
			$("#expandIcon").hide();
			$("#customViewSelector").show();
		});
	},
	
	deleteConditionHandler : function(e) {
		var element = jQuery(e.currentTarget);
		var row = element.closest('.customViewRow');
		var rowname = row.find(".sourceModuleMap").attr("id");
		var rowid = rowname.substr(rowname.indexOf("sourceModule") + 12);
		this.resetCurrentRowMarkers(rowid);
		row.remove();
	},
	
	resetCurrentRowMarkers: function(rowid) {
		for (var i = 0; i < mymap_markers.length; i++) {
			if(mymap_markers[i].filternum == rowid){
				mymap_markers[i].setMap(null);
			}
			mymap_markers = [];
		}
	},
	
	getParameterByName: function(name) {
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	},
	
	retrievePointsByModule: function(module) {
		var params = {
			'module': 'Map',
			'action': "GetCVAjax",
			'mode': "getGeoanalisi",
			'retrieve_module': module,
			'lat': clat,
			'lng': clng,
			'rad': crad,
        };
		
		AppConnector.request(params).then(
			function (esito) {
				if (esito) {
					jQuery.each(esito.result, function (i, item) {
						var myLatlng = new google.maps.LatLng(item['coords']['lat'],item['coords']['lng']);
						
						var popupcontentCV = "<table class=\"table table-condensed table-striped table-bordered\"><tr><td colspan=\"2\"><strong>"+item['title']+"</strong>";
						//popupcontentCV += "<a href=\"https://www.google.com/maps/dir/" + (navigator.geolocation.getCurrentPosition) + "/" + item['coords']['lat'] + "," + item['coords']['lng'] + "\">";
						//popupcontentCV += "<a class=\"directionsLinkMap\" data-input-coords=\""+item['coords']['lat']+","+item['coords']['lng']+"\">Portami Qui!</a></td></tr>";
						popupcontentCV += "</td></tr>";
						jQuery.each(item['data'], function (label, value){
							popupcontentCV += "<tr><td>"+app.vtranslate(label,module)+"</td><td>"+value+"</td></tr>";
						});
						popupcontentCV += "</table>";
						var infowindow = new google.maps.InfoWindow({
							content: popupcontentCV,
							maxWidth: 315,
							maxHeight: 550
						});
						
						var marker = new google.maps.Marker({
							position: myLatlng,
							map: mymap,
							filternum: -1
						});
						marker.setIcon("modules/Map/img/"+module+"_red.png");
						
						mymap_markers.push(marker);
						//latlngbounds.extend(myLatlng);
						
						google.maps.event.addListener(marker, 'click', function() {
							infowindow.open(mymap,marker);
						});
					});
				}
			},
			function (jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		);
	},
	
	registerModalOnHide: function(){
		$('#modalMapContainer').on('hidden.bs.modal', function () {
		    
		});
	},
	
	registerOpenModalClick: function(){
		$('#modalMapContainer').on('shown.bs.modal', function () {
	        google.maps.event.trigger(mymap, "resize");
	        mymap.setCenter(new google.maps.LatLng(clat,clng));
	    });
	},
	
	resetAllMarkers: function(){
		for (var i = 0; i < mymap_markers.length; i++) {
			mymap_markers[i].setMap(null);
		}
		mymap_markers = [];
	},
	
	resetMap: function(){
		for (var i = 0; i < mymap_markers.length; i++) {
			mymap_markers[i].setMap(null);
		}
		mymap_markers = [];
		leadCircle.setMap(null);
	},
	
	addListeners: function(){
		this.registerOnChangeEventOfSourceModule();
		this.registerShowCVevent();
		this.registerAddFilterClick();
		this.registerDeleteFilterClick();
		this.registerCollapseClick();
		this.registerExpandClick();
	},
	
	removeListeners: function(){
		$('.sourceModuleMap').off('change');
		$('.showCVMap').off('click');
		$('#aggiungiFiltro').off('click');
		$('.deleteCondition').off('click');
		$('.deleteCondition').off('click');
	},
	
	initializeMap: function(result){
		if(!firsttime){
			this.resetMap();
		}
		clat = result["latitude"];
		clng = result["longitude"];
		crad = $("#geoAnalisiRadius").val();
		var centerposition = new google.maps.LatLng(clat,clng);
		
		var marker = new google.maps.Marker({
			position: centerposition,
			map: mymap,
			filternum: -1
		});
		mymap_markers.push(marker);
		
		mymap.setCenter(centerposition);
		
		var circleOptions = {
			strokeColor: '#FF0000',
			strokeOpacity: 0.8,
			strokeWeight: 2,
			fillColor: '#FF0000',
			fillOpacity: 0.35,
			map: mymap,
			center: new google.maps.LatLng(clat,clng),
			radius: crad * 1000
	    };
		
	    leadCircle = new google.maps.Circle(circleOptions);
	    mymap.fitBounds(leadCircle.getBounds());
		
		if(anyPresetFilter){
			$(".customViewRow").each(function(i,item){
				if (i!=0) //Salto sempre la prima perchè corrisponde al template
					Geoanalisi.showMarkersByCvId($(item));
			});
		}
	}
},{});

function initializeOnReadyMapCanvas(){
	$("#modalMapContainer").appendTo("body");
	var mapOptions = {
		scrollwheel: true,
		zoom: 14
	};
	mymap =  new google.maps.Map(document.getElementById('map-canvas'),mapOptions);
	
	Geoanalisi.addListeners();
	
}

jQuery(document).ready(function(){
	var leadrecord = Geoanalisi.getParameterByName("record");
	if(leadrecord == ""){
		return;
	}
	Geoanalisi.registerOpenGeoanalisiClick(leadrecord);

});