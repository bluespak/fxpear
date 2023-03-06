<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.bluespak.vo.PearVO"%>
<%@ page import="com.bluespak.vo.BidVO"%>
<%@ page import="com.bluespak.utils.cd.NationCode"%>
<%@ page import="com.bluespak.utils.cd.CityCode"%>
<%@ page import="com.bluespak.utils.cd.CurrencyCode"%>
<%@ page import="com.bluespak.utils.cd.CurrencySymbol"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>  
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Result for FXPEAR</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">



<jsp:include page="./css_include.jsp"></jsp:include> 
<link href="./bootstrap/css/slider.css" rel="stylesheet">
<link href="./bootstrap/css/snap.css" rel="stylesheet">
<link href="./bootstrap/css/demo.css" rel="stylesheet">
<link href="./bootstrap/css/daterangepicker.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./css/page.style.css" media="screen"/>
    
<style type="text/css">
#map_canvas {
        margin: 0;
        padding: 0;
        height: 100%;
        box-shadow: 0px 0px 10px 1px #6F6F6F;
}
.gmnoprint img { max-width: none; }

.gm-style-iw{
    max-height: 2000px;
}
</style>

<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false&amp;libraries=places" type="text/javascript"></script>
<script type="text/javascript" src="./jquery/js/jquery.formatCurrency-1.4.0.min.js"></script>

<script type="text/javascript">

var geocoder = new google.maps.Geocoder();
var map;
var markers = [];
var infowindow ;
var infobox ;
var initialLocation;
var siberia = new google.maps.LatLng(60, 105);
var newyork = new google.maps.LatLng(40.69847032728747, -73.9514422416687);
var browserSupportFlag =  new Boolean();

var locationinfos  = [
                  <c:choose>
                  <c:when test="${!empty info.result}">
                   <c:forEach items="${info.result}" var="list" varStatus="st">
                   <c:set var="csymbol" scope="request" value="${list.sccd}"/>
                   ['<img class="img-rounded" src="http://graph.facebook.com/${list.fbuid}/picture?width=33&height=33&"><font color="blue"><B>${list.fname} ${list.lname}</B></font> wants to trade <font color="red"><B>${list.sccd} <%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %> ${list.samt}</B></font><br>until ${list.trdt} near <font color="brown"><B>${list.exlo}</B></font>', '${list.exlo}', '${list.pseq}'],
                   </c:forEach> 
                   </c:when>
                </c:choose>
                ['no want', 'LA', 0]
                ];   
                
           

/*                
function moveMapCenter() {

          if (!navigator.geolocation){
                alert("Geolocation is not supported by your browser");
            return;
          }

          function success(position) {
            latitude  = position.coords.latitude;
            longitude = position.coords.longitude;
            alert('latitude='+latitude + ' longitude='+longitude);
          };

          function error() {
                  alert('Unable to retrieve your location');
          };
          navigator.geolocation.getCurrentPosition(success, error);
        }
       
*/


function sleep(msecs) {
    var start = new Date().getTime(); var cur = start; while (cur - start <
    msecs) {
	cur = new Date().getTime();
    }
}

function initialize() {

        var mapOptions = {
                            zoom: 15,
                            mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        
        map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
        infowindow = new google.maps.InfoWindow({
                content: "loading..."
        });
        

  if(navigator.geolocation) {
    browserSupportFlag = true;
    var search_lat = "${param.initLatitute}";
    var search_lng = "${param.initLongitute}";
    navigator.geolocation.getCurrentPosition(function(position) {
    
      initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
      if(search_lat != "" && search_lng != ""){
          initialLocation = new google.maps.LatLng(search_lat,search_lng);
      }
      map.setCenter(initialLocation);
                snapper.open('left');
                snapperstat = false;
    }, function() {
      handleNoGeolocation(browserSupportFlag);
    });
  }else {
        //Browser doesn't support Geolocation
    browserSupportFlag = false;
    handleNoGeolocation(browserSupportFlag);
  }
        
        function handleNoGeolocation(errorFlag) {
            if (errorFlag == true) {
              alert("Geolocation service failed.");
              initialLocation = newyork;
            } else {
              alert("Your browser doesn't support geolocation. We've placed you in Siberia.");
              initialLocation = siberia;
            }
            map.setCenter(initialLocation);
            
        }
        
        
        setMarkers(map,locationinfos); 
}
  

function setMarkers(vmap,locationinfos) {
           var i = 0;
           for (i = 0; i < locationinfos.length -1; i++) {
              setMarker(vmap, locationinfos[i][1], locationinfos[i][2]);
           }

}


var infowindowsArray = [];

function clearOverlays(){
    if(infowindowsArray){
        for (i in infowindowsArray){
            infowindowsArray[i].setMap(null);
        }
    }
}


function setMarker(vmap, address, seq) {
	//	alert($('#infobox'+seq).html());
    //  alert('setMarker infobox='+document.getElementById("infobox" + seq).value);
	geocoder = new google.maps.Geocoder();
	geocoder.geocode( { 'address': address }, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
                    map.setCenter(results[0].geometry.location);

               
               var marker = new google.maps.Marker({
            	   position: results[0].geometry.location,
            	   map: vmap,
            	   html: seq,
            	   animation: google.maps.Animation.DROP,
            	   title: address,
            	   icon: ('./img/bank.png')
            	   });
                      
               		markers.push(marker);   
                   
               var infobox = new InfoBox({
            //	   content: document.getElementById("infobox" + seq),
            	   content: $('#infobox'+seq).html(),
            	   disableAutoPan: false,
            	   pixelOffset: new google.maps.Size(-20, 0),
            	   zIndex: 2,
            	   boxStyle:{
            		 background: "#FFFFFF",
            		 opacity: 0.75,
            		 maxwidth:"300px",
            		 maxheight:"500px"
            	   },
            	   closeBoxMargin: "2px 2px 2px 2px",
            	   closeBoxURL: "./img/close.png",
            	   isHidden: false,
            	   });
                    
                    
               google.maps.event.addListener(marker, 'click', function() {   
      	       	   clearOverlays();
            	   infowindowsArray.push(infobox);
            	   infobox.open(vmap, this);
            	   map.panTo(loc);
            	   });
                    
                 
			}else {            
				alert("Geocode was not successful for the following reason: " + status);
			}
		});  
	}
	
//Sets the map on all markers in the array.
function setAllMap(map) {
 for (var i = 0; i < markers.length; i++) {
	 markers[i].setMap(map);
 }
}

// Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
  setAllMap(null);
}

// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
  clearMarkers();
  marker = [];
}	


function closeinfobox(pseq){
        
}


function moveMapCenter(address,pseq){

	geocoder.geocode( { 'address': address}, function(results, status) {
    	if (status == google.maps.GeocoderStatus.OK) {
    		map.setZoom(15);
    		map.panTo(results[0].geometry.location);
    	//	var description = eval("document.resultForm.info_msg_"+pseq+".value");
    	//	var description = pseq;
    	setMarker(map, address, pseq);
    	} else {
    		//    alert('Geocode was not successful for the following reason: ' + status);
    	}
    });
        
}


google.maps.event.addDomListener(window, 'load', initialize);


// Facebook Post
function fbPost(pseq){
                alert("fbPost");
                alert("fbloginChk="+fbloginChk);                
        if(fbloginChk == 1){
                var body = "hello currencypear http://www.currencypear.com:8080/fxpear/searchPear.fx";
                FB.api('/me/feed', 'post', { message: body }, function(response) {
                        alert("fbpost response");
                          if (!response || response.error) {
                            alert('Error occured');
                          } else {
                            alert('Post ID: ' + response);
                          }
                });
                
        }else   {
                fbconnect("post");
        }                       
}

//Twitter Post
function twPost(pseq){
        alert("twPost");
        jQuery.ajax({
            type: "GET",
            url: "./tweetPost.fx",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: "pseq="+pseq,
            success: function(data) {
                alert("It posted in Twitter successfully.");
   //           alert(data);

           },
           error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
               alert(thrownError);
           }
        });
}

function goBid(pseq){

        var url = "./bidpear.fx?pseq="+pseq+"&buid=${sessionScope.logininfo.id}";
        location.href = url;
}
/*
function goBid(pseq){
    <c:choose>    
            <c:when test="${!empty sessionScope.logininfo}">
                <c:choose>    
                        <c:when test="${!empty sessionScope.logininfo.fbuid}">
                        facebook_send_message(name, to,description,link);
                        </c:when>       
                        </c:choose>
                var url = "./bidpear.fx?pseq="+pseq+"&buid=${sessionScope.logininfo.id}";
                location.href = url;
            </c:when>
            <c:otherwise>            
                alert('You need to be logged in to bid');
            </c:otherwise>  
   </c:choose>
}
*/
function goDetail(pseq){
                var url = "./summary.fx?cuid=${sessionScope.logininfo.id}&whoc=B&pseq="+pseq;
                location.href = url;
}

function goSDetail(pseq){
        var url = "./summary.fx?cuid=me&whoc=S&pseq="+pseq;
                 location.href = url;
}



function searchPearByPosition(){

        if(document.searchForm.initLatitute.value == "0"){
                alert("Couldn't access your location. Use Search Button Please.");
                return;
        }
        /*
        if(document.searchForm.sccd.value == ""){
                document.searchForm.sccd.value = "%";
        }               

        if(document.searchForm.bccd.value == ""){
                document.searchForm.bccd.value = "%";
        }               
        */
        
        if(checkValid_searchPear()){
                document.searchForm.action = "./searchPearByPosition.fx";
                searchForm.submit();
        }
}       



/*** Javascript - page.js ***/

	var qnum = <%=request.getParameter("qnum")%>;   // How many data in a page
		
		
	function displayLinks(current_page) {
		var resultlist_div = document.getElementById("result-list");
		resultlist_div.innerHTML = "";

		var snum = (current_page - 1 ) * qnum;
		jQuery.ajax({
    	    type: "GET",
    	    url: "./searchPearToJson.fx",
    	    dataType: "json",
    	    contentType: "application/json; charset=utf-8",
    	    data: "exlo=${param.exlo}&bccd=${param.bccd}&sccd=${param.sccd}&suid=${sessionScope.logininfo.id}&qnum="+qnum+"&snum="+snum+"&cpage="+current_page+"&initLongitute=${param.initLongitute}&initLatitute=${param.initLatitute}&min_amt=${param.min_amt}&max_amt=${param.max_amt}",
    	    success: function(data) {
    	    	deleteMarkers();
    	        for(var i=0; i<data.length;i++){                
    	        	makelist(data[i]);
    	        }
    	    //	var pagination = "<div id='pagediv' style='position:absolute ;top:80%;left:13%;z-index:99'></div>";
    	    //    $("#result-list").html($("#result-list").html()+pagination);  
    	   },
    	   error: function (xhr, ajaxOptions, thrownError) {
    	        alert(xhr.status);
    	       alert(thrownError);
    	   }
    	});    	        
        
		

	}
	
	function makelist(data) {
	//	var myString = $("#result-list").html(); 
	//	var resultlist_div = document.getElementById("result-list");
	//	alert($("#result-list").html()); 
	
	//	var sampledata="sampledata";
	
	/*
	
	Sample 		
					
	<div class="post">
     	
     	<div id="infobox84" class="infobox-wrapper infobox">
			<div class="popover-title" style="font-size: 24px; font-weight: bold;">
				<div style="padding: 4px">
                  <ul class="unstyled mo">
                     <li style="font-size: 24px">KRW</li>
                     <li class="mo" style="font-size: 44px; line-height: 35px; white-space: nowrap; overflow: hidden; min-width: 100px; margin: 0px -1px !important">
						<b style="vertical-align: middle; font-weight: bold">₩500,000</b>
						<button onClick="javascript:goBid('84'); return false;" style="vertical-align: middle" class="btn btn-info btn-large">View</button>
					 </li>
                  </ul>
                </div>
			</div>
			<div class="popover-content" style="display: inline-block">
				<div style="display: inline-block; float: left; margin-right: 10px">
					
                    
                    
                      <img height="33" width="33" style="margin-top: 6px" src="./img/user.png" alt="">
                    
                  
				</div>
                 
				<div style="display: inline-block; float: left; margin-top: 1px">
                  <ul class="unstyled mo">
                    <li class="mo f16"><b style="font-size: 16px"><i class="flag16 KR" style="vertical-align: text-top; margin-right: 3px !important; margin-top: 3px"></i>KRW <i class="icon-exchange" style="margin-right: 2px; font-size: 16px; margin-top: 3px"></i> <i class="flag16 AU" style="vertical-align: text-top; margin-right: 3px !important; margin-top: 3px"></i>AUD</b></li>
                    <li>Expires: <i class="icon-calendar"></i> 2014-11-27 <i class="icon-time"></i>  00:00:00</li>
                  </ul>
                </div>
			</div>

   		</div>
        <div id="pseq" style="display:none;">84</div>
        <div id="address" style="display:none;">Greenfields, Western Australia, Australia</div>
        <div class="list-wrap">
        
		 	<div class="span6 list-wrap-inner" style="border-bottom: 1px dashed #ddd; padding: 10px 0 10px; margin-top: 10px; margin-left: 0px; padding-left: 10px; max-width: 530px">
		        <div style="display: inline-block; float: left; margin-right: 10px"> 
		        
		        	
		        	
		        		<img height="50" width="50" style="margin-top: 5px" src="./img/user.png" alt="">
		        	
				
		        </div>
				<div style="display: inline-block; float: left; padding: 1px 10px 2px;">
		        	<ul class="unstyled mo">
		            	<li class="mo f16"><b style="font-size: 16px"><i class="flag16 KR" style="vertical-align: text-top; margin-right: 3px !important"></i>KRW <i class="icon-exchange" style="margin-right: 2px; font-size: 16px"></i> <i class="flag16 AU" style="vertical-align: text-top; margin-right: 3px !important"></i>AUD</b></li>
		                <li>Expires: <i class="icon-calendar" style="font-size: 13px; vertical-align: text-top"></i> 2014-11-27 <i class="icon-time"></i>  00:00:00</li>
		                <li style="white-space: nowrap; overflow: hidden; ">
		                <i class="icon-map-marker"></i> 
		                <a title="Greenfields, Western Australia, Australia" class="truncate" href="javascript:moveMapCenter('Greenfields, Western Australia, Australia','84')">Greenfields, Western Australia, Australia</a>
		                </li>
					</ul>
		        </div>
		        <div id="the-post" style="display: inline-block; background: #f5f5f5; padding: 12px; float: right">
		            <ul class="unstyled mo">
		                <li>KRW</li>
		                <li class="mo" style="font-size: 24px; color: rgb(95, 49, 144);white-space: nowrap; overflow: hidden; max-width: 151px; min-width: 100px"><b style="font-weight: bold">₩500,000</b></li>
		            </ul>
		        </div>
		    </div>
		    <div class="box-section news with-icons"></div>
        </div>
	</div>
        <input type="hidden" name="exlo_map" value="Greenfields, Western Australia, Australia">
        <input type="hidden" name="info_msg_84" value="<img class='img-rounded' src='http://graph.facebook.com//picture?width=33&height=33&'><font color='blue'><B>new begins</B></font> wants to trade <font color='red'><B>KRW ₩ 500000.0</B></font><br>until 2014-11-27 00:00:00.0 near <font color='brown'><B>Greenfields, Western Australia, Australia</B></font>">
        
	
        
    */
	
	
	    var sampledata	= "";
    	    	
	    sampledata = sampledata+"	<div class='post'>";
	    sampledata = sampledata+"		<div id='infobox"+data.pseq+"' class='infobox-wrapper infobox'>";
	    sampledata = sampledata+"			<div class='popover-title' style='font-size: 24px; font-weight: bold;'>";
	    sampledata = sampledata+"				<div style='padding: 4px'>";
	    sampledata = sampledata+"					<ul class='unstyled mo'>";
	    sampledata = sampledata+"     					<li style='font-size: 24px'>"+data.sccd+"</li>";
	    sampledata = sampledata+"     					<li class='mo' style='font-size: 44px; line-height: 35px; white-space: nowrap; overflow: hidden; min-width: 100px; margin: 0px -1px !important'>";
	    sampledata = sampledata+"						<b style='vertical-align: middle; font-weight: bold'>"+data.scsb+formatCurrency(data.samt)+"</b>";
	    sampledata = sampledata+"						<button onclick='javascript:goBid(\""+data.pseq+"\"); return false;' style='vertical-align: middle' class='btn btn-info btn-large'>View</button>";
	    sampledata = sampledata+"	 					</li>";
	    sampledata = sampledata+"					</ul>";
	    sampledata = sampledata+"				</div>";
	    sampledata = sampledata+"			</div>";
	    sampledata = sampledata+"		<div class='popover-content' style='display: inline-block'>";
	    sampledata = sampledata+"			<div style='display: inline-block; float: left; margin-right: 10px'>";
	    if(data.fbuid == "" || data.fbuid == null){
	    	sampledata = sampledata+"			<img style='margin-top: 6px' src='./img/user.png' alt='' height='33' width='33'>";
	    }else	{
	    	sampledata = sampledata+"			<img style='margin-top: 6px' src='http://graph.facebook.com/"+data.fbuid+"/picture?width=33&amp;height=33&amp;' alt=''>";
	    }
	    sampledata = sampledata+"			</div>";
	    sampledata = sampledata+"			<div style='display: inline-block; float: left; margin-top: 1px'>";
	    sampledata = sampledata+"  				<ul class='unstyled mo'>";
	    sampledata = sampledata+"    				<li class='mo f16'><b style='font-size: 16px'><i class='flag16 "+data.sccd.substring(0,2)+"' style='vertical-align: text-top; margin-right: 3px !important; margin-top: 3px'></i>"+data.sccd+" <i class='icon-exchange' style='margin-right: 2px; font-size: 16px; margin-top: 3px'></i> <i class='flag16 "+data.bccd.substring(0,2)+"' style='vertical-align: text-top; margin-right: 3px !important; margin-top: 3px'></i>"+data.bccd+"</b></li>";
	    sampledata = sampledata+"    				<li>Expires: <i class='icon-calendar'></i> "+data.trdt.substring(0,10)+" <i class='icon-time'></i>  "+data.trdt.substring(11,19)+"</li>";
	    sampledata = sampledata+"  				</ul>";
	    sampledata = sampledata+"			</div>";
	    sampledata = sampledata+"		</div>";
	    sampledata = sampledata+"	</div>";
	    sampledata = sampledata+"	<div id='pseq' style='display:none;'>"+data.pseq+"</div>";
	    sampledata = sampledata+"	<div id='address' style='display:none;'>"+data.exlo+"</div>";

	    
	    
	    sampledata = sampledata+"	<div class='list-wrap'>";
	    sampledata = sampledata+"		<div class='span6 list-wrap-inner' style='border-bottom: 1px dashed #ddd; padding: 10px 0 10px; margin-top: 5px; margin-left: 0px; padding-left: 10px; max-width: 530px'>";
	    sampledata = sampledata+"			<div style='display: inline-block; float: left; margin-right: 10px'> ";
	    
	    if(data.fbuid == "" || data.fbuid == null){
	    	sampledata = sampledata+"			<img height='50' width='50' style='margin-top: 5px' src='./img/user.png' alt=''>";
	    }else	{
	    	sampledata = sampledata+"			<img style='margin-top: 5px' src='http://graph.facebook.com/"+data.fbuid+"/picture?width=51&amp;height=51&amp;' alt=''>";
	    }
	    sampledata = sampledata+"			</div>";
	    sampledata = sampledata+"			<div style='display: inline-block; float: left; padding: 1px 10px 2px;'>";
	    sampledata = sampledata+"				<ul class='unstyled mo'>";
	    sampledata = sampledata+"					<li class='mo f16'><b style='font-size: 16px'><i class='flag16 "+data.sccd.substring(0,2)+"' style='vertical-align: text-top; margin-right: 3px !important'></i>"+data.sccd+" <i class='icon-exchange' style='margin-right: 2px; font-size: 16px'></i> <i class='flag16 "+data.bccd.substring(0,2)+"' style='vertical-align: text-top; margin-right: 3px !important'></i>"+data.bccd+"</b></li>";
	    sampledata = sampledata+"					<li>Expires: <i class='icon-calendar' style='font-size: 13px; vertical-align: text-top'></i> "+data.trdt.substring(0,10)+" <i class='icon-time'></i> "+data.trdt.substring(11,19)+"</li>";
	    sampledata = sampledata+"					<li style='white-space: nowrap; overflow: hidden; '>";
	    sampledata = sampledata+"					<i class='icon-map-marker'></i>"; 
	    sampledata = sampledata+"					<a title='"+data.exlo+"' class=\"truncate\" href='javascript:moveMapCenter(\""+data.exlo+"\",\""+data.pseq+"\")'>"+data.exlo.substring(0,38)+"...</a>";
	    sampledata = sampledata+"	                </li>";
	    sampledata = sampledata+"				</ul>";
	    sampledata = sampledata+"	        </div>";
	    sampledata = sampledata+"	        <div id='the-post' style='display: inline-block; background: #f5f5f5; padding: 12px; float: right'>";
	    sampledata = sampledata+"	            <ul class='unstyled mo'>";
	    sampledata = sampledata+"	                <li>"+data.sccd+"</li>";
	    sampledata = sampledata+"	                <li class='mo' style='font-size: 24px; color: rgb(95, 49, 144);white-space: nowrap; overflow: hidden; max-width: 151px; min-width: 100px'><b style='font-weight: bold;cursor:hand' onClick='javascript:goBid(\""+data.pseq+"\"); return false;'>"+data.scsb+formatCurrency(data.samt)+"</b></li>";
	    sampledata = sampledata+"	            </ul>";
	    sampledata = sampledata+"	        </div>";
	    sampledata = sampledata+"	    </div>";
	    sampledata = sampledata+"	    <div class='box-section news with-icons'></div>";
	    sampledata = sampledata+"    </div>";
	    sampledata = sampledata+"</div>";
   
		
	        
	    $("#result-list").html($("#result-list").html()+sampledata);
	    
	    
	    setMarker(map, data.exlo, data.pseq);
	    
   //     resultlist_div.innerHTML = resultlist_div.innerHTML +  ;
 
	// Create page links with first and last links based upon which page we are currently on (current_page)

	// Attach event listeners to our page links
	}	
	
	function formatCurrency(total) {
	    var neg = false;
	    if(total < 0) {
	        neg = true;
	        total = Math.abs(total);
	    }
	    return  parseFloat(total, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString();
	}
	
	function updatePage(clicked_element) {
		
		
		// Get the current_page based upon the text of the selected element

		// Call php displayPage(current_page) function via Ajax to get data and load this into #content section

		// Update links on the page by calling displayLinks(current_page)
	}

	
    </script>

</head>

<!-- <body style='background: url(./img/bg.png);overflow:hidden' >
 -->
<body style='background: url(./img/bg.png)'>
  
<c:choose>
        <c:when test="${sessionScope.mobileYN == 'Y'}">
        <jsp:include page="./menuM.jsp"></jsp:include>
        </c:when>
        <c:when test="${sessionScope.mobileYN == 'N'}">
        <jsp:include page="./menu.jsp"></jsp:include>
        </c:when>
</c:choose>
        <link href="./css/jquery.ias.css" rel="stylesheet" type="text/css" />
        
        <!--abbreviates long addresses in the list results--><script>
        $(document).ready(function(){
        	
            $('#map_canvas').mouseover(function() {
                snapper.close('left');
                snapperstat = true;
            });
            $('#result-list').mouseover(function() {
                snapperstat = true;
            });
            
        });
      </script>
        <script>
            $(function(){
                $('.truncate').succinct({
                    size: 45
                });
            });
        </script>
        
        
        
        <script type="text/javascript" src="./js/jquery-ias.js"></script>

        <script type="text/javascript">
        $(function(){
                window.prettyPrint && prettyPrint();

        $('#sl2').slider();

        var RGBChange = function() {
                var fpt = r.getValue()[0];
                var ept = r.getValue()[1];
                document.searchForm.min_amt.value = fpt;
                document.searchForm.max_amt.value = ept;
        $('#RGB').text ('$' + fpt + " - " + '$' + ept);
    };

    var r = $('#sl2').slider()
            .on('slide', RGBChange)
            .data('slider');


        $(document).ready(function(){
          $('#targetbar').hover(function() {
              $('#targeto').toggleClass('active');
          });
                });
        
        $(document).ready(function(){
          $('#targetbar').hover(function() {
              $('#targeto').toggleClass('progress-striped');
          });
                });



                  

        
    });
        
        
        <%
                        int qnum = 5;   // how many listviews when a query.
                        int pnum = 2;   // page no.
                        int snum = (pnum-1)*qnum +1;    //start view no.
                        System.out.println("bccd="+request.getParameter("bccd"));
                        System.out.println("sccd="+request.getParameter("sccd"));
                        String urlparams = "";
//                      urlparams = "bccd="+java.net.URLEncoder.encode(request.getParameter("bccd"))+"&sccd="+java.net.URLEncoder.encode(request.getParameter("sccd"))+"&suid="+request.getParameter("suid");
//System.out.println("urlparams1="+urlparams);
// {exlo=, qnum=6, min_amt=0, max_amt=1000, suid=, bccd=all, initLongitute=115.7367672, sccd=all, snum=0, initLatitute=-32.5205958}
        //              urlparams = urlparams +"&snum="+snum+"&qnum="+qnum;
                        urlparams = urlparams + "&bccd=" + request.getParameter("bccd")+ "&sccd="+request.getParameter("sccd");                 
                        urlparams = urlparams + "&max_amt=" + request.getParameter("max_amt")+ "&min_amt="+request.getParameter("min_amt");
                        urlparams = urlparams + "&initLongitute="+request.getParameter("initLongitute")+"&initLatitute="+request.getParameter("initLatitute");
//System.out.println("urlparams2="+urlparams);
                //      String encodedUrl = ""
                //      if(urlparams != null){
                //              encodedUrl = java.net.URLEncoder.encode(urlparams);
                //      }
//System.out.println("encodedUrl="+encodedUrl);
                %>             
                
     /*           
        var     resultpageNo = 2;
        var hasMoreData = true;
        $(document).ready(function() {
                

        
        $('#sccd_selectbox').change(function () {
                
                if(document.searchForm.sccd.value != "" || document.searchForm.bccd.value != ""){
                        
                   var sccd_flag = document.searchForm.sccd.value.substring(0,2);
                        $('#sccd_flag').attr("class","flag "+ sccd_flag);
                }
        });  
        
        $('#bccd_selectbox').change(function () {
                if(document.searchForm.sccd.value != "" || document.searchForm.bccd.value != ""){
                        $('#bccd_flag').attr("class","flag " + document.searchForm.bccd.value.substring(0,2));
                }
        });
        
        
        jQuery.ias({
        	scrollContainer :  jQuery('.resultbox'), 
            container : '#content',
            item: '.post',
            pagination: '#content .navigation',
            next: '.next-posts a',
            loader: '<i class="icon-spinner icon-spin icon-3x"></i>',
            noneleft: true,
            triggerPageThreshold: 2,
            history: false,
            beforePageChange: 
	           	function(scrollOffset, nextPageUrl) {
	                     // pnum을 파라메타로 추가
	//                      alert('nextPageUrl='+nextPageUrl);
	            	if(hasMoreData){
	            		var qnum = 10;
	                    $(function(){
	                    	$('.truncate').succinct({
	              	          size: 45
	                        });
	                	});
	                                
	                   	var path = $('.next-posts a').attr("href");
	                    if(path.lastIndexOf("&snum") > 0 ){
	              			path = path.substring(0,path.lastIndexOf("&snum"));
	                    } 
	                    nextPageUrl = path + "&snum="+((resultpageNo-1)*qnum +1) +"&qnum="+qnum;
	                    nextPageUrl = nextPageUrl + "<%=urlparams%>";
	                    $('.next-posts a').attr("href",nextPageUrl).attr("href");
	        //        	alert("new path="+$('.next-posts a').attr("href"));
						resultpageNo = resultpageNo +1;
					}else   {
	                	return false;
	                	
					}
	            },
            onPageChange: 
            	function(pageNum, pageUrl, scrollOffset) { 
               //       alert("onPageChange");

                },
                
            onLoadItems: 
            	function(items) {
					if(items.length == 0){
                    	hasMoreData = false;
                        return false;
                    }else   {
                    	for (var i = 0; i < items.length ; i++) {
                        	// items[i].show();   
                            var pseq = "";
                            var address = "";
                            for(var j = 0; j < items[i].childElementCount ; j++){
                            	if(items[i].children[j].id == 'pseq'){
                                  	pseq = items[i].children[j].innerHTML;
									}
                            	
                            	if(items[i].children[j].id == 'address'){
									address = items[i].children[j].innerHTML;
									}
                            }
                            setMarker(map, address, pseq);
                    	}
                    }
                }
                
            });
        });
			*/
			
			
			
            // AutoComplete
            $(function(){
                
                var options = {
                  map: ".map_geocomplete",
                };
                
                $("#geocomplete_filter").geocomplete(options)
                  .bind("geocode:result", function(event, result){
        
                          var lat = result.geometry.location.lat();
                          var lng = result.geometry.location.lng();
                          
                          if(lat != ""){
                                document.searchForm.initLatitute.value = lat;
                          }else {
                                document.searchForm.initLatitute.value = "0";
                          }
                          
                          if(lng != ""){
                                  document.searchForm.initLongitute.value = lng;
                          }else {
                                  document.searchForm.initLongitute.value = "0";                          
                          }
             //           alert("lat="+lat);
             //           alert("lng="+lng);
                  })
                  .bind("geocode:error", function(event, status){
                  })
                  .bind("geocode:multiple", function(event, results){
                  }); 
        
                
              });
    </script>
    <script src="./bootstrap/js/daterangepicker.js"></script>
    <script src="./bootstrap/js/moment.min.js"></script>
    <script src="./bootstrap/js/bootstrap-slider.js"></script>
    <script src="./bootstrap/js/reportrange.js"></script></li>
    <script src="./bootstrap/js/snap.js"></script>
    <script src="./bootstrap/js/succinct.js"></script>
    <script src="./bootstrap/js/infobox.js"></script>
  <div class="snap-drawer snap-drawer-left">
     <div class="">
      
      <form name="searchForm" class="mo" action="./searchPearByPosition.fx">
          <ul class="fil mo">
            <li style="background: none !important; font-size: 24px; color: #505050; text-shadow: 1px 1px 1px #fdfdfd"><i class="icon-search icon-2x" style="vertical-align: middle"></i> Find your currency</li>
            <li><div class="text-left pad10">Exchange Location</div><input id="geocomplete_filter" name="exlo"  class="addresspicker input-xxlarge" style="box-shadow: none; vertical-align: baseline" class="filter input-xxlarge" type="text" value="${param.exlo}"></li>            
            <li class="mo">
            <div class="text-left pad10">Exchange date</div>
            <div class="filter" id="reportrange" style="text-align: left !important; height: 20px !important">
              <span >July 10, 2013 - August 8, 2013</span> <b class="caret" style="margin-top: 8px; float: right"></b>
            </div>
 <!--            <script type="text/javascript" src="../bootstrap/js/reportrange.js"></script></li> -->
            <li class="text-left">
              <div class="text-left pad10">Currency</div>
              <ul class="inline slider-track" style="position: relative;">
                I have: <ol id="bccd_flag" class="flag ${fn:substring(param.bccd,0,2)}" style="overflow: hidden; padding: 0px !important; border-bottom: none !important;"></ol>
                <li style="border-bottom: none; border-top: none; background: none !important; padding-left: 0px !important;"><select id="bccd_selectbox" name="bccd" class="input-medium bfh-currencies mo" data-currency="${param.bccd}"></select></li>
                <hr class="mo">
                I want: <ol id="sccd_flag" class="flag ${fn:substring(param.sccd,0,2)}" style="overflow: hidden; padding: 0px !important; border-bottom: none !important;"></ol>
                <li style="border-bottom: none; border-top: none; background: none !important; padding-left: 0px !important;"><select id="sccd_selectbox" name="sccd" class="input-medium bfh-currencies mo" data-currency="${param.sccd}"></select></li>
              </ul>
              
            </li>
          
          <!--             <li id="targetbar">
            <div class="text-left pad5">Amount</div>
            <div class="slider slider-horizontal">
              <input type="text" class="span3" value="" data-slider-min="0" data-slider-max="1000" data-slider-step="5" data-slider-value="[${param.min_amt},${param.max_amt}]" id="sl2" style="">
              
            </div>
            <div id="RGB" style="margin-top: 10px">$${param.min_amt} - $${param.max_amt}</div>
            
        </li>
        	-->
            <li style="border-bottom: none"><button onClick="javascript:searchPearByPosition();return false;" class="btn btn-success btn-medium" style="margin-bottom: 2px">Apply Filters</button></li>
          </ul>
          <input type="hidden" name="suid" value="${sessionScope.logininfo.id}">
          <input type="hidden" name="qnum" value="0">
          <input type="hidden" name="snum" value="0">
          <input type="hidden" name="initLongitute" value="${param.initLongitute}">
          <input type="hidden" name="initLatitute" value="${param.initLatitute}">
          <input type="hidden" name="min_amt" value="${param.min_amt}">
          <input type="hidden" name="max_amt" value="${param.max_amt}">

          </form>
      
      
        <!--<form name="searchForm" class="mo" action="./searchPearByPosition.fx">
          <ul class="fil mo">
            <li class="" style="background: none !important" align="center"><i class="icon-filter icon-2x"> </i>Filter</li>
            <li class="text-left">
              <ul class="inline slider-track" style="position: relative">
                <ol id="bccd_flag" class="flag ${fn:substring(param.bccd,0,2)}" style="overflow: hidden; padding: 0px !important; border-bottom: none !important;"></ol>
                <li style="border-bottom: none !important; background: none !important; padding-left: 0px !important;">
                  <select id="bccd_selectbox" name="bccd" class="input-medium bfh-currencies mo" data-currency="${param.bccd}"></select>
                </li>
                <hr class="mo">
                <ol id="sccd_flag" class="flag ${fn:substring(param.sccd,0,2)}" style="overflow: hidden; padding: 0px !important; border-bottom: none !important;"></ol>
                <li style="border-bottom: none !important; background: none !important; padding-left: 0px !important;">
                 <select id="sccd_selectbox" name="sccd" class="input-medium bfh-currencies mo" data-currency="${param.sccd}"></select>
                </li>
              </ul>
              
            </li>
            <li>Amount<br>
            <div class="slider slider-horizontal">
              <input type="text" class="span3" value="" data-slider-min="0" data-slider-max="1000" data-slider-step="5" data-slider-value="[${param.min_amt},${param.max_amt}]" id="sl2" style="">
              
            </div>
            <div id="RGB" style="margin-top: 5px">$${param.min_amt} - $${param.max_amt}</div>
            
        </li>
            <hr class="mo green">
            <li>Exchange Location<br>
  <!--            <input id="geocomplete" name="exlo" type="text"  class="addresspicker" placeholder="Preferred exchange location" />
            
                        <input id="geocomplete_filter" name="exlo"  class="addresspicker" style="box-shadow: none; vertical-align: baseline" class="filter input-large" type="text" value="${param.exlo}"></li>
            <li class="mo" style="padding-left: 28px !important">Exchange date
            <div class="filter" id="reportrange">
              <span>July 10, 2013 - August 8, 2013</span> <b class="caret" style="margin-top: 8px"></b>
            </div>
            </li>
            <li class="" style="background: none !important;" align="center"><button onClick="javascript:searchPearByPosition();return false;" class="btn btn-success btn-medium" style="margin-bottom: 2px">Apply Filters</button></li>
          </ul>
          <input type="hidden" name="suid" value="${sessionScope.logininfo.id}">
          <input type="hidden" name="qnum" value="6">
          <input type="hidden" name="snum" value="0">
          <input type="hidden" name="initLongitute" value="${param.initLongitute}">
          <input type="hidden" name="initLatitute" value="${param.initLatitute}">
          <input type="hidden" name="min_amt" value="${param.min_amt}">
          <input type="hidden" name="max_amt" value="${param.max_amt}">
          
          </form>-->
        </div>
    </div>
        
        
        <div id="content" class="snap-content">
          <div class="filter-bar" align="center" style="width:50px">
            <a id="open-left" style="text-decoration: none"><i class="icon-search icon-2x" style="position: absolute; top: 45%; left: 26%"></i></a>
            <script src="./bootstrap/js/demo.js"></script>
          </div>
          
          <!--sample by Jeremy
        <div class="list-cont span4 mo">
          <div class="list-wrap pad mo">
            <div class="span1 mo" style="height: 64px"><img src="../bootstrap/img/pink2.jpg"></div>
            <ul class="inline mo">
              <li class="mo" style="vertical-align: middle"><p class="flag US mo" style="margin-top: -5px !important"></p></li>
              <li class="mo"><b class="mo" style="vertical-align: top; margin-left: -15px !important">USD $1000</b></li><br>
            </ul>
            <small style="margin-left: 5px"><i class="icon-map-marker"></i> Sydney, New South Whales</small><br>
            <small style="margin-left: 5px"><i class="icon-time"></i> Expires: 28/09/2013</small>
          </div>
        </div>-->
          
 <form name="resultForm" action="" class="mo"> 
 
          <div class="span6 pull-left mo" style="border-left: 1px solid #ddd;  margin-left: 50px !important">
                        
                <!-- Search Result (Right) -->
        <c:set var="bidcheck" scope="request" value="${info.bidcheck}" />



<%
        ArrayList<BidVO> bidcheckList = (ArrayList<BidVO>)request.getAttribute("bidcheck");

        int size = bidcheckList.size();
        HashMap bchm = new HashMap();
        for(int i=0; i < size; i++){
                BidVO bidcheckvalue= bidcheckList.get(i);
                bchm.put(bidcheckvalue.getPseq(),"");
        }
%>

	<div id="content">
    	<div id="result-list" class="resultbox span6" style="overflow-y:-moz-hidden-unscrollable; height: 100%; position: absolute; margin-left: 0px !important; margin-top:-1px;border-right: 1px solid #ddd; background: #eee">
	<c:choose>
		<c:when test="${!empty info.result}">
          <c:forEach items="${info.result}" var="list" varStatus="st">
			<c:set var="exlo" scope="request" value="${list.exlo}" />
			<c:set var="pseq" scope="request" value="${list.pseq}" />
			<c:set var="csymbol" scope="request" value="${list.sccd}" />
			<c:set var="stat" scope="request" value="${list.stat}" />
			<c:set var="total_cnt" scope="request" value="${list.cnt}" />
		
	<div class="post">
     	
     	<div id="infobox${list.pseq}" class="infobox-wrapper infobox">
			<div class="popover-title" style="font-size: 24px; font-weight: bold;">
				<div style="padding: 4px">
                  <ul class="unstyled mo">
                     <li style="font-size: 24px">${list.sccd}  count</li>
                     <li class="mo" style="font-size: 44px; line-height: 35px; white-space: nowrap; overflow: hidden; min-width: 100px; margin: 0px -1px !important">
						<b style="vertical-align: middle; font-weight: bold"><%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %><fmt:formatNumber value="${list.samt}" pattern=""/></b>
						<button onClick="javascript:goBid('${list.pseq}'); return false;" style="vertical-align: middle" class="btn btn-info btn-large">View</button>
					 </li>
                  </ul>
                </div>
			</div>
			<div class="popover-content" style="display: inline-block">
				<div style="display: inline-block; float: left; margin-right: 10px">
					<c:choose>
                    <c:when test="${!empty list.fbuid}">
                      <img style="margin-top: 6px" src="http://graph.facebook.com/${list.fbuid}/picture?width=33&amp;height=33&amp;" alt="">
                    </c:when>
                    <c:otherwise>
                      <img height="33" width="33" style="margin-top: 6px" src="./img/user.png" alt="">
                    </c:otherwise>
                  </c:choose>
				</div>
                 
				<div style="display: inline-block; float: left; margin-top: 1px">
                  <ul class="unstyled mo">
                    <li class="mo f16"><b style="font-size: 16px"><i class="flag16 ${fn:substring(list.sccd,0,2)}" style="vertical-align: text-top; margin-right: 3px !important; margin-top: 3px"></i>${list.sccd} <i class="icon-exchange" style="margin-right: 2px; font-size: 16px; margin-top: 3px"></i> <i class="flag16 ${fn:substring(list.bccd,0,2)}" style="vertical-align: text-top; margin-right: 3px !important; margin-top: 3px"></i>${list.bccd}</b></li>
                    <li>Expires: <i class="icon-calendar"></i> ${fn:substring(list.trdt,0,10)} <i class="icon-time"></i> ${fn:substring(list.trdt,10,19)}</li>
                  </ul>
                </div>
			</div>
   		</div>
        <div id="pseq" style="display:none;">${list.pseq}</div>
        <div id="address" style="display:none;">${list.exlo}</div>
        <div class="list-wrap">
        
		 	<div class="span6 list-wrap-inner" style="border-bottom: 1px dashed #ddd; padding: 10px 0 10px; margin-top: 10px; margin-left: 0px; padding-left: 10px; max-width: 530px">
		        <div style="display: inline-block; float: left; margin-right: 10px"> 
		        <c:choose>
		        	<c:when test="${!empty list.fbuid}">
		                <img style="margin-top: 5px" src="http://graph.facebook.com/${list.fbuid}/picture?width=51&amp;height=51&amp;" alt="">
		        	</c:when>
		        	<c:otherwise>
		        		<img height="50" width="50" style="margin-top: 5px" src="./img/user.png" alt="">
		        	</c:otherwise>
				</c:choose>
		        </div>
				<div style="display: inline-block; float: left; padding: 1px 10px 2px;">
		        	<ul class="unstyled mo">
		            	<li class="mo f16"><b style="font-size: 16px"><i class="flag16 ${fn:substring(list.sccd,0,2)}" style="vertical-align: text-top; margin-right: 3px !important"></i>${list.sccd} <i class="icon-exchange" style="margin-right: 2px; font-size: 16px"></i> <i class="flag16 ${fn:substring(list.bccd,0,2)}" style="vertical-align: text-top; margin-right: 3px !important"></i>${list.bccd}</b></li>
		                <li>Expires: <i class="icon-calendar" style="font-size: 13px; vertical-align: text-top"></i> ${fn:substring(list.trdt,0,10)} <i class="icon-time"></i> ${fn:substring(list.trdt,10,19)}</li>
		                <li style="white-space: nowrap; overflow: hidden; ">
		                <i class="icon-map-marker"></i> 
		                <a title="${list.exlo}" class="truncate" href="javascript:moveMapCenter('${list.exlo}','${list.pseq}')">${list.exlo}</a>
		                </li>
					</ul>
		        </div>
		        <div id="the-post" style="display: inline-block; background: #f5f5f5; padding: 12px; float: right">
		            <ul class="unstyled mo">
		                <li>${list.sccd}</li>
		                <li class="mo" style="font-size: 24px; color: rgb(95, 49, 144);white-space: nowrap; overflow: hidden; max-width: 151px; min-width: 100px"><b style="font-weight: bold;cursor:hand"  onClick="javascript:goBid('${list.pseq}'); return false;"><%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %><fmt:formatNumber value="${list.samt}" pattern=""/></b></li>
		            </ul>
		        </div>
		    </div>
		    <div class="box-section news with-icons"></div>
        </div>
	</div>
        <input type="hidden" name="exlo_map" value="${list.exlo}">
        <input type="hidden" name="info_msg_${list.pseq}" value="<img class='img-rounded' src='http://graph.facebook.com/${list.fbuid}/picture?width=33&height=33&'><font color='blue'><B>${list.fname} ${list.lname}</B></font> wants to trade <font color='red'><B>${list.sccd} <%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %> ${list.samt}</B></font><br>until ${list.trdt} near <font color='brown'><B>${list.exlo}</B></font>">
        </c:forEach>
        </c:when>
        <c:otherwise>
    	    <script>
        	    alert('No data!');
        	</script>
  	    </c:otherwise>
        </c:choose>
      </div>
      <div class="navigation">
 	     <ul>
           <li>1</li>
           <li class="next-posts"><a href="./searchPearByPosition.fx?">2</a></li>
         </ul>
      </div>
	</div>


       <!-- Result list -->

    </div>
    </form>
    
    
       <!-- Paging  START -->
       
                
   <%
	int totalPage = (Integer)request.getAttribute("total_cnt");
	int pageBlock = Integer.parseInt(request.getParameter("qnum"));

	int lastBlock = 0;
		if(totalPage%pageBlock !=0){
			lastBlock = totalPage/pageBlock +1;
		}else	{
			lastBlock = totalPage/pageBlock;
		}

%>

<script type="text/javascript" src="./jquery/js/jquery.paginate.js"></script>
<script type="text/javascript">
		$(function() {
			$("#pagediv").paginate({
				count 		: <%=lastBlock%>,
				start 		: 1,
				display     : 3,
				border					: false,
				text_color  			: '#888',
				background_color    	: '#EEE',	
				text_hover_color  		: 'black',
				background_hover_color	: '#CFCFCF',
				mouse					: 'press',
				onChange     			: function(page){
											displayLinks(page);
										  }
			});

		});
		</script>        

	   <!-- Paging  END -->  
  
     <div class="mo pull-left">
    
	    <!-- Google Map (left) -->
	    <div class="box-content scrollable" style="height: 100%; position: absolute; overflow-y: auto; margin-left: -0px !important; border-right: 1px solid #b9b9b9; right: 0; left: 592px">
	    	<i style="position: absolute; left: 45%; top: 45%" class="icon-spinner icon-spin icon-4x"></i>
	        <div id="map_canvas" style="height: 100%"></div>
	    </div>
	    <!-- Google Map (left) -->

	</div>
    <script type="text/javascript">
    
 		var snapper = new Snap({
        	element: document.getElementById('content'),
            disable: 'right'
		});
 	
 		
   </script>


<!-- 
        <script type="text/javascript">
         function goFaceBook(msg,url) {
             var w = (screen.width-1000)/2;
             var h = (screen.height-600)/2;
             var href = "http://www.facebook.com/sharer.php?s=100&p[url]=" + encodeURIComponent(url) + "&p[title]=" + encodeURIComponent(msg);
             var a = window.open(href, 'facebook', 'width=1000,height=600,left='+w+',top='+h+',scrollbars=0');
             if(a) { a.focus(); }
         }
         
 </script>

        <a
                href="javascript:facebook_send_message('Elvin Kang', '100006166420999','Someone bid your post in CurrencyPear.com','www.currencypear.com')">페이스북
                MSG 보내기</a>
        <a href="javascript:goFaceBook('currencypear share', location.href)">페이스북
                보내기</a>
        <a href="javascript:setInfoWindow()">setinfo</a>
        <a href="javascript:appendView()">appendView</a>

        facebook_send_message(name, to,description,link)
-->     
        		<div id="pagediv" style="position:absolute ;top:91%; margin-left:15%;  max-width:250px; z-index:99"></div>
        
        
        <form name="geoinfo">
                <input type="hidden" name="latitude">
                <input type="hidden" name="longitude">
        </form>
        
    <jsp:include page="./js_include.jsp"></jsp:include>         
</body>

</html>



