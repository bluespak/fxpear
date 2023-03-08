package com.bluespak.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.bluespak.common.CommonService;
import com.bluespak.dao.DiscussDAOImpl;
import com.bluespak.dao.PearDAOImpl;
import com.bluespak.vo.DiscussVO;
import com.bluespak.vo.PearVO;



public class DiscussService implements CommonService  {

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Autowired
	private DiscussDAOImpl discussDAO;
	
	@Autowired
	private PearDAOImpl pearDAO;
	
	public Map<String, String> getStrings() {
		// TODO Auto-generated method stub
		
		Map<String, String> info = new HashMap<String, String>();
		info.put("message", "Hello");
		return info;
	}
	

	public Map<String, Object> upDiscuss(Map<String,String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = discussDAO.upDiscuss(session,params);
			System.out.println(result);
			if(result != null){
//				info.put("userlist", fxuserDAO.getUserList(session));	
				info.put("detailinfo", (PearVO) pearDAO.getPearInfo(session,params));	
				info.put("discussresult", (List) discussDAO.getDiscussList(session,params));
				if(params.get("whoc").equals("S")){
					info.put("userdiscussresult", (List) discussDAO.getDiscussUserList(session,params));
				}
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
