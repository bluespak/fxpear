package com.bluespak.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.bluespak.common.CommonService;
import com.bluespak.dao.BidDAOImpl;
import com.bluespak.vo.BidVO;



public class Service implements CommonService  {

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Autowired
	private BidDAOImpl bidDAO;
	

	
	public Map<String, String> getStrings() {
		// TODO Auto-generated method stub
		
		Map<String, String> info = new HashMap<String, String>();
		info.put("message", "Hello");
		return info;
	}
	

	public Map<String, Object> bidPear(Map<String,String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = bidDAO.bidPear(session,params);
			if(result != null){
//				info.put("userlist", fxuserDAO.getUserList(session));	
			}	
			session.commit();
			return info;		
		} catch (Exception e) {
			session.rollback();
			System.out.println(e.toString());
			return null;
		} finally {
			session.close();
		}
		// TODO Auto-generated method stub

	}


	@Override
	public Map<?, ?> getInfo() {
		// TODO Auto-generated method stub
		return null;
	}		
}
