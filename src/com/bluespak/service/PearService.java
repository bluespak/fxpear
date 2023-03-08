package com.bluespak.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.bluespak.common.CommonService;
import com.bluespak.dao.BidDAOImpl;
import com.bluespak.dao.DiscussDAOImpl;
import com.bluespak.dao.FxUserDAOImpl;
import com.bluespak.dao.PearDAOImpl;
import com.bluespak.dao.UserDAOImpl;
import com.bluespak.vo.FxUserVO;
import com.bluespak.vo.PearVO;
import com.bluespak.vo.UserVO;


public class PearService implements CommonService  {

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Autowired
	private FxUserDAOImpl fxuserDAO;

	@Autowired
	private PearDAOImpl pearDAO;
	
	@Autowired
	private BidDAOImpl bidDAO;	

	@Autowired
	private DiscussDAOImpl discussDAO;	
	
	public Map<String, String> getStrings() {
		// TODO Auto-generated method stub
		
		Map<String, String> info = new HashMap<String, String>();
		info.put("message", "Hello");
		return info;
	}
	
	public void setFxUserDAO(PearDAOImpl pearDAO) {
		this.pearDAO = pearDAO;
	}

	public Map<String, Object> postPear(Map<String,String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = pearDAO.postPear(session,params);
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

	public Map<String, Object> completePear(Map<String,String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = pearDAO.completePear(session,params);
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

	public Map<String, Object> changeStatus(Map<String,String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			result = pearDAO.changeStatus(session,params);
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
	
	
	public Map<String, Object > searchPear(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("PearService.searchPear param="+params);
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			info.put("result", (List) pearDAO.searchPear(session,params));	
			info.put("bidcheck", (List) bidDAO.checkBidPear(session,params));	
			System.out.println("PearService.searchPear End");

			return info;		
		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		} finally {
			session.close();
		}
		// TODO Auto-generated method stub
	}	 
	
	
	public Map<String, Object > searchPearByPostion(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("PearService.searchPear param="+params);
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			info.put("result", (List) pearDAO.searchPearByPosition(session,params));	
			info.put("bidcheck", (List) bidDAO.checkBidPear(session,params));	
			System.out.println("PearService.searchPear End");

			return info;		
		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		} finally {
			session.close();
		}
		// TODO Auto-generated method stub
	}	 
	
	
	
	public Map<String, Object> getPearInfo(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("PearService.getPearInfo param="+params);
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			PearVO peardetail = (PearVO) pearDAO.getPearInfo(session,params);
			info.put("detailinfo", peardetail);	
			info.put("discussresult", (List) discussDAO.getDiscussList(session,params));
			if(params.get("whoc").equals("S")){
				info.put("userdiscussresult", (List) discussDAO.getDiscussUserList(session,params));
			}
			System.out.println("PearService.getPearInfo End");
			params.put("id", params.get("cuid"));
			info.put("biderinfo", (FxUserVO) fxuserDAO.getFxUser(session,params));
			if(params.get("whoc").equals("B")){
				// Case of Buyer, Sellere's count query 
				params.put("id",peardetail.getSuid());
			}
			System.out.println("PearService.getPearInfo id="+params.get("id"));
			PearVO cmptCnt = (PearVO)pearDAO.getPearCompleteCntByUser(session,params);
			info.put("cmptCnt", cmptCnt);	
			
			// when compleate
			if(peardetail.getStat() == 0){
				params.put("id", peardetail.getBuid());
				info.put("buyerinfo", (FxUserVO) fxuserDAO.getFxUser(session,params));	
			}
			return info;		
		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		} finally {
			session.close();
		}
	}	 	
	
	public Map<String, Object > getMyPear(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("PearService.getMyPear param="+params);
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
			params.put("suid",params.get("id"));
			info.put("myselllist", (List) pearDAO.getMySellList(session,params));	
			params.put("buid",params.get("id"));
			info.put("mybidlist", (List) pearDAO.getMyBidList(session,params));	
			info.put("bidcheck", (List) bidDAO.checkBidPear(session,params));	
			System.out.println("PearService.getMyPear End");

			return info;		
		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		} finally {
			session.close();
		}
	}	 	
	
	@Override
	public Map<?, ?> getInfo() {
		return null;
	}		
}
