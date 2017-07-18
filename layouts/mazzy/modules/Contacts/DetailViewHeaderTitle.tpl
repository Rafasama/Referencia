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

	<span class=" span4">
	<div class="imageContainer" style="width:90px; margin-left:5px">
	{assign var=IMAGE_DETAILS value=$RECORD->getImageDetails()}
						{foreach key=ITER item=IMAGE_INFO from=$IMAGE_DETAILS}
							{if !empty($IMAGE_INFO.path) && !empty({$IMAGE_INFO.orgname})}
								<img src="{$IMAGE_INFO.path}_{$IMAGE_INFO.orgname}" style="width:90px;height:90px">
							{else}
								<img src="layouts/mazzy/skins/images/DefaultUserIcon.png" style="width:90px;height:90px">
							{/if}
						{/foreach}
						{if empty($IMAGE_DETAILS)}
							<img src="layouts/mazzy/skins/images/DefaultUserIcon.png" style="width:90px;height:90px">
						{/if}
					</div>
	
	
	</span>


	<span class="span7">
		<span class="row-fluid">
			
					
			<h4 class="recordLabel" title="{$RECORD->getDisplayValue('salutationtype')}&nbsp;{$RECORD->getName()}"> 
				{if $RECORD->getDisplayValue('salutationtype')}
                    <span class="salutation">{$RECORD->getDisplayValue('salutationtype')}</span>&nbsp;
                {/if}
                {assign var=COUNTER value=0}
                {foreach item=NAME_FIELD from=$MODULE_MODEL->getNameFields()}
                    {assign var=FIELD_MODEL value=$MODULE_MODEL->getField($NAME_FIELD)}
                    {if $FIELD_MODEL->getPermissions()}
                        <span class="{$NAME_FIELD}">{$RECORD->get($NAME_FIELD)}</span>
                    {if $COUNTER eq 0 && ($RECORD->get($NAME_FIELD))}                    	
                    	<br/>{assign var=COUNTER value=$COUNTER+1}
                    {/if}
                {/if}
            {/foreach}
			</h4>
			
			
		</span>
		<span class="row-fluid">
			<span class="title_label">{$RECORD->getDisplayValue('title')}
            {if $RECORD->getDisplayValue('account_id') && $RECORD->getDisplayValue('title') }
				&nbsp;{vtranslate('LBL_AT')}&nbsp;
			{/if}
			{$RECORD->getDisplayValue('account_id')}</span>
			<br>
			<a style="margin-left:5px" onclick="mycShowMap()" class="btn"><i class="fa fa-globe fa-lg"></i> Show Map</a>
		</span>
		
			
	</span>
	
	
		
	
	
	<div class="myc-map-modal" style="display:none">
		<a href="" target="_blank" class="btn btn-mazzy myc-map-directions" style="margin-top:10px;margin-bottom:10px;"><i class="fa fa-globe"></i> Get Directions</a>	
		<a onclick="$('.myc-map-modal').hide()" class="btn btn-mazzy" style="margin-top:10px;margin-bottom:10px;"><i class="fa fa-times"></i> Close</a><br>
		<div id="myc-map" style="height:75%;width:90%"></div><br>	
		<a href="" target="_blank" class="btn btn-mazzy myc-map-directions" style="margin-top:10px;margin-bottom:10px;"><i class="fa fa-globe"></i> Get Directions</a>	
		<a onclick="$('.myc-map-modal').hide()" class="btn btn-mazzy" ><i class="fa fa-times"></i> Close</a>	
	</div>
				<script>
			    var mapviewurl="index.php?module=Google&action=MapAjax&mode=getLocation";
				var record="{$RECORD->getId()}";
	            var module="{$MODULE_NAME}";
	            mapviewurl+='&recordid='+record+'&source_module='+module;
	            jQuery.ajax({
	                url:mapviewurl
	            }).done(function(res){
	                var result=JSON.parse(res);
	                var address=result["address"];
	                google.maps.event.addDomListener(window, 'load', initialize(address));
	            });
			</script>
			
			
    <script type="text/javascript">
    
    
    
      var geocoder;
      var map;
      function initialize(mapaddress) {
      	geocoder = new google.maps.Geocoder();
        var mapOptions = {
          zoom: 13
        };
        
        map = new google.maps.Map(document.getElementById('myc-map'),
            mapOptions);
            
        setAddress(mapaddress,map);
        
        var styles = [
    {
        "featureType": "water",
        "stylers": [
            {
                "color": "#19a0d8"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "color": "#ffffff"
            },
            {
                "weight": 6
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#e85113"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#efe9e4"
            },
            {
                "lightness": -40
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#efe9e4"
            },
            {
                "lightness": -20
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "lightness": 100
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "lightness": -100
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "labels.icon"
    },
    {
        "featureType": "landscape",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape",
        "stylers": [
            {
                "lightness": 20
            },
            {
                "color": "#efe9e4"
            }
        ]
    },
    {
        "featureType": "landscape.man_made",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "lightness": 100
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "lightness": -100
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "hue": "#11ff00"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "lightness": 100
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.icon",
        "stylers": [
            {
                "hue": "#4cff00"
            },
            {
                "saturation": 58
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#f0e4d3"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#efe9e4"
            },
            {
                "lightness": -25
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#efe9e4"
            },
            {
                "lightness": -10
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    }
];
		map.setOptions( { styles: styles } );
      }
      
      var markerPos;
      function mycShowMap(){
      var currCenter = map.getCenter();
      $('.myc-map-modal').show();
      google.maps.event.trigger($("#myc-map")[0], 'resize');
      map.setCenter(currCenter);
    }
            
      
      function setAddress(address,mapobj) {
      
	    geocoder.geocode( { 'address': address}, function(results, status) {
	      if (status == google.maps.GeocoderStatus.OK) {
	        mapobj.setCenter(results[0].geometry.location);
	        $(".myc-map-directions").attr("href","https://maps.google.com?daddr="+address).show();
	        markerPos = results[0].geometry.location;
	        var contentString = '<div id="content">'+
			      '<div id="siteNotice">'+
			      '</div>'+
			      '<h4 id="firstHeading" class="firstHeading">'+address+'</h4>';
			
			var infowindow = new google.maps.InfoWindow({
			      content: contentString
			});

	        {if $MODULE_NAME == "Accounts"}
	        var image = 'layouts/mazzy/skins/images/summary_organizations_marker.png';
	        {/if}
	        
	        {if $MODULE_NAME == "Contacts"}
	        var image = 'layouts/mazzy/skins/images/DefaultUserIcon_marker.png';
	        {/if}
	        var marker = new google.maps.Marker({
	            map: mapobj,
	            icon: image,
	            position: results[0].geometry.location,	            
	        });
	        
	        
	        google.maps.event.addListener(marker, 'click', function() {
			    infowindow.open(mapobj,marker);
			});
	        
	      } else {
	      	$(".myc-map").html("Address not found..."+address);
	      }
	    });
	  }
      
    </script>

{/strip}