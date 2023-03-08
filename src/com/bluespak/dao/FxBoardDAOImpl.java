/*
 * Copyright 2013-Present Bluespak. All rights reserved.
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
package com.bluespak.dao;

import java.util.List;
import java.util.Map;

import com.bluespak.common.AbstractBaseDAO;
import com.bluespak.common.CommonDAO;

import org.apache.ibatis.session.SqlSession;

//import com.bluespak.bo.UserBOImpl;

/**
 * @author bluespak(bluespak@gmail.com)
 */
public class FxBoardDAOImpl extends AbstractBaseDAO implements CommonDAO {
	
	public Integer insertBoard(SqlSession session, Map<String,String> params) throws Exception {

		Integer result =  super.insert(session, "insertBoard", params );
		System.out.println("FxBoardDAOImpl.insertBoard result=" + result);
		
		return result;
	}	
	
	public Integer updateBoard(SqlSession session, Map<String,String> params) throws Exception {

		Integer result =  super.update(session, "updateBoard", params );
		System.out.println("FxBoardDAOImpl.updateBoard result=" + result);
		
		return result;
	}		
	
	
	public <T> List <T> getBoardList(SqlSession session, Map<String,String> params) throws Exception {

		System.out.println("FxBoardDAOImpl.getBoardList START");
		List<T> defaultValue = null;
//		return (T) super.selectList(session, "searchPear", params , defaultValue);
		List result = super.selectList(session, "getBoardList", params , defaultValue );
		System.out.println("FxBoardDAOImpl.getBoardList END result="+result);
		return result;
	}	
	
	public <T> T getBoardView(SqlSession session, Map<String,String> params) throws Exception {

		List<T> defaultValue = null;
		return (T) super.selectOne(session, "getBoardView", params , defaultValue);
	}
	
	public Integer changeStatus(SqlSession session, Map<String,String> params) throws Exception {

		Integer result =  super.update(session, "changeStatus", params );
		System.out.println("FxBoardDAOImpl.changeStatus result=" + result);
		
		return result;
	}		
			
	
	@Override
	protected String getSqlmapNamespace() {
		return "com.bluespak.FxBoardDAOImpl";
	}

	@Override
	public String getMessage() {
		// TODO Auto-generated method stub
		return null;
	}

}
