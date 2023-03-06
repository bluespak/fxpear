<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.bluespak.vo.PearVO"%>
<%@ page import="com.bluespak.vo.BidVO"%>
<%@ page import="com.bluespak.utils.cd.NationCode"%>
<%@ page import="com.bluespak.utils.cd.CityCode"%>
<%@ page import="com.bluespak.utils.cd.CurrencyCode"%>
<%@ page import="com.bluespak.utils.cd.CurrencySymbol"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>  
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Sign in &middot; Twitter Bootstrap</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">



<jsp:include page="./css_include.jsp"></jsp:include> 
<link href="./bootstrap/css/slider.css" rel="stylesheet">
<link href="./bootstrap/css/snap.css" rel="stylesheet">
<link href="./bootstrap/css/demo.css" rel="stylesheet">
<link href="./bootstrap/css/daterangepicker.css" rel="stylesheet">
    
<style type="text/css">
#map_canvas {
        margin: 0;
        padding: 0;
        height: 100%;
        box-shadow: 0px 0px 10px 1px #6F6F6F;
}
.gmnoprint img { max-width: none; }
</style>

<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false&amp;libraries=places" type="text/javascript"></script>

<script type="text/javascript">

var geocoder = new google.maps.Geocoder();
var map;
var marker = [];
var infowindow ;
var infobox ;
var initialLocation;
var siberia = new google.maps.LatLng(60, 105);
var newyork = new google.maps.LatLng(40.69847032728747, -73.9514422416687);
var browserSupportFlag =  new Boolean();

var locationinfos  = [
                  <c:choose>
                  <c:when test="${!empty info.result}">
                   <c:forEach items="${info.result}" var="list" varStatus="st">
                   <c:set var="csymbol" scope="request" value="${list.sccd}"/>
                   ['<img class="img-rounded" src="http://graph.facebook.com/${list.fbuid}/picture?width=33&height=33&"><font color="blue"><B>${list.fname} ${list.lname}</B></font> wants to trade <font color="red"><B>${list.sccd} <%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %> ${list.samt}</B></font><br>until ${list.trdt} near <font color="brown"><B>${list.exlo}</B></font>', '${list.exlo}', '${list.pseq}'],
                   </c:forEach> 
                   </c:when>
                </c:choose>
                ['no want', 'LA', 0]
                ];   
                
           

/*                
function moveMapCenter() {

          if (!navigator.geolocation){
                alert("Geolocation is not supported by your browser");
            return;
          }

          function success(position) {
            latitude  = position.coords.latitude;
            longitude = position.coords.longitude;
            alert('latitude='+latitude + ' longitude='+longitude);
          };

          function error() {
                  alert('Unable to retrieve your location');
          };
          navigator.geolocation.getCurrentPosition(success, error);
        }
       
*/


function sleep(msecs) {
    var start = new Date().getTime(); var cur = start; while (cur - start <
    msecs) {
	cur = new Date().getTime();
    }
}

function initialize() {

        var mapOptions = {
                            zoom: 15,
                            mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        
        map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
        infowindow = new google.maps.InfoWindow({
                content: "loading..."
        });
        

  if(navigator.geolocation) {
    browserSupportFlag = true;
    var search_lat = "${param.initLatitute}";
    var search_lng = "${param.initLongitute}";
    navigator.geolocation.getCurrentPosition(function(position) {
    
      initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
      if(search_lat != "" && search_lng != ""){
          initialLocation = new google.maps.LatLng(search_lat,search_lng);
      }
      map.setCenter(initialLocation);
                snapper.open('left');
                snapperstat = false;
    }, function() {
      handleNoGeolocation(browserSupportFlag);
    });
  }else {
        //Browser doesn't support Geolocation
    browserSupportFlag = false;
    handleNoGeolocation(browserSupportFlag);
  }
        
        function handleNoGeolocation(errorFlag) {
            if (errorFlag == true) {
              alert("Geolocation service failed.");
              initialLocation = newyork;
            } else {
              alert("Your browser doesn't support geolocation. We've placed you in Siberia.");
              initialLocation = siberia;
            }
            map.setCenter(initialLocation);
            
        }
        
        
        setMarkers(map,locationinfos); 
}
  

function setMarkers(vmap,locationinfos) {
           var i = 0;
           for (i = 0; i < locationinfos.length -1; i++) {
              setMarker(vmap, locationinfos[i][1], locationinfos[i][2]);
           }

}


var infowindowsArray = [];

function clearOverlays(){
    if(infowindowsArray){
        for (i in infowindowsArray){
            infowindowsArray[i].setMap(null);
        }
    }
}


function setMarker(vmap, address, description) {     

//      alert('setMarker address='+address);
                geocoder = new google.maps.Geocoder();
                geocoder.geocode( { 'address': address }, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
               //     map.setCenter(results[0].geometry.location);

               
                    var marker = new google.maps.Marker({
                        position: results[0].geometry.location,
                        map: vmap,
                        html: description,
                        animation: google.maps.Animation.DROP,
                        icon: ('./img/au.png')
                    });
                      
                      
                      
                    var infobox = new InfoBox({
                        content: document.getElementById("infobox" + description),
                        disableAutoPan: false,
                        pixelOffset: new google.maps.Size(0, 0),
                        zIndex: 2,
                        closeBoxMargin: "4px 4px 4px 4px",
                        closeBoxURL: "http://dev.fxpear.com:8080/fxpear/img/close.png",
                        isHidden: false,
                    });
                    
                    
                    google.maps.event.addListener(marker, 'click', function() {
                   
        
                                clearOverlays();
                                
                                                infowindowsArray.push(infobox);


                        infobox.open(vmap, this);
                        map.panTo(loc);

                    });
                    
                    
                }else {
                 //   alert("Geocode was not successful for the following reason: " + status);
                }
            });  
        }

function closeinfobox(pseq){
        
}


function moveMapCenter(address,pseq){
          geocoder.geocode( { 'address': address}, function(results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                      map.setZoom(15);
                      map.panTo(results[0].geometry.location);
        //            var description = eval("document.resultForm.info_msg_"+pseq+".value");
                   //   var description = pseq;
                      setMarker(map, address, pseq);
                    } else {
                  //    alert('Geocode was not successful for the following reason: ' + status);
                    }
                  });
        
}


google.maps.event.addDomListener(window, 'load', initialize);


// Facebook Post
function fbPost(pseq){
                alert("fbPost");
                alert("fbloginChk="+fbloginChk);                
        if(fbloginChk == 1){
                var body = "hello currencypear http://www.currencypear.com:8080/fxpear/searchPearM.fx";
                FB.api('/me/feed', 'post', { message: body }, function(response) {
                        alert("fbpost response");
                          if (!response || response.error) {
                            alert('Error occured');
                          } else {
                            alert('Post ID: ' + response);
                          }
                });
                
        }else   {
                fbconnect("post");
        }                       
}

//Twitter Post
function twPost(pseq){
        alert("twPost");
        jQuery.ajax({
            type: "GET",
            url: "./tweetPost.fx",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: "pseq="+pseq,
            success: function(data) {
                alert("It posted in Twitter successfully.");
   //           alert(data);

           },
           error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
               alert(thrownError);
           }
        });
}

function goBid(pseq){

        var url = "./bidpearM.fx?pseq="+pseq+"&buid=${sessionScope.logininfo.id}";
        location.href = url;
}
/*
function goBid(pseq){
    <c:choose>    
            <c:when test="${!empty sessionScope.logininfo}">
                <c:choose>    
                        <c:when test="${!empty sessionScope.logininfo.fbuid}">
                        facebook_send_message(name, to,description,link);
                        </c:when>       
                        </c:choose>
                var url = "./bidpearM.fx?pseq="+pseq+"&buid=${sessionScope.logininfo.id}";
                location.href = url;
            </c:when>
            <c:otherwise>            
                alert('You need to be logged in to bid');
            </c:otherwise>  
   </c:choose>
}
*/
function goDetail(pseq){
                var url = "./summaryM.fx?cuid=${sessionScope.logininfo.id}&whoc=B&pseq="+pseq;
                location.href = url;
}

function goSDetail(pseq){
        var url = "./summaryM.fx?cuid=me&whoc=S&pseq="+pseq;
                 location.href = url;
}



function searchPearByPosition(){

        if(document.searchForm.initLatitute.value == "0"){
                alert("Couldn't access your location. Use Search Button Please.");
                return;
        }
        /*
        if(document.searchForm.sccd.value == ""){
                document.searchForm.sccd.value = "%";
        }               

        if(document.searchForm.bccd.value == ""){
                document.searchForm.bccd.value = "%";
        }               
        */
        
        if(checkValid_searchPear()){
                document.searchForm.action = "./searchPearByPositionM.fx";
                searchForm.submit();
        }
}       

    </script>

</head>

<!-- <body style='background: url(./img/bg.png);overflow:hidden' >
 -->
<body style='background: url(./img/bg.png)'>

        <jsp:include page="./menu.jsp"></jsp:include>
	
        
        <!--abbreviates long addresses in the list results-->
        <script>
            $(function(){
                $('.truncate').succinct({
                    size: 35
                });
            });
        </script>
        
        <script>
        $(document).ready(function(){
            $('#map_canvas').mouseover(function() {
                snapper.close('left');
                snapperstat = true;
            });
            $('#result-list').mouseover(function() {
                snapperstat = true;
            });
        });
      </script>
        
        <script type="text/javascript" src="./js/jquery-ias.js"></script>

        <script type="text/javascript">
        $(function(){
                window.prettyPrint && prettyPrint();

        $('#sl2').slider();

        var RGBChange = function() {
                var fpt = r.getValue()[0];
                var ept = r.getValue()[1];
                document.searchForm.min_amt.value = fpt;
                document.searchForm.max_amt.value = ept;
        $('#RGB').text ('$' + fpt + " - " + '$' + ept);
    };

    var r = $('#sl2').slider()
            .on('slide', RGBChange)
            .data('slider');


        $(document).ready(function(){
          $('#targetbar').hover(function() {
              $('#targeto').toggleClass('active');
          });
                });
        
        $(document).ready(function(){
          $('#targetbar').hover(function() {
              $('#targeto').toggleClass('progress-striped');
          });
                });



                  

        
    });
        
        
        <%
                        int qnum = 5;   // how many listviews when a query.
                        int pnum = 2;   // page no.
                        int snum = (pnum-1)*qnum +1;    //start view no.
                        System.out.println("bccd="+request.getParameter("bccd"));
                        System.out.println("sccd="+request.getParameter("sccd"));
                        String urlparams = "";
//                      urlparams = "bccd="+java.net.URLEncoder.encode(request.getParameter("bccd"))+"&sccd="+java.net.URLEncoder.encode(request.getParameter("sccd"))+"&suid="+request.getParameter("suid");
//System.out.println("urlparams1="+urlparams);
// {exlo=, qnum=6, min_amt=0, max_amt=1000, suid=, bccd=all, initLongitute=115.7367672, sccd=all, snum=0, initLatitute=-32.5205958}
        //              urlparams = urlparams +"&snum="+snum+"&qnum="+qnum;
                        urlparams = urlparams + "&bccd=" + request.getParameter("bccd")+ "&sccd="+request.getParameter("sccd");                 
                        urlparams = urlparams + "&max_amt=" + request.getParameter("max_amt")+ "&min_amt="+request.getParameter("min_amt");
                        urlparams = urlparams + "&initLongitute="+request.getParameter("initLongitute")+"&initLatitute="+request.getParameter("initLatitute");
//System.out.println("urlparams2="+urlparams);
                //      String encodedUrl = ""
                //      if(urlparams != null){
                //              encodedUrl = java.net.URLEncoder.encode(urlparams);
                //      }
//System.out.println("encodedUrl="+encodedUrl);
                %>                    
        var     resultpageNo = 2;
        var hasMoreData = true;
        $(document).ready(function() {
                

        
        $('#sccd_selectbox').change(function () {
                
                if(document.searchForm.sccd.value != "" || document.searchForm.bccd.value != ""){
                        
                   var sccd_flag = document.searchForm.sccd.value.substring(0,2);
                        $('#sccd_flag').attr("class","flag "+ sccd_flag);
                }
        });  
        
        $('#bccd_selectbox').change(function () {
                if(document.searchForm.sccd.value != "" || document.searchForm.bccd.value != ""){
                        $('#bccd_flag').attr("class","flag " + document.searchForm.bccd.value.substring(0,2));
                }
        });
        
            jQuery.ias({
                scrollContainer :  jQuery('.resultbox'), 
                container : '#content',
                item: '.post',
                pagination: '#content .navigation',
                next: '.next-posts a',
                loader: '<i class="icon-spinner icon-spin icon-3x"></i>',
                noneleft: true,
                triggerPageThreshold: 2,
                history: false,
                beforePageChange: function(scrollOffset, nextPageUrl) {
                        // pnum을 파라메타로 추가
//                      alert('nextPageUrl='+nextPageUrl);
                        if(hasMoreData){
                                var qnum = 10;
                                
                                $(function(){
                                    $('.truncate').succinct({
                                        size: 35
                                    });
                                });
                                
                                var path = $('.next-posts a').attr("href");
                                if(path.lastIndexOf("&snum") > 0 ){
                                        path = path.substring(0,path.lastIndexOf("&snum"));
                                } 
                                nextPageUrl = path + "&snum="+((resultpageNo-1)*qnum +1) +"&qnum="+qnum;
                                nextPageUrl = nextPageUrl + "<%=urlparams%>";
                                $('.next-posts a').attr("href",nextPageUrl).attr("href");
        //                      alert("new path="+$('.next-posts a').attr("href"));
                                resultpageNo = resultpageNo +1;

                                }else   {
                            return false;
                                }
            
                },
                onPageChange: function(pageNum, pageUrl, scrollOffset) { 
               //       alert("onPageChange");

                },
                onLoadItems: function(items) {
                        

                        if(items.length == 0){
                                
                                hasMoreData = false;
                                return false;
                        }else   {
                                
                           for (var i = 0; i < items.length ; i++) {
                                  // items[i].show();   
                                         var pseq = "";
                                         var address = "";
                                  for(var j = 0; j < items[i].childElementCount ; j++){
                                          
                                          
                                          if(items[i].children[j].id == 'pseq'){
                                                  pseq = items[i].children[j].innerHTML;
                                          }
                                          
                                          if(items[i].children[j].id == 'address'){
                                                  address = items[i].children[j].innerHTML;                                               
                                          }
                                  }
                                  setMarker(map, address, pseq);
                                          
                           }

                        }
                }
                
            });
        });

            // AutoComplete
            $(function(){
                
                var options = {
                  map: ".map_geocomplete",
                };
                
                $("#geocomplete_filter").geocomplete(options)
                  .bind("geocode:result", function(event, result){
        
                          var lat = result.geometry.location.lat();
                          var lng = result.geometry.location.lng();
                          
                          if(lat != ""){
                                document.searchForm.initLatitute.value = lat;
                          }else {
                                document.searchForm.initLatitute.value = "0";
                          }
                          
                          if(lng != ""){
                                  document.searchForm.initLongitute.value = lng;
                          }else {
                                  document.searchForm.initLongitute.value = "0";                          
                          }
             //           alert("lat="+lat);
             //           alert("lng="+lng);
                  })
                  .bind("geocode:error", function(event, status){
                  })
                  .bind("geocode:multiple", function(event, results){
                  }); 
        
                
              });
    </script>
    <script src="./bootstrap/js/daterangepicker.js"></script>
    <script src="./bootstrap/js/moment.min.js"></script>
    <script src="./bootstrap/js/bootstrap-slider.js"></script>
    <script src="./bootstrap/js/reportrange.js"></script></li>
    <script src="./bootstrap/js/snap.js"></script>
    <script src="./bootstrap/js/succinct.js"></script>
    <script src="./bootstrap/js/infobox.js"></script>
  <div class="snap-drawer snap-drawer-left">
     <div class="">
      
      <form name="searchForm" class="mo" action="./searchPearByPositionM.fx">
          <ul class="fil mo">
            <li style="background: none !important; font-size: 24px; color: #505050; text-shadow: 1px 1px 1px #fdfdfd"><i class="icon-search icon-2x" style="vertical-align: middle"></i> Find your currency</li>
            <li><div class="text-left pad10">Exchange Location</div><input id="geocomplete_filter" name="exlo"  class="addresspicker input-xxlarge" style="box-shadow: none; vertical-align: baseline" class="filter input-xxlarge" type="text" value="${param.exlo}"></li>            
            <li class="mo">
            <div class="text-left pad10">Exchange date</div>
            <div class="filter" id="reportrange" style="text-align: left !important; height: 20px !important">
              <span >July 10, 2013 - August 8, 2013</span> <b class="caret" style="margin-top: 8px; float: right"></b>
            </div>
 <!--            <script type="text/javascript" src="../bootstrap/js/reportrange.js"></script></li> -->
            <li class="text-left">
              <div class="text-left pad10">Currency</div>
              <ul class="inline slider-track" style="position: relative;">
                I have: <ol id="bccd_flag" class="flag ${fn:substring(param.bccd,0,2)}" style="overflow: hidden; padding: 0px !important; border-bottom: none !important;"></ol>
                <li style="border-bottom: none; border-top: none; background: none !important; padding-left: 0px !important;"><select id="bccd_selectbox" name="bccd" class="input-medium bfh-currencies mo" data-currency="${param.bccd}"></select></li>
                <hr class="mo">
                I want: <ol id="sccd_flag" class="flag ${fn:substring(param.sccd,0,2)}" style="overflow: hidden; padding: 0px !important; border-bottom: none !important;"></ol>
                <li style="border-bottom: none; border-top: none; background: none !important; padding-left: 0px !important;"><select id="sccd_selectbox" name="sccd" class="input-medium bfh-currencies mo" data-currency="${param.sccd}"></select></li>
              </ul>
              
            </li>
          
            <li id="targetbar">
            <div class="text-left pad5">Amount</div>
            <div class="slider slider-horizontal">
              <input type="text" class="span3" value="" data-slider-min="0" data-slider-max="1000" data-slider-step="5" data-slider-value="[${param.min_amt},${param.max_amt}]" id="sl2" style="">
              
            </div>
            <div id="RGB" style="margin-top: 10px">$${param.min_amt} - $${param.max_amt}</div>
            
        </li>
            <li style="border-bottom: none"><button onClick="javascript:searchPearByPosition();return false;" class="btn btn-success btn-medium" style="margin-bottom: 2px">Apply Filters</button></li>
          </ul>
          <input type="hidden" name="suid" value="${sessionScope.logininfo.id}">
          <input type="hidden" name="qnum" value="15">
          <input type="hidden" name="snum" value="0">
          <input type="hidden" name="initLongitute" value="${param.initLongitute}">
          <input type="hidden" name="initLatitute" value="${param.initLatitute}">
          <input type="hidden" name="min_amt" value="${param.min_amt}">
          <input type="hidden" name="max_amt" value="${param.max_amt}">
          </form>
      
      
        <!--<form name="searchForm" class="mo" action="./searchPearByPositionM.fx">
          <ul class="fil mo">
            <li class="" style="background: none !important" align="center"><i class="icon-filter icon-2x"> </i>Filter</li>
            <li class="text-left">
              <ul class="inline slider-track" style="position: relative">
                <ol id="bccd_flag" class="flag ${fn:substring(param.bccd,0,2)}" style="overflow: hidden; padding: 0px !important; border-bottom: none !important;"></ol>
                <li style="border-bottom: none !important; background: none !important; padding-left: 0px !important;">
                  <select id="bccd_selectbox" name="bccd" class="input-medium bfh-currencies mo" data-currency="${param.bccd}"></select>
                </li>
                <hr class="mo">
                <ol id="sccd_flag" class="flag ${fn:substring(param.sccd,0,2)}" style="overflow: hidden; padding: 0px !important; border-bottom: none !important;"></ol>
                <li style="border-bottom: none !important; background: none !important; padding-left: 0px !important;">
                 <select id="sccd_selectbox" name="sccd" class="input-medium bfh-currencies mo" data-currency="${param.sccd}"></select>
                </li>
              </ul>
              
            </li>
            <li>Amount<br>
            <div class="slider slider-horizontal">
              <input type="text" class="span3" value="" data-slider-min="0" data-slider-max="1000" data-slider-step="5" data-slider-value="[${param.min_amt},${param.max_amt}]" id="sl2" style="">
              
            </div>
            <div id="RGB" style="margin-top: 5px">$${param.min_amt} - $${param.max_amt}</div>
            
        </li>
            <hr class="mo green">
            <li>Exchange Location<br>
  <!--            <input id="geocomplete" name="exlo" type="text"  class="addresspicker" placeholder="Preferred exchange location" />
            
                        <input id="geocomplete_filter" name="exlo"  class="addresspicker" style="box-shadow: none; vertical-align: baseline" class="filter input-large" type="text" value="${param.exlo}"></li>
            <li class="mo" style="padding-left: 28px !important">Exchange date
            <div class="filter" id="reportrange">
              <span>July 10, 2013 - August 8, 2013</span> <b class="caret" style="margin-top: 8px"></b>
            </div>
            </li>
            <li class="" style="background: none !important;" align="center"><button onClick="javascript:searchPearByPosition();return false;" class="btn btn-success btn-medium" style="margin-bottom: 2px">Apply Filters</button></li>
          </ul>
          <input type="hidden" name="suid" value="${sessionScope.logininfo.id}">
          <input type="hidden" name="qnum" value="6">
          <input type="hidden" name="snum" value="0">
          <input type="hidden" name="initLongitute" value="${param.initLongitute}">
          <input type="hidden" name="initLatitute" value="${param.initLatitute}">
          <input type="hidden" name="min_amt" value="${param.min_amt}">
          <input type="hidden" name="max_amt" value="${param.max_amt}">
          
          </form>-->
        </div>
    </div>
        
        
        <div id="content" class="snap-content">
          <div class="filter-bar" align="center">
            <a id="open-left" style="text-decoration: none"><i class="icon-search icon-3x" style="position: absolute; top: 45%; left: 26%"></i></a>
            <script src="./bootstrap/js/demo.js"></script>
          </div>
          
          <!--sample by Jeremy
        <div class="list-cont span4 mo">
          <div class="list-wrap pad mo">
            <div class="span1 mo" style="height: 64px"><img src="../bootstrap/img/pink2.jpg"></div>
            <ul class="inline mo">
              <li class="mo" style="vertical-align: middle"><p class="flag US mo" style="margin-top: -5px !important"></p></li>
              <li class="mo"><b class="mo" style="vertical-align: top; margin-left: -15px !important">USD $1000</b></li><br>
            </ul>
            <small style="margin-left: 5px"><i class="icon-map-marker"></i> Sydney, New South Whales</small><br>
            <small style="margin-left: 5px"><i class="icon-time"></i> Expires: 28/09/2013</small>
          </div>
        </div>-->
          
          <div class="span6 pull-left mo" style="border-left: 1px solid #ddd;  margin-left: 80px !important">
                        
                <!-- Search Result (Right) -->
        <c:set var="bidcheck" scope="request" value="${info.bidcheck}" />

        <%
        ArrayList<BidVO> bidcheckList = (ArrayList<BidVO>)request.getAttribute("bidcheck");

        int size = bidcheckList.size();
        HashMap bchm = new HashMap();
        for(int i=0; i < size; i++){
                BidVO bidcheckvalue= bidcheckList.get(i);
                bchm.put(bidcheckvalue.getPseq(),"");
        }
%>
<form name="resultForm" action="" class="mo">
	<div id="content">
    <div id="result-list" class="resultbox span6" style="overflow-y: scroll; height: 100%; position: absolute; margin-left: 0px !important; border-right: 1px solid #ddd; background: #eee">
			<c:choose>
				<c:when test="${!empty info.result}">
          <c:forEach items="${info.result}" var="list" varStatus="st">
					<c:set var="exlo" scope="request" value="${list.exlo}" />
					<c:set var="pseq" scope="request" value="${list.pseq}" />
					<c:set var="csymbol" scope="request" value="${list.sccd}" />
					<c:set var="stat" scope="request" value="${list.stat}" />
					
					<div class="post">
            <div id="infobox${list.pseq}" class="infobox-wrapper infobox">
							<div class="popover-title" style="font-size: 24px; font-weight: bold;">
								<div style="padding: 4px">
                  <ul class="unstyled mo">
                     <li style="font-size: 24px">${list.sccd}</li>
                     <li class="mo" style="font-size: 44px; line-height: 35px; white-space: nowrap; overflow: hidden; min-width: 100px; margin: 0px -1px !important">
											<b style="vertical-align: middle; font-weight: bold"><%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %><fmt:formatNumber value="${list.samt}" pattern=""/></b>
											<button onClick="javascript:goBid('${list.pseq}'); return false;" style="vertical-align: middle" class="btn btn-info btn-large">View</button>
										 </li>
                  </ul>
                </div>
							</div>
							<div class="popover-content" style="display: inline-block">
								<div style="display: inline-block; float: left; margin-right: 10px">
									<c:choose>
                    <c:when test="${!empty list.fbuid}">
                      <img style="margin-top: 6px" src="http://graph.facebook.com/${list.fbuid}/picture?width=33&amp;height=33&amp;" alt="">
                    </c:when>
                    <c:otherwise>
                      <img height="33" width="33" style="margin-top: 6px" src="./img/user.png" alt="">
                    </c:otherwise>
                  </c:choose>
								</div>
                 
								<div style="display: inline-block; float: left; margin-top: 1px">
                  <ul class="unstyled mo">
                    <li class="mo f16"><b style="font-size: 16px"><i class="flag16 ${fn:substring(list.sccd,0,2)}" style="vertical-align: text-top; margin-right: 3px !important; margin-top: 3px"></i>${list.sccd} <i class="icon-exchange" style="margin-right: 2px; font-size: 16px; margin-top: 3px"></i> <i class="flag16 ${fn:substring(list.bccd,0,2)}" style="vertical-align: text-top; margin-right: 3px !important; margin-top: 3px"></i>${list.bccd}</b></li>
                    <li>Expires: <i class="icon-calendar"></i> ${fn:substring(list.trdt,0,10)} <i class="icon-time"></i> ${fn:substring(list.trdt,10,19)}</li>
                  </ul>
                </div>
							</div>

        <!--<div class="pad">
                <button onClick="javascript:goBid('${list.pseq}'); return false;" class="btn-primary btn" style="position: absolute; right: 20px" >Pear up</button>-->


                <!--<table>
                        <tr style="font-size: 32px; font-weight: bold">
                                <td class="flag ${fn:substring(list.sccd,0,2)}"></td>
                                <td style="font-weight: 100">${list.sccd}</td>
                                <td><%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %></td>
                                <td><fmt:formatNumber value="${list.samt}" pattern=""/></td>
                        </tr>
                </table>
          <table>
                <tr>
                        <td class="text-center" style="padding-right: 10px"><i class="icon-map-marker"></i> </td>
                        <td class="truncate"> ${list.exlo}</td>
                </tr>
                <tr>
                        <td style="padding-right: 10px"><i class="icon-time"></i> </td>
                        <td> Expires: <fmt:formatDate value="${list.trdt}" pattern="dd/MM/yyyy"/></td>
                </tr>
                <tr>
                        <td style="padding-right: 10px"><i class="icon-exchange"></i> </td>
                        <td> Currency pair USD/AUD</td>
                </tr>
          </table>
        </div>-->
    </div>
                                                                                        <div id="pseq" style="display:none;">${list.pseq}</div>
                                                                                        <div id="address" style="display:none;">${list.exlo}</div>
                                                                          <div class="list-wrap">

                                                                         <!--   <div class="span1 mo" style="height: 70px">

                                                                                                        <c:choose>
                                                                                                                <c:when test="${!empty list.fbuid}">
                                                                                                                        <img
                                                                                                                                src="http://graph.facebook.com/${list.fbuid}/picture?width=50&amp;height=50&amp;"
                                                                                                                                alt="">
                                                                                                                </c:when>
                                                                                                                <c:otherwise>
                                                                                                                        <img height="33" width="33" class="img-rounded"
                                                                                                                                src="./img/user.png" alt="">
                                                                                                                </c:otherwise>
                                                                                                        </c:choose>
                                                                                                <c:choose>
                                                                                                                <c:when test="${list.stat == 0}">
                                                                                                                        <span class="label label-info">Closed</span>
                                                                                                                </c:when>
                                                                                                                <c:when test="${list.stat == 2}">
                                                                                                                        <span class="label label-info">Suspended</span>
                                                                                                                </c:when>
                                                                                                        </c:choose>
                                                                                                <%
                                                                                                        Integer pseq = (Integer)request.getAttribute("pseq");
                                                                                                        Integer stat = (Integer)request.getAttribute("stat");

                                                                                                                String disabledBid = "";

                                                                                                                if(bchm.containsKey(pseq) || stat != 1 || session.getAttribute("logininfo") == null){
                                                                                                                  disabledBid = "disabled";
                                                                                                                }
                                                                                                  %>
                                                                                                        <c:choose>
                                                                                                                <c:when test="${sessionScope.logininfo.id != list.suid}">
                                                                                                                        <button <%=disabledBid %> class="btn btn-primary"
                                                                                                                                onClick="javascript:goBid('${list.pseq}'); return false;" style="position: absolute; right: 20px">
                                                                                                                                Pear up
                                                                                                                        </button>
                                                                                                                        <br>
                                                                                                                </c:when>
                                                                                                        </c:choose>
                                                                            </div>
                                                                                -->
                                                                                <div class="span6 list-wrap-inner" style="border-bottom: 1px dashed #ddd; padding: 20px 0 30px; margin-top: 10px; margin-left: 0px; padding-left: 10px; max-width: 450px">
                                                                                <div style="display: inline-block; float: left; margin-right: 10px"><c:choose>
                                                                                                                <c:when test="${!empty list.fbuid}">
                                                                                                                        <img style="margin-top: 5px"
                                                                                                                                src="http://graph.facebook.com/${list.fbuid}/picture?width=51&amp;height=51&amp;"
                                                                                                                                alt="">
                                                                                                                </c:when>
                                                                                                                <c:otherwise>
                                                                                                                        <img height="50" width="50" style="margin-top: 5px" src="./img/user.png" alt="">
                                                                                                                </c:otherwise>
                                                                                                        </c:choose></div>
                                                                                <div style="display: inline-block; float: left; padding: 1px 10px 2px;">
                                                                                  <ul class="unstyled mo">
                                                                                    <li class="mo f16"><b style="font-size: 16px"><i class="flag16 ${fn:substring(list.sccd,0,2)}" style="vertical-align: text-top; margin-right: 3px !important"></i>${list.sccd} <i class="icon-exchange" style="margin-right: 2px; font-size: 16px"></i> <i class="flag16 ${fn:substring(list.bccd,0,2)}" style="vertical-align: text-top; margin-right: 3px !important"></i>${list.bccd}</b></li>
                                                                                    <li>Expires: <i class="icon-calendar" style="font-size: 13px; vertical-align: text-top"></i> ${fn:substring(list.trdt,0,10)} <i class="icon-time"></i> ${fn:substring(list.trdt,10,19)}</li>
                                                                                    <li style="white-space: nowrap; overflow: hidden; "><i class="icon-map-marker"></i> <a title="${list.exlo}" class="truncate" href="javascript:moveMapCenter('${list.exlo}','${list.pseq}')">${list.exlo}</a></li>
                                                                                  </ul>
                                                                                </div>
                                                                                <div id="the-post" style="display: inline-block; background: #f5f5f5; padding: 12px; float: right">
                                                                                  <ul class="unstyled mo">
                                                                                    <li>${list.sccd}</li>
                                                                                    <li class="mo" style="font-size: 24px; white-space: nowrap; overflow: hidden; max-width: 151px; min-width: 100px"><b style="font-weight: bold"><%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %><fmt:formatNumber value="${list.samt}" pattern=""/></b></li>
                                                                                  </ul>
                                                                                </div>
                                                                                </div>


                                                                        <!--    <ul class="inline unstyled mo results-list-item">
                                                                                <div class="row-fluid">
                                                                                  <div class="span2 mo" style="max-width: 60px !important">
                                                                                <c:choose>
                                                                                                                <c:when test="${!empty list.fbuid}">
                                                                                                                        <img
                                                                                                                                src="http://graph.facebook.com/${list.fbuid}/picture?width=50&amp;height=50&amp;"
                                                                                                                                alt="">
                                                                                                                </c:when>
                                                                                                                <c:otherwise>
                                                                                                                        <img height="33" width="33" class="img-rounded"
                                                                                                                                src="./img/user.png" alt="">
                                                                                                                </c:otherwise>
                                                                                                        </c:choose>
                                                                                        </div>
                                                                                  <div class="span11 mo results-list-item-inner" style="background: #fff; max-width: 360px;">
                                                                                <div class="mo" style="display: inline-block">
                                                                                <li class="ri" style="font-size: 24px"><b style="font-weight: bold">${list.sccd}</b> <%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %> <fmt:formatNumber value="${list.samt}" pattern=""/></li>
                                                                                </div>
                                                                                <div class="mo" style="display: inline-block; position: absolute; padding-left: 30px">
                                                                                <li style="line-height: 48px"><button onClick="javascript:goBid('${list.pseq}'); return false;" class="btn-success btn">Exchange</button> <a class="btn" title="${list.exlo}" href="javascript:moveMapCenter('${list.exlo}','${list.pseq}')"><i class="icon-map-marker"></i> Map</a></li>
                                                                                </div>
                                                                                  </div>
                                                                                <div class="row-fluid">
                                                                                        <div class="span2 mo" style="min-width: 60px !important"></div>
                                                                                        <div class="span10 mo" style="display: inline-block">
                                                                                                <ul class="mt unstyled">
                                                                                                        <li><i class="icon-map-marker"></i> <a title="${list.exlo}" class="truncate" href="javascript:moveMapCenter('${list.exlo}','${list.pseq}')">${list.exlo}</a></li>
                                                                                                        <li><i class="icon-time"></i> Expires: 29/07/2013</li>
                                                                                                </ul>
                                                                                        </div>
                                                                                </div>


                                                                                </div>
                                                                              </ul>-->

                                                                                        <div class="box-section news with-icons">

                                                                                        <!--  facebook interface button,
                                                                                                <div class="news-time">

                                                                                                        ${list.pseq}
                                                                                                        <c:choose>
                                                                                                                <c:when test="${list.stat == 0}">
                                                                                                                        <span class="label label-info">Closed</span>
                                                                                                                </c:when>
                                                                                                                <c:when test="${list.stat == 2}">
                                                                                                                        <span class="label label-info">Suspended</span>
                                                                                                                </c:when>
                                                                                                        </c:choose>
                                                                                                        <c:choose>
                                                                                                                <c:when test="${sessionScope.logininfo.id != list.suid}">
                                                                                                                        <button <%=disabledBid %> class="btn btn-primary"
                                                                                                                                onClick="javascript:goBid('${list.pseq}'); return false;">
                                                                                                                                <i class="icon-comment icon-white"></i> Bid
                                                                                                                        </button>
                                                                                                                        <br>
                                                                                                                </c:when>
                                                                                                        </c:choose>
                                                                                                        <span style="margin-top: 5px" class="pull-right"> <img
                                                                                                                onClick="javascript:fbPost('${list.pseq}')"
                                                                                                                style="cursor: pointer" src="./img/f_logo.png" alt="">
                                                                                                                <img onClick="javascript:twPost('${list.pseq}')"
                                                                                                                style="cursor: pointer" src="./img/t_logo.png" alt="">
                                                                                                                <img src="./img/g_logo.png" alt=""> <img
                                                                                                                src="./img/p_logo.png" alt=""></span>
                                                                                                </div>
                                                                                                -->

                                                                                                <!--
                                                                                                <div class="news-content">

                                                                                                        <div class="news-title">
                                                                                                                <a href="#">${list.fname} ${list.lname}</a> has<br>
                                                                                                                <p class="flag ${fn:substring(list.sccd,0,2)}" style="margin: 0px"></p><i class="icon-flag-${fn:substring(list.sccd,0,2)}"></i>${list.sccd}
                                                                                                                <a
                                                                                                                        href="#"
                                                                                                                        style="font-size: 24px; vertical-align: baseline;"> <%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %>
                                                                                                                        <span></span><fmt:formatNumber value="${list.samt}" pattern=""/>
                                                                                                                </a>
                                                                                                        </div>
                                                                                                        <small style="color: #bbb">Posted: <span
                                                                                                                data-localtime-format="yyyy/MM/dd HH:mm:ss">${fn:substring(list.spdt,0,19)}Z</span></small>
                                                                                                        <hr>

                                                                                                        <div class="news-text">
                                                                                                                <i class="icon-map-marker"></i> <a
                                                                                                                        href="javascript:moveMapCenter('${list.exlo}','${list.pseq}')">${list.exlo}</a><br>
                                                                                                                <i class="icon-time"></i> Expires in <a><abbr
                                                                                                                        class="timeago" title="${fn:substring(list.trdt,0,19)}Z"></abbr></a>
                                                                                                        </div>

                                                                                                </div>
                                                                                                -->
                                                                                        </div>
                                                                                        </div>
                                                                                </div>
                                                                                <input type="hidden" name="exlo_map" value="${list.exlo}">
                                                                                <input type="hidden" name="info_msg_${list.pseq}" value="<img class='img-rounded' src='http://graph.facebook.com/${list.fbuid}/picture?width=33&height=33&'><font color='blue'><B>${list.fname} ${list.lname}</B></font> wants to trade <font color='red'><B>${list.sccd} <%=CurrencySymbol.getText((String)request.getAttribute("csymbol")) %> ${list.samt}</B></font><br>until ${list.trdt} near <font color='brown'><B>${list.exlo}</B></font>">

                                                                        </c:forEach>
                                                                </c:when>
                                                                <c:otherwise>
                                                                        <!--
                                                                <div class="post">
                                                                        <TR>
                                                                                <TD>No Result!!!</TD>
                                                                        </TR>
                                                                </div>
                                                                -->
                                                                <script>
                                                                        alert('No data!');
                                                                </script>
                                                                </c:otherwise>
                                                        </c:choose>

                                </div>
                        <div class="navigation">
                                <ul>
                                        <li>1</li>

                                        <li class="next-posts"><a
                                                href="./searchPearByPositionM.fx?">2</a></li>
                                </ul>
                        </div>
                </div>
        </form>
        <!-- Result list -->
          </div>
          <div class="mo pull-left">
            
        <!-- Google Map (left) -->

                                <div class="box-content scrollable"
                                        style="height: 100%; position: absolute; overflow-y: auto; margin-left: -0px !important; border-right: 1px solid #b9b9b9; right: 0; left: 542px">
                                        <i style="position: absolute; left: 45%; top: 45%" class="icon-spinner icon-spin icon-4x"></i>
                                        <div id="map_canvas" style="height: 100%"></div>

                                </div>

        <!-- Google Map (left) -->





        
        
        </div>
        <script type="text/javascript">
            var snapper = new Snap({
                element: document.getElementById('content'),
                disable: 'right'
            });
            
        </script>
        

<!-- 
        <script type="text/javascript">
         function goFaceBook(msg,url) {
             var w = (screen.width-1000)/2;
             var h = (screen.height-600)/2;
             var href = "http://www.facebook.com/sharer.php?s=100&p[url]=" + encodeURIComponent(url) + "&p[title]=" + encodeURIComponent(msg);
             var a = window.open(href, 'facebook', 'width=1000,height=600,left='+w+',top='+h+',scrollbars=0');
             if(a) { a.focus(); }
         }
         
 </script>

        <a
                href="javascript:facebook_send_message('Elvin Kang', '100006166420999','Someone bid your post in CurrencyPear.com','www.currencypear.com')">페이스북
                MSG 보내기</a>
        <a href="javascript:goFaceBook('currencypear share', location.href)">페이스북
                보내기</a>
        <a href="javascript:setInfoWindow()">setinfo</a>
        <a href="javascript:appendView()">appendView</a>

        facebook_send_message(name, to,description,link)
-->     
        
        <form name="geoinfo">
                <input type="hidden" name="latitude">
                <input type="hidden" name="longitude">
        </form>
        
    <jsp:include page="./js_include.jsp"></jsp:include>         
</body>

</html>



