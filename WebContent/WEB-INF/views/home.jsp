<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.bluespak.vo.PearVO" %>
<%@ page import="com.bluespak.utils.cd.NationCode" %>
<%@ page import="com.bluespak.utils.cd.CityCode" %>
<%@ page import="com.bluespak.utils.cd.CurrencyCode" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en"> 
  <head>
    <meta charset="utf-8">
    <title>Sign in &middot; Twitter Bootstrap</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
	
    <!-- Le styles -->
    <link href="./css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background: url(img/naruta_airport.jpg);
      }

      .form-signin {
        max-width: 800px;
        padding: 15px 29px 0px 40px;
        margin: 120px auto 20px;
        background-color: rgba(20,20,20,.6);

        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
      }

    </style>
    <link href="./css/bootstrap-responsive.css" rel="stylesheet">
    <link href="./css/bootstrap-formhelpers.css" rel="stylesheet">
    <link href="./css/pear.css" rel="stylesheet">
    

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="ico/apple-touch-icon-114-precomposed.png">
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="ico/apple-touch-icon-72-precomposed.png">
                    <link rel="apple-touch-icon-precomposed" href="ico/apple-touch-icon-57-precomposed.png">
                                   <link rel="shortcut icon" href="ico/favicon.png">
  </head>

 <body>
 
<jsp:include page="./menu.jsp"></jsp:include>

<div class="form-signin" align="center">
    <form class="form-search" name="searchForm" METHOD=POST>
    
            <select  name="sccd" class="input-medium bfh-currencies span3" data-currency="EUR">
        	<option value="">Which currency do you have?</option>
	        	<%
        		List CurrencyKeys = CurrencyCode.getKeyList();
	        	Iterator i2 = CurrencyKeys.iterator();
	        		        	while(i2.hasNext()){
	        		        		String key = (String)i2.next();
	        	%>
	        	<option value="<%=key%>"><%=CurrencyCode.getText(key)%></option>
	        	<%
	        		}
	        	%>
        	</select>
  <div class="input-append">
            <select  name="bccd" class="input-medium bfh-currencies span3" data-currency="EUR" >
        	<option value="">Which currency do you need?</option>
	        	<%
	        		Iterator i3 = CurrencyKeys.iterator();
	        		        	while(i3.hasNext()){
	        		        		String key = (String)i3.next();
	        	%>
	        	<option value="<%=key%>"><%=CurrencyCode.getText(key)%></option>
	        	<%
	        		}
	        	%>     
        	</select>  
    <button class="btn" onClick="javascript:searchPear()" >Search</button>
  </div>
  <a href="#" style="margin-left: 10px">advanced search</a>
</form>
    </div>
 <c:choose>
    <c:when test="${!empty info.result}">
     <c:forEach items="${info.result}" var="list" varStatus="st">
    	<c:set var="exlo" scope="request" value="${list.exlo}"/> 
	<div class="post">
        <span>
        <img src="./img/au.png">
          <h5 style="display: inline; vertical-align: middle; font-weight: 300; padding: 10px"></h5>
          <h5 style="display: inline; vertical-align: middle; font-weight: 300; padding: 10px">${list.bccd}</h5>
          <h2 style="display: inline; vertical-align: middle; font-weight: 400; background: #fff; padding: 20px">${list.samt}</h2>
          <h5 style="display: inline; vertical-align: middle; font-weight: 300; padding: 10px">Posted on: ${list.spdt}</h5>
          <h5 style="display: inline; vertical-align: middle; font-weight: 300; padding: 10px">Expires on: ${list.trdt}</h5>          
          <h5 style="display: inline; vertical-align: middle; font-weight: 300; padding: 10px">Location: <%=NationCode.getText((String)request.getAttribute("exlo"))%> </h5>
          <hr>  
          <button>Contact Poster </button><button>Trade</button>
        </span>
	</div>
     </c:forEach> 
    </c:when>
    <c:otherwise> 
        <TR>
     		<TD>No Result!!!
     		</TD>
     	</TR>
    </c:otherwise> 
   </c:choose>  
    <div class="footer" align="center">
      
    </div>
	    

  </body>
</html>
