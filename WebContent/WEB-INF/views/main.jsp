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
<%
int qnum = 7;	// How much data show a page..

%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Welcome FXpear!</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <jsp:include page="./css_include.jsp"></jsp:include> 
      
    <style>
      body {
        background: url(./bootstrap/img/bgg.png);
/*         padding-top: 40px;  */
        /* 60px to make the container go all the way to the bottom of the topbar */
        }
        .jumbotron h1 {
        font-size: 100px;
        line-height: 1;
      
      }
    </style>

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="./bootstrap/js/html5shiv.js"></script>
    <![endif]-->

  </head>

  <body onload="initialize()">
    <jsp:include page="./menu.jsp"></jsp:include>
  	<script>
    $(document).ready(function () {
    	
        $('#major_currency_sccd').change(function () {
        	getMajorCurrency_SCCD();
        });

        $('#major_currency_bccd').change(function () {
        	getMajorCurrency_BCCD();
        });	
        
        $('#major_currency_sccd > option')[1].selected = true;
	
	 $('#major_currency_bccd > option')[1].selected = true;
        callCurrency();

        
       	$('#std_rate').text(document.searchForm.bccd.value + " 1.0 =");
       	
        $('#sccd_selectbox').change(function () {
        	
        	if(document.searchForm.sccd.value != "" || document.searchForm.bccd.value != ""){
        		callCurrency();
        	}
        });  
        
        $('#bccd_selectbox').change(function () {
        	if(document.searchForm.sccd.value != "" || document.searchForm.bccd.value != ""){
        		callCurrency();
        	}
        });      
        
    });	  	
  	
    function callCurrency(){
    	var bccd_val = "USD";
    	var sccd_val = "AUD";
    	if (document.searchForm.bccd.value != "" && document.searchForm.sccd.value != ""){
    		bccd_val = document.searchForm.bccd.value;
    		sccd_val = document.searchForm.sccd.value;
    	}
    	
    	jQuery.ajax({
    	    type: "GET",
    	    url: "./currencyinfo.fx",
    	    dataType: "json",
    	    contentType: "application/json; charset=utf-8",
    	    data: "from="+bccd_val+"&to="+sccd_val,
    	    success: function(data) {
    	    	var srate = data.query.results.rate.Rate;
    	    	var mrate = 1 ;
    	    	
       	    	if((srate < 0.5) && (srate > 0.1)){
    	    		mrate = 10;    	    		
       	    	}else if((srate < 0.1) && (srate > 0.01)){
        	    		mrate = 100;    	    		
    	    	}else if(srate < 0.01){
    	    		mrate = 1000; 	 
    	    		
    	    	}
       	    	

	            $('#kiosk_rate').text(sccd_val + " " + Math.round(srate * mrate * 0.95 * 10000)/10000);
	            $('#bank_rate').text(sccd_val + " " + Math.round(srate * mrate * 0.9 * 10000)/10000);
	            $('#interbank_rate').text(sccd_val + " " + Math.round(srate * mrate * 10000)/10000);

	            	
	            $('#std_rate').text(bccd_val +" "+mrate+ "=");

	
    	   },
    	   error: function (xhr, ajaxOptions, thrownError) {
    	        alert(xhr.status);
    	       alert(thrownError);
    	   }
    	});    	
    	
    }
    
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

		if(document.searchForm.initLatitute.value == "0"){
			alert("Couldn't access your location. Use Search Button Please.");
			//Temp setting for Error for getting Location.
			document.searchForm.initLatitute.value = "-32.5367";
			document.searchForm.initLongitute.value = "115.743"	;		

			//	return;
		}
		if(document.searchForm.sccd.value == ""){
			document.searchForm.sccd.value = "all";
		}		
		if(document.searchForm.bccd.value == ""){
			document.searchForm.bccd.value = "all";
		}
		
		
		if(checkValid_searchPear()){
			document.searchForm.action = "./searchPearByPosition.fx";
			searchForm.submit();
		}
  	} 	
  	
	function searchPear(){

		if(document.searchForm.sccd.value == ""){
			document.searchForm.sccd.value = "";
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
	var currencies = new bfhcurrencies();
	function getMajorCurrency_SCCD(){
		var sel_currency = document.searchForm.major_currency_sccd;
		
		if(sel_currency.selectedIndex == 1){	

			var $sccd_currencies = $('#sccd_selectbox');
		    $sccd_currencies.data('bfhcurrencies','');
		    $sccd_currencies.data('currencylist','USD,EUR,AUD,GBP,CHF,JPY,CAD,CNY,HKD,INR,KRW');
     		$sccd_currencies.bfhcurrencies($sccd_currencies.data());

		}else	if(sel_currency.selectedIndex == 0){ 
			
		    var $sccd_currencies = $('#sccd_selectbox');
		    $sccd_currencies.data('bfhcurrencies','');
		    $sccd_currencies.data('currencylist','');
     		$sccd_currencies.bfhcurrencies($sccd_currencies.data());

     		}
	  

	}
		
	function getMajorCurrency_BCCD(){
		var sel_currency = document.searchForm.major_currency_bccd;
		
		if(sel_currency.selectedIndex == 1){	

		    var $bccd_currencies = $('#bccd_selectbox');
		    $bccd_currencies.data('bfhcurrencies','');
		    $bccd_currencies.data('currencylist','USD,EUR,AUD,GBP,CHF,JPY,CAD,CNY,HKD,INR,KRW');
     		$bccd_currencies.bfhcurrencies($bccd_currencies.data());
    		 
		}else	if(sel_currency.selectedIndex == 0){ 
			
		    var $bccd_currencies = $('#bccd_selectbox');
		    $bccd_currencies.data('bfhcurrencies','');
		    $bccd_currencies.data('currencylist','');
     		$bccd_currencies.bfhcurrencies($bccd_currencies.data());

     		}
	  

	}
	
	</script>    
 
    <div class="container" style="margin-top: 40px; margin-bottom: 40px" align="center">
      <div class="ho pad featured" align="center">FX PEAR  gets you the<b class="text-success"> interbank rate!</b></div>
      <div align="center">
	<p class="mo lead pad"><b>FX PEAR</b> connects you with people who have the foreign currency you want, and vice versa. 
        <br>By exchanging directly with each other, both you and your exchange counterpart get the best exchange rate possible - the <b style="color: #51a351;  font-weight: 300">interbank rate</b>.
	<br><small>
          <i style="color: #51a351;" class="icon-play"></i> Start now by <a style="color: #51a351;">posting</a> your currency or find currencies using the search box below.
        </small>
      </p>
      </div>
      <p class="container lead mo featured2" style="height: 100px; position: absolute">
      </p>
    </div>

    <div class="jumbotron masthead" style="color: #fff; background: url(./bootstrap/img/gl.jpg) repeat;">
      <div class="container" align="left">
        <div class="center" align="center" style="padding: 25px; margin-top: 5px; position: relative; bottom: 0px !important; margin-bottom: 0px">
          <form class="center" name="searchForm" METHOD=POST style="margin-bottom: 0px;">
              <input name="snum" type="hidden" value="0">
              <input name="qnum" type="hidden" value="<%=qnum%>">  
              <input name="suid" type="hidden" value="${sessionScope.logininfo.id}">
 	          <input type="hidden" name="buid" value="${sessionScope.logininfo.id}">
	          <input type="hidden" name="initLatitute" value="0">
	          <input type="hidden" name="initLongitute" value="0">
	          <input type="hidden" name="min_amt" value="0">
	          <input type="hidden" name="max_amt" value="1000">
	          
	          <div>
	      
              <div id="bccd_selectbox" class="bfh-selectbox bfh-currencies" data-currency="" data-currencyList="USD,EUR,AUD,GBP,CHF,JPY,CAD,CNY,HKD,INR,KRW" data-flags="true" align="left">
                <input name="bccd" type="hidden" value="">
                <a class="bfh-selectbox-toggle" role="button" data-toggle="bfh-selectbox" href="#">
                  <span class="bfh-selectbox-option input-xlarge" data-option="">What currency do you have?</span>
                </a>
                <div class="bfh-selectbox-options" align="left">
                  <input type="text" class="bfh-selectbox-filter" placeholder="search">
                  <div role="listbox">
		    <div class="mo" align="center">
		      <select id="major_currency_bccd"  background-color="#CCCCCC" class="input-medium"  name="major_currency_bccd">
			<option id="ALL">All currencies</option>
			<option id="MJR">Major currencies</option>
		      </select>
		    </div>
                  <ul role="option"></ul>
                  </div>
                </div>
              </div> 
               <div id="sccd_selectbox" class="bfh-selectbox bfh-currencies" data-currency="" data-flags="true" data-currencyList="USD,EUR,AUD,GBP,CHF,JPY,CAD,CNY,HKD,INR,KRW" align="left">
                <input name="sccd" type="hidden" value="">
                <a class="bfh-selectbox-toggle" role="button" data-toggle="bfh-selectbox" href="#">
                  <span class="bfh-selectbox-option input-xlarge" data-option="" >What currency do you want? <i class="icon-sort" style="vertical-align: middle"></i></span>
                </a>
                <div class="bfh-selectbox-options" align="left">
                  <input type="text" class="bfh-selectbox-filter" placeholder="search">
                  <div role="listbox">
		    <div class="mo" align="center">
		      <select id="major_currency_sccd"  background-color="#CCCCCC" class="input-medium"  name="major_currency_sccd">
			<option id="ALL">All currencies</option>
			<option id="MJR">Major currencies</option>
		      </select>
		    </div>
                  <ul role="option"></ul>
                  </div>
                </div>
              </div>
                <a href="#" class="btn btn-success btn-large" onClick="javascript:searchPearByPosition()" style="vertical-align: top;height: 24px;line-height: 24px;"><i class="icon-search"></i>My Location!</a>
              </div>
          </form>
      </div>
      </div>
    </div>
    
    <div class="container" style="margin-top: 40px;">
      <div class="span1 pad mo" style="background: #51a351; line-height: 100px;" align="center">
        <img style="vertical-align: middle;" src="./bootstrap/img/calc48 copy.png">
      </div>
      <form>
      <div style="background: #f5f5f5; min-height: 140px; vertical-align: middle">
        <ul class="pad unstyled" style="float: right; padding-left: 0px !important">
          <li class="span3 pad mo ho" style="font-size: 18px; font-weight: 300; border-right: 1px solid #ddd; max-width: 380px"><b style="font-weight: 500; margin-bottom: 10px" id="std_rate" ></b></li>
          <li class="span1half pad mo" style="font-size: 18px; font-weight: 300; border-right: 1px solid #ddd"><b style="font-weight: 500; margin-bottom: 10px">Typical kiosk rate</b><br><p class="mo text-error" id="kiosk_rate"><b>AUD </b>0.96726</p></li>
          <li class="span1half pad mo" style="font-size: 18px; font-weight: 300; border-right: 1px solid #ddd"><b style="font-weight: 500; margin-bottom: 10px">Typical bank rate</b><br><p class="mo text-warning" id="bank_rate"><b>AUD </b>0.98726</p></li>
          <li class="span1 mo" style="max-width: 40px; padding-left: 15px; line-height: 140px; color: #51a351;" align="center"><i class="icon-ok-circle icon-4x"></i></li>
          <li class="span1half pad mo" style="font-size: 18px; font-weight: 300;"><b style="font-weight: 500; margin-bottom: 10px">FX PEAR / Interbank rate</b><br><p class="mo text-success" id="interbank_rate"><b>AUD </b>1.00684</p></li>
        </ul>
      </div>
      </form>
    </div>
    
    <hr class="dark">
      
    <div class="bs-docs-social pad" style="background: #f8f8f8; border-top: 1px solid #ddd">
      <div class="container">
      <div class="row-fluid">
        <div class="span3">
          <ul class="unstyled">
            <li><b>FX PEAR</b></li>
            <br>
            <li><i style="color: #51a351;" class="icon-double-angle-right"></i> <a href="#">Company</a></li>
            <li><i style="color: #51a351;" class="icon-double-angle-right"></i> Team</li>
            <li><i style="color: #51a351;" class="icon-double-angle-right"></i> Blog</li>
            <li><i style="color: #51a351;" class="icon-double-angle-right"></i> Contact</li>
            <li><i style="color: #51a351;" class="icon-double-angle-right"></i> Press</li>
          </ul>
        </div>
        <div class="span3" style="border-right: 1px solid #ddd">
          <ul class="unstyled">
            <li><b><br></b></li>
            <br>
            <li><i style="color: #51a351;" class="icon-double-angle-right"></i> How FX PEAR works</li>
            <li><i style="color: #51a351;" class="icon-double-angle-right"></i> Why use FX PEAR</li>
            <li><i style="color: #51a351;" class="icon-double-angle-right"></i> Trust & Security</li>
            <li><i style="color: #51a351;" class="icon-double-angle-right"></i> Search</li>
            <li><i style="color: #51a351;" class="icon-double-angle-right"></i> Post</li>
          </ul>
        </div>
        <div class="span3">
          <span class="icon-stack icon-2x">
            <i class="icon-circle icon-stack-base" style="color: #51a351;"></i>
            <i class="icon-twitter" style="color: #fff;"></i>
          </span>
          Follow <a href="#">@FXPEAR</a>
        </div>
      </div>
      </div>
    </div>

    <jsp:include page="./js_include.jsp"></jsp:include> 
  </body> 
</html>

