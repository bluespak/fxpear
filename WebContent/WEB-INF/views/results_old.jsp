<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.bluespak.vo.PearVO" %>


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
	
	<script>
		function login(){
			if(document.loginForm.id.value == ""){
				alert ("No ID");
				return;
			}
			document.loginForm.action = "./login.fx";
			loginForm.submit();
		}
		
		function logout(){
			document.loginForm.action = "./logout.fx";
			loginForm.submit();
		}		
		
		function upPear(){
			if(checkValid_upPear()){
				document.PearForm.action = "./pearup.fx";
				loginForm.submit();
			}
		}		
		
		function checkValid_upPear(){
			
			var ret = true;
			
			if(document.PearForm.suid.value == ""){
				alert(" If you want to post pear, you must be loggined");
				ret = false;
				return;
			}
			
			if(document.PearForm.sccd.value == ""){
				document.PearForm.sccd.focus();
				alert ("choose your currency you want to change.");
				ret = false;
				return;
			}
			
			if(document.PearForm.samt.value == ""){
				document.PearForm.samt.focus();
				alert ("input your money how much you want to change.");
				ret = false;
				return;
			}

			
			if(document.PearForm.trdt.value == ""){
				document.PearForm.bccd.focus();
				alert ("choose your date you want to change.");
				ret = false;
				return;
			}

			
			if(document.PearForm.bccd.value == ""){
				document.PearForm.bccd.focus();
				alert ("input the currency you want to change to.");
				ret = false;
				return;
			}
			
			if(document.PearForm.exlo.value == ""){
				document.PearForm.exlo.focus();
				alert ("choose your city you want to change.");
				ret = false;
				return;
			}
			
			return ret;
		}

	</script>
	
    <!-- Le styles -->
    <link href="css/bootstrap.css" rel="stylesheet">
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
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <link href="css/bootstrap-formhelpers.css" rel="stylesheet">
    <link href="css/pear.css" rel="stylesheet">
    

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

   
    <!-- Navbar --><div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#">Currency Pear</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="#">Home</a></li>
              <li><a href="#contact">How it works</a></li>
              <li><a href="#postModal" data-toggle="modal" data-target="#postModal">Post your currency</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Browse currencies <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="#">by location</a></li>
                  <li><a href="#">by currency</a></li>
                  <li><a href="#">by amount</a></li>
                  <li class="divider"></li>
                  <li class="nav-header">Nav header</li>
                  <li><a href="#">Separated link</a></li>
                  <li><a href="#">One more separated link</a></li>
                </ul>
              </li>
              <li><a href="#myModal" data-toggle="modal">Register</a></li>
            </ul>
       <c:if test="${empty sessionScope.logininfo}">
            <form class="navbar-form pull-right" name="loginForm" METHOD=POST>
              <input class="span2" type="text" placeholder="Email" name="id">
              <input class="span2" type="password" placeholder="Password" name="password">
              <button class="btn" onClick="javascript:login()">Sign in</button>
             
            </form>
		</c:if>
		<c:if test="${!empty sessionScope.logininfo}">
            <form class="navbar-form pull-right" name="loginForm" METHOD=POST>
              <div class="" style="color: #fff; float: right; line-height: 40px">
              <span>logged in as ${sessionScope.logininfo.fname} ${sessionScope.logininfo.lname} <a href="#" onclick="javascript:logout()" style="margin-left: 10px">Sign out</a></span>
            </div>
            </form>
		</c:if>	
          </div><!--/.nav-collapse -->
        </div>
      </div>
      <div class="post">
        <span>
        <img src="./img/au.png">
          <h5 style="display: inline; vertical-align: middle; font-weight: 300; padding: 10px">AUD</h5>
          <h2 style="display: inline; vertical-align: middle; font-weight: 400; background: #fff; padding: 20px">$400</h2>
          <h5 style="display: inline; vertical-align: middle; font-weight: 300; padding: 10px">Posted on: 29/06/2013</h5>
          <h5 style="display: inline; vertical-align: middle; font-weight: 300; padding: 10px">Expires on: 29/06/2013</h5>
          <h5 style="display: inline; vertical-align: middle; font-weight: 300; padding: 10px">Location: Sydney Airport</h5>
          <hr>
          <button>Contact Poster</button><button>Trade</button>
        </span>
      </div>
    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="./js/jquery.js"></script>
    <script src="./js/bootstrap-transition.js"></script>
    <script src="./js/bootstrap-alert.js"></script>
    <script src="./js/bootstrap-modal.js"></script>
    <script src="./js/bootstrap-dropdown.js"></script>
    <script src="./js/bootstrap-scrollspy.js"></script>
    <script src="./js/bootstrap-tab.js"></script>
    <script src="./js/bootstrap-tooltip.js"></script>
    <script src="./js/bootstrap-popover.js"></script>
    <script src="./js/bootstrap-button.js"></script>
    <script src="./js/bootstrap-collapse.js"></script>
    <script src="./js/bootstrap-carousel.js"></script>
    <script src="./js/bootstrap-typeahead.js"></script>
    <script src="./js/bootstrap-formhelpers-datepicker.js"></script>
    <script src="./js/bootstrap-formhelpers-datepicker.en_US.js"></script>
  </body>
</html>
