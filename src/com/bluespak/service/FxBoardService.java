package com.bluespak.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import com.bluespak.common.CommonService;
import com.bluespak.dao.FxBoardDAOImpl;
import com.bluespak.dao.FxbCatDAOImpl;
import com.bluespak.vo.FxBoardVO;
import com.bluespak.vo.FxUserVO;
import com.bluespak.vo.FxbCatVO;
import com.bluespak.vo.PearVO;



public class FxBoardService implements CommonService  {

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Autowired
	private FxBoardDAOImpl fxboardDAO;
	
	@Autowired
	private FxbCatDAOImpl fxbcatDAO;

	
	public Map<String, String> getStrings() {
		// TODO Auto-generated method stub
		
		Map<String, String> info = new HashMap<String, String>();
		info.put("message", "Hello");
		return info;
	}
	
	public void setFxBoardDAO(FxBoardDAOImpl fxboardDAO) {
		this.fxboardDAO = fxboardDAO;
	}
	
	
	public Map<String, Object> goPost(Map<String,String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			info.put("catinfo", (FxbCatVO) fxbcatDAO.getCatInfo(session,params));
			return info;		
		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		} finally {
			session.close();
		}
		// TODO Auto-generated method stub

	}

	
	public Map<String, Object> insertBoard(Map<String,String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = fxboardDAO.insertBoard(session,params);
			System.out.println("FxBoardService.insertBoard result====="+result);
			if(result != null){
				info.put("boardlist", (List) fxboardDAO.getBoardList(session,params));	
				info.put("catinfo", (FxbCatVO) fxbcatDAO.getCatInfo(session,params));
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

	public Map<String, Object> updateBoard(Map<String,String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = fxboardDAO.updateBoard(session,params);
			FxBoardVO boarddetail = (FxBoardVO) fxboardDAO.getBoardView(session,params);
			info.put("detailinfo", boarddetail);	
			info.put("catinfo", (FxbCatVO) fxbcatDAO.getCatInfo(session,params));
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
	
	
	public Map<String, Object > getBoardList(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("FxBoardService.getBoardList param="+params);
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			info.put("boardlist", (List) fxboardDAO.getBoardList(session,params));	
			System.out.println("FxBoardService.getBoardList End");
			info.put("catinfo", (FxbCatVO) fxbcatDAO.getCatInfo(session,params));
			return info;		 
		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		} finally {
			session.close();
		}
		// TODO Auto-generated method stub
	}	 	
	
	public Map<String, Object> getBoardView(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("FxBoardService.getBoardView param="+params);
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			FxBoardVO boarddetail = (FxBoardVO) fxboardDAO.getBoardView(session,params);
			info.put("detailinfo", boarddetail);	
			info.put("catinfo", (FxbCatVO) fxbcatDAO.getCatInfo(session,params));
			return info;		
		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		} finally {
			session.close();
		}
		// TODO Auto-generated method stub
	}	 	
	
	public Map<String, Object> updateStatus(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = fxboardDAO.changeStatus(session,params);
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
	}	

	
	@Override
	public Map<?, ?> getInfo() {
		// TODO Auto-generated method stub
		return null;
	}		
}
