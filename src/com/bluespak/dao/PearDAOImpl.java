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
public class PearDAOImpl extends AbstractBaseDAO implements CommonDAO {
	

	public Integer postPear(SqlSession session, Map<String,String> params) throws Exception {

		Integer result =  super.insert(session, "postPear", params );
		System.out.println("PearDAOImpl.postPear result=" + result);
		return result;
	}	
	
	public Integer completePear(SqlSession session, Map<String,String> params) throws Exception {

		Integer result =  super.update(session, "completePear", params );
		System.out.println("PearDAOImpl.completePear result=" + result);
		
		return result;
	}	
	
	public Integer changeStatus(SqlSession session, Map<String,String> params) throws Exception {

		Integer result =  super.update(session, "changeStatus", params );
		System.out.println("PearDAOImpl.changeStatus result=" + result);
		
		return result;
	}		
	

	public <T> List <T> searchPear(SqlSession session, Map<String,String> params) throws Exception {

		System.out.println("PearDAOImpl.searchPear START");
		List<T> defaultValue = null;
//		return (T) super.selectList(session, "searchPear", params , defaultValue);
		List result = super.selectList(session, "searchPear", params , defaultValue );
		System.out.println("PearDAOImpl.searchPear END result="+result);
		return result;
	}
	
	public <T> List <T> searchPearByPosition(SqlSession session, Map<String,String> params) throws Exception {

		System.out.println("PearDAOImpl.searchPearByPosition START");
		List<T> defaultValue = null;
//		return (T) super.selectList(session, "searchPear", params , defaultValue);
		List result = super.selectList(session, "searchPearByPosition", params , defaultValue );
		System.out.println("PearDAOImpl.searchPearByPosition END result="+result);
		return result;
	}	
	
		
	public <T> List <T> getMySellList(SqlSession session, Map<String,String> params) throws Exception {

		System.out.println("PearDAOImpl.getMySellList START");
		List<T> defaultValue = null;
//		return (T) super.selectList(session, "searchPear", params , defaultValue);
		List result = super.selectList(session, "getMySellList", params , defaultValue );
		System.out.println("PearDAOImpl.getMySellList END result="+result);
		return result;
	}	
	
	public <T> List <T> getMyBidList(SqlSession session, Map<String,String> params) throws Exception {

		System.out.println("PearDAOImpl.getMyBidist START");
		List<T> defaultValue = null;
//		return (T) super.selectList(session, "searchPear", params , defaultValue);
		List result = super.selectList(session, "getMyBidist", params , defaultValue );
		System.out.println("PearDAOImpl.getMyBidist END result="+result);
		return result;
	}	
		
	
	
	public <T> T getPearInfo(SqlSession session, Map<String,String> params) throws Exception {

		List<T> defaultValue = null;
		return (T) super.selectOne(session, "getPearInfo", params , defaultValue);
	}
	
	public <T> T getPearCompleteCntByUser(SqlSession session, Map<String,String> params) throws Exception {

		List<T> defaultValue = null;
		return (T) super.selectOne(session, "getPearCompleteCntByUser", params , defaultValue);
	}

	
	
	
	@Override
	protected String getSqlmapNamespace() {
		return "com.bluespak.PearDAOImpl";
	}

	@Override
	public String getMessage() {
		// TODO Auto-generated method stub
		return null;
	}

}
