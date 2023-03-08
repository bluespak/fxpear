/*
 * Copyright 2012-Present bluespak. All rights reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.bluespak.controllers;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bluespak.service.DiscussService;
import com.bluespak.service.FxBoardService;
import com.bluespak.service.FxUserService;
import com.bluespak.service.PearService;
import com.bluespak.service.BidService;
import com.bluespak.service.FxbRplService;
import com.bluespak.utils.TwitterService;
import com.bluespak.vo.FxUserVO;
import com.bluespak.vo.FxbRplVO; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
/**
 * @author bluespak(bluespak@gmail.com)
 */
@Controller
public class FxPearController {
//	@Autowired
//	private CommonBO commonBO;

//	@Autowired
//	private FxUserDAOImpl fxuserDAO;

	@Autowired
	private FxUserService fxuserService;
	
	@Autowired
	private PearService pearService;

	@Autowired
	private BidService bidService;
	
	@Autowired
	private DiscussService discussService;

	@Autowired
	private TwitterService twitterService;
	
	@RequestMapping(value="/home", method = RequestMethod.GET)
	public String home(ModelMap model) {
		

		return "home";
	}	
	
	@RequestMapping(value="/main", method = RequestMethod.GET)
	public String main(HttpSession session,ModelMap model) {
		
		session.setAttribute("mobileYN", "N");
		return "main";
	}	
		
	@RequestMapping(value="/mainM", method = RequestMethod.GET)
	public String mainweb(HttpSession session,ModelMap model) {
		
		session.setAttribute("mobileYN", "Y");
		return "mainM";
	}	
	
	@RequestMapping(value="/Register")
	public String regist(ModelMap model,@RequestParam Map<String,String> params) {
		
		return "register";
	}	
	
	@RequestMapping(value="/fxuserInsert")
	public String fxuserInsert(ModelMap model,HttpSession session,@RequestParam Map<String,String> params) {
		
		System.out.println("fxuserInsert params============="+params);
		String password = params.get("password");
		System.out.println("original password="+password);
		Map<String, Object> userinfo = fxuserService.insertUser(params);
		params.put("password", password);
		System.out.println("saved password="+password);
		Map<String, Object> info = fxuserService.loginFxUser(params);
//		Map<String, Object> userinfo = fxboardService.insertBoard(params);
		if(info != null && info.get("userinfo") != null){
			session.setAttribute("logininfo", info.get("userinfo"));
			System.out.println("session set before userinfo="+info.get("userinfo"));
			System.out.println("session set complete!!"); 
		}
		model.addAttribute("info", userinfo);
		return "main";
	}		 
	
	@RequestMapping(value="/login")
	public String login(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		
		Map<String, Object> info = fxuserService.loginFxUser(params);
		if(info != null && info.get("userinfo") != null){
			session.setAttribute("logininfo", info.get("userinfo"));
			System.out.println("session set before userinfo="+info.get("userinfo"));
			System.out.println("session set complete!!"); 
		}
		System.out.println(session.getAttribute("logininfo"));
		
		model.addAttribute("info", info);
		/*
		try {
			response.sendRedirect("./main.fx");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/		
		return "main";  
	}	
	
	@RequestMapping(value="/requestPW")
	public String requestPW(ModelMap model,HttpSession session, HttpServletResponse response, HttpServletRequest request, @RequestParam Map<String,String> params) {
		
		params.put("hostname", request.getServerName()+":"+request.getServerPort()); 

		Map<String, Object> info = fxuserService.requestPassword(params);
	
		model.addAttribute("info", info);
		/*
		try {
			response.sendRedirect("./main.fx");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/		
		return "main";  
	}	

	@RequestMapping(value="/changePW")
	public String changePW(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		

		Map<String, Object> info = fxuserService.changePassword(params);
	
		model.addAttribute("info", info);
		/*
		try {
			response.sendRedirect("./main.fx");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/		
		return "main";  
	}	

	
	@RequestMapping(value="/passwordAuth")
	public String passwordAuth(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		

		Map<String, Object> info = fxuserService.passwordAuth(params);
	
		model.addAttribute("info", info);
		/*
		try {
			response.sendRedirect("./main.fx");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/		
		return "main";  
	}	
	
	@RequestMapping(value="/logout")
	public String logout(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		session.removeAttribute("logininfo");
		
		try {
			response.sendRedirect("./main.fx");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "main";
	}		

	@RequestMapping(value="/pearup")
	public String pearup(ModelMap model,@RequestParam Map<String,String> params) {

		System.out.println("Controller.pearup params============="+params);
		Map<String, Object> pearinfo = pearService.postPear(params);
		model.addAttribute("info", pearinfo);
		return "main";	
	}		

	
	@RequestMapping(value="/searchPear")
	public String seachPear(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		FxUserVO userinfo = (FxUserVO)session.getAttribute("logininfo");
		if(userinfo != null){
			params.put("suid",userinfo.getId());
		}else {
			params.put("suid","");		
		}
		
		Map<String, Object> info = pearService.searchPear(params);
		model.addAttribute("info", info);
	
		return "results";
	}	

	@RequestMapping(value="/searchPearByPosition")
	public String searchPearByPosition(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		FxUserVO userinfo = (FxUserVO)session.getAttribute("logininfo");
		if(userinfo != null){
			params.put("suid",userinfo.getId());
		}else {
			params.put("suid","");		
		}
		
		Map<String, Object> info = pearService.searchPearByPostion(params);
		model.addAttribute("info", info);
	
		return "results";
	}	
	
	
	@RequestMapping(value="/discussion")
	public String discussion(ModelMap model,HttpServletRequest request, @RequestParam Map<String,String> params) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Map<String, Object> info = pearService.getPearInfo(params);
		model.addAttribute("info", info);
	
		return "discussion";
	}		
	
	@RequestMapping(value="/summary")
	public String summary(ModelMap model, @RequestParam Map<String,String> params) {
		Map<String, Object> info = pearService.getPearInfo(params);
		model.addAttribute("info", info);
	
		return "summary";
	}	
	
	@RequestMapping(value="/detail")
	public String detail(ModelMap model, @RequestParam Map<String,String> params) {
		Map<String, Object> info = pearService.getPearInfo(params);
		model.addAttribute("info", info);
	
		return "detail";
	}	
		
	
	@RequestMapping(value="/bidpear")
	public String bidpear(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {

		System.out.println("Controller bidpear params============="+params);
		bidService.bidPear(params);
		try {
			response.sendRedirect("./detail.fx?cuid="+params.get("buid")+"&whoc=B&pseq="+params.get("pseq"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//model.addAttribute("info", bidinfo);
		return "detail";	
	}	
	
	@RequestMapping(value="/upDiscuss")
	public String upDiscuss(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {

		System.out.println("Controller.upDiscuss params============="+params);
		Map<String, Object> bidinfo = discussService.upDiscuss(params);
		try {
			response.sendRedirect("./detail.fx?cuid="+params.get("cuid")+"&whoc="+params.get("whoc")+"&pseq="+params.get("pseq"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	//	model.addAttribute("info", bidinfo);
		return "detail";	
	}		

	@RequestMapping(value="/completePear")
	public String completePear(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {

		System.out.println("completePear params============="+params);
		Map<String, Object> pearinfo = pearService.completePear(params);
		try {
			response.sendRedirect("./detail.fx?cuid="+params.get("buid")+"&whoc=S&pseq="+params.get("pseq"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//model.addAttribute("info", bidinfo);
		return "detail";	
	}		
	
	@RequestMapping(value="/changeStatus")
	public String changeStatus(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {

		System.out.println("changeStatus params============="+params);
		Map<String, Object> pearinfo = pearService.changeStatus(params);
		try {
			response.sendRedirect("./myPage.fx");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//model.addAttribute("info", bidinfo);
		return "detail";	
	}		
	
	
	@RequestMapping(value="/myPage")
	public String myPage (ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {

		System.out.println("myPage params============="+params);
		FxUserVO userinfo = (FxUserVO)session.getAttribute("logininfo");
		if(userinfo != null){
			params.put("id",userinfo.getId());
			Map<String, Object> mypageinfo = pearService.getMyPear(params);
			model.addAttribute("info", mypageinfo);
			return "mypage";	
		}else	{
			return "main";	
		}
	}		 
	
	
	

	@RequestMapping("/tweetPost")
	@ResponseBody
	public void tweetPost(HttpServletResponse response,@RequestParam Map<String,String> params) throws Exception{
		Map<String, Object> info = twitterService.tweetPost(params);
		
	    BufferedWriter bw = new BufferedWriter(response.getWriter());
	    bw.write("{}");
	    bw.close();
	}

	@RequestMapping("/currencyinfo")
	@ResponseBody
	public void currency(HttpServletResponse response,@RequestParam Map<String,String> params) throws Exception{
	    response.setContentType("text/xml");
	      
	    URLConnection conn;
	    BufferedWriter bw;
	    BufferedReader br;
	     
//	    conn = new URL("http://www.naver.com/include/timesquare/widget/exchange.xml").openConnection();
//	    conn.addRequestProperty("Referer", "http://www.naver.com");

//	    conn = new URL("http://www.google.com/ig/calculator?hl=en&q=1000USD=?AUD").openConnection();
//	    conn.addRequestProperty("Referer", "http://www.google.com/ig/calculator");

/*	   
	    conn = new URL("http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22"+params.get("from")+params.get("to")+"%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=cbfunc").openConnection();
	    conn.addRequestProperty("Referer", "http://query.yahooapis.com");

	    
	    
//	    conn = new URL("http://rate-exchange.appspot.com/currency?from=USD&to=EUR").openConnection();
//	    conn.addRequestProperty("Referer", "http://rate-exchange.appspot.com");
	    
	    br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	    bw = new BufferedWriter(response.getWriter());
	     
	    String line = null;
	    StringBuffer sb = new StringBuffer();
	    while( (line=br.readLine())!=null ){
	    	line = line.replace("cbfunc(", "");
	    	line = line.replace(");", "");
	//   	line = line.replace("error:", "\"error\":");
	//    	line = line.replace("icc:", "\"icc\":");
	    	sb.append(line);
	    }
  //      bw.write(line);
        bw.write(sb.toString(),0,sb.length());
	     
	    
	    bw.close();
*/	    
	}




}