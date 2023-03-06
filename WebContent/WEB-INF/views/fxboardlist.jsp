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
 /*        padding-top: 60px; */
         /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>
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
 <script>
		 function goBoardView(fxseq){
			    	var url = "./fxboardView.fx?fxcat=${param.fxcat}&fxseq="+fxseq;
			   		 location.href = url;
		}

		 function goRegBoard(){
				location.href = "./fxboardpost.fx?fxcat=${param.fxcat}";
		 }
		 


</script>

         <div class="container">
       <!--        <div class="span12">
        <div class="span3 offset1" style="background: #fff; padding: 40px 40px; height: 2000px">
         <div class="tabbable tabs-left" > 

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
          <li <%if(request.getParameter("fxcat").equals("notice")){out.println("class=\"active\"");} %>><a href="./fxboardlist.fx?fxcat=notice" ><i class="icon-user"></i> Fxpear Notice</a></li>
          <li <%if(request.getParameter("fxcat").equals("travel")){out.println("class=\"active\"");} %>><a href="./fxboardlist.fx?fxcat=travel" ><i class="icon-user"></i> Travel Information</a></li>
          <li <%if(request.getParameter("fxcat").equals("qna")){out.println("class=\"active\"");} %>><a href="./fxboardlist.fx?fxcat=qna"><i class="icon-user"></i>  Q&A</a></li>
         </ul>
      
      </div>

           </div>
        -->  
        <div class="span10" style="background: #fff;margin-left: 0;">
          <div class="box span9" style="padding: 40px 40px 40px 20px; ">
            <div>
              <h1>${info.catinfo.catname}</h1><hr class="soften">
            </div>
            <table class="table table-hover">
              <thead>
                <tr>
                  <th width="5%">No.</th>
                 <th >Title</th>
                  <th width="20%">Register</th>
                  <th width="20%">reg date</th>
                </tr>
              </thead>
              <tbody>
         <c:choose>
    <c:when test="${!empty info.boardlist}">
     <c:forEach items="${info.boardlist}" var="list" varStatus="st">

                <tr>
                  <td><a href="#" onClick="javascript:goBoardView('${list.fxseq}');">FX${list.fxseq}</a></td>
                  <td>${list.title}</td>
                  <td>${list.fname} ${list.lname}</td>
                  <td><span data-localtime-format="yyyy/MM/dd HH:mm:ss">${fn:substring(list.wrdt,0,19)}Z</span></td>
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
					<a href="#" class="btn btn-primary btn-small" onClick="javascript:goRegBoard()">new</a>

              </tbody>
            </table>
          </div>
        </div>
        </div>
     <jsp:include page="./js_include.jsp"></jsp:include>        
</body>
</html>