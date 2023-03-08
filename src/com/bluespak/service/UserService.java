package com.bluespak.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.bluespak.common.CommonService;
import com.bluespak.dao.UserDAOImpl;
import com.bluespak.vo.UserVO;


public class UserService implements CommonService  {

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Autowired
	private UserDAOImpl userDAO;
	
	public Map<String, Object> getInfo() {
		// TODO Auto-generated method stub
		SqlSession session = sqlSessionFactory.openSession();
		Map<String, Object> info;
		try {
			info = new HashMap<String, Object>();
		
			info.put("userlist", userDAO.getUserList(session));
			return info;
		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		} finally {
			session.close();
		}
	}
	
	public Map<String, String> getStrings() {
		// TODO Auto-generated method stub
		
		Map<String, String> info = new HashMap<String, String>();
		info.put("message", "Hello");
		return info;
	}
	
	public void setUserDAO(UserDAOImpl userDAO) {
		this.userDAO = userDAO;
	}

	public Map<String, Object> insertUser(Map<String,String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = userDAO.insertUser(session,params);
			if(result != null){
				info.put("userlist", userDAO.getUserList(session));	
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

	public Map<String, Object> deleteUser(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = userDAO.deleteUser(session,params);
			if(result != null){
				info.put("userlist", userDAO.getUserList(session));	
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
	 
	public Map<String, Object> updateUser(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = userDAO.updateUser(session,params);
			if(result != null){
				info.put("userlist", userDAO.getUserList(session));	
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
	
	public Map<String, Object > selectUser(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("UserService.selectUser param="+params);
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			info.put("selectone", (UserVO) userDAO.getUser(session,params));	
			info.put("userlist", userDAO.getUserList(session));	

	//		session.commit();
			return info;		
		} catch (Exception e) {
	//		session.rollback();
			System.out.println(e.toString());
			return null;
		} finally {
			session.close();
		}
		// TODO Auto-generated method stub
	}		
}
