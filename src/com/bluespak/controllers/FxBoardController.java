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

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Reader;
import java.io.Writer;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bluespak.common.CommonBO;
import com.bluespak.dao.UserDAOImpl;
import com.bluespak.service.FxBoardService;
import com.bluespak.service.FxbRplService;
import com.bluespak.service.UserService;
import com.bluespak.vo.FxbRplVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

/**
 * @author bluespak(bluespak@gmail.com)
 */
@Controller
public class FxBoardController {
	@Autowired
	private CommonBO basicBO;

	@Autowired
	private FxBoardService fxboardService;

	@Autowired
	private FxbRplService fxbrplService;

	
	@RequestMapping(value="/fxboardpost")
	public String fxboardpost(ModelMap model, @RequestParam Map<String,String> params) {
		Map<String, Object> info = fxboardService.goPost(params);
		model.addAttribute("info", info);
		System.out.println("fxboardpost in Controll info="+info);
		return "fxboardpost";
	}	

	@RequestMapping(value="/fxboardlist")
	public String fxboardlist(ModelMap model, @RequestParam Map<String,String> params) {
		Map<String, Object> info = fxboardService.getBoardList(params);
		model.addAttribute("info", info);
	
		return "fxboardlist";
	}		
	
	@RequestMapping(value="/fxboardView")
	public String fxboardView(ModelMap model, @RequestParam Map<String,String> params) {
		Map<String, Object> info = fxboardService.getBoardView(params);
		model.addAttribute("info", info);
	
		return "fxboardview";
	}	
	
	@RequestMapping(value="/fxboarddelete")
	public void fxboarddelete(HttpServletResponse response, ModelMap model, @RequestParam Map<String,String> params) {

		System.out.println("changeStatus params============="+params);
		Map<String, Object> info = fxboardService.updateStatus(params);
		try {
			response.sendRedirect("./fxboardlist.fx?fxcat="+params.get("fxcat"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//model.addAttribute("info", bidinfo);
	//	return "fxboardlist";	
	}	
	
	
	@RequestMapping(value="/insertBoard")
	public String insertBoard(ModelMap model, @RequestParam Map<String,String> params) {
		Map<String, Object> info = fxboardService.insertBoard(params);
		model.addAttribute("info", info);
	
		return "fxboardlist";
	}	

	@RequestMapping(value="/updateBoard")
	public String updateBoard(ModelMap model, @RequestParam Map<String,String> params) {
		Map<String, Object> info = fxboardService.updateBoard(params);
		model.addAttribute("info", info);
		
		return "fxboardview";
	}	
	
	@RequestMapping(value="/insertReply")
	@ResponseBody
	public void insertReply(HttpServletResponse response, @RequestParam Map<String,String> params) throws IOException {
		Map<String, Object> info = fxbrplService.insertReply(params);
		FxbRplVO replyinfo = (FxbRplVO)info.get("replyinfo");
		System.out.println(replyinfo.toString());
	//	model.addAttribute("info", info); 
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        StringBuffer sb = new StringBuffer();
        sb.append("{ \"rpseq\" : "+replyinfo.getRpseq()+",");
        sb.append(" \"fxseq\" : "+replyinfo.getFxseq() +",");
        sb.append(" \"ruid\" : \""+replyinfo.getRuid() +"\",");
        sb.append(" \"reply\" : \""+replyinfo.getReply() +"\",");
        sb.append(" \"fname\" : \""+replyinfo.getFname() +"\",");
        sb.append(" \"lname\" : \""+replyinfo.getLname() +"\",");
        sb.append(" \"fbuid\" : \""+replyinfo.getFbuid() +"\"}");
		System.out.println("json::"+sb.toString());       
        response.getWriter().write(sb.toString());
	}


}