<%@ page session="true" language="java"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<title>Sign in &middot; Twitter Bootstrap</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">


<!-- Face book Open Graph Meta -->
<!-- 
 	<meta property="og:audio" content="http://example.com/bond/theme.mp3" />
	<meta property="og:description" 
	  content="Sean Connery found fame and fortune as the
	           suave, sophisticated British agent, James Bond." />
	<meta property="og:determiner" content="the" />
	<meta property="og:locale" content="en_GB" />
	<meta property="og:locale:alternate" content="fr_FR" />
	<meta property="og:locale:alternate" content="es_ES" />
	<meta property="og:site_name" content="IMDb" />
	<meta property="og:video" content="http://example.com/bond/trailer.swf" />
-->

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="./js/html5shiv.js"></script>
    <![endif]-->



    <link href="./bootstrap3/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./bootstrap3/css/font-awesome.css" rel="stylesheet">
    <link href="./bootstrap3/css/style.css" rel="stylesheet">
    <link href="./bootstrap3/css/flags16.css" rel="stylesheet">
    <link href="./bootstrap3/css/slider.css" rel="stylesheet">
    
<style type="text/css">
    
    body {
        padding-top: 50px;
    }
    
#map_canvas {
	margin: 0;
	padding: 0;
	height: 100%;
        box-shadow: 0px 0px 10px 1px #6F6F6F;
}
.gmnoprint img { max-width: none; }
</style>
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false&amp;libraries=places"
	type="text/javascript"></script>
<script type="text/javascript">

var geocoder = new google.maps.Geocoder();
var map;
var marker = [];
var infowindow ;
var infobox ;
var initialLocation;
var siberia = new google.maps.LatLng(60, 105);
var newyork = new google.maps.LatLng(40.69847032728747, -73.9514422416687);
var browserSupportFlag =  new Boolean();

var locations  = [
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


function sleep(msecs) 
{
    var start = new Date().getTime();
    var cur = start;
    while (cur - start < msecs) 
    {
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
	
	setMarkers(map,locations);
	
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
  
}
  


function setMarkers(map,locations) {
	   var i = 0;
	   for (i = 0; i < locations.length -1; i++) {
	      setMarker(map, locations[i][1], locations[i][0]);
	   }

	}

//function setMarker(map, locations) {     
function setMarker(map, address, description) {     

//	alert('setMarker address='+address);
  	  	geocoder = new google.maps.Geocoder();
		geocoder.geocode( { 'address': address }, function(results, status) {
	        if (status == google.maps.GeocoderStatus.OK) {
	       //     map.setCenter(results[0].geometry.location);

	            var marker = new google.maps.Marker({
	                position: results[0].geometry.location,
	                map: map,
	                html: description
	            });
                      
                    var infobox = new InfoBox({
                        content: document.getElementById("infobox" + description),
                        disableAutoPan: false,
                        pixelOffset: new google.maps.Size(-220, 0),
                        zIndex: null,
                        closeBoxMargin: "4px 4px 4px 4px",
                        closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif",
                        infoBoxClearance: new google.maps.Size(1, 1)
                    });

	    //        google.maps.event.addListener(marker, "click", function () {
	      //          infowindow.setContent(description);
	        //        infowindow.open(map, this);
	          //  });
                    
                    google.maps.event.addListener(marker, 'click', function() {
                        infobox.open(map, this);
                        map.panTo(loc);
                    });
            
	        }else {
	         //   alert("Geocode was not successful for the following reason: " + status);
	        }
	    });  
	}



function moveMapCenter(address,pseq){
	  geocoder.geocode( { 'address': address}, function(results, status) {
		    if (status == google.maps.GeocoderStatus.OK) {
		      map.setZoom(15);
		      map.setCenter(results[0].geometry.location);
	//	      var description = eval("document.resultForm.info_msg_"+pseq+".value");
		   //   var description = pseq;
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
        	
       	}else	{
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
   // 		alert(data);

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
    
    
    $('.searchForm')
		  var txtiwant = $('#Iwant');
		  var txtihave = $('#Ihave');
		  txtiwant.val("" + txtiwant.val().substring(0,3));
		  txtihave.val("" + txtihave.val().substring(0,3));
		;
    

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
		document.searchForm.action = "./searchPearByPosition.fx";
		searchForm.submit();
	
  
} 	

    </script>

</head>

<!-- <body style='background: url(./img/bg.png);overflow:hidden' >
 -->
<body>
    
    
  
<c:choose>
	<c:when test="${sessionScope.mobileYN == 'Y'}">
	<jsp:include page="./menuM.jsp"></jsp:include>
	</c:when>
	<c:when test="${sessionScope.mobileYN == 'N'}">
	<jsp:include page="./menu.jsp"></jsp:include>
	</c:when>
</c:choose>
	<link href="./css/jquery.ias.css" rel="stylesheet" type="text/css" />
        
        <!--abbreviates long addresses in the list results-->
        <script>
            $(function(){
                $('.truncate').succinct({
                    size: 40
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
			int qnum = 5;	// how many listviews when a query.
			int pnum = 2;	// page no.
			int snum = (pnum-1)*qnum +1;	//start view no.
			System.out.println("bccd="+request.getParameter("bccd"));
			System.out.println("sccd="+request.getParameter("sccd"));
			String urlparams = "";
//			urlparams = "bccd="+java.net.URLEncoder.encode(request.getParameter("bccd"))+"&sccd="+java.net.URLEncoder.encode(request.getParameter("sccd"))+"&suid="+request.getParameter("suid");
//System.out.println("urlparams1="+urlparams);
// {exlo=, qnum=6, min_amt=0, max_amt=1000, suid=, bccd=all, initLongitute=115.7367672, sccd=all, snum=0, initLatitute=-32.5205958}
	//		urlparams = urlparams +"&snum="+snum+"&qnum="+qnum;
			urlparams = urlparams + "&bccd=" + request.getParameter("bccd")+ "&sccd="+request.getParameter("sccd");			
			urlparams = urlparams + "&max_amt=" + request.getParameter("max_amt")+ "&min_amt="+request.getParameter("min_amt");
			urlparams = urlparams + "&initLongitute="+request.getParameter("initLongitute")+"&initLatitute="+request.getParameter("initLatitute");
//System.out.println("urlparams2="+urlparams);
		//	String encodedUrl = ""
		//	if(urlparams != null){
		//		encodedUrl = java.net.URLEncoder.encode(urlparams);
		//	}
//System.out.println("encodedUrl="+encodedUrl);
		%>		      

	var	resultpageNo = 2;
	var hasMoreData = true;
	$(document).ready(function() {
        snapper.open('left');
        
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
	        loader: '<img src="./img/loader.gif"/>',
	        noneleft: true,
	        triggerPageThreshold: 2,
	        history: false,
	        beforePageChange: function(scrollOffset, nextPageUrl) {
	        	// pnum을 파라메타로 추가
//	        	alert('nextPageUrl='+nextPageUrl);
	        	if(hasMoreData){
	        		var qnum = 5;
		        	
		        	var path = $('.next-posts a').attr("href");
		        	if(path.lastIndexOf("&snum") > 0 ){
		        		path = path.substring(0,path.lastIndexOf("&snum"));
		        	} 
		        	nextPageUrl = path + "&snum="+((resultpageNo-1)*qnum +1) +"&qnum="+qnum;
		        	nextPageUrl = nextPageUrl + "<%=urlparams%>";
		        	$('.next-posts a').attr("href",nextPageUrl).attr("href");
	//	 	      	alert("new path="+$('.next-posts a').attr("href"));
		        	resultpageNo = resultpageNo +1;

				}else	{
		            return false;
				}
	    
	        },
	        onPageChange: function(pageNum, pageUrl, scrollOffset) { 
	       // 	alert("onPageChange");

	        },
	        onLoadItems: function(items) {
	        	
	        //	alert(items.length + " = items.length")
	        //	alert($('.post').length);
	        	if(items.length == 0){
	        		alert('No More Data');
	        		hasMoreData = false;
	        		return false;
	        	}else	{
	        		
	        	   var i = 0;
	        	   for (i = 0; i < items.length ; i++) {
	        		  // items[i].show();   
  
	        		   alert(items[i].nodeName + "::" + items[i].nodeValue);						
	        	//	   alert(items[i].childNodes[1].nodeName + "::" + items[i].childNodes[1].nodeValue);						
	        	//	   alert(items[i].getElementByID('pseq').nodeValue);						
	 				 //alert(items[i].show());

	        //	     setMarker(map, items[i].name, $(items[i] > '#address'));
	        	   }

	        	}
	        }
	        
	    });
	});

              // AutoComplete
            $(function(){
                
                var options = {
                  map: ".map_geocomplete",
                };
                
                $(".geocomplete_filter").geocomplete(options)
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
    
         <form name="searchForm" class="form-horizontal" role="form" action="./searchPearByPosition.fx">               
    <!-- Modal Filter -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Filter</h4>
            </div>
            <div class="modal-body" style="background: #eee">
                
            <div style="max-width: 770px; max-height: 360px; overflow: scroll; margin: 0 auto; text-align: center; padding: 10px">
		
                    <div class="panel panel-default mb0">
                        <div class="panel-heading">
                            <h1 class="m0" style="font-size: 80px"><i class="icon-money"></i></h1>
                          <h3 class="m0 panel-title">What currency do you have?</h3>
                        </div>
                        <div class="panel-body">
                          <div class="row" style="padding: 0">
                              <input value="${param.bccd}" name="bccd" id="Ihave" class="currencycode form-control vertical typeahead tt-query" type="text" placeholder="e.g. USD" autocomplete="off" spellcheck="false" style="position: relative; vertical-align: top; background-color: transparent; margin-bottom: 10px">
                        </div>
                        </div>
                    </div>
                    <div class="panel panel-default" style="margin-top: -1px">
                        <div class="panel-heading">
                          <h3 class="panel-title">What currency do you want?</h3>
                        </div>
                        <div class="panel-body">
                          <div class="row" style="padding: 0">
                              <input value="${param.sccd}" name="sccd" id="Iwant" class="currencycode form-control vertical typeahead tt-query" type="text" placeholder="e.g. GBP" autocomplete="off" spellcheck="false" style="position: relative; vertical-align: top; background-color: transparent; margin-bottom: 10px">
                        </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h1 class="m0" style="font-size: 80px"><i class="icon-usd"></i></h1>
                          <h3 class="panel-title">How much currency do you want?</h3>
                        </div>
                        <div class="panel-body">
                            <div onmousedown="return false" class="slider slider-horizontal">
                                <input type="text" data-slider-min="0" data-slider-max="1000" data-slider-step="5" data-slider-value="[${param.min_amt},${param.max_amt}]" id="sl3">
                            </div>
                            <div id="RGB"><h2>$${param.min_amt} - $${param.max_amt}</h2></div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h1 class="m0" style="font-size: 80px"><i class="icon-map-marker"></i></h1>
                          <h3 class="panel-title">Where do you want to look?</h3>
                        </div>
                        <div class="panel-body">
                          <div class="row" style="padding: 0">
                              <input name="exlo" placeholder="location"  class="geocomplete_filter addresspicker" style="box-shadow: none; vertical-align: baseline" class="filter input-large" type="text" value="${param.exlo}">
                          </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h1 class="m0" style="font-size: 80px"><i class="icon-time"></i></h1>
                          <h3 class="panel-title">When do you want to exchange?</h3>
                        </div>
                        <div class="panel-body">
                          <div class="row twitter-typeahead" style="padding: 0">
                              <input class="form-control vertical typeahead tt-query" type="text" placeholder="e.g. Sydney, Australia" autocomplete="off" spellcheck="false" style="position: relative; vertical-align: top; background-color: transparent; margin: 0 auto">
                        </div>
                        </div>
                        <button onClick="javascript:searchPearByPosition(); return false;" type="button" class="btn btn-primary">Update results</button> 
                    </div>
          </div>
          <input type="hidden" name="suid" value="${sessionScope.logininfo.id}">
          <input type="hidden" name="qnum" value="6">
          <input type="hidden" name="snum" value="0">
          <input id="inlong" type="hidden" name="initLongitute" value="${param.initLongitute}">
          <input id="inlat" type="hidden" name="initLatitute" value="${param.initLatitute}">
          <input type="hidden" name="min_amt" value="${param.min_amt}">
          <input type="hidden" name="max_amt" value="${param.max_amt}">
               
        </div><!-- /.modal-content -->
            <div class="modal-footer m0">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button onClick="javascript:searchPearByPosition();return false;" type="button" class="btn btn-primary">Update results</button>
          </div>
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    </div>
                   </form>  
     

    <div class="row" style="height: 100%; margin: 0">
                    <div id="results" class="col-xs-5 resultbox" style="height: 100%; padding: 75px 10px; background: #f5f5f5; overflow-y: scroll; border-right: 1px solid #ddd">
<!-- Filter bar -->
                <div style="position: fixed; top: 50px; background: #f5f5f5; border-bottom: 10px solid #f5f5f5; min-width: 513px; padding: 10px 0 0">
                    <button class="btn btn-lg btn-primary btn-block" data-toggle="modal" href="#myModal">Filter</button>
                </div>
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
	<form name="resultForm" action="">
    <div id="content">
    
    							<c:choose>
                                                          
								<c:when test="${!empty info.result}">
									<c:forEach items="${info.result}" var="list" varStatus="st">
										<c:set var="exlo" scope="request" value="${list.exlo}" />
										<c:set var="pseq" scope="request" value="${list.pseq}" />
										<c:set var="csymbol" scope="request" value="${list.sccd}" />
										<c:set var="stat" scope="request" value="${list.stat}" />
            <div id="pseq" style="display:none;">${list.pseq}</div>
						<div id="address" style="display:none;">${list.exlo}</div>
            							            
								          			<c:choose>
														<c:when test="${list.stat == 0}">
															<span class="label label-info">Closed</span>
														</c:when>
														<c:when test="${list.stat == 2}">
															<span class="label label-info">Suspended</span>
														</c:when>
													</c:choose>
												<%
													Integer pseq = (Integer)request.getAttribute("pseq");
													Integer stat = (Integer)request.getAttribute("stat");
												  
												  		String disabledBid = "";
												  		
												  		if(bchm.containsKey(pseq) || stat != 1 || session.getAttribute("logininfo") == null){
												  		  disabledBid = "disabled";
												  		}
												  %>													
													<c:choose>
														<c:when test="${sessionScope.logininfo.id != list.suid}">
															<button <%=disabledBid %> class="btn btn-primary"
																onClick="javascript:goBid('${list.pseq}'); return false;" style="position: absolute; right: 20px">
																Pear up
															</button>
														</c:when>
													</c:choose>

                <div id="post" class="panel panel-default" style="overflow: hidden; white-space: nowrap; min-width: 513px">
                    <div class="panel-body">
                        <div class="media">
                          <a class="pull-left" href="#" style="line-height: 71px">
                            <c:choose>
														<c:when test="${!empty list.fbuid}">
															<img 
																src="http://graph.facebook.com/${list.fbuid}/picture?width=33&amp;height=33&amp;"
																alt="">
														</c:when>
														<c:otherwise>
															<img height="33" width="33" class="img-rounded"
																src="./img/user.png" alt="">
														</c:otherwise>
													</c:choose>	
                          </a>
                          <button type="button" class="pull-right btn btn-money btn-default"><h1 class="m0"><b>$700,000.00</b></h1></button>
                          <div class="media-body" style="margin-top: 5px">
                            <ul class="list-unstyled" style="margin-bottom: 0">
                                <li class="mo f16"><b style="font-size: 16px"><i class="flag16 ${fn:substring(list.sccd,0,2)}" style="vertical-align: text-top; margin-right: 3px !important"></i>${list.sccd} <i class="icon-exchange" style="margin-right: 2px; font-size: 16px"></i> <i class="flag16 ${fn:substring(list.bccd,0,2)}" style="vertical-align: text-top; margin-right: 3px !important"></i>${list.bccd}</b></li>
                                                                                    <li>Expires: <i class="icon-calendar" style="font-size: 13px; vertical-align: text-top"></i> ${fn:substring(list.trdt,0,10)} <i class="icon-time"></i> ${fn:substring(list.trdt,10,19)}</li>
                                                                                    <li style="white-space: nowrap; overflow: hidden; "><i class="icon-map-marker"></i> <a title="${list.exlo}" class="truncate" href="javascript:moveMapCenter('${list.exlo}','${list.pseq}')">${list.exlo}</a></li>
                            </ul>
                          </div>
                        </div>
                    </div>
                </div>
                <hr class="hrmain">
                                                                                <input type="hidden" name="exlo_map" value="${list.exlo}">
                                                                                <input type="hidden" name="info_msg_${list.pseq}" value="<img class='img-rounded' src='http://graph.facebook.com/${list.fbuid}/picture?width=33&height=33&'><font color='blue'><B>${list.fname} ${list.lname}</B></font> wants to trade <font color='red'><B>${list.sccd} <%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %> ${list.samt}</B></font><br>until ${list.trdt} near <font color='brown'><B>${list.exlo}</B></font>">
                                  </c:forEach>
                </c:when>
                  </c:choose>
            </div>
                   </form> </div>
  
  
              <div class=col-xs-7 style="height: 100%; padding: 0">
                <div id="map_canvas"></div>
            </div>
    </div>
    
	<script type="text/javascript">
	 function goFaceBook(msg,url) {
	     var w = (screen.width-1000)/2;
	     var h = (screen.height-600)/2;
	     var href = "http://www.facebook.com/sharer.php?s=100&p[url]=" + encodeURIComponent(url) + "&p[title]=" + encodeURIComponent(msg);
	     var a = window.open(href, 'facebook', 'width=1000,height=600,left='+w+',top='+h+',scrollbars=0');
	     if(a) { a.focus(); }
	 }
	 
 </script>
<!--
	<a
		href="javascript:facebook_send_message('Elvin Kang', '100006166420999','Someone bid your post in CurrencyPear.com','www.currencypear.com')">페이스북
		MSG 보내기</a>
	<a href="javascript:goFaceBook('currencypear share', location.href)">페이스북
		보내기</a>
	<a href="javascript:setInfoWindow()">setinfo</a>
	<a href="javascript:appendView()">appendView</a>

	facebook_send_message(name, to,description,link)-->
	<form name="geoinfo">
		<input type="hidden" name="latitude">
		<input type="hidden" name="longitude">
	</form>
	    <script src="./bootstrap3/js/jquery.js"></script>
    <script src="./bootstrap3/js/bootstrap.js"></script>
    <script src="./bootstrap3/js/slider.js"></script>
    <script src="./js/jquery.geocomplete.js"></script> 
    <script src="./bootstrap3/js/twitter-typeahead.js"></script>
    <script>
        jQuery (function() {
        $('.currencycode').typeahead({                                
            name: 'mycodes',                                                          
            prefetch: '../bootstrap3/codes.json',
            limit: 10                                                                  
          });
        });
    </script>
    <script type="text/javascript">
		$(function(){
                    
    	$('#sl3').slider();

    	var RGBChange = function() {
   	  	var fpt = r.getValue()[0];
   		var ept = r.getValue()[1];
   		document.searchForm.min_amt.value = fpt;
   		document.searchForm.max_amt.value = ept;
      	$('#RGB').text ('$' + fpt + " - " + '$' + ept);
    };

    var r = $('#sl3').slider()
            .on('slide', RGBChange)
            .data('slider');

    });
    </script>
        <script>
      $(function() {
      // Fix input element click problem
      $('.dropdown-toggle input').click(function(e) {
	e.stopPropagation();
      });
    });
    </script>
        
</body>


</html>


