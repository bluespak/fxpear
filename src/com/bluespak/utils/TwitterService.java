package com.bluespak.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluespak.dao.PearDAOImpl;
import com.bluespak.vo.PearVO;

import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;


@Service("twitterService")
public class TwitterService{
	
  private final Logger logger = Logger.getLogger(TwitterService.class.getName());
	
  @Autowired
  private SqlSessionFactory sqlSessionFactory;
  
  @Autowired
  private PearDAOImpl pearDAO; 
  
  public Map<String, Object> tweetPost(Map<String, String> params){ 

		SqlSession session = sqlSessionFactory.openSession();
		System.out.println("TwitterService.getPearInfo param="+params);
		Map<String, Object> info ;
	  
	     String message="Hello World";
	      try {
				info = new HashMap<String, Object>();
				PearVO peardetail = (PearVO) pearDAO.getPearInfo(session,params);
				info.put("detailinfo", peardetail);	

	          Twitter twitter = new TwitterFactory().getInstance();
	          try {
	              RequestToken requestToken = twitter.getOAuthRequestToken();
	              
	              AccessToken accessToken = null;
	              while (null == accessToken) {
	                  logger.fine("Open the following URL and grant access to your account:");
	                  logger.fine(requestToken.getAuthorizationURL());
	                  try {
	                          accessToken = twitter.getOAuthAccessToken(requestToken);
	                  } catch (TwitterException te) {
	                      if (401 == te.getStatusCode()) {
	                          logger.severe("Unable to get the access token.");
	                      } else {
	                          te.printStackTrace();
	                      }
	                  }
	              }
	              logger.info("Got access token.");
	              logger.info("Access token: " + accessToken.getToken());
	              logger.info("Access token secret: " + accessToken.getTokenSecret());
	          } catch (IllegalStateException ie) {
	              // access token is already available, or consumer key/secret is not set.
	              if (!twitter.getAuthorization().isEnabled()) {
	                  logger.severe("OAuth consumer key/secret is not set.");
	                  return null;
	              }
	          }
	          message = message + "["+params.get("pseq")+"]";
	          Status status = twitter.updateStatus(message);
	          logger.info("Successfully updated the status to [" + status.getText() + "].");
	          return info;		
	      } catch (TwitterException te) {
				System.out.println(te.toString());
				logger.severe("Failed to get timeline: " + te.getMessage());
				return null;
				
	      } catch (Exception e) {
				System.out.println(e.toString());
				return null;		
		  } finally {
				session.close();
	      } 
  }

  
  
  /*
  
  public void publish(){
      String message="Hello World";
      try {
  	//	'consumer_key' => 'FP5J3QHcCSEC4E2isrLVsA',
  	//			'consumer_secret' => 'Ri6l5EOJABJgzzUokLC0whh6DxnmrRpRsl63iOnGmQo',
  	//			'user_token' => '82809257-ypXAlGbFmbn6FYu0fndH2eT0PswI9wbCHckwEUdbQ',
  	//			'user_secret' => 'DL2OWRkcGiXyaD7JV9zlqkn20Hl8QKWIxwwNtWtJfg',

          Twitter twitter = new TwitterFactory().getInstance();
          try {
              RequestToken requestToken = twitter.getOAuthRequestToken();
              
              AccessToken accessToken = null;
              while (null == accessToken) {
                  logger.fine("Open the following URL and grant access to your account:");
                  logger.fine(requestToken.getAuthorizationURL());
                  try {
                          accessToken = twitter.getOAuthAccessToken(requestToken);
                  } catch (TwitterException te) {
                      if (401 == te.getStatusCode()) {
                          logger.severe("Unable to get the access token.");
                      } else {
                          te.printStackTrace();
                      }
                  }
              }
              logger.info("Got access token.");
              logger.info("Access token: " + accessToken.getToken());
              logger.info("Access token secret: " + accessToken.getTokenSecret());
          } catch (IllegalStateException ie) {
              // access token is already available, or consumer key/secret is not set.
              if (!twitter.getAuthorization().isEnabled()) {
                  logger.severe("OAuth consumer key/secret is not set.");
                  return;
              }
          }
          Status status = twitter.updateStatus(message);
          logger.info("Successfully updated the status to [" + status.getText() + "].");
      } catch (TwitterException te) {
          te.printStackTrace();
          logger.severe("Failed to get timeline: " + te.getMessage());
      } 
   }
  */
}
  