<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.bluespak.vo.PearVO" %>
<%@ page import="com.bluespak.vo.BidVO" %>
<%@ page import="com.bluespak.utils.cd.NationCode" %>
<%@ page import="com.bluespak.utils.cd.CityCode" %>
<%@ page import="com.bluespak.utils.cd.CurrencyCode" %>
<%@ page import="com.bluespak.utils.cd.CurrencySymbol" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Bootstrap, from Twitter</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Le styles -->
    <link href="./bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="./bootstrap/css/style.css" rel="stylesheet">
    <link href="./bootstrap/css/flags32.css" rel="stylesheet">  
    <link href="./bootstrap/css/font-awesome.css" rel="stylesheet">
    <link href="./bootstrap/css/bootstrap-formhelpers.css" rel="stylesheet">
    <link href="./bootstrap/css/bootstrap-formhelpers-currencies.flags.css" rel="stylesheet">


    <script src="./bootstrap/js/jquery.js"></script>

<!--     
    <link href="./bootstrap/css/daterangepicker.css" rel="stylesheet">
    <link href="./bootstrap/css/slider.css" rel="stylesheet">
    <link href="./bootstrap/css/snap.css" rel="stylesheet">
    <link href="./bootstrap/css/demo.css" rel="stylesheet">
    <link href="./bootstrap/css/MyFontsWebfontsKit.css" rel="stylesheet">
    <script src="./bootstrap/js/bootstrap-slider.js"></script>
    <script src="./bootstrap/js/moment.min.js"></script>
    <script src="./bootstrap/js/daterangepicker.js"></script>
 -->   
    
    <style type="text/css">
      body {
        margin-top: 40px;
        background: url(./bootstrap/img/bgg.png);
        overflow: scroll;
      }
      
      .gmnoprint img { max-width: none; }
    </style>
    
    <style>
      html, body, #map_canvas {
        margin: 0;
        padding: 0;
        height: 100%;
      }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script>
      
    function getmydata(pseq){
	alert("getmydata");
	jQuery.ajax({
	    type: "GET",
	    url: "./summary.fx?cuid=me&whoc=S&pseq="+pseq,
	    data: "pseq="+pseq,
	    success: function(data) {
	    	alert("it works!.").sessionScope.logininfo.id;
   // 		alert(data);

	   },
	   error: function (xhr, ajaxOptions, thrownError) {
	        alert(xhr.status);
	       alert(thrownError);
	   }
	});
}
 


    function setMarker() {
    	var address = '${info.detailinfo.exlo}';
    	var pseq = '${info.detailinfo.pseq}';
        var mapOptions = {
                zoom: 12,
                mapTypeId: google.maps.MapTypeId.ROADMAP
              };
        var map = new google.maps.Map(document.getElementById('map_canvas'),
                  mapOptions);
              
      	    var geocoder = new google.maps.Geocoder();
      	    
    		geocoder.geocode( { 'address': address }, function(results, status) {
    	        if (status == google.maps.GeocoderStatus.OK) {
    	            map.setCenter(results[0].geometry.location);

    	            var marker = new google.maps.Marker({
    	                position: results[0].geometry.location,
    	                map: map,
    	                html: pseq
    	            });
                          
                        var infobox = new InfoBox({
                            content: document.getElementById("infobox" + pseq),
                            disableAutoPan: false,
                            pixelOffset: new google.maps.Size(-220, 0),
                            zIndex: null,
                            closeBoxMargin: "4px 4px 4px 4px",
                            closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif",
                            infoBoxClearance: new google.maps.Size(1, 1)
                        });
					/*
    	            google.maps.event.addListener(marker, "click", function () {
    	              infowindow.setContent(description);
    	              infowindow.open(map, this);
    	            });
                        
					*/
                        google.maps.event.addListener(marker, 'click', function() {
                        	
                        	alert(marker);
                            infobox.open(map, this);
                       //     map.panTo(loc);
                        });
                
    	        }else {
    	         //   alert("Geocode was not successful for the following reason: " + status);
    	        }
    	    });  
    	}



    
    google.maps.event.addDomListener(window, 'load', setMarker);
    
        </script>
    
    <script type="text/javascript">
      /*
 * jQuery autoResize (textarea auto-resizer)
 * @copyright James Padolsey http://james.padolsey.com
 * @version 1.04
 */
 
(function($){
 
    $.fn.autoResize = function(options) {
 
        // Just some abstracted details,
        // to make plugin users happy:
        var settings = $.extend({
            onResize : function(){},
            animate : true,
            animateDuration : 3000,
            animateCallback : function(){},
            extraSpace : 20,
            limit: 1000
        }, options);
 
        // Only textarea's auto-resize:
        this.filter('textarea').each(function(){
 
                // Get rid of scrollbars and disable WebKit resizing:
            var textarea = $(this).css({resize:'none','overflow-y':'hidden'}),
 
                // Cache original height, for use later:
                origHeight = textarea.height(),
 
                // Need clone of textarea, hidden off screen:
                clone = (function(){
 
                    // Properties which may effect space taken up by chracters:
                    var props = ['height','width','lineHeight','textDecoration','letterSpacing'],
                        propOb = {};
 
                    // Create object of styles to apply:
                    $.each(props, function(i, prop){
                        propOb[prop] = textarea.css(prop);
                    });
 
                    // Clone the actual textarea removing unique properties
                    // and insert before original textarea:
                    return textarea.clone().removeAttr('id').removeAttr('name').css({
                        position: 'absolute',
                        top: 0,
                        left: -9999
                    }).css(propOb).attr('tabIndex','-1').insertBefore(textarea);
 
                })(),
                lastScrollTop = null,
                updateSize = function() {
 
                    // Prepare the clone:
                    clone.height(0).val($(this).val()).scrollTop(10000);
 
                    // Find the height of text:
                    var scrollTop = Math.max(clone.scrollTop(), origHeight) + settings.extraSpace,
                        toChange = $(this).add(clone);
 
                    // Don't do anything if scrollTip hasen't changed:
                    if (lastScrollTop === scrollTop) { return; }
                    lastScrollTop = scrollTop;
 
                    // Check for limit:
                    if ( scrollTop >= settings.limit ) {
                        $(this).css('overflow-y','');
                        return;
                    }
                    // Fire off callback:
                    settings.onResize.call(this);
 
                    // Either animate or directly apply height:
                    settings.animate && textarea.css('display') === 'block' ?
                        toChange.stop().animate({height:scrollTop}, settings.animateDuration, settings.animateCallback)
                        : toChange.height(scrollTop);
                };
 
            // Bind namespaced handlers to appropriate events:
            textarea
                .unbind('.dynSiz')
                .bind('keyup.dynSiz', updateSize)
                .bind('keydown.dynSiz', updateSize)
                .bind('change.dynSiz', updateSize);
 
        });
 
        // Chain:
        return this;
 
    };
 
 
 
})(jQuery);
 
 $(document).ready(function() {
     
 	jQuery.ajax({
 	    type: "GET",
 	    url: "./currencyinfo.fx",
 	    dataType: "json",
 	    contentType: "application/json; charset=utf-8",
 	    data: "from=${info.detailinfo.sccd}&to=${info.detailinfo.bccd}",
 	    success: function(data) {
     		
 	    	var srate = data.query.results.rate.Rate;
 	    	var mrate = 1 ;
    	    	if(srate < 0.5 && srate > 0.1){
 	    		mrate = 10;    	    		
    	    	}else if(srate < 0.1 && srate > 0.01){
     	    		mrate = 100;    	    		
 	    	}else if(srate < 0.01){
 	    		mrate = 1000; 	    		
 	    	}

 	    	
 	    	var s_Rate_div = document.getElementById('s_Rate');
 	    	s_Rate_div.innerHTML = s_Rate_div.innerHTML + 1 * mrate ;

 	    	var b_Rate_div = document.getElementById('b_Rate');
 	    	b_Rate_div.innerHTML = b_Rate_div.innerHTML + currencyFormat(Math.round(data.query.results.rate.Rate * mrate * 10000)/10000) ;
 	    	var Ask_div = document.getElementById('Ask');
 	    	Ask_div.innerHTML = Ask_div.innerHTML + currencyFormat(Math.round( data.query.results.rate.Ask * mrate * 10000)/10000) ;
 	    	var Bid_div = document.getElementById('Bid');
 	    	Bid_div.innerHTML = Bid_div.innerHTML + currencyFormat(Math.round( data.query.results.rate.Bid * mrate * 10000)/10000) ;
 	    	var bamt_div = document.getElementById('bamt');
 	    	var bamt = data.query.results.rate.Rate * ${info.detailinfo.samt} * 10000;
 	    	bamt_div.innerHTML = bamt_div.innerHTML + currencyFormat(Math.round( data.query.results.rate.Rate * ${info.detailinfo.samt} * 10000)/10000);
 	    	var date_div = document.getElementById('date');
 	    	date_div.innerHTML = date_div.innerHTML + data.query.results.rate.Date;
 	    	var time_div = document.getElementById('time');
 	    	time_div.innerHTML = time_div.innerHTML + data.query.results.rate.Time;
 	    	
 	   },
 	   error: function (xhr, ajaxOptions, thrownError) {
 	        alert(xhr.status);
 	       alert(thrownError);
 	   }
 	});
 	
 	
 });
 
 
 
 
 function sendDiscuss(){
		if(checkValid_sendDiscuss()){
			document.discussForm.method = "POST";
			document.discussForm.action = "./upDiscuss.fx";
			document.discussForm.submit();
		}   	 
	}
  

	function checkValid_sendDiscuss(){
			
		var ret = true; 
		if(document.discussForm.comt.value == ""){
			alert(" Please type a message.");
			ret = false;
			return;
		}	
		if(document.discussForm.cuid.value == ""){
			alert("Please log in and try again.");
			ret = false;
			return;
		}	

		if(document.discussForm.cuid.value == "me"){
			alert("You need to choose bider first.");
			ret = false;
			return;
		}	
			
		
		return ret;
	}	
	
	function completePear(pseq,name,buid){
		
		if(confirm("Do want to pear up with "+name)){
			location.href = "./completePear.fx?pseq="+pseq+"&buid="+buid;
		}
	}	
	
	function currencyFormat (num) {
	    return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,")
	}	
	
    </script>
    
    <script type="text/javascript">
            $(function(){
                $('.truncate').succinct({
                    size: 30
                });
            });
        </script>

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="./bootstrap/js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="./ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="./ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="./ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="./ico/apple-touch-icon-57-precomposed.png">
    <link rel="shortcut icon" href="./ico/favicon.png">

  </head>

  <body>
 <c:choose>
	<c:when test="${sessionScope.mobileYN == 'Y'}">
	<jsp:include page="./menuM.jsp"></jsp:include>
	</c:when>
	<c:when test="${sessionScope.mobileYN == 'N'}">
	<jsp:include page="./menu.jsp"></jsp:include>
	</c:when>
</c:choose> 
   <c:set var="scsymbol" scope="request" value="${info.detailinfo.sccd}"/>
   <c:set var="bcsymbol" scope="request" value="${info.detailinfo.bccd}"/> 
   
    <!-- Map Container -->
    <div class="row-fluid" style="margin-bottom: 20px">
      <div class="container" style="background: #f5f5f5; border-bottom-left-radius: 4px; border-bottom-right-radius: 4px; border: 1px solid #ddd;">
        <div class="span12 pad">
        <div id="demo" class="collapse in" style="border:  1px solid #ddd; margin-top: -1px">
          <div id="map_canvas" style="height: 300px"></div>
        </div>
        <div class="span1 mo text-center" style="padding: 10px; background: #fff; float: right; border-bottom-left-radius: 4px; border-bottom-right-radius: 4px; border: 1px solid #ddd; border-top: none">
          <a type="button" data-toggle="collapse" data-target="#demo"><i class="icon-map-marker icon-2x"></i></a>
        </div>
	
	<div class="pull-left" style="margin-top: 20px"><p class="lead">${info.detailinfo.fname} ${info.detailinfo.lname} wants to exchange ${info.detailinfo.sccd} for ${info.detailinfo.bccd}</p></div>
        <div class="span12 mo mj">
	  <ul class="inline mo" style="background: #fff; font-size: 14px">

	    <li><img src="http://graph.facebook.com/${info.detailinfo.fbuid}/picture?width=50&amp;height=50&amp;"></li>

	    <li style="font-size: 24px; padding-left: 10px !important"><b>${info.detailinfo.sccd}</b> <%=CurrencySymbol.getText((String)request.getAttribute("scsymbol")) %><fmt:formatNumber value="${info.detailinfo.samt}" pattern=""/></li>
	    <li><span class="bfh-currencies" data-currency="${info.detailinfo.sccd}" data-flags="true"></span></li>
	    /
	    <li><span class="bfh-currencies" data-currency="${info.detailinfo.bccd}" data-flags="true"></span></li>
	    <BR>
	    <li class="truncate" title="${info.detailinfo.exlo}"><i class="icon-map-marker"></i> ${info.detailinfo.exlo}</li>
	    <li><i class="icon-calendar"></i> Expires: <span data-localtime-format="yyyy/MM/dd">${fn:substring(info.detailinfo.trdt,0,19)}Z</span> <i class="icon-time"></i> <span data-localtime-format="hh:mm:ss">${fn:substring(info.detailinfo.trdt,0,19)}Z</span></li>
	  </ul>
	</div> 
	
     <!--    <h3 class="mo" style="font-weight: 400; margin-top: 20px !important">${info.detailinfo.fname} ${info.detailinfo.lname} wants to exchange ${info.detailinfo.sccd} for ${info.detailinfo.bccd}</h3>
        <p class="mo">
          <ul class="inline" style="font-size: 18px">
            <li style="padding-left: 0px;"><span class="label label-info" style="padding: 5px 15px;">Info</span></li>
            <li style="padding: 0 !important">${info.detailinfo.sccd} <%=CurrencySymbol.getText((String)request.getAttribute("scsymbol")) %><fmt:formatNumber value="${info.detailinfo.samt}" pattern=""/></li>
            <li><i class="icon-exchange"></i> ${info.detailinfo.sccd}/${info.detailinfo.bccd}</li>
            <li><i class="icon-map-marker"></i> ${info.detailinfo.exlo}</li>
            <li><i class="icon-time"></i> Expires: <span data-localtime-format="yyyy/MM/dd">${fn:substring(info.detailinfo.trdt,0,19)}Z</span></li>
          </ul>
        </p>-->
        </div>
      </div>
    </div>
    

    
    <div class="row-fluid">
      <div class="container">
      <div class="span8 pad" style="background: #f5f5f5; border-radius: 4px; border: 1px solid #ddd;">
        <div class="dropdown mo" style="display: inline-block; float: right">
	<c:set var="userdiscussresultSize" value="${fn:length(info.userdiscussresult)}" />

	<c:choose>
	 <c:when test="${param.whoc == 'S' && userdiscussresultSize != '0'}">     
  
        <button class="dropdown-toggle btn" data-toggle="dropdown" href="#"> Discuss with (${fn:length(info.userdiscussresult)})<b class="caret"></b> </button><a href="#" id="LinkId">  <!-- img style="margin-left: 10px; vertical-align: bottom" src="http://graph.facebook.com/${info.detailinfo.fbuid}/picture?width=50&amp;height=50&amp;"--> </a>
        <!-- 
                <div class="btn-group" style="margin-top: -4px"><button class="btn btn-mini" style="padding: 5px; font-size: 14px; font-weight: 300"><img class="img-rounded" src="./img/user.png" width=33 height=33> Select someone else (${fn:length(info.userdiscussresult)})</button>
              <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown" style="padding: 15px 20px">
                <span class="caret"></span>
              </button>
        -->      
              

        
        <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
              <c:choose>
				    <c:when test="${!empty info.userdiscussresult}">
				     <c:forEach items="${info.userdiscussresult}" var="list" varStatus="st">
						  <c:choose>
								<c:when test="${!empty list.b_fbuid}">
								        
          <li><a tabindex="-1" href="./detail.fx?cuid=${list.cuid}&whoc=S&pseq=${info.detailinfo.pseq}"><img src="http://graph.facebook.com/${list.b_fbuid}/picture?width=12&height=12&"> ${list.b_fname} ${list.b_lname}</a></li>
          						</c:when>
								<c:otherwise>
          <li><a tabindex="-1" href="./detail.fx?cuid=${list.cuid}&whoc=S&pseq=${info.detailinfo.pseq}"><img src="./img/user.png"> ${list.b_fname} ${list.b_lname}</a></li>
								</c:otherwise>
							</c:choose>
				     </c:forEach> 
				    </c:when>
				 </c:choose>            
        </ul>
	  </c:when>     			 
	 </c:choose>            
        
      </div>
      
      
      
      <!-- Discussion Box -->
      
      <div><h3 class="mo" style="font-weight: 400; line-height: 24.5px">Discussion</h3></div>
      <small class="mo">Set a Date, time and place to exchange.</small>
      <div class="row-fluid" style="margin-top: 20px">
      
	      <c:choose>    
	      <c:when test="${param.cuid != 'me'}">
	      
	      
            <div class="span1">
  			<c:choose>    
            <c:when test="${!empty sessionScope.logininfo.fbuid}">
            <img src="http://graph.facebook.com/${sessionScope.logininfo.fbuid}/picture?width=12&height=12">
            </c:when>
		    <c:otherwise>            
              <img src="./img/user.png">
            </c:otherwise>  
           </c:choose>          
            </div>
              <div class="span11">
                  <form name="discussForm">
              <textarea name="comt" class="span12" type="text" placeholder="Type your message here.." value="" type="text" style="padding-bottom: 20px"></textarea>
                <button class="btn pull-right" type="button"  onClick="javascript:sendDiscuss(); return false;">Send!</button>
                <script>$('textarea').autoResize();
                </script>
                       <input type="hidden" name="pseq" value="${info.detailinfo.pseq}">
				       <input type="hidden" name="whoc" value="${param.whoc}">
				       <input type="hidden" name="cuid" value="${param.cuid}">
	              </form>
              </div>
          </div>
          
          <div class="row-fluid">
            <div class="span12">
              <hr>
            </div>
          </div>
          
		 <div style="overflow:auto; width:580px; height:150px; padding:0px;">   
		       
				 <c:choose>
				    <c:when test="${!empty info.discussresult}">
				     <c:forEach items="${info.discussresult}" var="list" varStatus="st">
  				         <c:choose>
  				         	 <c:when test="${list.whoc != 'S'}">
				               
						          <div class="row-fluid" style="margin-bottom: 20px">
						            <div class="span1">
							      <c:choose>
				    <c:when test="${!empty info.biderinfo.fbuid}">
							      <img src="http://graph.facebook.com/${info.biderinfo.fbuid}/picture?width=50&amp;height=50&amp;">
				    </c:when>
				    <c:otherwise>
				      <img src="./img/user.png">
				    </c:otherwise>
							      </c:choose>
							    </div>
						            
							    <div class="discussbox" style="height: 0"></div>
						            <div class="span11" style="border: 1px solid #ddd; border-radius: 4px; background: #fff"><p class="pad mo">${info.biderinfo.fname} ${info.biderinfo.lname}: ${list.comt}</p><small class="pull-right muted" style="margin-right: 10px !important; margin-bottom: 5px">Posted: <a><abbr class="timeago" title="${fn:substring(list.rgdt,0,19)}Z"></abbr></a></small></div>
						          </div>
						     </c:when>
							 <c:otherwise>  				          
						          <div class="row-fluid" style="margin-bottom: 20px">
						            <div class="discussbox2" style="height: 0"></div>
						            <div class="span11 mo" style="border: 1px solid #ddd; border-radius: 4px; background: #fff"><p class="pad mo">${info.detailinfo.fname} ${info.detailinfo.lname}: ${list.comt}</p><small class="pull-right muted" style="margin-right: 10px !important; margin-bottom: 5px">Posted: <a><abbr class="timeago" title="${fn:substring(list.rgdt,0,19)}Z"></abbr></a></small></div>
						            <div class="span1"><img src="http://graph.facebook.com/${info.detailinfo.fbuid}/picture?width=50&amp;height=50&amp;"></div>
						          </div>
				             </c:otherwise>  
      				     </c:choose> 
				       </c:forEach> 
  					  </c:when>
				   </c:choose>       
      		</div>
      	      </c:when>
	      <c:otherwise>
            <div class="span1"><img src="http://graph.facebook.com/${info.detailinfo.fbuid}/picture?width=50&amp;height=50&amp;"></div>
              <div class="span11">
		<c:choose>
		
	 <c:when test="${param.whoc == 'S' && userdiscussresultSize != '0'}">
	 Choose your partner first. 
	 </c:when>
	 <c:otherwise>No partner yet.
	 </c:otherwise>
	</c:choose>   
	
		<form class="">
              <textarea class="span12" type="text" placeholder="Type your message here.." disabled value="" type="text" style="padding-bottom: 20px">            
              </textarea>
                <button class="btn pull-right" type="button">Send!</button>
                <script>$('textarea').autoResize();
                </script>
              </form>
              </div>
          </div>
          
          <div class="row-fluid">
            <div class="span12">
              <hr>
            </div>
          </div>
          


	      
	      </c:otherwise> 
	      </c:choose>	 
	      </div>     
            <!-- Detail Box -->
      <div class="span4" style="
    border: 1px solid #ddd;
    border-radius: 4px;
    background: #f5f5f5;">
            <ul id="myTab" class="nav nav-tabs mo" style="
    /* background: #fff; */
    padding: 10px 10px 0;">
              <li class="active"><a href="#home" data-toggle="tab"><i class="icon-info-sign icon-2x"></i></a></li>
              <li class=""><a href="#profile" data-toggle="tab"><i class="icon-user icon-2x"></i></a></li>
            </ul>
            <div id="myTabContent" class="tab-content pad" style="background: #fff">
              <div class="tab-pane fade active in" id="home">
                <ul class="unstyled mo">
                  <li style="font-size: 14px">${info.detailinfo.sccd} <small>(${info.detailinfo.fname})</small></li>
                  <li style="font-size: 24px"><%=CurrencySymbol.getText((String)request.getAttribute("scsymbol")) %><fmt:formatNumber value="${info.detailinfo.samt}" pattern=""/></li>
                  <li style="border-bottom: 1px dashed #ddd; margin: 10px 0px"></li>
                  <li style="font-size: 14px">${info.detailinfo.bccd} <small>(${info.biderinfo.fname})</small></li>
                  <li style="font-size: 24px"><%=CurrencySymbol.getText((String)request.getAttribute("bcsymbol")) %><a id="bamt" type="text"  style="color: #2b2b2b; text-decoration: none"></a></li>
                  <li class="well text-center" style="margin: 20px"><a id="s_Rate" type="text" style="color: #2b2b2b; text-decoration: none"></a> ${info.detailinfo.sccd} = <a id="b_Rate" type="text" style="color: #2b2b2b; text-decoration: none"></a> ${info.detailinfo.bccd}<BR><font color="red">Sell</font>: <a id="Bid" type="text"  style="color: #2b2b2b; text-decoration: none"></a><BR><font color="blue">Buy</font>: <a id="Ask" type="text"  style="color: #2b2b2b; text-decoration: none"></a><br><small>(Source: Yahoo Finance)<br><a id="date" type="text"  style="color: #2b2b2b; text-decoration: none"></a> <a id="time" type="text"  style="color: #2b2b2b; text-decoration: none"></a></small></li>
                  
                </ul>
                
           

			<c:choose>
	           <c:when test="${param.whoc == 'S' && info.biderinfo != null && info.detailinfo.stat != '0'}">
                <div class="text-center" style="padding: 20px 0px 20px 0px; border-top: 1px solid #ddd">
                <button onClick="javascript:completePear('${info.detailinfo.pseq}','${info.biderinfo.fname} ${info.biderinfo.lname}','${info.biderinfo.id}'); return false;" class="btn btn-success btn-large" style="margin-bottom: 10px">Exchange</button>
                <br>with ${info.biderinfo.fname} ${info.biderinfo.lname}</div>
                </c:when>
            </c:choose>
                
                
              </div>
              
              
              <div class="tab-pane fade" id="profile">
              	<c:choose>
              	<c:when test="${param.whoc == 'S'}">
              		<c:choose>
              		<c:when test="${param.cuid != 'me'}">
              		    <img src="http://graph.facebook.com/${info.biderinfo.fbuid}/picture?width=50&amp;height=50&amp;"><br>
	                	<p class="mo">${info.biderinfo.fname} ${info.biderinfo.lname}<br>(${info.cmptCnt.cnt}) successful exchanges</p>
	                	<hr>
	                	<p class="mo">Feedback</p>
              		</c:when>
              		<c:otherwise>
              		<p class="mo">Choose your partner first.</p>
              		</c:otherwise>
              		</c:choose>

                </c:when>
                <c:otherwise>
                	<img src="http://graph.facebook.com/${info.detailinfo.fbuid}/picture?width=50&amp;height=50&amp;"><br>
	                <p class="mo">${info.detailinfo.fname} ${info.detailinfo.lname}<br>(${info.cmptCnt.cnt}) successful exchanges</p>
	                <hr>
	                <p class="mo">Feedback</p>
                </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
      </div>
      
    </div>
    
    <!-- InfoBox -->
    <!-- 
	<div id="infobox${info.detailinfo.pseq}" class="infobox-wrapper">
      <div class="infobox-inner">
		<button class="btn-primary btn" style="position: absolute; right: 20px">Pear up</button>
		<table>
			<tr style="font-size: 32px; font-weight: bold">
				<td class="flag ${fn:substring(info.detailinfo.sccd,0,2)}"></td>
				<td style="font-weight: 100">${info.detailinfo.sccd}</td>
				<td><%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %></td>
				<td><fmt:formatNumber value="${info.detailinfo.samt}" pattern=""/></td>
			</tr>
		</table>
          <table>
		<tr>
			<td class="text-center" style="padding-right: 10px"><i class="icon-map-marker"></i> </td>
			<td class="truncate"> ${info.detailinfo.exlo}</td>
		</tr>
		<tr>
			<td style="padding-right: 10px"><i class="icon-time"></i> </td>
			<td> Expires: <fmt:formatDate value="${info.detailinfo.trdt}" pattern="dd/MM/yyyy"/></td>
		</tr>
		<tr>
			<td style="padding-right: 10px"><i class="icon-exchange"></i> </td>
			<td> Currency pair USD/AUD</td>
		</tr>
	  </table>
	  <hr>
	  <c:choose>
							<c:when test="${!empty info.detailinfo.fbuid}">
									<img 
										src="http://graph.facebook.com/${info.detailinfo.fbuid}/picture?width=50&amp;height=50&amp;"
										alt="">
								</c:when>
								<c:otherwise>
									<img height="33" width="33" class="img-rounded"
										src="./img/user.png" alt="">
								</c:otherwise>
							</c:choose><br>
<small>Posted by: ${info.detailinfo.fname} ${info.detailinfo.lname}</small><br>
<small>Joined 27/01/2013</small><br>
<small>Verified</small>
	 
        </div>
    </div>			
    -->
    
    <jsp:include page="./js_include.jsp"></jsp:include>
    
    <script>
	    function jeremy-style() {
	    $("#jeremydivloading").html('Loading..'); 
	    $.ajax({
	      type: 'GET',
	      url: './upDiscuss.fx',
	      timeout: 2000,
	      success: function(data) {
		$("#some_div").html(data);
		$("#notice_div").html(''); 
		window.setTimeout(update, 10000);
	      },
	      error: function (XMLHttpRequest, textStatus, errorThrown) {
		$("#notice_div").html('Timeout contacting server..');
		window.setTimeout(update, 60000);
	      }
	  }
    </script>

    
    
  </body>
</html>

