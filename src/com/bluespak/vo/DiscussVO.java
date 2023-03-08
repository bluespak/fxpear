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
public class DiscussVO implements CommonBO {
	@Autowired
	private CommonDAO basicDAO;
	
	private int dseq;	
	private int pseq;	
	private String whoc;
	private String cuid;
	private String comt;
	private Timestamp rgdt;

	private String b_fbuid;
	private String b_fname;
	private String b_lname;
	
	



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
		return "DiscussVO [basicDAO=" + basicDAO + ", dseq=" + dseq + ", pseq="
				+ pseq + ", whoc=" + whoc + ", cuid=" + cuid + ", comt=" + comt
				+ ", rgdt=" + rgdt + ", b_fbuid=" + b_fbuid + ", b_fname="
				+ b_fname + ", b_lname=" + b_lname + "]";
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


	public int getDseq() {
		return dseq;
	}


	public void setDseq(int dseq) {
		this.dseq = dseq;
	}


	public int getPseq() {
		return pseq;
	}


	public void setPseq(int pseq) {
		this.pseq = pseq;
	}


	public String getWhoc() {
		return whoc;
	}


	public void setWhoc(String whoc) {
		this.whoc = whoc;
	}


	public String getCuid() {
		return cuid;
	}


	public void setCuid(String cuid) {
		this.cuid = cuid;
	}

	public String getComt() {
		return comt;
	}


	public void setComt(String comt) {
		this.comt = comt;
	}


	public Timestamp getRgdt() {
		return rgdt;
	}


	public void setRgdt(Timestamp rgdt) {
		this.rgdt = rgdt;
	}

	
	public String getB_fbuid() {
		return b_fbuid;
	}


	public void setB_fbuid(String b_fbuid) {
		this.b_fbuid = b_fbuid;
	}


	public String getB_fname() {
		return b_fname;
	}


	public void setB_fname(String b_fname) {
		this.b_fname = b_fname;
	}


	public String getB_lname() {
		return b_lname;
	}


	public void setB_lname(String b_lname) {
		this.b_lname = b_lname;
	}
	
}
