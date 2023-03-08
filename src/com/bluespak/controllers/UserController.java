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

import java.util.List;
import java.util.Map;

import com.bluespak.dao.UserDAOImpl;
import com.bluespak.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author bluespak(bluespak@gmail.com)
 */
@Controller
public class UserController {
//	@Autowired
//	private CommonBO commonBO;

	@Autowired
	private UserDAOImpl userDAO;

	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/userlist")
	public String userlist(ModelMap model) {
		Map<String, Object> userinfo = userService.getInfo();
		model.addAttribute("info", userinfo);
//		model.addAttribute("userlist", userDAO.getUserList());
//		model.addAttribute("userlist", "UserDAO");

		return "userlist";
	}	
	
	
	@RequestMapping(value="/userInsert")
	public String userInsert(ModelMap model,@RequestParam Map<String,String> params) {
		
		System.out.println("params============="+params);
		Map<String, Object> userinfo = userService.insertUser(params);
		model.addAttribute("info", userinfo);
		return "userlist";
	}		
	
	@RequestMapping(value="/userDelete")
	public String userDelete(ModelMap model,@RequestParam Map<String,String> params) {
		
		System.out.println("params============="+params);
		Map<String, Object> userinfo = userService.deleteUser(params);
		model.addAttribute("info", userinfo);

		return "userlist";
	}	
	
	@RequestMapping(value="/userUpdate")
	public String userUpdate(ModelMap model,@RequestParam Map<String,String> params) {
		
		System.out.println("params============="+params);
		Map<String, Object> userinfo = userService.updateUser(params);
		model.addAttribute("info", userinfo);
		return "userlist";
	}	
	
	@RequestMapping(value="/userSelect")
	public String userSelect(ModelMap model,@RequestParam Map<String,String> params) {
		
		System.out.println("params============="+params);
		Map<String, Object> userinfo = userService.selectUser(params);
		model.addAttribute("info", userinfo);
		return "userlist";
	}		
	
		
	
/*	
	public CommonBO getBasicBO() {
		return commonBO;
	}

	public void setCommonBO(CommonBO commonBO) {
		this.commonBO = commonBO;
	}
*/
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

/*	
	public void setUserDAO(UserDAOImpl userDAO) {
		this.userDAO = userDAO;
	}	
*/	
}