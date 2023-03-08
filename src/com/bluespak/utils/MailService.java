package com.bluespak.utils;

import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.ui.velocity.VelocityEngineUtils;

@Service("mailService")
public class MailService{
  @Autowired
  private MailSender mailSender;
  
  private JavaMailSender javamailSender;
  
  private VelocityEngine velocityEngine;

  
  public MailSender getMailSender() {
	return mailSender;
	}
	
  public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}
	

  public JavaMailSender getJavamailSender() {
	return javamailSender;
  	}

  public void setJavamailSender(JavaMailSender javamailSender) {
	this.javamailSender = javamailSender;
  	}

  public VelocityEngine getVelocityEngine() {
		return velocityEngine;
	}

  public void setVelocityEngine(VelocityEngine velocityEngine) {
		this.velocityEngine = velocityEngine;
	}
	
	

public void sendMail(String from, String to, String subject, String text) {
    SimpleMailMessage message = new SimpleMailMessage();
    message.setFrom(from);
    message.setTo(to);
    message.setSubject(subject);
    message.setText(text);
    mailSender.send(message);
    System.out.println("Message sending ok..");
  }  
  
  public void sendHtmlMail(String vmfile,String from,String to, String subject,String text,Map model) {
	  System.out.println("in MailService.sendHtmlMail");
	  sendEMail(vmfile, from,to,subject,text,model);
  }
  
  public void sendEMail(final String vmfile,final String from,final String to, final String subject,final String text,final Map model) {
	  final String vmpath = "velocity/";
	  System.out.println("in MailService.sendEMail");
     MimeMessagePreparator preparator = new MimeMessagePreparator() {
    	  
    	@Override
  		public void prepare(MimeMessage mimeMessage) throws Exception {
    		System.out.println("sendHtmlMail.prepare start");
             MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
     		System.out.println("sendHtmlMail.prepare to="+to);
             message.setTo(to);
      		System.out.println("sendHtmlMail.prepare from="+from);
            message.setFrom(from); // could be parameterized...
      		System.out.println("sendHtmlMail.prepare subject="+subject);
            message.setSubject(subject); // could be parameterized...
       		System.out.println("sendHtmlMail.prepare velocityEngine="+velocityEngine);
      		 String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, vmpath + vmfile, model);
       		System.out.println("sendHtmlMail.prepare text="+text);
             message.setText(text, true);
          }

       };
       System.out.println("javamailSender="+javamailSender);
       System.out.println("preparator="+preparator);
       javamailSender.send(preparator);
  }
  
}
  