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
import com.bluespak.service.UserService;

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
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

/**
 * @author bluespak(bluespak@gmail.com)
 */
@Controller
public class HelloController {
	@Autowired
	private CommonBO basicBO;

	@Autowired
	private UserDAOImpl userDAO;

	
	@RequestMapping("/")
	public String index(ModelMap model) {
		return "default";
	}

	@RequestMapping(value="/hello", method = RequestMethod.GET)
	public String hello(ModelMap model) {
		
		UserService userService = new UserService();
		model.addAttribute("message", "Hello World! BasicBO returned message: " + basicBO.getMessage());

		return "hello";
	}


	
	@RequestMapping(value="/KTest", method = RequestMethod.GET)
	public String KTest(ModelMap model) {
		
		model.addAttribute("message", "Hello World! BasicBO returned message: " + basicBO.getMessage());

		return "KTest";
	}	
	
	public String test(HttpServletRequest request
            , HttpServletResponse response
            , HttpSession session
            , WebRequest webRequest
 //           , NaviteWebRequest nwRequest
            , Locale locale
            , InputStream is
            , Reader reader
            , OutputStream os
            , Writer writer
            , @PathVariable("name") String name
            , @RequestParam("name") String name2    // 이 name 파라미터가 없으면 404 오류 발생
            , @RequestParam(value="name", required=false, defaultValue="뭉충닷컴") String name3 // name 파라미터를 안받을 경우 기본값 설정
            , @RequestParam String name4 // 메서드 파라미터의 이름과 요청파라미터가 같다면 ("name") 생략가능
            , String name5 // 메서드 파라미터의 이름과 요청파라미터가 같고 String, int등 단순한 타입의 경우 @RequestParam 생략가능
            , @RequestParam Map<String, String> params // 모든요청파라미터를 Map으로 담는다.
            , @CookieValue("cookieName") String cookieName // 값없으면 404 오류 발생
            , @CookieValue(value="cookieName", required=false, defaultValue="뭉충닷컴") String cookieName2
            , @RequestHeader("Host") String host   // 값없으면 404 오류 발생
            , @RequestHeader("Keep-Alive") long keepAlive  // 값없으면 404 오류 발생
            , ModelMap model
            , Model model2
            , Map map
 //           , @ModelAttribute UserModel userModel
 //           , @ModelAttribute("xxUser") UserModel userModel
 //           , @ModelAttribute UserModel userModel, BindingResult bindingResult
 //           , @ModelAttribute UserModel userModel, Errors errors
            , SessionStatus sessionStatus
            , @RequestBody String body
            , @Value("#{commonprop['os.name']}") String osName 
 //           , @Valid
           ) {
		return "";
	}

	
	
	public CommonBO getBasicBO() {
		return basicBO;
	}

	public void setBasicBO(CommonBO basicBO) {
		this.basicBO = basicBO;
	}

	public void setUserDAO(UserDAOImpl userDAO) {
		this.userDAO = userDAO;
	}	
}