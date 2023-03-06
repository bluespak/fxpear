<%@ page session="false" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bluespak.vo.UserVO" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %> 

<html>
<head>
<title>Spring 3.0 MVC Series: Hello World</title>
</head>
<script src="js/bootstrap-typeahead.js"></script>
<script>
function insert(){
	alert('Insert');
	if(document.userForm.id.value == ""){
		alert ("No ID");
		return;
	}
	document.userForm.action = "userInsert.fx";
	userForm.sumit();
}

function update(){
	
	alert('Update');
	if(document.userForm.id.value == ""){
		alert ("No ID");
		return;
	}
	
	document.userForm.action = "userUpdate.fx";
	userForm.sumit();
}


</script>

<body>
<%
/*
List userlist = (List)request.getAttribute("userlist");

for(int i=0;i<userlist.size();i++){

	

	out.println(i+"="+userlist.get(i)+"<BR/>");
	UserBOImpl userBO = (UserBOImpl)userlist.get(i);
	out.println(userBO.getID()+"||"+userBO.getNAME()+"||"+userBO.getADDRESS());
	

}
*/
%>
<BR>
<BR>
<Table border="1">
<c:choose>
    <c:when test="${!empty info.userlist}">
     <c:forEach items="${info.userlist}" var="list" varStatus="st">

     	<TR>
     		<TD>ID :: <a href="userSelect.fx?id=${list.id}">${list.id}</a>
     		</TD>
    		<TD>PASSWORD :: ${list.password}
     		</TD>
   		<TD>NAME :: ${list.name}
     		</TD>
   		<TD>NATION :: ${list.nation}
     		</TD>
   		<TD>CITY :: ${list.city}
     		</TD>
   		<TD>Address :: ${list.address}
     		</TD>
   		<TD><a href="userDelete.fx?id=${list.id}">delete</a>
     		</TD>
     	</TR>
     </c:forEach>
    </c:when>
    <c:otherwise> 
        <TR>
     		<TD>No Result!!!
     		</TD>
     	</TR>
    </c:otherwise> 
   </c:choose>  
     
     </Table>
 <BR> 
 <FORM NAME=userForm METHOD=POST >

    <input type="text"  data-provide="typeahead" data-source='["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Dakota","North Carolina","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]'> 

     
<BR>     
ID : <INPUT TYPE=TEXT NAME=id SIZE=15 value="${info.selectone.id}"><BR>
PASSWORD : <INPUT TYPE=TEXT NAME=password SIZE=30 value="${info.selectone.password}"><BR>
NAME : <INPUT TYPE=TEXT NAME=name SIZE=30 value="${info.selectone.name}"><BR>
NATION : <INPUT TYPE=TEXT NAME=nation SIZE=30 value="${info.selectone.nation}"><BR>
CITY : <INPUT TYPE=TEXT NAME=city SIZE=30 value="${info.selectone.city}"><BR>
ADDRESS : <INPUT TYPE=TEXT NAME=address SIZE=30 value="${info.selectone.address}"><BR>
<button onClick="javascript:insert()" VALUE="insert">insert</button> <button onClick="javascript:update()" VALUE="update">update</button>
</FORM>


     ID : <c:out value="${param.id}" /><BR>
	password : <c:out value="${param.password}" /><BR>


     
</html>