package com.bluespak.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import com.bluespak.common.CommonService;
import com.bluespak.dao.FxBoardDAOImpl;
import com.bluespak.dao.FxbRplDAOImpl;
import com.bluespak.vo.FxBoardVO;
import com.bluespak.vo.FxUserVO;
import com.bluespak.vo.FxbRplVO;



public class FxbRplService implements CommonService  {

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Autowired
	private FxbRplDAOImpl fxrplDAO;
	 
	
	public Map<String, String> getStrings() {
		// TODO Auto-generated method stub
		
		Map<String, String> info = new HashMap<String, String>();
		info.put("message", "Hello");
		return info; 
	}
	
	public void setReplyBoardDAO(FxbRplDAOImpl fxrplDAO) {
		this.fxrplDAO = fxrplDAO;
	}
	
	public Map<String, Object> insertReply(Map<String,String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = fxrplDAO.insertReply(session,params);
			System.out.println("ReplyBoardService.insertReply result====="+result);
			if(result != null){
				info.put("replyinfo", (FxbRplVO) fxrplDAO.getReplyInfo(session,params));	
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

	
	public Map<String, Object> getReplyInfo(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("PearService.getPearInfo param="+params);
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			FxbRplVO replydetail = (FxbRplVO) fxrplDAO.getReplyInfo(session,params);
			info.put("detailinfo", replydetail);	
			return info;		
		} catch (Exception e) {
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
