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
    <link href="./bootstrap/css/bootstrap-formhelpers.css" rel="stylesheet">
    <link href="./bootstrap/css/bootstrap-formhelpers-countries.flags.css" rel="stylesheet">
    <link href="./bootstrap/css/bootstrap-formhelpers-currencies.flags.css" rel="stylesheet">
    <link href="./bootstrap/css/flags32.css" rel="stylesheet">
    <style>
      body {
        background: url(./bootstrap/img/bbgg.png);
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>
   <script src=" http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.js"></script>    
   <script> 
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
			alert(" Please put the message for him/her.");
			ret = false;
			return;
		}	
		if(document.discussForm.cuid.value == ""){
			alert(" You are not logged in now. Please logged in then try again.");
			ret = false;
			return;
		}	
				
		
		return ret;
	}
	
	function goSDetail(cuid){
		var url = "./discussion.fx?cuid="+cuid+"&whoc=S&pseq=${info.detailinfo.pseq}";
			 location.href = url;
	}
    </script>
    
<script type="text/javascript">
$(document).ready(function() {
    
	jQuery.ajax({
	    type: "GET",
	    url: "./currencyinfo.fx",
	    dataType: "json",
	    contentType: "application/json; charset=utf-8",
	    data: "from=${info.detailinfo.sccd}&to=${info.detailinfo.bccd}",
	    success: function(data) {
    	
	    //    data = data.replace(/([a-z0-9]+):/gi,"\"$1\":");
	   //     var obj = $.parseJSON( data );
	   		
	        alert( "Name:"+data.query.results.rate.Name );
	        alert( "Rate:"+data.query.results.rate.Rate );
	        alert( "Date:"+data.query.results.rate.Date );
	        alert( "Time:"+data.query.results.rate.Time );
	        alert( "Ask:"+data.query.results.rate.Ask );
	        alert( "Bid:"+data.query.results.rate.Bid );
	   },
	   error: function (xhr, ajaxOptions, thrownError) {
	        alert(xhr.status);
	       alert(thrownError);
	   }
	});
});
</script>


    
     <link href="./bootstrap/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="./bootstrap/js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../ico/apple-touch-icon-57-precomposed.png">
    <link rel="shortcut icon" href="../ico/favicon.png">
  </head>

  <body>
 <jsp:include page="./menu.jsp"></jsp:include>

    <div class="span4 offset2 pad bg">
          <img class="img-rounded"src="http://graph.facebook.com/${info.detailinfo.fbuid}/picture?width=133&height=133&">

          <p class="lead" style="margin-bottom: 10px"><a>${info.detailinfo.fname} ${info.detailinfo.lname}</a> wants to trade KRW</p>

            <p class="h0">&#8361; 3,000,000.00</p>
            <p class="lead" style="margin-bottom: 10px">in exchange for <a style="color: #25B900">AUD</a></p>

      <hr class="dark" style="margin: 0px">
        <p><ul class="unstyled inline" align="left">
      <li style="padding-left: 0px"><i class="icon-map-marker"> </i> Perth, Western Australia</li>
      <li><i class="icon-time"> </i> Expires: 2h 36mins</li>
      </ul></p>
       <hr class="dark" style="margin: 0px">
          <div class="">
            <p class="lead" style="margin-top: 10px">
              Bid Summary 
            </p>
            <ul class="unstyled" style="font-size: 12px">
              <li>Your currency: ${info.detailinfo.sccd}</li>
              <li>Exchange currency: ${info.detailinfo.bccd}</li>
              <li>Exchange rate: AUD 1.00 = KRW 1,000.00</li>
              <br>
       			  <c:set var="csymbol" scope="request" value="${info.detailinfo.sccd}"/>
              
              <li>You pay: <%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %> ${info.detailinfo.samt}</li>
              <li>You receive: 3,000,000.00 ????</li>
              <br>
              <li>Exchange location: ${info.detailinfo.exlo}</li>
              <li>Exchange date: ${info.detailinfo.trdt}</li>
              <li>Exchange time: 3:00pm (local time)</li>
            </ul></div>
          </div>

    
    
    <div class="span4 pad bg" style="height: 410px; overflow-y: auto">
      <p class="lead" style="margin-bottom: 0px">Discussion </p>
 <c:choose>
    <c:when test="${!empty info.userdiscussresult}">
     <c:forEach items="${info.userdiscussresult}" var="list" varStatus="st">
           <a href="javascript:goSDetail('${list.cuid}')">${list.b_fname} ${list.b_lname}</a>
     </c:forEach> 
    </c:when>
 </c:choose>  


      <hr class="dark">


 <c:choose>
    <c:when test="${!empty info.discussresult}">
     <c:forEach items="${info.discussresult}" var="list" varStatus="st">
 
            <c:choose>    
            <c:when test="${list.whoc == 'S'}">
		        <div class="post-img">
		        S<img class="img-rounded" src="http://graph.facebook.com/${info.detailinfo.fbuid}/picture?width=56&height=56&"><a style="position: absolute; margin-top: -31px; margin-left: 45px">${info.detailinfo.fname} ${info.detailinfo.lname}</a>
		        <p>${list.comt}</p>
		        <p class="pd">5 mins ago ${list.rgdt}</p>
		      	</div>
            </c:when>
		    <c:otherwise>            
			      <div class="post-img">
			        B<img style="position: absolute; margin-top: -56px; margin-left: 310px"  class="img-rounded" src="http://graph.facebook.com/${list.b_fbuid}/picture?width=56&height=56&"><a style="position: absolute; margin-top: -31px; margin-left: 195px">${list.b_fname} ${list.b_lname}</a>
			        <p>${list.comt}</p>
			        <p class="pd">5 mins ago ${list.rgdt}</p>
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




    </div>
     
    <div class="span4 pad bg">
    <form name="discussForm">
      <div class="span4" style="margin: 0px" align="center"><p>
      <img class="img-rounded" src="http://graph.facebook.com/${sessionScope.logininfo.fbuid}/picture?width=36&height=36&">
      <textarea name="comt" style="margin-left: 10px" placeholder="Type your comment.."></textarea>
      <button style="margin-left: 9px" class="btn btn-large btn-info" onClick="javascript:sendDiscuss(); return false;">Send</button></p> 
      </div>
      <input type="hidden" name="pseq" value="${info.detailinfo.pseq}">
      <input type="hidden" name="whoc" value="${param.whoc}">
      <input type="hidden" name="cuid" value="${param.cuid}">
     </form>
      
      </div>
    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="./bootstrap/js/bootstrap-formhelpers-currencies.en_US.js"></script>
    <script src="./bootstrap/js/bootstrap-formhelpers-currencies.js"></script>
    <script src="./bootstrap/js/bootstrap-formhelpers-countries.js"></script>
    <script src="./bootstrap/js/bootstrap-formhelpers-countries.en_US.js"></script>
    <script src="./bootstrap/js/bootstrap-tab.js"></script>
  </body>
</html>
