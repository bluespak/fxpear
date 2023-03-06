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
<html>
  <head>
    <META HTTP-EQUIV="contentType" CONTENT="text/html;charset=UTF-8">
    <title>Summary in CurrencyPear</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <jsp:include page="./css_include.jsp"></jsp:include> 

    <style>
      body {
        background: url(./bootstrap/img/bbgg.png);
/*         padding-top: 60px;  */
        /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="./bootstrap/js/html5shiv.js"></script>
    <![endif]-->


   <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    
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
   
   <script type="text/javascript">
        jQuery(document).ready(function() {
		  jQuery("abbr.timeago").timeago();
		});
    </script>
     <script>
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
    	    	b_Rate_div.innerHTML = b_Rate_div.innerHTML + Math.round(data.query.results.rate.Rate * mrate * 10000)/10000 ;
    	    	var Ask_div = document.getElementById('Ask');
    	    	Ask_div.innerHTML = Ask_div.innerHTML + Math.round( data.query.results.rate.Ask * mrate * 10000)/10000 ;
    	    	var Bid_div = document.getElementById('Bid');
    	    	Bid_div.innerHTML = Bid_div.innerHTML + Math.round( data.query.results.rate.Bid * mrate * 10000)/10000 ;
    	    	var bamt_div = document.getElementById('bamt');
    	    	bamt_div.innerHTML = bamt_div.innerHTML + Math.round( data.query.results.rate.Rate * ${info.detailinfo.samt} * 10000)/10000;
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
    
    function initialize() {

    	  var latlng = new google.maps.LatLng(0, 0);
    	  var mapOptions = {
    	    zoom: 11,
    	    center: latlng,
    	    mapTypeControl: false,
    	    mapTypeId: google.maps.MapTypeId.ROADMAP
    	  }
    	  map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

    	  infowindow = new google.maps.InfoWindow({
    	      content: "loading..."
    	  });
    	  moveMapCenter('${info.detailinfo.exlo}');  

    	}
    
    google.maps.event.addDomListener(window, 'load', initialize);


    function moveMapCenter(address){
    	var scsymbol= '<%=CurrencySymbol.getText((String)request.getAttribute("scsymbol"))%>';
    	var description = '<font color="blue"><B>${info.detailinfo.fname} ${info.detailinfo.lname}</B></font> wants to trade <font color="red"><B>'+scsymbol+' ${info.detailinfo.samt}</B></font> until ${info.detailinfo.trdt} in <font color="brown"><B>${info.detailinfo.exlo}</B></font>';
    	var geocoder = new google.maps.Geocoder();
    	  geocoder.geocode( { 'address': address}, function(results, status) {
    		    if (status == google.maps.GeocoderStatus.OK) {
    		    	
    		      map.setCenter(results[0].geometry.location);
    		      var marker = new google.maps.Marker({
  	                position: results[0].geometry.location,
  	                map: map,
  	                html: description

  		            });
		            google.maps.event.addListener(marker, "click", function () {
  		                infowindow.setContent(description);
  		                infowindow.open(map, this);
  	            });
    		    } else {
    		      alert('Geocode was not successful for the following reason: ' + status);
    		    }
    		  });
    	
    }
    
	function goSDetail(cuid){
		var url = "./summary.fx?cuid="+cuid+"&whoc=S&pseq=${info.detailinfo.pseq}";
			 location.href = url;
	}    
	
    function sendDiscuss(){
		if(checkValid_sendDiscuss()){
			document.discussForm.method = "POST";
			document.discussForm.action = "./upDiscuss.fx";
			document.discussForm.submit();
		}   	 
	}
     
    function reload(){
		var url = "./summary.fx?cuid=${param.cuid}&pseq=${info.detailinfo.pseq}&whoc=${param.whoc}";
			 location.href = url;
	}
	function linkSummary(){
		locatin.href="#summary";
	}
	function checkValid_sendDiscuss(){
			
		var ret = true; 
		if(document.discussForm.comt.value == ""){
			alert(" Please put the message for him/her.");
			ret = false;
			return;
		}	
		if(document.discussForm.cuid.value == ""){
			alert(" You are not logged in now. Please logged in then try again.");
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

    </script>
            
   

    
    
    <div class="span4 offset2 pad bg" style="margin-bottom: 10px">
      <div class="span4" style="margin-left: 0px; margin-bottom: 10px">
        <div class="span1" style="margin-left: 0px; margin-right: 5px; font-size: 11px; font-weight: 300; max-width: 50px">
        <img class="img-polaroid"src="http://graph.facebook.com/${info.detailinfo.fbuid}/picture?width=133&height=133&">
        
        </div>

        <div class="span3">
	      <a name="summary"></a>
        
          <ul class="unstyled">
            <li><a>${info.detailinfo.fname} ${info.detailinfo.lname} </a>wants to exchange</li>
            <li><p class="lead" style="margin: 0px; font-size: 24px"><%=CurrencySymbol.getText((String)request.getAttribute("scsymbol")) %> <fmt:formatNumber value="${info.detailinfo.samt}" pattern=""/> to ${info.detailinfo.bccd}</p></li>
            status: 
      	<c:choose> 
        <c:when test="${info.detailinfo.stat == 1}">  
            <span class="label label-info">open to bids</span>
        </c:when>
	    <c:otherwise>
            <span class="label label-info">close to bids with ${info.buyerinfo.fname} ${info.buyerinfo.lname}</span>
	    </c:otherwise>
	    </c:choose>    
          </ul>
 			<div class="hidden-desktop"><a href="#discuss"><button style="margin: 2px 5px" class="btn btn-small btn-info"  >go Discuss</button></a></div>
       </div>
        <hr class="dark span4" style="margin-bottom: 10px; margin-top: 10px">
          <ul class="unstyled inline span4" style="margin: 0px">
            <li><i class="icon-user"></i> Posted by: ${info.detailinfo.fname} ${info.detailinfo.lname}</li>
            <li><i class="icon-time"></i> Posting Time: <a><abbr class="timeago" title="${fn:substring(info.detailinfo.spdt,0,19)}Z"></abbr></a></li>
            <li><i class="icon-time"></i> Expires in <a><abbr class="timeago" title="${fn:substring(info.detailinfo.trdt,0,19)}Z"></abbr></a></li>
          </ul>
        <hr class="dark span4" style="margin-bottom: 10px; margin-top: 10px">
      </div>

      <div id="map_canvas" class="span4" align="center" style="margin-left: 0px; height: 140px"></div>
               
	
	
            <div class="span4" style="margin-left: 0px;">    
              <div style="background: #fff">
                  <ul style="padding: 15px; font-size: 12px" class="unstyled inline">
                    <li><i class="icon-map-marker"></i>  Exchange Place: ${info.detailinfo.exlo}</li>
                    <li><i class="icon-calendar"></i> Exchange date: <span data-localtime-format="yyyy/MM/dd HH:mm:ss">${fn:substring(info.detailinfo.trdt,0,19)}Z</span></li>
                    <li><i class="icon-time"></i> Exchange time: 3:00pm</li>
                 </ul>
               </div>
        
        <div class="text-center" style="background: #fff">
          <p class="alert-grey" style="font-weight: 300"><i class="icon-flag-${fn:substring(info.detailinfo.sccd,0,2)}"></i> ${info.detailinfo.sccd} <%=CurrencySymbol.getText((String)request.getAttribute("scsymbol")) %> <a id="s_Rate" type="text" style="color: #2b2b2b; text-decoration: none"></a> = ${info.detailinfo.bccd} <%=CurrencySymbol.getText((String)request.getAttribute("bcsymbol")) %> <a id="b_Rate" type="text" style="color: #2b2b2b; text-decoration: none"></a> <i class="icon-flag-${fn:substring(info.detailinfo.bccd,0,2)}"></i><br>
          Sell: <a id="Bid" type="text"  style="color: #2b2b2b; text-decoration: none"></a>&nbsp;&nbsp;Buy: <a id="Ask" type="text"  style="color: #2b2b2b; text-decoration: none"></a>
           <p>Soooo, You can pay: ${info.detailinfo.sccd} <%=CurrencySymbol.getText((String)request.getAttribute("scsymbol")) %> <fmt:formatNumber value="${info.detailinfo.samt}" pattern=""/><br>You can receive :${info.detailinfo.bccd} <%=CurrencySymbol.getText((String)request.getAttribute("bcsymbol")) %> <a id="bamt" type="text"  style="color: #2b2b2b; text-decoration: none"></a></p>
          <a id="date" type="text"  style="color: #2b2b2b; text-decoration: none"></a> <a id="time" type="text"  style="color: #2b2b2b; text-decoration: none"></a>
 
        </div>
     
      	<c:choose> 
        <c:when test="${info.detailinfo.stat == 1 && param.whoc == 'S'  && param.cuid != 'me'}">  
      <br>
            <button align="center" onClick="javascript:completePear('${info.detailinfo.pseq}','${info.biderinfo.fname} ${info.biderinfo.lname}','${info.biderinfo.id}'); return false;" class="btn-middle  btn-success" style="margin-top: -3px; height: 60px; margin-left: 5px; font-size: 24px">Pear up<br><small style="font-size: 13px; font-weight: 300; letter-spacing: 1px">with ${info.biderinfo.fname} ${info.biderinfo.lname}</small></button>
         </c:when>
	    </c:choose>            
           </div>
    </div>
    <a name="discuss"></a>
    <div class="span4 pad bg">
      <c:choose>    
      <c:when test="${param.whoc == 'S'}">
	      <c:choose>    
	      <c:when test="${param.cuid != 'me'}">
	      <p class="">You're talking to <a>${info.biderinfo.fname} ${info.biderinfo.lname}</a>
	      </c:when>
	      <c:otherwise>
	      <p class="">Choose your partner first.</p>
	      </c:otherwise> 
	      
	      </c:choose>
        <div class="btn-group" style="margin-top: -4px"><button class="btn btn-mini" style="padding: 5px; font-size: 14px; font-weight: 300"><img class="img-rounded" src="./img/user.png" width=33 height=33> Select someone else (${fn:length(info.userdiscussresult)})</button>
              <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown" style="padding: 15px 20px">
                <span class="caret"></span>
              </button>
              <ul class="dropdown-menu">
              <c:choose>
				    <c:when test="${!empty info.userdiscussresult}">
				     <c:forEach items="${info.userdiscussresult}" var="list" varStatus="st">
						  <c:choose>
								<c:when test="${!empty list.b_fbuid}">
				            <li><a data-target="#" href="./summary.fx?cuid=${list.cuid}&whoc=S&pseq=${info.detailinfo.pseq}"><img src="http://graph.facebook.com/${list.b_fbuid}/picture?width=12&height=12&"> ${list.b_fname} ${list.b_lname}</a></li>
								</c:when>
								<c:otherwise>
							<li><a data-target="#" href="./summary.fx?cuid=${list.cuid}&whoc=S&pseq=${info.detailinfo.pseq}"><img src="./img/user.png" width=40 height=40> ${list.b_fname} ${list.b_lname}</a></li>
								</c:otherwise>
							</c:choose>
				     </c:forEach> 
				    </c:when>
				 </c:choose>  
              </ul>
            </div>
        </p> 
        </c:when>
	    </c:choose>    
	    
      <p><i class="icon-comment"> </i> (${fn:length(info.discussresult)}) comments</p>
      <hr class="dark" style="margin: 10px">
      
      <div class="span4" style="height: 340px; overflow-y: auto; margin-left: 0px !important">

 <c:choose>
    <c:when test="${!empty info.discussresult}">
     <c:forEach items="${info.discussresult}" var="list" varStatus="st">
 <!-- Discussion LOOP Start -->
 
 
             <c:choose>    
            <c:when test="${list.whoc == 'S'}">
		      <div class="post-img">
			  <c:choose>
				<c:when test="${!empty info.detailinfo.fbuid}">
				<img style="position: absolute; margin-top: -56px" src="http://graph.facebook.com/${info.detailinfo.fbuid}/picture?width=12&height=12">
				</c:when>
				<c:otherwise>
				<img style="position: absolute; margin-top: -56px" src="./img/user.png" height="40" width="40">
				</c:otherwise>
			  </c:choose>
				
				<a style="position: absolute; margin-top: -31px; margin-left: 45px">${info.detailinfo.fname} ${info.detailinfo.lname}</a>
		        <p>${list.comt}</p>
		        <p class="pd"><a><abbr class="timeago" title="${fn:substring(list.rgdt,0,19)}Z"></abbr></a><i class="icon-flag"> <BR></i> Flag this comment as inappropriate
					  <div style="display: inline" class="btn-group">
					  <button class="btn btn-mini"><i class="icon-flag"></i></button>
					  <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
					    <span class="caret"></span>
					  </button>
					  <ul class="dropdown-menu" style="font-size: 12px">
					    <li style="margin-left: 5px">Flag this comment</li>
					    <li class="divider"></li>
					    <li><a>Suspicious or misleading</a></li>
					    <li><a>Inappropriate/offensive</a></li>
					    <li><a>Spam</a></li>
					  </ul>
					</div>
				</p>
			</div>		      	
            </c:when>
		    <c:otherwise>  
		      <div class="post-img">
			  <c:choose>
				<c:when test="${!empty list.b_fbuid}">
		        <img style="position: absolute; margin-top: -56px" src="http://graph.facebook.com/${list.b_fbuid}/picture?width=12&height=12"><a style="position: absolute; margin-top: -31px; margin-left: 45px">${list.b_fname} ${list.b_lname}</a>
				</c:when>
				<c:otherwise>
				<img style="position: absolute; margin-top: -56px" src="./img/user.png" height="40" width="40"><a style="position: absolute; margin-top: -31px; margin-left: 45px">${list.b_fname} ${list.b_lname}</a>
				</c:otherwise>
			  </c:choose>
		        <p>${list.comt}</p>
		        <p class="pd"><a><abbr class="timeago" title="${fn:substring(list.rgdt,0,19)}Z"></abbr></a><i class="icon-flag"></i> Flag this comment as inappropriate
					  <div style="display: inline" class="btn-group">
					  <button class="btn btn-mini"><i class="icon-flag"></i></button>
					  <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
					    <span class="caret"></span>
					  </button>
					  <ul class="dropdown-menu" style="font-size: 12px">
					    <li style="margin-left: 5px">Flag this comment</li>
					    <li class="divider"></li>
					    <li><a>Suspicious or misleading</a></li>
					    <li><a>Inappropriate/offensive</a></li>
					    <li><a>Spam</a></li>
					  </ul>
					</div>
					</p>
				</div>		      	
		              
             </c:otherwise>  
           </c:choose> 

      
      </c:forEach> 
    </c:when>
    <c:otherwise> 
        <TR>
     		<TD>No Comment yet!!
     		</TD>
     	</TR>
    </c:otherwise> 
   </c:choose>       
  <!-- Discussion LOOP End -->      
      
 	</div>
    <div class="span4" style="margin-left: 0px; margin-top: 10px;">
    <form name="discussForm">
      <div class="span2" style="">
        <p>
          <textarea name="comt" style="width: 250px" placeholder="Type your comment.."></textarea>
        </p>
      </div>
	  <div class="span2" align="right">
       <button style="margin: 2px 5px" class="btn btn-middle btn-info"  onClick="javascript:sendDiscuss(); return false;">Send</button>
	   <a onClick="javascript:reload(); return false;"><i class="icon-refresh"  ></i></a>
	  </div>
	  <!--
 		<div class="hidden-desktop"><button style="margin: 2px 5px" class="btn btn-small btn-info"  onClick="javascript:linkSummary();return false;">go Summary</button></div>
-->

       <input type="hidden" name="pseq" value="${info.detailinfo.pseq}">
       <input type="hidden" name="whoc" value="${param.whoc}">
       <input type="hidden" name="cuid" value="${param.cuid}">
      </form>
      </div>
    </div>
    
    <jsp:include page="./js_include.jsp"></jsp:include> 
  </body>
</html>
