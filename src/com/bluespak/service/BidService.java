package com.bluespak.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.bluespak.common.CommonService;
import com.bluespak.dao.BidDAOImpl;
import com.bluespak.dao.FxUserDAOImpl;
import com.bluespak.dao.PearDAOImpl;
import com.bluespak.utils.MailService;
import com.bluespak.vo.FxUserVO;
import com.bluespak.vo.PearVO;



public class BidService implements CommonService  {

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Autowired
	private BidDAOImpl bidDAO;
	
	@Autowired
	private PearDAOImpl pearDAO;
	
	@Autowired
	private FxUserDAOImpl fxuserDAO;	
	
	@Autowired
	private MailService mailService;
	
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
				
			System.out.println("Start in bidPearService");
			info = new HashMap<String, Object>();
			result = bidDAO.bidPear(session,params);
			if(result != null){
//				info.put("userlist", fxuserDAO.getUserList(session));	
			}	
			PearVO peardetail = (PearVO) pearDAO.getPearInfo(session,params);
//			info.put("detailinfo", peardetail);	
			params.put("id", peardetail.getSuid());
			FxUserVO seller= (FxUserVO) fxuserDAO.getFxUser(session,params);	

			params.put("id", params.get("buid"));
			FxUserVO biduser= (FxUserVO) fxuserDAO.getFxUser(session,params);	

			session.commit();
			System.out.println("commit complete");

			
			// Mail Send Start
			System.out.println("Mail Sending Start. in bidPearService");
//			String fromAddress = "fxpear@gmail.com";
			String fromAddress = biduser.getEmail();
			String toAddress = seller.getEmail();
			String someSubject = "Someone bided your post in FXPear.";
			String someText = "Hello I'm Currency Pear. <BR> "+biduser.getFname()+" "+biduser.getLname()+" bided your post in FXID:"+params.get("pseq");
			
			mailService.sendMail(fromAddress, toAddress, someSubject, someText);	
			System.out.println("Mail Sending ok. in bidPearService");
			
			
						
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
