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

<%
String mode = request.getParameter("mode");
if(mode == null){
	mode ="view";
}

%>

<!DOCTYPE html>
<html lang="en"><head>
    <meta charset="utf-8">
    <title>Bootstrap, from Twitter</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <jsp:include page="./css_include.jsp"></jsp:include> 
	<link href="./bootstrap/css/bootstrap-wysihtml5.css" type="text/css" rel="stylesheet">

    <style>
      body {
        background: url(./bootstrap/img/bbgg.png);
/*         padding-top: 60px;  */
        /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>


    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../ico/apple-touch-icon-57-precomposed.png">
    <link rel="shortcut icon" href="../ico/favicon.png">

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
 function goRegBoard(){
		location.href = "./fxboardpost.fx?fxcat=${param.fxcat}";
 }
 
 function goList(){
		location.href = "./fxboardlist.fx?fxcat=${param.fxcat}";
 }
 
 function goDelete(){
	 if(confirm('Do you want to delete this post.?')){
		location.href = "./fxboarddelete.fx?fxcat=${param.fxcat}&fxseq=${param.fxseq}";
	 }
 }
 
 function goUpdate(){
		document.boardForm.method = "POST";
		document.boardForm.action = "./updateBoard.fx";
		document.boardForm.submit();
 }
 
 function goReply(){

	 	var fxseq = document.boardForm.fxseq.value;
		var ruid = document.boardForm.ruid.value;
		var reply = document.boardForm.reply.value;
		var datastring = "fxseq="+fxseq+"&ruid="+ruid+"&reply="+encodeURIComponent(reply);		
	    jQuery.ajax({
	           type:"POST",
	           async : true,
	           url:"./insertReply.fx",
	           data:datastring,
	           dataType:"JSON", 
	           success : function(data) {
	        	   alert('saved your reply successfully.');
	        	   var rpseq = data.rpseq;
	        	   var reply = data.reply;
	        	   alert("reply:"+reply);
	                 // TODO
	           },
	           complete : function(data) {
	                 // TODO
	           },
	           error : function(xhr, status, error) {
	                 alert("xhr="+xhr);
	                 alert("status="+status);
	                 alert("error="+error);
	           }
	     });
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
           	<form id="boardForm" NAME="boardForm">
            	<div id="board">
				    <input name="fxseq" type="hidden" value="${info.detailinfo.fxseq}"/>
  				    <input name="fxcat" type="hidden" value="${info.detailinfo.fxcat}"/>
 				    <input name="ruid" type="hidden" value="${sessionScope.logininfo.id}"/>
				    <div>Post : <img class="img-rounded" style="margin-bottom: 10px" src="http://graph.facebook.com/${info.detailinfo.fbuid}/picture?width=12&height=12"> ${info.detailinfo.fname} ${info.detailinfo.lname}</div>
				    <div>Regist Date : <span data-localtime-format="yyyy/MM/dd HH:mm:ss">${fn:substring(info.detailinfo.wrdt,0,19)}Z</span> <a><abbr class="timeago" title="${fn:substring(info.detailinfo.wrdt,0,19)}Z"></abbr></a></div>
 					<%if(mode.equals("view")){%>
 				    <div>Title : ${info.detailinfo.title}</div>
            		<%}else	{ %>
  				    <input id="title" name="title" type="text" value="${info.detailinfo.title}" class="input-block-level" placeholder="..input title" />
            		
            		<%} %>
					<textarea id="bcont" name="story" <%if(mode.equals("view")){out.println("disabled");} %> style="height:300px;width:100%" class="resizable" placeholder="Enter your Story ..." autofocus>${info.detailinfo.story}</textarea>
			<!-- 	<script src="./bootstrap/js/wysihtml_locales/bootstrap-wysihtml5.ko-KR.js"></script>  -->
					<script type="text/javascript">
					<%
					String toolbar_boolean = "false";
					if(mode.equals("edit")){
						
						toolbar_boolean = "true";
					}
					%>
						$('#bcont').wysihtml5({
					//		locale: "ko-KR", 
							stylesheets: ["./bootstrap/css/wysiwyg-color.css"],
							customTemplates: myCustomTemplates,
							"font-styles": <%=toolbar_boolean%>, //Font styling, e.g. h1, h2, etc. Default true
							"emphasis": <%=toolbar_boolean%>, //Italics, bold, etc. Default true
							"lists": <%=toolbar_boolean%>, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
							"html": <%=toolbar_boolean%>, //Button which allows you to edit the generated HTML. Default false
							"link": <%=toolbar_boolean%>, //Button to insert a link. Default true
							"image": <%=toolbar_boolean%>, //Button to insert an image. Default true,
							"color": <%=toolbar_boolean%> //Button to change color of font  
						});
						
						var myCustomTemplates = {
								  html : function(locale) {
								    return "<li>" +
								           "<div class='btn-group'>" +
								           "<a class='btn' data-wysihtml5-action='change_view' title='" + locale.html.edit + "'>HTML</a>" +
								           "</div>" +
								           "</li>";
								  }
								};
						<%if(mode.equals("view")){%>
						function enforceInactiveStates() {
						    var disabled = this.textareaElement.disabled;
						    var readonly = !!this.textareaElement.getAttribute('readonly');

						    if (readonly) {
						        this.composer.element.setAttribute('contenteditable', false);
						        this.toolbar.commandsDisabled = true;
						    }

						    if (disabled) {
						        this.composer.disable();
						        this.toolbar.commandsDisabled = true;
						    }
						}
						editor.on( 'load', enforceInactiveStates );
						<%}%>
						
						function enforceActiveStates(){
							 this.editor.composer.element.setAttribute('contenteditable', true);
						     this.editor.toolbar.commandsDisabled = false;
					//	     this.composer.disable();
						}
						
						function checkEditMode(){
							var editswitch = document.boardForm.editswitch.checked;
							if(editswitch){
								location.href="./fxboardView.fx?fxcat=${param.fxcat}&fxseq=${param.fxseq}&mode=edit";
							}else	{
								location.href="./fxboardView.fx?fxcat=${param.fxcat}&fxseq=${param.fxseq}&mode=view";
							}
						}
					</script>
          <c:choose>    
            <c:when test="${info.catinfo.repyn == 'Y'}">
				<div>
					<textarea id="reply" name="reply" style="height:50px;width:100%" class="resizable" placeholder="Enter your reply ..." autofocus></textarea>
				</div>
            </c:when>
		  </c:choose>			
				</div>
					<a href="#" class="btn btn-primary btn-small" onClick="javascript:goRegBoard()">New</a>
					<a href="#" class="btn btn-primary btn-small" onClick="javascript:goList()">List</a>
	
         <c:choose>    
            <c:when test="${info.detailinfo.uid == sessionScope.logininfo.id}">
					<a href="#" class="btn btn-primary btn-small" onClick="javascript:goDelete()">Delet</a>
						<%if(mode.equals("edit")){%>
					<a href="#" class="btn btn-primary btn-small" onClick="javascript:goUpdate()">Update</a>				
						<%}%>					
		  			<input type="checkbox" name="editswitch" <%if(!mode.equals("view")){out.println("checked");} %> onClick="javascrip:checkEditMode()">Edit Mode
            </c:when>
		  </c:choose>			
         <c:choose>    
            <c:when test="${info.catinfo.repyn == 'Y'}">
					<div align="right"><a href="#" class="btn btn-primary btn-small right" onClick="javascript:goReply()">Reply</a></div>
            </c:when>
		  </c:choose>		
				</form>
				
          </div>
          </div>
        </div>
    <jsp:include page="./js_include.jsp"></jsp:include>         
</body>
</html>