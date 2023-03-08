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
package com.bluespak.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bluespak.BaseConstants;
import com.bluespak.BuildPhase;
import com.bluespak.utils.LogUtils;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * @author bluespak(bluespak@gmail.com)
 */
public class SessionInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		System.out.println("This is Session Interceptor Area!!!!!");
//		String stGetConfig = weekUtil.checkNull( request.getParameter("configLogin"));
		String stGetConfig = "N";
		
//		Object oSession  = request.getSession().getAttribute("USER_INFO");
		if( !stGetConfig.equals("Y")){
	//		if(oSession == null){
				return true;
	//			throw new ModelAndViewDefiningException(new ModelAndView("resigter"));
	//		}else {
	//			return true;
	//		}
		}else {
			return true;
		}	
		
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

	}
}
