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
public class FxPearMController {
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


	@RequestMapping(value="/RegisterM")
	public String registM(ModelMap model,@RequestParam Map<String,String> params) {
		
		return "register";
	}	
	
	@RequestMapping(value="/fxuserInsertM")
	public String fxuserInsertM(ModelMap model,HttpSession session,@RequestParam Map<String,String> params) {
		
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
	
	@RequestMapping(value="/loginM")
	public String loginM(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		
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
	
	@RequestMapping(value="/requestPWM")
	public String requestPWM(ModelMap model,HttpSession session, HttpServletResponse response, HttpServletRequest request, @RequestParam Map<String,String> params) {
		
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

	@RequestMapping(value="/changePWM")
	public String changePWM(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		

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

	
	@RequestMapping(value="/passwordAuthM")
	public String passwordAuthM(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		

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
	
	@RequestMapping(value="/logoutM")
	public String logoutM(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		session.removeAttribute("logininfo");
		
		try {
			response.sendRedirect("./main.fx");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "main";
	}		

	@RequestMapping(value="/pearupM")
	public String pearupM(ModelMap model,@RequestParam Map<String,String> params) {

		System.out.println("Controller.pearup params============="+params);
		Map<String, Object> pearinfo = pearService.postPear(params);
		model.addAttribute("info", pearinfo);
		return "main";	
	}		

	
	@RequestMapping(value="/searchPearM")
	public String seachPearM(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		FxUserVO userinfo = (FxUserVO)session.getAttribute("logininfo");
		if(userinfo != null){
			params.put("suid",userinfo.getId());
		}else {
			params.put("suid","");		
		}
		
		Map<String, Object> info = pearService.searchPear(params);
		model.addAttribute("info", info);
	
		return "resultsM";
	}	

	@RequestMapping(value="/searchPearByPositionM")
	public String searchPearByPositionM(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {
		FxUserVO userinfo = (FxUserVO)session.getAttribute("logininfo");
		if(userinfo != null){
			params.put("suid",userinfo.getId());
		}else {
			params.put("suid","");		
		}
		
		Map<String, Object> info = pearService.searchPearByPostion(params);
		model.addAttribute("info", info);
	
		return "resultsM";
	}	
	
	
	@RequestMapping(value="/discussionM")
	public String discussionM(ModelMap model,HttpServletRequest request, @RequestParam Map<String,String> params) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Map<String, Object> info = pearService.getPearInfo(params);
		model.addAttribute("info", info);
	
		return "discussionM";
	}		
	
	@RequestMapping(value="/summaryM")
	public String summaryM(ModelMap model, @RequestParam Map<String,String> params) {
		Map<String, Object> info = pearService.getPearInfo(params);
		model.addAttribute("info", info);
	
		return "summaryM";
	}	
	
	@RequestMapping(value="/detailM")
	public String detailM(ModelMap model, @RequestParam Map<String,String> params) {
		Map<String, Object> info = pearService.getPearInfo(params);
		model.addAttribute("info", info);
	
		return "detailM";
	}	
		
	
	@RequestMapping(value="/bidpearM")
	public String bidpearM(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {

		System.out.println("Controller bidpear params============="+params);
		bidService.bidPear(params);
		try {
			response.sendRedirect("./detail.fx?cuid="+params.get("buid")+"&whoc=B&pseq="+params.get("pseq"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//model.addAttribute("info", bidinfo);
		return "detailM";	
	}	
	
	@RequestMapping(value="/upDiscussM")
	public String upDiscussM(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {

		System.out.println("Controller.upDiscuss params============="+params);
		Map<String, Object> bidinfo = discussService.upDiscuss(params);
		try {
			response.sendRedirect("./detail.fx?cuid="+params.get("cuid")+"&whoc="+params.get("whoc")+"&pseq="+params.get("pseq"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	//	model.addAttribute("info", bidinfo);
		return "detailM";	
	}		

	@RequestMapping(value="/completePearM")
	public String completePearM(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {

		System.out.println("completePear params============="+params);
		Map<String, Object> pearinfo = pearService.completePear(params);
		try {
			response.sendRedirect("./detail.fx?cuid="+params.get("buid")+"&whoc=S&pseq="+params.get("pseq"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//model.addAttribute("info", bidinfo);
		return "detailM";	
	}		
	
	@RequestMapping(value="/changeStatusM")
	public String changeStatusM(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {

		System.out.println("changeStatus params============="+params);
		Map<String, Object> pearinfo = pearService.changeStatus(params);
		try {
			response.sendRedirect("./myPage.fx");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//model.addAttribute("info", bidinfo);
		return "detailM";	
	}		
	
	
	@RequestMapping(value="/myPageM")
	public String myPageM(ModelMap model,HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> params) {

		System.out.println("myPage params============="+params);
		FxUserVO userinfo = (FxUserVO)session.getAttribute("logininfo");
		if(userinfo != null){
			params.put("id",userinfo.getId());
			Map<String, Object> mypageinfo = pearService.getMyPear(params);
			model.addAttribute("info", mypageinfo);
			return "mypageM";	
		}else	{
			return "mainM";	
		}
	}		 

}