package com.bluespak.service;

import java.net.InetAddress;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.bluespak.common.CommonService;
import com.bluespak.dao.FxUserDAOImpl;
import com.bluespak.utils.MailService;
import com.bluespak.vo.FxUserVO;


public class FxUserService implements CommonService  {

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Autowired
	private FxUserDAOImpl fxuserDAO;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private MailService mailService;
	
	public Map<String, String> getStrings() {
		// TODO Auto-generated method stub
		
		Map<String, String> info = new HashMap<String, String>();
		info.put("message", "Hello");
		return info;
	}
	
	public void setFxUserDAO(FxUserDAOImpl fxuserDAO) {
		this.fxuserDAO = fxuserDAO;
	}

	public Map<String, Object> insertUser(Map<String,String> params) {
		SqlSession session = sqlSessionFactory.openSession();
		Integer result;
		Map<String, Object> info ;
		try {
				
			info = new HashMap<String, Object>();
	//		String hashedpassword = BCrypt.checkpw(params.get("password"), );
			String hashedpassword = BCrypt.hashpw(params.get("password"), BCrypt.gensalt(12));
			params.put("password", hashedpassword);
			System.out.println("hashedpassword====="+hashedpassword);
			result = fxuserDAO.insertUser(session,params);
			System.out.println("FxUserService.insertUser result====="+result);
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


	 
	
	public Map<String, Object > loginFxUser(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("FxUserService.loginFxUser param="+params);
		Map<String, Object> info = new HashMap<String, Object>();

		try {
			
			FxUserVO userinfo =  (FxUserVO) fxuserDAO.getFxUser(session,params);	
			
			if(userinfo != null){
				boolean isMatched = BCrypt.checkpw(params.get("password"), userinfo.getPassword());

				if(isMatched){
					System.out.println("Password is matched");	
					info.put("userinfo",userinfo);
					
				}else 	{
					info.put("login","FAIL");	
					info.put("failerinfo",userinfo);
					System.out.println("Password is unmatched");			
					
				}
				
			}else	{
				info.put("login","FAIL");	
				System.out.println("There is no user to match with id ["+params.get("id")+"]");			
				
			}
			
			
	//		params.put("password",hashedPassword);			
			
				
//			info = new HashMap<String, Object>();
//			info.put("userinfo", (FxUserVO) fxuserDAO.loginFxUser(session,params));	

			return info;		
		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		} finally {
			session.close();
		}
		// TODO Auto-generated method stub
	}
	
	
	public Map<String, Object > requestPassword(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("FxUserService.checkPassword param="+params);
		Map<String, Object> info = new HashMap<String, Object>();

		try {
			
			//Generate auth key
			Random ran = new Random();
			String[] filter_word = {"!","@","#","$","%",":","\\^","\\'","`","&","\\*","-","=","\\?","~","<",">","/"};			
		    String authkey = "";
		    
		    for (int i = 0; i < 50; i++) {     
		       int num1 = (int) 48 + (int) (ran.nextDouble() * 74);
		       authkey = authkey+ (char) num1;

		    }
		    for(int i=0; i < filter_word.length ; i++){
		    	authkey = authkey.replaceAll(filter_word[i],"");
		    }
		    
		    params.put("auth",authkey);
		    fxuserDAO.setAuthKey(session,params);
		    session.commit();
			
			FxUserVO userinfo =  (FxUserVO) fxuserDAO.getFxUser(session,params);	
			
			if(userinfo != null){
				// Mail Send Start
				Map model = new HashMap();
				System.out.println("hostname:"+params.get("hostname"));
				model.put("hostname",params.get("hostname"));
				model.put("userinfo", userinfo);
				System.out.println("Mail Sending Start. in changePassword");
				String vmfilename = "changePW.vm";
				String fromAddress = "fxpear@gmail.com";
				String toAddress = userinfo.getId();
				String someSubject = "Change Your password in Fxpear";
				String someText = "Please click to next link";
				
				System.out.println("before mailService.sendHtmlMail in FxUserService.checkPassword");
				System.out.println("mailService="+mailService);
				mailService.sendHtmlMail(vmfilename, fromAddress, toAddress, someSubject, someText,model);	
				System.out.println("Mail Sending ok. in FxUserService.checkPassword");
			}
			return info;		
		} catch (Exception e) {
			System.out.println(e.toString());
			session.rollback();
			return null;
		} finally {
			session.close();
		}
		// TODO Auto-generated method stub
	}

	
	public Map<String, Object > changePassword(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("FxUserService.checkPassword param="+params);
		Map<String, Object> info = new HashMap<String, Object>();

		try {
			
			FxUserVO userinfo =  (FxUserVO) fxuserDAO.getFxUser(session,params);
			
			if(userinfo.getAuth().equals(params.get("auth"))){
			
				String hashedpassword = BCrypt.hashpw(params.get("password"), BCrypt.gensalt(12));
				params.put("password", hashedpassword);
				
			    fxuserDAO.updateNewPassword(session,params);
			    session.commit();
			}else	{
				
				info.put("userinfo", userinfo);
				info.put("login", "NEWPW");			
			}

			
		return info;		
		} catch (Exception e) {
			System.out.println(e.toString());
			session.rollback();
			return null;
		} finally {
			session.close();
		}
		// TODO Auto-generated method stub
	}
	
	
	public Map<String, Object > passwordAuth(Map<String, String> params) {
		SqlSession session = sqlSessionFactory.openSession();
System.out.println("FxUserService.passwordAuth param="+params);
		Map<String, Object> info = new HashMap<String, Object>();

		try {
			
			FxUserVO userinfo =  (FxUserVO) fxuserDAO.getFxUser(session,params);	
			
			System.out.println("param.id="+params.get("id"));
			System.out.println("param.auth="+params.get("auth"));
			System.out.println("uinfo.auth="+userinfo.getAuth());
			info.put("userinfo", userinfo);
			info.put("login", "NEWPW");
			return info;		
		} catch (Exception e) {
			System.out.println(e.toString());
			session.rollback();
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
