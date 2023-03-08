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
public class FxBoardVO implements CommonBO {
	@Autowired
	private CommonDAO basicDAO;
	
	private int fxseq;
	private String fxcat;
	private String uid;
	private Timestamp wrdt;
	private String title;
	private String story;
	private String bstat;


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
		return "FxBoardVO [basicDAO=" + basicDAO + ", fxseq=" + fxseq
				+ ", fxcat=" + fxcat + ", uid=" + uid + ", wrdt=" + wrdt
				+ ", title=" + title + ", story= long text type, bstat=" + bstat
				+ ", fname=" + fname + ", lname=" + lname + ", fbuid=" + fbuid
				+ "]";
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


	public int getFxseq() {
		return fxseq;
	}


	public void setFxseq(int fxseq) {
		this.fxseq = fxseq;
	}


	public String getFxcat() {
		return fxcat;
	}


	public void setFxcat(String fxcat) {
		this.fxcat = fxcat;
	}


	public String getUid() {
		return uid;
	}


	public void setUid(String uid) {
		this.uid = uid;
	}


	public Timestamp getWrdt() {
		return wrdt;
	}


	public void setWrdt(Timestamp wrdt) {
		this.wrdt = wrdt;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}

	public String getStory() {
		return story;
	}


	public void setBstat(String bstat) {
		this.bstat = bstat;
	}

	public String getBstat() {
		return bstat;
	}


	public void setStory(String story) {
		this.story = story;
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
