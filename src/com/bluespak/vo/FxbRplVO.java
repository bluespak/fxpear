/*
 * Copyright 2012-Present bluespak. All rights reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.bluespak.vo;


import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;

import com.bluespak.common.CommonDAO;
import com.bluespak.common.CommonBO;

/**
 * @author bluespak(bluespak@gmail.com)
 */
public class FxbRplVO implements CommonBO {
	@Autowired
	private CommonDAO basicDAO;
	
	private int rpseq;
	private int fxseq;
	private String ruid;
	private Timestamp rpdt;
	private String reply;

	private String fname;
	private String lname; 
	private String fbuid;
	
	@Override
	public String getMessage() {
		if (null == basicDAO.getMessage()) {
			return "DATABASE ERROR";
		} else {
			return "DAO Result: " + basicDAO.getMessage();
		}
	}
	
	

	@Override
	public String toString() {
		return "FxbRplVO [basicDAO=" + basicDAO + ", rpseq=" + rpseq
				+ ", fxseq=" + fxseq + ", ruid=" + ruid + ", rpdt=" + rpdt
				+ ", reply=" + reply + ", fname=" + fname + ", lname=" + lname
				+ ", fbuid=" + fbuid + "]";
	}



	/**
	 * @return the basicDAO
	 */
	public CommonDAO getBasicDAO() {
		return basicDAO;
	}

	/**
	 * @param basicDAO the basicDAO to set
	 */
	public void setBasicDAO(CommonDAO basicDAO) {
		this.basicDAO = basicDAO;
	}


	public int getRpseq() {
		return rpseq;
	}


	public void setRpseq(int rpseq) {
		this.rpseq = rpseq;
	}


	public int getFxseq() {
		return fxseq;
	}


	public void setFxseq(int fxseq) {
		this.fxseq = fxseq;
	}


	public String getRuid() {
		return ruid;
	}


	public void setRuid(String ruid) {
		this.ruid = ruid;
	}


	public Timestamp getRpdt() {
		return rpdt;
	}


	public void setRpdt(Timestamp rpdt) {
		this.rpdt = rpdt;
	}


	public String getReply() {
		return reply;
	}


	public void setReply(String reply) {
		this.reply = reply;
	}


	public String getFname() {
		return fname;
	}


	public void setFname(String fname) {
		this.fname = fname;
	}


	public String getLname() {
		return lname;
	}


	public void setLname(String lname) {
		this.lname = lname;
	}


	public String getFbuid() {
		return fbuid;
	}


	public void setFbuid(String fbuid) {
		this.fbuid = fbuid;
	}
 
}
