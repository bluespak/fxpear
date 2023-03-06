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
    <title>Welcome! Fxpear</title>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <meta name="description" content="">
    <meta name="author" content=""> 
       
    <link href="../bootstrap331/css/bootstrap.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="../bootstrap331/css/font-awesome.css" rel="stylesheet">
    <link href="../bootstrap331/css/style.css" rel="stylesheet">
    <style>
        body {
        padding-top: 50px;
        padding-bottom: 20px;
				background: url("../bootstrap331/img/money.jpg");
        }
    </style>
  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="../bootstrap/js/html5shiv.js"></script>
    <![endif]-->   

  </head>
    
  <body onload="initialize()">   
  	<script>
  	var initialLocation;
  	var browserSupportFlag =  new Boolean();
  	var initialLatitute;
  	var initialLongitude;
  	
  	function initialize() {
//	alert("initialize");
  		
  	  if(navigator.geolocation) {
  	    browserSupportFlag = true;
  	    var location_timeout = setTimeout("handleNoGeolocation()", 10000);
  	    navigator.geolocation.getCurrentPosition(function(position) {
  	    //navigator.geolocation.getCurrentPosition(successCallback,errorCallback,{timeout:10000});
  	    //	alert("getCurrentPosition");
 	    	initialLatitute = position.coords.latitude;
  	    	initialLongitude = position.coords.longitude;
  	    	document.searchForm.initLatitute.value = initialLatitute;
  	    	document.searchForm.initLongitute.value = initialLongitude;
  	    }, function errorCallback(error) {
  	  //      clearTimeout(location_timeout);
  	  //      geolocFail();  	   
  	      handleNoGeolocation(browserSupportFlag);
  	    },
  	    {
  	    	enableHighAccuracy: true,
            maximumAge:3000,
            timeout:5000 	    	
  	    });
  	  }else {
  		//Browser doesn't support Geolocation
  	    browserSupportFlag = false;
  	    handleNoGeolocation(browserSupportFlag);
  	  }

  	  	function handleNoGeolocation(errorFlag) {
  		    if (errorFlag == true) {
  		      alert("Geolocation service failed.");
  		    } else {
  		      alert("Your browser doesn't support geolocation. We've placed you in Siberia.");
   		    }
  		}
  	  
  	} 	
  	

 
	function searchPearByPosition(){
	
		$('.myForm')
		  var txtiwant = $('#Iwant');
		  var txtihave = $('#Ihave');
		  txtiwant.val("" + txtiwant.val().substring(0,3));
		  txtihave.val("" + txtihave.val().substring(0,3));
		;

		if(document.searchForm.initLatitute.value == "0"){
			alert("Couldn't access your location. Use Search Button Please.");
			return;
		}
		if(document.searchForm.sccd.value == ""){
			document.searchForm.sccd.value = "all";
			document.searchForm.bccd.value = "all";
		}		
		
		if(checkValid_searchPear()){
			document.searchForm.action = "./searchPearByPosition.fx";
			searchForm.submit();
		}
		
  	} 	
  	
	function searchPear(){

		if(document.searchForm.sccd.value == ""){
			document.searchForm.sccd.value = "%";
		}		
		
		if(checkValid_searchPear()){
			document.searchForm.action = "./searchPear.fx";
			searchForm.submit();
		}
	}		
	
	function checkValid_searchPear(){
		var ret = true;
/*			
		if(document.PearForm.suid.value == ""){
			alert(" If you want to post pear, you must be loggined");
			ret = false;
			return;
		}
*/			
		if(document.searchForm.sccd.value == ""){
			alert("Please tell us what currency you have.");
			ret = false;
			return;
		}

		if(document.searchForm.sccd.value == ""){
			alert("Please tell us what currency you want.");
			ret = false;
			return;
		}

		return ret;
	} 

	</script>    
	
    <div id="wrap" style="background: rgba(25,207,155,.90) !important;">
    <jsp:include page="./menuM.jsp"></jsp:include>
    
    <div class="container" style="margin: 0 auto;">
	<div class="jumbotron text-center" style="background: none; padding-bottom: 0; margin-bottom: 0; padding-top: 0">
		<img class="img-responsive" style="margin-left: auto; margin-right: auto" src="../bootstrap331/img/pearapp.png">
            <h2 class="lead" style="font-size: 28px; color: #fff">Find someone to exchange currency with. <button class="btn btn-md btn-grey">Learn more »</button></h2>
        </div>
    </div>

    <div class="container m0" style="margin: 0 auto; text-align: center; padding-top: 0;">
	<div class="container">
	  <form class="myForm" role="form" METHOD=POST name="searchForm" target='_new'>
	    <input name="snum" type="hidden" value="0">
            <input name="qnum" type="hidden" value="6">
	    <div class="jumbotron" style="background: none; padding: 0;">
	      <div class="row">
		  <div style="max-width: 782px; margin: 0 auto; text-align: center;">
		      <div class="form-group">
			  <label>What currency do you have?</label>
			  <input name="bccd" id="Ihave" class="currencycode form-control vertical typeahead tt-query" type="text" placeholder="e.g. USD" autocomplete="off" spellcheck="false" style="position: relative; vertical-align: top; background-color: transparent; background: none; margin-bottom: 10px">
			  <input name="suid" type="hidden" value="${sessionScope.logininfo.id}">
		      </div>
		      <div class="form-group">
			  <label>What currency do you want?</label>
			  <input name="sccd" id="Iwant" class="currencycode form-control vertical typeahead tt-query" type="text" placeholder="e.g. GBP" autocomplete="off" spellcheck="false" style="position: relative; vertical-align: top; background-color: transparent; margin-bottom: 10px">
		      </div>
		      <div class="text-right">
			 <input type="submit" onClick="javascript:searchPearByPosition()" onkeydown="javascript:searchPearByPosition()" class="btn btn-lg btn-grey vertical submitBtn" value="Search »">
	      	      </div>
		  </div>
              </div>
            </div>
	    <input type="hidden" name="buid" value="${sessionScope.logininfo.id}">
	    <input type="hidden" name="initLatitute" value="0">
	    <input type="hidden" name="initLongitute" value="0">
	  </form>
	</div>
    </div>
    </div>
    <div id="footer">
      <hr>
      <div class="container">
	<div class="row">
	  <div class="col-md-12">
	    <ul class="list-inline text-center">
            <li>
	     <div class="dropup">
	      <a class="dropdown-toggle" data-toggle="dropdown" style="cursor: pointer">About</a>
	      <ul class="dropdown-menu" style="text-align: left">
		<li><a>Company</a></li>
		<li><a>Team</a></li>
		<li><a>FAQ</a></li>
		<li><a>Blog</a></li>
	      </ul>
	    </div>
	    </li>
	    <li><a href="../bootstrap331/tos.html">Legal</a></li>
	    <li><a href="#">Safety & security</a></li>
        </ul>
	</div>
	</div>
	</div>
    </div>
	<script src="../jquery/js/jquery.js"></script>
	<script src="../bootstrap331/js/bootstrap.js"></script>
	<script src="../bootstrap331/js/twitter-typeahead.js"></script>
	<script>
        jQuery (function() {
        $('.currencycode').typeahead({                                
            name: 'mycodes',                                                          
            prefetch: '../bootstrap/codes.json',
            limit: 10                                                                  
          });
        });
    </script>
	
    <script type="text/javascript">
      $(document).ready(function(){
       $("#Ihave").focus();
	$('.vertical').keypress(function(event){
                if(event.which == 13) { 
                textboxes = $("input.vertical");
                debugger;
                currentBoxNumber = textboxes.index(this);
                if (textboxes[currentBoxNumber + 1] != null) {
                    nextBox = textboxes[currentBoxNumber + 1]
                    nextBox.focus();
                    nextBox.select();
                    event.preventDefault();
                    return false 
                    }
                }
            });
      })
    </script>
    <script>
      $('#myBtn').click(function() {
	var x = $('#Ihave').val();
	var y = $('#Iwant').val();
	$('#Ihave').val(y);
	$('#Iwant').val(x);
	  });
    </script>
    
    <script>
      $(function() {
      // Fix input element click problem
      $('.dropdown-toggle input').click(function(e) {
	e.stopPropagation();
      });
    });
    </script>

  </body>
</html>

