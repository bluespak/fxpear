<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.bluespak.vo.PearVO" %>
<%@ page import="com.bluespak.utils.cd.NationCode" %>
<%@ page import="com.bluespak.utils.cd.CityCode" %>
<%@ page import="com.bluespak.utils.cd.CurrencyCode" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Iterator" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>

   <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&amp;libraries=places"></script>
    <script src="./bootstrap/js/jquery.js"></script>  
    <script src="./js/jquery.geocomplete.js"></script> 
    <script src="./js/fxPear.js"></script>
    <script src="./js/jquery-localtime.js"></script>
	<script src="./js/bootstrap/bootstrap-modal.js"></script>  

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    <script src="./bootstrap/js/jquery.timeago.js"></script>
    <script src="./bootstrap/js/bootstrap-collapse.js"></script>
	<script src="./bootstrap/js/bootstrap-transition.js"></script>
    <script src="./bootstrap/js/bootstrap-dropdown.js"></script>
    <script src="./bootstrap/js/bootstrap-tab.js"></script>
    <script src="./bootstrap/js/bootstrap-scrollspy.js"></script>
	<style>
	
	.pac-container {
	    background-color: #FFF;
	    z-index: 20;
	    position: fixed;
	    display: inline-block;
	    float: left;
	}
	.modal{
	    z-index: 20;   
	}
	.modal-backdrop{
	    z-index: 10;        
	}

	</style>
    <script>
    if( /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ) {
    	   location.href = "./mainM.fx";
    }
    
    // AutoComplete
    $(function(){
        
        var options = {
          map: ".map_geocomplete"
        }; 
        $("#geocomplete").geocomplete(options)
          .bind("geocode:result", function(event, result){

        	  var lat = result.geometry.location.lat();
        	  var lng = result.geometry.location.lng();
        	  
        	  if(lat != ""){
        	  	document.postForm.exlat.value = lat;
        	  }else	{
          	  	document.postForm.exlat.value = "0";
        	  }
        	  
        	  if(lng != ""){
        		  document.postForm.exlng.value = lng;
        	  }else	{
        		  document.postForm.exlng.value = "0";        		  
        	  }
          })
          .bind("geocode:error", function(event, status){
          })
          .bind("geocode:multiple", function(event, results){
          }); 

        
      });

      // TimeAgo
      jQuery(document).ready(function() {
		  jQuery("abbr.timeago").timeago();
	  });

      

      
  
	   </script>    
   
   <!-- Navbar -->   
<form name="loginForm" method=POST accept-charset="UTF-8">
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
           <a class="brand" href="./main.fx"><b class="text-success">FX</b> PEAR</a>
          <div class="nav-collapse collapse">
          
            <ul class="nav">
              <li><a href="#contact">How it works</a></li>
        <c:if test="${!empty sessionScope.logininfo}">
              <li><a href="#postModal" data-toggle="modal" data-target="#postModal">Post your currency</a></li>
       		  <li class="dropdown" role="menu" aria-labelledby="dropdownMenu">              
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown">FxBoard <b class="caret"></b></a>
                 <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                  <li><a href="./fxboardlist.fx?fxcat=notice">Fxpear Notice</a></li>
                  <li><a href="./fxboardlist.fx?fxcat=travel">Travel information</a></li>
                  <li><a href="./fxboardlist.fx?fxcat=qna">Q&A</a></li>
                </ul>
              </li>
              <li class="dropdown">              
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown">MyPage <b class="caret"></b></a>
                 <ul class="dropdown-menu">
                  <li><a href="./myPage.fx?tab=1">Profile Information</a></li>
                  <li><a href="./myPage.fx?tab=2">I'm Selling</a></li>
                  <li><a href="./myPage.fx?tab=3">I'm Biding</a></li>
                </ul>
              </li>
              <div class="" style="color: #fff; float: right; line-height: 40px"> 
              <span>logged in as ${sessionScope.logininfo.fname} ${sessionScope.logininfo.lname}&nbsp;&nbsp;
          <c:choose>    
            <c:when test="${!empty sessionScope.logininfo.fbuid}">
            <img src="http://graph.facebook.com/${sessionScope.logininfo.fbuid}/picture?width=12&height=12">
            </c:when>
		    <c:otherwise>            
              <img src="./img/user.png">
            </c:otherwise>  
           </c:choose>
              <a href="javascript:logout()"  style="margin-left: 10px" ><font color="#FFFFFF">Sign out</font></a></span>
            </div>
 		</c:if>	
            </ul>
       <c:if test="${empty sessionScope.logininfo}">
              <!-- The drop down menu -->
	        <ul class="nav pull-right" >
	          <li><a href="#registModal" data-toggle="modal">Sign Up</a></li>
		          <li class="divider-vertical"></li>
	          <li class="dropdown">
	            <a class="dropdown-toggle" href="#" data-toggle="dropdown">Sign In <strong class="caret"></strong></a>
	            <div class="dropdown-menu" style="padding: 15px; padding-bottom: 0px;">

					 E-Mail <input id="user_username" style="margin-bottom: 15px;" type="text" name="id" size="30" />
					 Password <input id="user_password" style="margin-bottom: 15px;" type="password" name="password" size="30" />
					  <input id="user_remember_me" style="float: left; margin-right: 10px;" type="checkbox" name="remember_me" value="1" />
					  <label class="string optional" for="user_remember_me"> Remember me</label>
					 
					  <input class="btn btn-primary" onClick="javascript:login('login');return false;" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Sign In" />
	            </div>
	          </li>
	        </ul> 
		</c:if>
	
          </div><!--/.nav-collapse -->
        </div>
      </div> 
 	</div>
 </form>
      <!--Register Modal -->
<div id="registModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
    <h3>Sign Up</h3>
  </div>
   <div class="modal-body">
		<form NAME="fbregisterForm" class="modal-register" >  
        <input type="hidden" name="id" value=""/>
        <input type="hidden" name="fname" value=""/>
        <input type="hidden" name="lname" value=""/>
        <input type="hidden" name="nation" value=""/>
        <input type="hidden" name="city" value=""/>
        <input type="hidden" name="currency" value=""/>
        <input type="hidden" name="password" value=""/>
        <input type="hidden" name="email" value=""/>
        <input type="hidden" name="address1" value=""/>
        <input type="hidden" name="address2" value=""/>           
        <input type="hidden" name="fbuid" value=""/>   
		</form>
      <button class="btn btn-primary" onClick="javascript:fbconnect('regist');return false">Connect using Facebook</button>
    </div> 


  <div>
<form NAME="registerForm" class="modal-register" >
  <div class="modal-body">
      <h3>Complete the form</h3>
        <input type="text"  name="id" class="input-block-level" placeholder="Email address">
        <input type="text" name="fname" class="input-block-level" placeholder="First name">
        <input type="text" name="lname" class="input-block-level" placeholder="Last name">
        <!--select name="nation" class="input-medium bfh-countries span3" data-country="US"><option value="">Select your country</option><option value="AF">Afghanistan</option><option value="AL">Albania</option><option value="DZ">Algeria</option><option value="AS">American Samoa</option><option value="AD">Andorra</option><option value="AO">Angola</option><option value="AI">Anguilla</option><option value="AQ">Antarctica</option><option value="AG">Antigua and Barbuda</option><option value="AR">Argentina</option><option value="AM">Armenia</option><option value="AW">Aruba</option><option value="AU">Australia</option><option value="AT">Austria</option><option value="AZ">Azerbaijan</option><option value="BH">Bahrain</option><option value="BD">Bangladesh</option><option value="BB">Barbados</option><option value="BY">Belarus</option><option value="BE">Belgium</option><option value="BZ">Belize</option><option value="BJ">Benin</option><option value="BM">Bermuda</option><option value="BT">Bhutan</option><option value="BO">Bolivia</option><option value="BA">Bosnia and Herzegovina</option><option value="BW">Botswana</option><option value="BV">Bouvet Island</option><option value="BR">Brazil</option><option value="IO">British Indian Ocean Territory</option><option value="VG">British Virgin Islands</option><option value="BN">Brunei</option><option value="BG">Bulgaria</option><option value="BF">Burkina Faso</option><option value="BI">Burundi</option><option value="CI">C�te d'Ivoire</option><option value="KH">Cambodia</option><option value="CM">Cameroon</option><option value="CA">Canada</option><option value="CV">Cape Verde</option><option value="KY">Cayman Islands</option><option value="CF">Central African Republic</option><option value="TD">Chad</option><option value="CL">Chile</option><option value="CN">China</option><option value="CX">Christmas Island</option><option value="CC">Cocos (Keeling) Islands</option><option value="CO">Colombia</option><option value="KM">Comoros</option><option value="CG">Congo</option><option value="CK">Cook Islands</option><option value="CR">Costa Rica</option><option value="HR">Croatia</option><option value="CU">Cuba</option><option value="CY">Cyprus</option><option value="CZ">Czech Republic</option><option value="CD">Democratic Republic of the Congo</option><option value="DK">Denmark</option><option value="DJ">Djibouti</option><option value="DM">Dominica</option><option value="DO">Dominican Republic</option><option value="TP">East Timor</option><option value="EC">Ecuador</option><option value="EG">Egypt</option><option value="SV">El Salvador</option><option value="GQ">Equatorial Guinea</option><option value="ER">Eritrea</option><option value="EE">Estonia</option><option value="ET">Ethiopia</option><option value="FO">Faeroe Islands</option><option value="FK">Falkland Islands</option><option value="FJ">Fiji</option><option value="FI">Finland</option><option value="MK">Former Yugoslav Republic of Macedonia</option><option value="FR">France</option><option value="FX">France, Metropolitan</option><option value="GF">French Guiana</option><option value="PF">French Polynesia</option><option value="TF">French Southern Territories</option><option value="GA">Gabon</option><option value="GE">Georgia</option><option value="DE">Germany</option><option value="GH">Ghana</option><option value="GI">Gibraltar</option><option value="GR">Greece</option><option value="GL">Greenland</option><option value="GD">Grenada</option><option value="GP">Guadeloupe</option><option value="GU">Guam</option><option value="GT">Guatemala</option><option value="GN">Guinea</option><option value="GW">Guinea-Bissau</option><option value="GY">Guyana</option><option value="HT">Haiti</option><option value="HM">Heard and Mc Donald Islands</option><option value="HN">Honduras</option><option value="HK">Hong Kong</option><option value="HU">Hungary</option><option value="IS">Iceland</option><option value="IN">India</option><option value="ID">Indonesia</option><option value="IR">Iran</option><option value="IQ">Iraq</option><option value="IE">Ireland</option><option value="IL">Israel</option><option value="IT">Italy</option><option value="JM">Jamaica</option><option value="JP">Japan</option><option value="JO">Jordan</option><option value="KZ">Kazakhstan</option><option value="KE">Kenya</option><option value="KI">Kiribati</option><option value="KW">Kuwait</option><option value="KG">Kyrgyzstan</option><option value="LA">Laos</option><option value="LV">Latvia</option><option value="LB">Lebanon</option><option value="LS">Lesotho</option><option value="LR">Liberia</option><option value="LY">Libya</option><option value="LI">Liechtenstein</option><option value="LT">Lithuania</option><option value="LU">Luxembourg</option><option value="MO">Macau</option><option value="MG">Madagascar</option><option value="MW">Malawi</option><option value="MY">Malaysia</option><option value="MV">Maldives</option><option value="ML">Mali</option><option value="MT">Mayotte</option><option value="MH">Marshall Islands</option><option value="MQ">Martinique</option><option value="MR">Mauritania</option><option value="MU">Mauritius</option><option value="MX">Mexico</option><option value="FM">Micronesia</option><option value="MD">Moldova</option><option value="MC">Monaco</option><option value="MN">Mongolia</option><option value="ME">Montenegro</option><option value="MS">Montserrat</option><option value="MA">Morocco</option><option value="MZ">Mozambique</option><option value="MM">Myanmar</option><option value="NA">Namibia</option><option value="NR">Nauru</option><option value="NP">Nepal</option><option value="NL">Netherlands</option><option value="AN">Netherlands Antilles</option><option value="NC">New Caledonia</option><option value="NZ">New Zealand</option><option value="NI">Nicaragua</option><option value="NE">Niger</option><option value="NG">Nigeria</option><option value="NU">Niue</option><option value="NF">Norfolk Island</option><option value="KP">North Korea</option><option value="MP">Northern Marianas</option><option value="NO">Norway</option><option value="OM">Oman</option><option value="PK">Pakistan</option><option value="PW">Palau</option><option value="PA">Panama</option><option value="PG">Papua New Guinea</option><option value="PY">Paraguay</option><option value="PE">Peru</option><option value="PH">Philippines</option><option value="PN">Pitcairn Islands</option><option value="PL">Poland</option><option value="PT">Portugal</option><option value="PR">Puerto Rico</option><option value="QA">Qatar</option><option value="RE">Reunion</option><option value="RO">Romania</option><option value="RU">Russia</option><option value="RW">Rwanda</option><option value="ST">S�o Tom� and Pr�ncipe</option><option value="SH">Saint Helena</option><option value="PM">St. Pierre and Miquelon</option><option value="KN">Saint Kitts and Nevis</option><option value="LC">Saint Lucia</option><option value="VC">Saint Vincent and the Grenadines</option><option value="WS">Samoa</option><option value="SM">San Marino</option><option value="SA">Saudi Arabia</option><option value="SN">Senegal</option><option value="RS">Serbia</option><option value="SC">Seychelles</option><option value="SL">Sierra Leone</option><option value="SG">Singapore</option><option value="SK">Slovakia</option><option value="SI">Slovenia</option><option value="SB">Solomon Islands</option><option value="SO">Somalia</option><option value="ZA">South Africa</option><option value="GS">South Georgia and the South Sandwich Islands</option><option value="KR">South Korea</option><option value="ES">Spain</option><option value="LK">Sri Lanka</option><option value="SD">Sudan</option><option value="SR">Suriname</option><option value="SJ">Svalbard and Jan Mayen Islands</option><option value="SZ">Swaziland</option><option value="SE">Sweden</option><option value="CH">Switzerland</option><option value="SY">Syria</option><option value="TW">Taiwan</option><option value="TJ">Tajikistan</option><option value="TZ">Tanzania</option><option value="TH">Thailand</option><option value="BS">The Bahamas</option><option value="GM">The Gambia</option><option value="TG">Togo</option><option value="TK">Tokelau</option><option value="TO">Tonga</option><option value="TT">Trinidad and Tobago</option><option value="TN">Tunisia</option><option value="TR">Turkey</option><option value="TM">Turkmenistan</option><option value="TC">Turks and Caicos Islands</option><option value="TV">Tuvalu</option><option value="VI">US Virgin Islands</option><option value="UG">Uganda</option><option value="UA">Ukraine</option><option value="AE">United Arab Emirates</option><option value="GB">United Kingdom</option><option value="US">United States</option><option value="UM">United States Minor Outlying Islands</option><option value="UY">Uruguay</option><option value="UZ">Uzbekistan</option><option value="VU">Vanuatu</option><option value="VA">Vatican City</option><option value="VE">Venezuela</option><option value="VN">Vietnam</option><option value="WF">Wallis and Futuna Islands</option><option value="EH">Western Sahara</option><option value="YE">Yemen</option><option value="ZM">Zambia</option><option value="ZW">Zimbabwe</option></select-->
        <div class="bfh-selectbox bfh-countries" data-country="${sessionScope.logininfo.nation}" data-flags="true" align="left">
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
                <!--br><select name="city" class="input-medium bfh-states span3" data-country="US" data-state="CA"><option value="">Select your city</option><option value="AL">Alabama</option><option value="AK">Alaska</option><option value="AS">American Samoa</option><option value="AZ">Arizona</option><option value="AR">Arkansas</option><option value="AF">Armed Forces Africa</option><option value="AA">Armed Forces Americas</option><option value="AC">Armed Forces Canada</option><option value="AE">Armed Forces Europe</option><option value="AM">Armed Forces Middle East</option><option value="AP">Armed Forces Pacific</option><option value="CA">California</option><option value="CO">Colorado</option><option value="CT">Connecticut</option><option value="DE">Delaware</option><option value="DC">District of Columbia</option><option value="FM">Federated States Of Micronesia</option><option value="FL">Florida</option><option value="GA">Georgia</option><option value="GU">Guam</option><option value="HI">Hawaii</option><option value="ID">Idaho</option><option value="IL">Illinois</option><option value="IN">Indiana</option><option value="IA">Iowa</option><option value="KS">Kansas</option><option value="KY">Kentucky</option><option value="LA">Louisiana</option><option value="ME">Maine</option><option value="MH">Marshall Islands</option><option value="MD">Maryland</option><option value="MA">Massachusetts</option><option value="MI">Michigan</option><option value="MN">Minnesota</option><option value="MS">Mississippi</option><option value="MO">Missouri</option><option value="MT">Montana</option><option value="NE">Nebraska</option><option value="NV">Nevada</option><option value="NH">New Hampshire</option><option value="NJ">New Jersey</option><option value="NM">New Mexico</option><option value="NY">New York</option><option value="NC">North Carolina</option><option value="ND">North Dakota</option><option value="MP">Northern Mariana Islands</option><option value="OH">Ohio</option><option value="OK">Oklahoma</option><option value="OR">Oregon</option><option value="PW">Palau</option><option value="PA">Pennsylvania</option><option value="PR">Puerto Rico</option><option value="RI">Rhode Island</option><option value="SC">South Carolina</option><option value="SD">South Dakota</option><option value="TN">Tennessee</option><option value="TX">Texas</option><option value="UT">Utah</option><option value="VT">Vermont</option><option value="VI">Virgin Islands</option><option value="VA">Virginia</option><option value="WA">Washington</option><option value="WV">West Virginia</option><option value="WI">Wisconsin</option><option value="WY">Wyoming</option></select-->
        <!--br><select name="currency" class="input-medium bfh-currencies span3" data-currency="EUR"><option value="">Select your currency</option><option value="AED"><i class="icon-flag-EUR"></i> United Arab Emirates dirham</option><option value="AFN">Afghan afghani</option><option value="ALL">Albanian lek</option><option value="AMD">Armenian dram</option><option value="AOA">Angolan kwanza</option><option value="ARS">Argentine peso</option><option value="AUD">Australian dollar</option><option value="AWG">Aruban florin</option><option value="AZN">Azerbaijani manat</option><option value="BAM">Bosnia and Herzegovina convertible mark</option><option value="BBD">Barbadian dollar</option><option value="BDT">Bangladeshi taka</option><option value="BGN">Bulgarian lev</option><option value="BHD">Bahraini dinar</option><option value="BIF">Burundian franc</option><option value="BMD">Bermudian dollar</option><option value="BND">Brunei dollar</option><option value="BOB">Bolivian boliviano</option><option value="BRL">Brazilian real</option><option value="BSD">Bahamian dollar</option><option value="BTN">Bhutanese ngultrum</option><option value="BWP">Botswana pula</option><option value="BYR">Belarusian ruble</option><option value="BZD">Belize dollar</option><option value="CAD">Canadian dollar</option><option value="CDF">Congolese franc</option><option value="CHF">Swiss franc</option><option value="CLP">Chilean peso</option><option value="CNY">Chinese yuan</option><option value="COP">Colombian peso</option><option value="CRC">Costa Rican col�n</option><option value="CUP">Cuban convertible peso</option><option value="CVE">Cape Verdean escudo</option><option value="CZK">Czech koruna</option><option value="DJF">Djiboutian franc</option><option value="DKK">Danish krone</option><option value="DOP">Dominican peso</option><option value="DZD">Algerian dinar</option><option value="EGP">Egyptian pound</option><option value="ERN">Eritrean nakfa</option><option value="ETB">Ethiopian birr</option><option value="EUR">Euro</option><option value="FJD">Fijian dollar</option><option value="FKP">Falkland Islands pound</option><option value="GBP">British pound</option><option value="GEL">Georgian lari</option><option value="GHS">Ghana cedi</option><option value="GMD">Gambian dalasi</option><option value="GNF">Guinean franc</option><option value="GTQ">Guatemalan quetzal</option><option value="GYD">Guyanese dollar</option><option value="HKD">Hong Kong dollar</option><option value="HNL">Honduran lempira</option><option value="HRK">Croatian kuna</option><option value="HTG">Haitian gourde</option><option value="HUF">Hungarian forint</option><option value="IDR">Indonesian rupiah</option><option value="ILS">Israeli new shekel</option><option value="IMP">Manx pound</option><option value="INR">Indian rupee</option><option value="IQD">Iraqi dinar</option><option value="IRR">Iranian rial</option><option value="ISK">Icelandic kr�na</option><option value="JEP">Jersey pound</option><option value="JMD">Jamaican dollar</option><option value="JOD">Jordanian dinar</option><option value="JPY">Japanese yen</option><option value="KES">Kenyan shilling</option><option value="KGS">Kyrgyzstani som</option><option value="KHR">Cambodian riel</option><option value="KMF">Comorian franc</option><option value="KPW">North Korean won</option><option value="KRW">South Korean won</option><option value="KWD">Kuwaiti dinar</option><option value="KYD">Cayman Islands dollar</option><option value="KZT">Kazakhstani tenge</option><option value="LAK">Lao kip</option><option value="LBP">Lebanese pound</option><option value="LKR">Sri Lankan rupee</option><option value="LRD">Liberian dollar</option><option value="LSL">Lesotho loti</option><option value="LTL">Lithuanian litas</option><option value="LVL">Latvian lats</option><option value="LYD">Libyan dinar</option><option value="MAD">Moroccan dirham</option><option value="MDL">Moldovan leu</option><option value="MGA">Malagasy ariary</option><option value="MKD">Macedonian denar</option><option value="MMK">Burmese kyat</option><option value="MNT">Mongolian t�gr�g</option><option value="MOP">Macanese pataca</option><option value="MRO">Mauritanian ouguiya</option><option value="MUR">Mauritian rupee</option><option value="MVR">Maldivian rufiyaa</option><option value="MWK">Malawian kwacha</option><option value="MXN">Mexican peso</option><option value="MYR">Malaysian ringgit</option><option value="MZN">Mozambican metical</option><option value="NAD">Namibian dollar</option><option value="NGN">Nigerian naira</option><option value="NIO">Nicaraguan c�rdoba</option><option value="NOK">Norwegian krone</option><option value="NPR">Nepalese rupee</option><option value="NZD">New Zealand dollar</option><option value="OMR">Omani rial</option><option value="PAB">Panamanian balboa</option><option value="PEN">Peruvian nuevo sol</option><option value="PGK">Papua New Guinean kina</option><option value="PHP">Philippine peso</option><option value="PKR">Pakistani rupee</option><option value="PLN">Polish z?oty</option><option value="PRB">Transnistrian ruble</option><option value="PYG">Paraguayan guaran�</option><option value="QAR">Qatari riyal</option><option value="RON">Romanian leu</option><option value="RSD">Serbian dinar</option><option value="RUB">Russian ruble</option><option value="RWF">Rwandan franc</option><option value="SAR">Saudi riyal</option><option value="SBD">Solomon Islands dollar</option><option value="SCR">Seychellois rupee</option><option value="SDG">Singapore dollar</option><option value="SEK">Swedish krona</option><option value="SGD">Singapore dollar</option><option value="SHP">Saint Helena pound</option><option value="SLL">Sierra Leonean leone</option><option value="SOS">Somali shilling</option><option value="SRD">Surinamese dollar</option><option value="SSP">South Sudanese pound</option><option value="STD">S�o Tom� and Pr�ncipe dobra</option><option value="SVC">Salvadoran col�n</option><option value="SYP">Syrian pound</option><option value="SZL">Swazi lilangeni</option><option value="THB">Thai baht</option><option value="TJS">Tajikistani somoni</option><option value="TMT">Turkmenistan manat</option><option value="TND">Tunisian dinar</option><option value="TOP">Tongan pa?anga</option><option value="TRY">Turkish lira</option><option value="TTD">Trinidad and Tobago dollar</option><option value="TWD">New Taiwan dollar</option><option value="TZS">Tanzanian shilling</option><option value="UAH">Ukrainian hryvnia</option><option value="UGX">Ugandan shilling</option><option value="USD">United States dollar</option><option value="UYU">Uruguayan peso</option><option value="UZS">Uzbekistani som</option><option value="VEF">Venezuelan bol�var</option><option value="VND">Vietnamese ??ng</option><option value="VUV">Vanuatu vatu</option><option value="WST">Samoan t?l?</option><option value="XAF">Central African CFA franc</option><option value="XCD">East Caribbean dollar</option><option value="XOF">West African CFA franc</option><option value="XPF">CFP franc</option><option value="YER">Yemeni rial</option><option value="ZAR">South African rand</option><option value="ZMW">Zambian kwacha</option><option value="ZWL">Zimbabwean dollar</option></select-->
        <div class="bfh-selectbox bfh-currencies" data-currency="${sessionScope.logininfo.currency}" data-flags="true" align="left">
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
        <label class="checkbox">
          <input type="checkbox" value="remember-me">Agree to FX Pear's <a href="#">terms of use</a>
        </label>
         <input type="hidden" name="email" value=""/>
        <input type="hidden" name="address1" value=""/>
        <input type="hidden" name="address2" value=""/>

  </div>
  </form>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    <button  onClick="javascript:register(); return false" class="btn btn-primary">Register</button>
  </div>
  </div>
  </div>

</div> 



<!--PearUp Modal -->
<div id="postModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
    <h3 id="ModalLabel">Post your currency</h3>
  </div>

<form name="postForm" class="modal-register" >
       <c:if test="${empty sessionScope.logininfo}">
		  <div >
				<font color="red"><B>before posting, you must be loggined.</B></font>
		  </div>
		</c:if>  
<div>
  <div class="modal-body">
                <div class="bfh-selectbox bfh-currencies" data-currency="" data-flags="true" align="left">
                <input name="sccd" type="hidden" value="">
                <a class="bfh-selectbox-toggle" role="button" data-toggle="bfh-selectbox" href="#">
                  <span class="bfh-selectbox-option input-xlarge" data-option="">What currency do you have?</span>
                </a>
                <div class="bfh-selectbox-options" align="left">
                  <input type="text" class="bfh-selectbox-filter" placeholder="search">
                  <div role="listbox">
                  <ul role="option"></ul>
                  </div>
                </div>
              </div>
               <div class="bfh-selectbox bfh-currencies" data-currency="" data-flags="true" align="left">
                <input id="post_bccd" name="bccd" type="hidden" value="">
                <a class="bfh-selectbox-toggle" role="button" data-toggle="bfh-selectbox" href="#">
                  <span  id="post_bccd_selectbar" class="bfh-selectbox-option input-xlarge" data-option="">What currency do you want?</span>
                </a>
                <div class="bfh-selectbox-options" align="left">
                  <input type="text" class="bfh-selectbox-filter" placeholder="search">
                  <div role="listbox">
                  <ul role="option"></ul>
                  </div>
                </div>
              </div>
        
         <br><span>How much currency do you want to exchange?</span>
        <div class="input-prepend">
        <span id='post_cur_mark' class="add-on"></span>
        <input name="samt" id="prependedInput" type="text" class="input-mini" placeholder="0">
        <div class="input-append">
        <span id='post_currency' class="add-on">USD - United States Dollars</span></div>
        </div>
<%
Calendar calendar = Calendar.getInstance();
String today = "";
today += calendar.get(calendar.YEAR);
today += "-";
int month = calendar.get(calendar.MONTH)+1;
int day = calendar.get(calendar.DAY_OF_MONTH);
today += month < 10 ? "0"+month : month;
today += "-";
today += day < 10 ? "0"+day : day;
%>        

        <br><span>When do you need your currency?</span><div class="bfh-datepicker" data-format="y-m-d" data-date="<%=today%>">
  <div class="input-prepend bfh-datepicker-toggle" data-toggle="bfh-datepicker">
    <span class="add-on"><i class="icon-calendar"></i></span>
    <input name="trdt" type="text" class="input-medium" readonly>
  </div>
  <div class="bfh-datepicker-calendar">
    <table class="calendar table table-bordered">
      <thead>
        <tr class="months-header">
          <th class="month" colspan="4">
            <a class="previous" href="#"><i class="icon-chevron-left"></i></a>
            <span></span>
            <a class="next" href="#"><i class="icon-chevron-right"></i></a>
          </th>
          <th class="year" colspan="3">
            <a class="previous" href="#"><i class="icon-chevron-left"></i></a>
            <span></span>
            <a class="next" href="#"><i class="icon-chevron-right"></i></a>
          </th>
        </tr>
        <tr class="days-header">
        </tr>
      </thead>
      <tbody>
      </tbody>
    </table>
  </div>
</div>
  <!--     <input id="geocompletea" name="exlo" type="text" class="input-block-level" placeholder="Preferred exchange location"> -->
      <input id="geocomplete" name="exlo" type="text"  class="addresspicker" placeholder="Preferred exchange location" />
      
  </div>
  <input type="hidden" name="suid" value="${sessionScope.logininfo.id}"/>
  <input type="hidden" name="exlat" value="0"/>
  <input type="hidden" name="exlng" value="0"/>
	</div>
<div class="map_geocomplete" style="width:0%; height:0%"></></div>
<div class="geodetails">
  <span id="geo_lat" data-geo="lat" />
  <span id="geo_lng" data-geo="lng" />
</div>
</form> 
 
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    <button class="btn btn-primary" onClick="javascript:pearUp();return false">Pear Up</button>
  </div>
</div>


<!--Login Modal -->
<div id="loginModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">?</button>
    <h3 id="ModalLabel">Login</h3>
  </div>

<form name="reloginForm" class="modal-register"  METHOD=POST>
<div>
  <div class="modal-body">
        <c:choose>
	    	<c:when test="${!empty info.failerinfo}">
	    	<br><img src="http://graph.facebook.com/${info.failerinfo.fbuid}/picture?width=12&height=12"><span> Are you ${info.failerinfo.fname} ${info.failerinfo.lname}?</span>
		    </c:when>
		    <c:otherwise>
		    <br><span>Your ID[${param.id}] does not exist in Fxpear.</span>&nbsp;&nbsp;&nbsp;<a href="javascript:goRegist();" data-toggle="modal">Register</a>
		    </c:otherwise>
	  </c:choose>
         <br><span>Your ID or Password is incorrect. Can you try again to login?</span>
	  	 <BR>
	  	 <BR>
         <input type="text"  name="id" class="input-block-level" placeholder="Email address" value="${info.failerinfo.id}">
         <input type="password" name="password" class="input-block-level" placeholder="Password">
        <c:choose>
	    	<c:when test="${!empty info.failerinfo}">
         <br><span>forgot your password?</span>&nbsp;&nbsp;&nbsp;<a href="javascript:requestPassWord();" data-toggle="modal">Sending your email to change your password.</a>
		    </c:when>  
		</c:choose>
  </div>
</div>
</form> 
 
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    <button class="btn btn-primary" onClick="javascript:login('relogin');return false;">Login</button>
  </div>
</div>


<!--changpw Modal -->
<div id="changpwModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">?</button>
    <h3 id="ModalLabel">Change PassWord</h3>
  </div>
        <c:choose>     
        <c:when test="${param.auth == info.userinfo.auth}">

<form name="changpwForm" class="modal-register"  METHOD=POST>
<div>
  <div class="modal-body">
         <span>Input your new password</span>
  
        <c:choose>
	    	<c:when test="${!empty info.userinfo}">
	    	<br><br><img src="http://graph.facebook.com/${info.userinfo.fbuid}/picture?width=23&height=23"><span> ${info.userinfo.fname} ${info.userinfo.lname}</span>
		    </c:when>
	  </c:choose>
	  	 <BR>
	  	 <BR>

	  	 <div> 
         <input type="password" name="password" class="input-block-level" placeholder="new Password">
         <input type="password" name="repassword" class="input-block-level" placeholder="confirm Password">
         <input type="hidden" name="id" value="${info.userinfo.id}">
         <input type="hidden" name="auth" value="${param.auth}">
         </div>
  </div>
</div> 
</form> 

  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    <button class="btn btn-primary" onClick="javascript:changpw();return false;">Confirm</button>
  </div>

         </c:when>
        <c:otherwise>
        Your Auth information is not correct. Please check you email.
        <BR>You can try to ask password auth email again in login popup window.
        </c:otherwise>
        </c:choose>  
</div>


<script>

   	 <c:choose>
	    <c:when test="${info.login == 'FAIL'}">
	    $('#loginModal').modal('show');
	    </c:when>
	    <c:when test="${info.login == 'NEWPW'}">
	    $('#changpwModal').modal('show');	    
	    </c:when>
	  </c:choose>
</script>
	<script>
	jQuery(document).ready(function($) {
	    $("li.dropdown a").click(function(e){
	        $(this).next('ul.dropdown-menu').css("display", "block");
	        e.stopPropagation();
	        });
	    
		  // Setup drop down menu
		  $('.dropdown-toggle').dropdown();
		  
		  // Fix input element click problem
		  $('.dropdown-menu input,.dropdown-menu label').click(function(e) {
			$(this).next('.dropdown-menu').css("display", "block");
		    e.stopPropagation();
		  });
		  
		  $('#post_bccd').change(function () {
			  
	//		  alert('post_bccd_selectbar=='+  $('#post_bccd_selectbar option:selected').text());
			  alert($('#post_bccd_selectbar').find("option:selected").text()+' clicked!');
			  alert($('#post_bccd_selectbar').val()+' selected!');
			  $('#post_cur_mark').text('메롱');
			  $('#post_currency').text($('#post_bccd').val() + " - " + "dffdsafdsaf");
	      });  
		  
	});
	
	$(function() {
		  // Setup drop down menu
		  $('.dropdown-toggle').dropdown();
		 
		  // Fix input element click problem
		  $('.dropdown input, .dropdown label').click(function(e) {
			  $(this).next('.dropdown-menu').css("display", "block");
		    e.stopPropagation();
		  });
		});
	
	
	
    
	</script>	


