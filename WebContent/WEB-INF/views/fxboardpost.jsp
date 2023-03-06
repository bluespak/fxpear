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
/*         padding-top: 60px; */
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
 function insertBoard(){
		document.boardForm.method = "POST";
		document.boardForm.action = "./insertBoard.fx";
		document.boardForm.submit();
}
 </script>

 <script src="./bootstrap/js/wysihtml5.js"></script>
 <script src="./bootstrap/js/bootstrap-wysihtml5.js"></script> 

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
          <li <%if(request.getParameter("fxcat").equals("notice")){out.println("class=\"active\"");} %>><a href="./fxboardlist.fx?fxcat=notice" ><i class="icon-user"></i> Fxpear Notice</a></li>
          <li <%if(request.getParameter("fxcat").equals("travel")){out.println("class=\"active\"");} %>><a href="./fxboardlist.fx?fxcat=travel" ><i class="icon-user"></i> Travel Information</a></li>
          <li <%if(request.getParameter("fxcat").equals("qna")){out.println("class=\"active\"");} %>><a href="./fxboardlist.fx?fxcat=qna"><i class="icon-user"></i>  Q&A</a></li>
       </ul>
        
      </div>
        </div>
        
  -->      
        <div class="span10" style="background: #fff;margin-left: 0;">
          <div class="box span9" style="padding: 40px 40px 40px 20px ">
            <div><h1>${info.catinfo.catname}</h1><hr class="soften"></div>
           	<form NAME="boardForm">
            	<div id="board">
  				    <input name="fxcat" type="hidden" value="${param.fxcat}"/>
 				    <input name="uid" type="hidden" value="${sessionScope.logininfo.id}"/>
				    <input id="title" name="title" type="text"  class="input-block-level" placeholder="..input title" />
            		
					<textarea id="bcont" name="story" placeholder="Enter text ..."  style="height:300px;width:100%" class="resizable" placeholder="Enter your Story ..." autofocus></textarea>
	<!-- 				<script src="./bootstrap/js/wysihtml_locales/bootstrap-wysihtml5.ko-KR.js"></script>  -->
					<script type="text/javascript"> 
					
						$('#bcont').wysihtml5({
			//				locale: "ko-KR", 
							stylesheets: ["./bootstrap/css/wysiwyg-color.css"],
							customTemplates: myCustomTemplates,
							"font-styles": true, //Font styling, e.g. h1, h2, etc. Default true
							"emphasis": true, //Italics, bold, etc. Default true
							"lists": true, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
							"html": true, //Button which allows you to edit the generated HTML. Default false
							"link": true, //Button to insert a link. Default true
							"image": true, //Button to insert an image. Default true,
							"color": true //Button to change color of font  
						});
						
						var myCustomTemplates = {
								  html : function(locale) {
								    return "<li>" +
								           "<div class='btn-group'>" +
								           "<a class='btn' data-wysihtml5-action='change_view' title='" + locale.html.edit + "'>HTML</a>" +
								           "</div>" +
								           "</li>";
								  }
								}

					</script>
				</div>
					<a href="#" class="btn btn-primary btn-small" onClick="javascript:insertBoard()">Write</a>
				</form>
				
          </div>

        </div>
        </div>
     <jsp:include page="./js_include.jsp"></jsp:include>        
</body>
</html>