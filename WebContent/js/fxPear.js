		var FBappId = '478393655583465';  // dev server
//		var FBappId = '178340612342930';  // op server
	
		window.fbAsyncInit = function() {  
			    FB.init({appId: FBappId, 
			    	    status: true, 
			    	    cookie: true,
			    	    xfbml: true
			    });      
			};  
			      
			(function(d){  
			   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];  
			   if (d.getElementById(id)) {return;}  
			   js = d.createElement('script'); js.id = id; js.async = true;  
			   js.src = "//connect.facebook.net/en_US/all.js";  
			   ref.parentNode.insertBefore(js, ref);  
			 }(document));  
			
			var FBtoken = "";
			var fbloginChk = 0;
			
			function fbconnect(fbaction) {  
			    //페이스북 로그인 버튼을 눌렀을 때의 루틴. 
			        FB.login(function(response) {  
			        	alert("response.status=="+response.status);
			        	if(response.status === 'connected'){
			        		fbloginChk = 1;
			        		FBtoken = response.authResponse.accessToken;  
			        	//	alert(FBtoken);
			        		if(fbaction == "regist"){
			        			fblogininvoke();
			        		}else if(fbaction == "post"){
			        			fbPost("35");
			        		}
			        	}else	{
			        		alert("login failed!!");
			        		fbloginChk = 0;			     
			        		
			        	}
			            
			      //      alert(accessToken);
			        }, {scope: 'user_about_me,publish_stream,read_friendlists,offline_access,email,user_location'});  
			        

			}  
			
		function fblogininvoke(){
	        if(fbloginChk == 1){
	        	
		        FB.api( 
		        	    {
		        	      method: 'fql.query', 
		        	      query: 'select uid,first_name,last_name,email,locale,currency,current_address from user where uid  = me()'
		        	     }, 
		        	    function(response) {
		        	    	   
		        	    //	 alert("response="+response);
		        	    //	 alert("length="+response.length);
		        	    	 
		        	      for(var i=0; i < response.length; i++){
		        	    	  if(i == 0){
		        	    		  

		        	    	  document.fbregisterForm.id.value = response[i].email; // 이름
		        	    	  document.fbregisterForm.fname.value = response[i].first_name; // 이름
		        	    	  document.fbregisterForm.lname.value = response[i].last_name; // 이름
		        	    	  document.fbregisterForm.email.value = response[i].email; // 이름
		        	    	  document.fbregisterForm.fbuid.value = response[i].uid; // 이름
		        	    	  if(response[i].locale != ''){
			        	    	  document.fbregisterForm.nation.value = response[i].locale.substring(3,5); // 이름
		        	    		  
		        	    	  }
		 
		        	    	  document.fbregisterForm.currency.value = response[i].currency.user_currency; // 이름
		        	    	  document.fbregisterForm.password.value = prompt("input the password","");
			   		     //      alert("before submit;;");
			        	       document.fbregisterForm.action = "./fxuserInsert.fx";
			        	       document.fbregisterForm.method = "post";
			        	       document.fbregisterForm.submit();
		        	    	  }
		        	      } 
		        	      
		        	    } 
		        	    );

        	}			
		}

		
		function facebook_send_message(name, to,description,link) {
		    FB.ui({
		        app_id:FBappId,
		        method: 'send',
		        name: name,
		        link: link,
		        to:to,
		        description: description

		    });
		}
		
		function login(type){
			
			var vloginform;
			if (type == 'login'){
				vloginform = document.loginForm;
			}else if(type == 'mblogin'){
				vloginform = document.mbloginForm;
			}else if(type == 'relogin'){
				vloginform = document.reloginForm;
			}
			
			if(vloginform.id.value == ""){
				alert ("No ID");
				return;
			}
			
			vloginform.action = "./login.fx";
			vloginform.submit();
		}
		
		function logout(){
			document.loginForm.action = "./logout.fx";
			loginForm.submit();
		}		
		
		function goRegist(){
			$('#loginModal').modal('hide');
			$('#registModal').modal('show');
		}
		
		function changpw(){
			
		
			if(checkValid_changpw()){
				document.changpwForm.method = "POST";
				document.changpwForm.action = "./changePW.fx";
				document.changpwForm.submit();
			}

		}	
		
		function checkValid_changpw(){
			
			var ret = true; 
			if(document.changpwForm.password.value != document.changpwForm.repassword.value){
				alert("It's different between password and confirm password!");
				ret = false;
				return;
			}
			return ret;
		}
		
		function requestPassWord(){
			document.reloginForm.action = "./requestPW.fx";
			document.reloginForm.submit();	
		}
		
		function pearUp(){
			if(checkValid_pearUp()){
				document.postForm.method = "POST";
				document.postForm.action = "./pearup.fx";
				postForm.submit();
			}
		}		
	

		
		function checkValid_pearUp(){
			
			var ret = true; 
			if(document.postForm.suid.value == ""){
				alert(" If you want to post pear, you must be loggined");
				ret = false;
				return;
			}
			
			if(document.postForm.sccd.value == ""){
				document.postForm.sccd.focus();
				alert ("choose your currency you want to change.");
				ret = false;
				return;
			}
			
			if(document.postForm.samt.value == ""){
				document.postForm.samt.focus();
				alert ("input your money how much you want to change.");
				ret = false;
				return;
			}

			
			if(document.postForm.trdt.value == ""){
				document.postForm.bccd.focus();
				alert ("choose your date you want to change.");
				ret = false;
				return;
			}

			
			if(document.postForm.bccd.value == ""){
				document.postForm.bccd.focus();
				alert ("input the currency you want to change to.");
				ret = false;
				return;
			}
			
			if(document.postForm.exlo.value == ""){
				document.postForm.exlo.focus();
				alert ("choose your city you want to change.");
				ret = false;
				return;
			}
			
			return ret;
		} 
		
		function register(){
			alert("register");
	//		if(register_isValid()){	
				alert("here");
				document.registerForm.email.value = document.registerForm.id.value;
				document.registerForm.action = "./fxuserInsert.fx";
				document.registerForm.submit();
	//		}else	{
	//			return false;
	//		}
		}
		
		function register_isValid(){
			var ret = true;
			alert('register_isValid');
			if(document.registerForm.id.value == ""){
				document.registerForm.id.focus();
				alert ("No EMAIL");
				ret = false;
			}
			
			if(document.userForm.password.value == ""){
				document.userForm.password.focus();
				alert ("No PASSWORD");
				ret = false;
			}
			
			if(document.registerForm.nation.value == ""){
				document.registerForm.nation.focus();
				alert ("No Nation");
				ret = false;
			}
			
			if(document.registerForm.fname.value == ""){
				document.registerForm.fname.focus();
				alert ("No First Name");
				ret = false;
			}
			
			if(document.registerForm.lname.value == ""){
				document.registerForm.lname.focus();
				alert ("No Last Name");
				ret = false;
			}

			if(document.registerForm.id.value == ""){
				document.registerForm.id.focus();
				alert ("No ID");
				ret = false;
			}
			
			if(document.userForm.currency.value == ""){
				document.userForm.currency.focus();
				alert ("No Currency");
				ret = false;
			}
			
			if(document.registerForm.password.value != document.registerForm.repassword.value){
				alert ("Please check your password again");
				document.registerForm.password.focus();
				ret = false;
			}
			alert(ret);
			return ret;
		}
		
