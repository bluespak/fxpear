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
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * @author bluespak(bluespak@gmail.com)
 */
public class TimeloggingInterceptor extends HandlerInterceptorAdapter {

	private static final String KEY_TIMESTAMP = "T" + SessionInterceptor.class.toString().hashCode();

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception	{

		if (BuildPhase.LOCAL.equals(BaseConstants.BUILD_PHASE)) {
			request.setAttribute(KEY_TIMESTAMP, System.currentTimeMillis());
		}

		return super.preHandle(request, response, handler);
		
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if (BuildPhase.LOCAL.equals(BaseConstants.BUILD_PHASE)) {
			long startTime = (Long)request.getAttribute(KEY_TIMESTAMP);
			long endTime = System.currentTimeMillis();
			long executionTime = endTime - startTime;
	
		//	LogUtils.i("View %s, execution time: %s ms ", modelAndView.getViewName(), executionTime);
		}
	}
}
