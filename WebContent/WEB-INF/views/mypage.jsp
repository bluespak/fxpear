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
<html lang="en"><head>
    <meta charset="utf-8">
    <title>Bootstrap, from Twitter</title>
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


  <body>
<c:choose>
	<c:when test="${sessionScope.mobileYN == 'Y'}">
	<jsp:include page="./menuM.jsp"></jsp:include>
	</c:when>
	<c:when test="${sessionScope.mobileYN == 'N'}">
	<jsp:include page="./menu.jsp"></jsp:include>
	</c:when>
</c:choose>
 <script>
		 function goDetail(pseq){
			    	var url = "./detail.fx?cuid=${sessionScope.logininfo.id}&whoc=B&pseq="+pseq;
			   		 location.href = url;
		}
		
		function goSDetail(pseq){
			var url = "./detail.fx?cuid=me&whoc=S&pseq="+pseq;
				 location.href = url;
		}
		
		function changeStatus(pseq,stat){
	    	var url = "./changeStatus.fx?stat="+stat+"&pseq="+pseq;
	   		 location.href = url;
		}

		function goModify(){
	    	alert('goModify');
		}
		
		function getInfobyFb(){
	    	alert('getInfobyFb');
		}
		
</script>
  
      <div class="container">
<!--
        <div class="span12">
        <div class="span3 offset1" style="background: #fff; padding: 40px 40px; height: 2000px">
          <div class="tabbable tabs-left" style="position: fixed">
        <ul class="nav nav-tabs" style="background: #fff;">
          <li>
          <c:choose>    
            <c:when test="${!empty sessionScope.logininfo.fbuid}">
            <img class="img-rounded" style="margin-bottom: 10px" src="http://graph.facebook.com/${sessionScope.logininfo.fbuid}/picture?width=100&height=100">
            </c:when>
		    <c:otherwise>            
              <img class="img-rounded" style="margin-bottom: 10px" src="./img/user.png">
            </c:otherwise>  
           </c:choose>
          <p class="lead">${sessionScope.logininfo.fname} ${sessionScope.logininfo.lname}</p></li>
          <li><a href="#tab1" data-toggle="tab"><i class="icon-user"></i> Profile information</a></li>
          <li class="active"><a href="#tab2" data-toggle="tab"><i class="icon-mail-forward"></i> I'm selling</a></li>
          <li><a href="#tab3" data-toggle="tab"><i class="icon-mail-reply"></i> I'm Biding</a></li>
          <li><a href="#tab3" data-toggle="tab"><i class="icon-time"></i> History</a></li>
        </ul>
        
      </div>
        </div>

-->
        <div class="span10" style="background: #fff;margin-left: 0;">
  	<c:choose> 
    <c:when test="${param.tab == 1}">

		  
		  <div class="box span9" style="padding: 40px 40px 40px 0px ">
 <form NAME="registerForm">            
      <h3>Modify your information</h3>
        ID : <input type="text"  name="id" class="input-block-level" placeholder="Email address" value="${sessionScope.logininfo.id}" readonly> 
        First Name : <input type="text" name="fname" value="${sessionScope.logininfo.fname}" class="input-block-level" placeholder="First name">
        Last Name :<input type="text" name="lname" value="${sessionScope.logininfo.lname}" class="input-block-level" placeholder="Last name">
        <br>
        Nationality : <div class="bfh-selectbox bfh-countries" data-country="${sessionScope.logininfo.nation}" data-flags="true" align="left">
           <input name="nation" type="hidden" value="">
              <a class="bfh-selectbox-toggle" role="button" data-toggle="bfh-selectbox" href="#">
              <span class="bfh-selectbox-option input-xlarge" data-option="">What is your country?</span>
              </a>
              <div class="bfh-selectbox-options" align="left">
               <input type="text" class="bfh-selectbox-filter" placeholder="search">
                 <div role="listbox">
                  <ul role="option"></ul>
                 </div>
              </div>
        </div> 

        <br>
        Currency : <div class="bfh-selectbox bfh-currencies" data-currency="${sessionScope.logininfo.currency}" data-flags="true" align="left">
           <input name="currency" type="hidden" value="">
              <a class="bfh-selectbox-toggle" role="button" data-toggle="bfh-selectbox" href="#">
              <span class="bfh-selectbox-option input-xlarge" data-option="">What currency is yours?</span>
              </a>
              <div class="bfh-selectbox-options" align="left">
               <input type="text" class="bfh-selectbox-filter" placeholder="search">
                 <div role="listbox">
                  <ul role="option"></ul>
                 </div>
              </div>
        </div> 

        <input type="password" name="password" class="input-block-level" placeholder="Password">
        <input type="password" name="repassword" class="input-block-level" placeholder="Re-enter Password">
        <input type="hidden" name="email" value=""/>
        <input type="hidden" name="address1" value=""/>
        <input type="hidden" name="address2" value=""/>
        <input type="hidden" name="city" value="${sessionScope.logininfo.city}">
        <a href="#" class="btn btn-primary btn-small" onClick="javascript:goModify()">Modify</a>
 <%--          <c:choose>    
            <c:when test="${empty sessionScope.logininfo.fbuid}">
  --%>           
            
           <a href="#" class="btn btn-primary btn-small" onClick="javascript:getInfobyFb()">Get your information from Facebook</a>

<%--         </c:when>
        </c:choose>
 --%>
 </form>
  </div>


	</c:when>
	<c:when test="${param.tab == 2}">




          <div class="box span9" id="tab2">
            <div><h1>I'm selling</h1><hr class="soften"></div>
            <table class="table table-hover">
              <thead>
                <tr>
                  <th>Code</th>
                 <th>I have</th>
                  <th>Amount</th>
                  <th>I want</th>
                  <th>Location</th>
                  <th>Posting Date</th>
                  <th>Expire in</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
         <c:choose>
    <c:when test="${!empty info.myselllist}">
     <c:forEach items="${info.myselllist}" var="list" varStatus="st">
    	<c:set var="exlo" scope="request" value="${list.exlo}"/> 
    	<c:set var="pseq" scope="request" value="${list.pseq}"/> 
 		<c:set var="csymbol" scope="request" value="${list.sccd}"/>      
 		<c:set var="bsymbol" scope="request" value="${list.bccd}"/>      
              
                <tr>
                  <td><a href="#" onClick="javascript:goSDetail('${list.pseq}');">FX${list.pseq}</a></td>
                  <td><i class="icon-flag-US"><i class="icon-flag-${fn:substring(list.sccd,0,2)}"></i></i><%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %></td>
                  <td><i class="icon-krw"></i><fmt:formatNumber value="${list.samt}" pattern=""/></td>
                  <td><i class="icon-flag-${fn:substring(list.bccd,0,2)}"></i><%=CurrencySymbol.getText((String)request.getAttribute("bsymbol")) %></td>
                  <td>${list.exlo}</td>
                  <td><span data-localtime-format="yyyy/MM/dd HH:mm:ss">${fn:substring(list.spdt,0,19)}Z</span></td>
                  <td><a><abbr class="timeago" title="${fn:substring(list.trdt,0,19)}Z"></abbr></a></td>
                  <td>
                   	<c:choose> 
				    <c:when test="${list.stat == 0}">
				    	<span class="label label-info">Closed</span>
				     </c:when>
				    <c:when test="${list.stat == 1}">
				    	<span class="label label-info">Opened</span>
				    	<button class="btn btn-success" onClick="javascript:changeStatus('${list.pseq}','2'); return false;"><i class="icon-refresh icon-white"></i> go Suspend</button>
				     </c:when>
				    <c:when test="${list.stat == 2}">
				    	<span class="label label-info">Suspended</span>
				    	<button class="btn btn-success" onClick="javascript:changeStatus('${list.pseq}','1'); return false;"><i class="icon-refresh icon-white"></i> go Open</button>
				     </c:when>
					</c:choose>        
 				</td>
                </tr>
            </c:forEach> 
    </c:when>
    <c:otherwise> 
        <TR>
     		<TD colspan="6">No Result!!!
     		</TD>
     	</TR>
    </c:otherwise> 
   </c:choose>           

              </tbody>
            </table>
          </div>

	</c:when>
	<c:when test="${param.tab == 3}">


          <div class="box span9" id="tab3">
            <div><h1>I'm Biding</h1><hr class="soften"></div>
            <table class="table table-hover">
              <thead>
                <tr>
                  <th>Code</th>
                 <th>Seller have</th>
                  <th>Seller Amount</th>
                  <th>I have</th>
                  <th>Location</th>
                  <th>Posting Date</th>
                  <th>Expire in</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
         <c:choose>
    <c:when test="${!empty info.mybidlist}">
     <c:forEach items="${info.mybidlist}" var="list" varStatus="st">
    	<c:set var="exlo" scope="request" value="${list.exlo}"/> 
    	<c:set var="pseq" scope="request" value="${list.pseq}"/> 
 		<c:set var="csymbol" scope="request" value="${list.sccd}"/>      
  		<c:set var="bsymbol" scope="request" value="${list.bccd}"/>      
              
                <tr>
                  <td><a href="#" onClick="javascript:goDetail('${list.pseq}');">FX${list.pseq}</a></td>
                  <td><i class="icon-flag-US"><i class="icon-flag-${fn:substring(list.sccd,0,2)}"></i></i><%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %></td>
                  <td><i class="icon-krw"></i>${list.samt}</td>
                  <td><i class="icon-flag-${fn:substring(list.bccd,0,2)}"></i><%=CurrencySymbol.getText((String)request.getAttribute("bsymbol")) %></td>
                  <td>${list.exlo}</td>
                  <td><span data-localtime-format="yyyy/MM/dd HH:mm:ss">${fn:substring(list.spdt,0,19)}Z</span></td>
                  <td><a><abbr class="timeago" title="${fn:substring(list.trdt,0,19)}Z"></abbr></a></abbr></td>
                  <td>
                   	<c:choose> 
				    <c:when test="${list.stat == 0}">
				    	<span class="label label-info">Closed</span>
				     </c:when>
				    <c:when test="${list.stat == 1}">
				    	<span class="label label-info">Opened</span>
				     </c:when>
				    <c:when test="${list.stat == 2}">
				    	<span class="label label-info">Suspended</span>
				     </c:when>
					</c:choose>        
 				</td>
                </tr>
            </c:forEach> 
    </c:when>
    <c:otherwise> 
        <TR>
     		<TD colspan="6">No Result!!!
     		</TD>
     	</TR>
    </c:otherwise> 
   </c:choose>           

              </tbody>
            </table>
             </div>
        </div>
     </c:when>
	</c:choose>        

      </div>
     <jsp:include page="./js_include.jsp"></jsp:include> 
</body>
</html>
