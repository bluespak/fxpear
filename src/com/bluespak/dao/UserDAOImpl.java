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
public class UserDAOImpl extends AbstractBaseDAO implements CommonDAO {
	
	public <T> List<T> getUserList(SqlSession session) throws Exception {
		List<T> defaultValue = null;
		return super.selectList(session, "selectUserList", defaultValue );
	}
	
	public <T> T getUser(SqlSession session, Map<String,String> params) throws Exception {

		List<T> defaultValue = null;
		return (T) super.selectOne(session, "selectUser", params , defaultValue);
	}	
	
	public Integer insertUser(SqlSession session, Map<String,String> params) throws Exception {

		Integer result =  super.insert(session, "insertUser", params );
		System.out.println("UserDAOImpl.inserUser result=" + result);
		
		return result;
	}	

	public Integer deleteUser(SqlSession session, Map<String,String> params) throws Exception {

		Integer result =  super.delete(session, "deleteUser", params );
		System.out.println("UserDAOImpl.deleteUser result=" + result);
		
		return result;
	}	
	
	public Integer updateUser(SqlSession session, Map<String,String> params) throws Exception {

		Integer result =  super.update(session, "updateUser", params );
		System.out.println("UserDAOImpl.updateUser result=" + result);
		
		return result;
	}	
	
	@Override
	protected String getSqlmapNamespace() {
		return "com.bluespak.UserDAOImpl";
	}

	@Override
	public String getMessage() {
		// TODO Auto-generated method stub
		return null;
	}

}
