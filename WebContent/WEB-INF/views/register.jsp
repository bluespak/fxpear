<%@ page session="false" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
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

    <!-- Le styles -->
    <link href="./css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }

      .form-signin {
        max-width: 300px;
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
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
        padding: 7px 9px;
      }

    </style>
    <link href="./css/bootstrap-responsive.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="./js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="./ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="./ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="./ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="./ico/apple-touch-icon-57-precomposed.png">
    <link rel="shortcut icon" href="./ico/favicon.png">
    
	<script>
	function insert(){

		if(isValid()){	
			alert("here");
			document.userForm.email.value = document.userForm.id.value;
			document.userForm.action = "./fxuserInsert.fx";
			userForm.sumit();
		}else	{
			return false;
		}
	}
	
	function isValid(){
		var ret = true;
		if(document.userForm.id.value == ""){
			document.userForm.id.focus();
			alert ("No EMAIL");
			ret = false;
		}
		
		if(document.userForm.password.value == ""){
			document.userForm.password.focus();
			alert ("No PASSWORD");
			ret = false;
		}
		
		if(document.userForm.nation.value == ""){
			document.userForm.nation.focus();
			alert ("No Nation");
			ret = false;
		}
		
		if(document.userForm.fname.value == ""){
			document.userForm.fname.focus();
			alert ("No Fist Name");
			ret = false;
		}
		
		if(document.userForm.lname.value == ""){
			document.userForm.lname.focus();
			alert ("No Last Name");
			ret = false;
		}

		if(document.userForm.id.value == ""){
			document.userForm.id.focus();
			alert ("No ID");
			ret = false;
		}
		
		if(document.userForm.currency.value == ""){
			document.userForm.currency.focus();
			alert ("No Currency");
			ret = false;
		}
		
		if(document.userForm.password.value != document.userForm.repassword.value){
			alert ("Please check your password again");
			document.userForm.password.focus();
			ret = false;
		}
		alert(ret);
		return ret;
	}
	</script>                                   
  </head>

  <body>
    
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#">FX Pear</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="#">Home</a></li>
              <li><a href="#about">About</a></li>
              <li><a href="#contact">Contact</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="#">Action</a></li>
                  <li><a href="#">Another action</a></li>
                  <li><a href="#">Something else here</a></li>
                  <li class="divider"></li>
                  <li class="nav-header">Nav header</li>
                  <li><a href="#">Separated link</a></li>
                  <li><a href="#">One more separated link</a></li>
                </ul>
              </li>
            </ul>
            <form class="navbar-form pull-right">
              <input class="span2" type="text" placeholder="Email">
              <input class="span2" type="password" placeholder="Password">
              <button type="submit" class="btn">Sign in</button>
            </form>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
    <br class="clear">
    <div class="container">
      <form class="form-signin" NAME=userForm METHOD=POST>
        <h2 class="form-signin-heading">Register</h2>
        <input type="text" class="input-block-level" placeholder="Email address" name="id">
        <input type="text" class="input-block-level" placeholder="First name"  name="fname">
        <input type="text" class="input-block-level" placeholder="Last name"  name="lname">
        <select class="input-medium bfh-countries" data-country="US"  name="nation"><option value=""></option><option value="AF">Afghanistan</option><option value="AL">Albania</option><option value="DZ">Algeria</option><option value="AS">American Samoa</option><option value="AD">Andorra</option><option value="AO">Angola</option><option value="AI">Anguilla</option><option value="AQ">Antarctica</option><option value="AG">Antigua and Barbuda</option><option value="AR">Argentina</option><option value="AM">Armenia</option><option value="AW">Aruba</option><option value="AU">Australia</option><option value="AT">Austria</option><option value="AZ">Azerbaijan</option><option value="BH">Bahrain</option><option value="BD">Bangladesh</option><option value="BB">Barbados</option><option value="BY">Belarus</option><option value="BE">Belgium</option><option value="BZ">Belize</option><option value="BJ">Benin</option><option value="BM">Bermuda</option><option value="BT">Bhutan</option><option value="BO">Bolivia</option><option value="BA">Bosnia and Herzegovina</option><option value="BW">Botswana</option><option value="BV">Bouvet Island</option><option value="BR">Brazil</option><option value="IO">British Indian Ocean Territory</option><option value="VG">British Virgin Islands</option><option value="BN">Brunei</option><option value="BG">Bulgaria</option><option value="BF">Burkina Faso</option><option value="BI">Burundi</option><option value="CI">Cte d'Ivoire</option><option value="KH">Cambodia</option><option value="CM">Cameroon</option><option value="CA">Canada</option><option value="CV">Cape Verde</option><option value="KY">Cayman Islands</option><option value="CF">Central African Republic</option><option value="TD">Chad</option><option value="CL">Chile</option><option value="CN">China</option><option value="CX">Christmas Island</option><option value="CC">Cocos (Keeling) Islands</option><option value="CO">Colombia</option><option value="KM">Comoros</option><option value="CG">Congo</option><option value="CK">Cook Islands</option><option value="CR">Costa Rica</option><option value="HR">Croatia</option><option value="CU">Cuba</option><option value="CY">Cyprus</option><option value="CZ">Czech Republic</option><option value="CD">Democratic Republic of the Congo</option><option value="DK">Denmark</option><option value="DJ">Djibouti</option><option value="DM">Dominica</option><option value="DO">Dominican Republic</option><option value="TP">East Timor</option><option value="EC">Ecuador</option><option value="EG">Egypt</option><option value="SV">El Salvador</option><option value="GQ">Equatorial Guinea</option><option value="ER">Eritrea</option><option value="EE">Estonia</option><option value="ET">Ethiopia</option><option value="FO">Faeroe Islands</option><option value="FK">Falkland Islands</option><option value="FJ">Fiji</option><option value="FI">Finland</option><option value="MK">Former Yugoslav Republic of Macedonia</option><option value="FR">France</option><option value="FX">France, Metropolitan</option><option value="GF">French Guiana</option><option value="PF">French Polynesia</option><option value="TF">French Southern Territories</option><option value="GA">Gabon</option><option value="GE">Georgia</option><option value="DE">Germany</option><option value="GH">Ghana</option><option value="GI">Gibraltar</option><option value="GR">Greece</option><option value="GL">Greenland</option><option value="GD">Grenada</option><option value="GP">Guadeloupe</option><option value="GU">Guam</option><option value="GT">Guatemala</option><option value="GN">Guinea</option><option value="GW">Guinea-Bissau</option><option value="GY">Guyana</option><option value="HT">Haiti</option><option value="HM">Heard and Mc Donald Islands</option><option value="HN">Honduras</option><option value="HK">Hong Kong</option><option value="HU">Hungary</option><option value="IS">Iceland</option><option value="IN">India</option><option value="ID">Indonesia</option><option value="IR">Iran</option><option value="IQ">Iraq</option><option value="IE">Ireland</option><option value="IL">Israel</option><option value="IT">Italy</option><option value="JM">Jamaica</option><option value="JP">Japan</option><option value="JO">Jordan</option><option value="KZ">Kazakhstan</option><option value="KE">Kenya</option><option value="KI">Kiribati</option><option value="KW">Kuwait</option><option value="KG">Kyrgyzstan</option><option value="LA">Laos</option><option value="LV">Latvia</option><option value="LB">Lebanon</option><option value="LS">Lesotho</option><option value="LR">Liberia</option><option value="LY">Libya</option><option value="LI">Liechtenstein</option><option value="LT">Lithuania</option><option value="LU">Luxembourg</option><option value="MO">Macau</option><option value="MG">Madagascar</option><option value="MW">Malawi</option><option value="MY">Malaysia</option><option value="MV">Maldives</option><option value="ML">Mali</option><option value="MT">Mayotte</option><option value="MH">Marshall Islands</option><option value="MQ">Martinique</option><option value="MR">Mauritania</option><option value="MU">Mauritius</option><option value="MX">Mexico</option><option value="FM">Micronesia</option><option value="MD">Moldova</option><option value="MC">Monaco</option><option value="MN">Mongolia</option><option value="ME">Montenegro</option><option value="MS">Montserrat</option><option value="MA">Morocco</option><option value="MZ">Mozambique</option><option value="MM">Myanmar</option><option value="NA">Namibia</option><option value="NR">Nauru</option><option value="NP">Nepal</option><option value="NL">Netherlands</option><option value="AN">Netherlands Antilles</option><option value="NC">New Caledonia</option><option value="NZ">New Zealand</option><option value="NI">Nicaragua</option><option value="NE">Niger</option><option value="NG">Nigeria</option><option value="NU">Niue</option><option value="NF">Norfolk Island</option><option value="KP">North Korea</option><option value="MP">Northern Marianas</option><option value="NO">Norway</option><option value="OM">Oman</option><option value="PK">Pakistan</option><option value="PW">Palau</option><option value="PA">Panama</option><option value="PG">Papua New Guinea</option><option value="PY">Paraguay</option><option value="PE">Peru</option><option value="PH">Philippines</option><option value="PN">Pitcairn Islands</option><option value="PL">Poland</option><option value="PT">Portugal</option><option value="PR">Puerto Rico</option><option value="QA">Qatar</option><option value="RE">Reunion</option><option value="RO">Romania</option><option value="RU">Russia</option><option value="RW">Rwanda</option><option value="ST">So Tom and Prncipe</option><option value="SH">Saint Helena</option><option value="PM">St. Pierre and Miquelon</option><option value="KN">Saint Kitts and Nevis</option><option value="LC">Saint Lucia</option><option value="VC">Saint Vincent and the Grenadines</option><option value="WS">Samoa</option><option value="SM">San Marino</option><option value="SA">Saudi Arabia</option><option value="SN">Senegal</option><option value="RS">Serbia</option><option value="SC">Seychelles</option><option value="SL">Sierra Leone</option><option value="SG">Singapore</option><option value="SK">Slovakia</option><option value="SI">Slovenia</option><option value="SB">Solomon Islands</option><option value="SO">Somalia</option><option value="ZA">South Africa</option><option value="GS">South Georgia and the South Sandwich Islands</option><option value="KR">South Korea</option><option value="ES">Spain</option><option value="LK">Sri Lanka</option><option value="SD">Sudan</option><option value="SR">Suriname</option><option value="SJ">Svalbard and Jan Mayen Islands</option><option value="SZ">Swaziland</option><option value="SE">Sweden</option><option value="CH">Switzerland</option><option value="SY">Syria</option><option value="TW">Taiwan</option><option value="TJ">Tajikistan</option><option value="TZ">Tanzania</option><option value="TH">Thailand</option><option value="BS">The Bahamas</option><option value="GM">The Gambia</option><option value="TG">Togo</option><option value="TK">Tokelau</option><option value="TO">Tonga</option><option value="TT">Trinidad and Tobago</option><option value="TN">Tunisia</option><option value="TR">Turkey</option><option value="TM">Turkmenistan</option><option value="TC">Turks and Caicos Islands</option><option value="TV">Tuvalu</option><option value="VI">US Virgin Islands</option><option value="UG">Uganda</option><option value="UA">Ukraine</option><option value="AE">United Arab Emirates</option><option value="GB">United Kingdom</option><option value="US">United States</option><option value="UM">United States Minor Outlying Islands</option><option value="UY">Uruguay</option><option value="UZ">Uzbekistan</option><option value="VU">Vanuatu</option><option value="VA">Vatican City</option><option value="VE">Venezuela</option><option value="VN">Vietnam</option><option value="WF">Wallis and Futuna Islands</option><option value="EH">Western Sahara</option><option value="YE">Yemen</option><option value="ZM">Zambia</option><option value="ZW">Zimbabwe</option></select>
        <select class="input-medium bfh-states" data-country="US" data-state="CA" name="city"><option value=""></option><option value="AL">Alabama</option><option value="AK">Alaska</option><option value="AS">American Samoa</option><option value="AZ">Arizona</option><option value="AR">Arkansas</option><option value="AF">Armed Forces Africa</option><option value="AA">Armed Forces Americas</option><option value="AC">Armed Forces Canada</option><option value="AE">Armed Forces Europe</option><option value="AM">Armed Forces Middle East</option><option value="AP">Armed Forces Pacific</option><option value="CA">California</option><option value="CO">Colorado</option><option value="CT">Connecticut</option><option value="DE">Delaware</option><option value="DC">District of Columbia</option><option value="FM">Federated States Of Micronesia</option><option value="FL">Florida</option><option value="GA">Georgia</option><option value="GU">Guam</option><option value="HI">Hawaii</option><option value="ID">Idaho</option><option value="IL">Illinois</option><option value="IN">Indiana</option><option value="IA">Iowa</option><option value="KS">Kansas</option><option value="KY">Kentucky</option><option value="LA">Louisiana</option><option value="ME">Maine</option><option value="MH">Marshall Islands</option><option value="MD">Maryland</option><option value="MA">Massachusetts</option><option value="MI">Michigan</option><option value="MN">Minnesota</option><option value="MS">Mississippi</option><option value="MO">Missouri</option><option value="MT">Montana</option><option value="NE">Nebraska</option><option value="NV">Nevada</option><option value="NH">New Hampshire</option><option value="NJ">New Jersey</option><option value="NM">New Mexico</option><option value="NY">New York</option><option value="NC">North Carolina</option><option value="ND">North Dakota</option><option value="MP">Northern Mariana Islands</option><option value="OH">Ohio</option><option value="OK">Oklahoma</option><option value="OR">Oregon</option><option value="PW">Palau</option><option value="PA">Pennsylvania</option><option value="PR">Puerto Rico</option><option value="RI">Rhode Island</option><option value="SC">South Carolina</option><option value="SD">South Dakota</option><option value="TN">Tennessee</option><option value="TX">Texas</option><option value="UT">Utah</option><option value="VT">Vermont</option><option value="VI">Virgin Islands</option><option value="VA">Virginia</option><option value="WA">Washington</option><option value="WV">West Virginia</option><option value="WI">Wisconsin</option><option value="WY">Wyoming</option></select>
        <select class="input-medium bfh-currencies" data-currency="EUR" name="currency"><option value=""></option><option value="AED">United Arab Emirates dirham</option><option value="AFN">Afghan afghani</option><option value="ALL">Albanian lek</option><option value="AMD">Armenian dram</option><option value="AOA">Angolan kwanza</option><option value="ARS">Argentine peso</option><option value="AUD">Australian dollar</option><option value="AWG">Aruban florin</option><option value="AZN">Azerbaijani manat</option><option value="BAM">Bosnia and Herzegovina convertible mark</option><option value="BBD">Barbadian dollar</option><option value="BDT">Bangladeshi taka</option><option value="BGN">Bulgarian lev</option><option value="BHD">Bahraini dinar</option><option value="BIF">Burundian franc</option><option value="BMD">Bermudian dollar</option><option value="BND">Brunei dollar</option><option value="BOB">Bolivian boliviano</option><option value="BRL">Brazilian real</option><option value="BSD">Bahamian dollar</option><option value="BTN">Bhutanese ngultrum</option><option value="BWP">Botswana pula</option><option value="BYR">Belarusian ruble</option><option value="BZD">Belize dollar</option><option value="CAD">Canadian dollar</option><option value="CDF">Congolese franc</option><option value="CHF">Swiss franc</option><option value="CLP">Chilean peso</option><option value="CNY">Chinese yuan</option><option value="COP">Colombian peso</option><option value="CRC">Costa Rican coln</option><option value="CUP">Cuban convertible peso</option><option value="CVE">Cape Verdean escudo</option><option value="CZK">Czech koruna</option><option value="DJF">Djiboutian franc</option><option value="DKK">Danish krone</option><option value="DOP">Dominican peso</option><option value="DZD">Algerian dinar</option><option value="EGP">Egyptian pound</option><option value="ERN">Eritrean nakfa</option><option value="ETB">Ethiopian birr</option><option value="EUR">Euro</option><option value="FJD">Fijian dollar</option><option value="FKP">Falkland Islands pound</option><option value="GBP">British pound</option><option value="GEL">Georgian lari</option><option value="GHS">Ghana cedi</option><option value="GMD">Gambian dalasi</option><option value="GNF">Guinean franc</option><option value="GTQ">Guatemalan quetzal</option><option value="GYD">Guyanese dollar</option><option value="HKD">Hong Kong dollar</option><option value="HNL">Honduran lempira</option><option value="HRK">Croatian kuna</option><option value="HTG">Haitian gourde</option><option value="HUF">Hungarian forint</option><option value="IDR">Indonesian rupiah</option><option value="ILS">Israeli new shekel</option><option value="IMP">Manx pound</option><option value="INR">Indian rupee</option><option value="IQD">Iraqi dinar</option><option value="IRR">Iranian rial</option><option value="ISK">Icelandic krna</option><option value="JEP">Jersey pound</option><option value="JMD">Jamaican dollar</option><option value="JOD">Jordanian dinar</option><option value="JPY">Japanese yen</option><option value="KES">Kenyan shilling</option><option value="KGS">Kyrgyzstani som</option><option value="KHR">Cambodian riel</option><option value="KMF">Comorian franc</option><option value="KPW">North Korean won</option><option value="KRW">South Korean won</option><option value="KWD">Kuwaiti dinar</option><option value="KYD">Cayman Islands dollar</option><option value="KZT">Kazakhstani tenge</option><option value="LAK">Lao kip</option><option value="LBP">Lebanese pound</option><option value="LKR">Sri Lankan rupee</option><option value="LRD">Liberian dollar</option><option value="LSL">Lesotho loti</option><option value="LTL">Lithuanian litas</option><option value="LVL">Latvian lats</option><option value="LYD">Libyan dinar</option><option value="MAD">Moroccan dirham</option><option value="MDL">Moldovan leu</option><option value="MGA">Malagasy ariary</option><option value="MKD">Macedonian denar</option><option value="MMK">Burmese kyat</option><option value="MNT">Mongolian tgrg</option><option value="MOP">Macanese pataca</option><option value="MRO">Mauritanian ouguiya</option><option value="MUR">Mauritian rupee</option><option value="MVR">Maldivian rufiyaa</option><option value="MWK">Malawian kwacha</option><option value="MXN">Mexican peso</option><option value="MYR">Malaysian ringgit</option><option value="MZN">Mozambican metical</option><option value="NAD">Namibian dollar</option><option value="NGN">Nigerian naira</option><option value="NIO">Nicaraguan crdoba</option><option value="NOK">Norwegian krone</option><option value="NPR">Nepalese rupee</option><option value="NZD">New Zealand dollar</option><option value="OMR">Omani rial</option><option value="PAB">Panamanian balboa</option><option value="PEN">Peruvian nuevo sol</option><option value="PGK">Papua New Guinean kina</option><option value="PHP">Philippine peso</option><option value="PKR">Pakistani rupee</option><option value="PLN">Polish z?oty</option><option value="PRB">Transnistrian ruble</option><option value="PYG">Paraguayan guaran</option><option value="QAR">Qatari riyal</option><option value="RON">Romanian leu</option><option value="RSD">Serbian dinar</option><option value="RUB">Russian ruble</option><option value="RWF">Rwandan franc</option><option value="SAR">Saudi riyal</option><option value="SBD">Solomon Islands dollar</option><option value="SCR">Seychellois rupee</option><option value="SDG">Singapore dollar</option><option value="SEK">Swedish krona</option><option value="SGD">Singapore dollar</option><option value="SHP">Saint Helena pound</option><option value="SLL">Sierra Leonean leone</option><option value="SOS">Somali shilling</option><option value="SRD">Surinamese dollar</option><option value="SSP">South Sudanese pound</option><option value="STD">So Tom and Prncipe dobra</option><option value="SVC">Salvadoran coln</option><option value="SYP">Syrian pound</option><option value="SZL">Swazi lilangeni</option><option value="THB">Thai baht</option><option value="TJS">Tajikistani somoni</option><option value="TMT">Turkmenistan manat</option><option value="TND">Tunisian dinar</option><option value="TOP">Tongan pa?anga</option><option value="TRY">Turkish lira</option><option value="TTD">Trinidad and Tobago dollar</option><option value="TWD">New Taiwan dollar</option><option value="TZS">Tanzanian shilling</option><option value="UAH">Ukrainian hryvnia</option><option value="UGX">Ugandan shilling</option><option value="USD">United States dollar</option><option value="UYU">Uruguayan peso</option><option value="UZS">Uzbekistani som</option><option value="VEF">Venezuelan bolvar</option><option value="VND">Vietnamese ??ng</option><option value="VUV">Vanuatu vatu</option><option value="WST">Samoan t?l?</option><option value="XAF">Central African CFA franc</option><option value="XCD">East Caribbean dollar</option><option value="XOF">West African CFA franc</option><option value="XPF">CFP franc</option><option value="YER">Yemeni rial</option><option value="ZAR">South African rand</option><option value="ZMW">Zambian kwacha</option><option value="ZWL">Zimbabwean dollar</option></select>
        <input type="password" class="input-block-level" placeholder="Password" name="password"> 
        <input type="password" class="input-block-level" placeholder="Re-enter Password"  name="repassword">
        <label class="checkbox">
          <input type="checkbox" value="remember-me">Agree to <a href="#">terms and conditions</a>
        </label>
        <input type="hidden" name="email" value=""/>
        <input type="hidden" name="address1" value=""/>
        <input type="hidden" name="address2" value=""/>
        <button class="btn btn-large btn-primary" onClick="javascript:insert()" type="submit">Sign in</button>
      </form>
    </div> <!-- /container -->

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
    <script src="./js/bootstrap-formhelpers-countries.en_US.js"></script>
    <script src="./js/bootstrap-formhelpers-countries.js"></script>
    <script src="./-formhelpers-states.en_US.js"></script>
    <script src="./-formhelpers-states.js"></script>
    <script src="./-formhelpers-currencies.en_US.js"></script>
    <script src="./-formhelpers-currencies.js"></script>
    <script src="./jquery.geocomplete.js"></script>
  </body>
</html>
