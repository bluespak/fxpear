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


import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;

import com.bluespak.common.CommonDAO;
import com.bluespak.common.CommonBO;

/**
 * @author bluespak(bluespak@gmail.com)
 */
public class PearVO implements CommonBO {
	@Autowired
	private CommonDAO basicDAO;
	  
	private int pseq;
	private String suid;
	private Timestamp spdt;
	private String sccd;
	private float samt;
	private Timestamp trdt;
	private String bccd;
	private String exlo;
	private int stat;
	private String buid;
	private float exlat;
	private float exlng;	
	
	private String fname;
	private String lname; 
	private String fbuid;
	
	private int cnt;
	
	private int snum;	// paging start no
	private int qnum;	// paging quantity no

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
		return "PearVO [basicDAO=" + basicDAO + ", pseq=" + pseq + ", suid="
				+ suid + ", spdt=" + spdt + ", sccd=" + sccd + ", samt=" + samt
				+ ", trdt=" + trdt + ", bccd=" + bccd + ", exlo=" + exlo
				+ ", stat=" + stat + ", buid=" + buid + ", exlat=" + exlat
				+ ", exlng=" + exlng + ", fname=" + fname + ", lname=" + lname
				+ ", fbuid=" + fbuid + ", cnt=" + cnt + ", snum=" + snum
				+ ", qnum=" + qnum + "]";
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


	public int getPseq() {
		return pseq;
	}


	public void setPseq(int pseq) {
		this.pseq = pseq;
	}


	public String getSuid() {
		return suid;
	}


	public void setSuid(String suid) {
		this.suid = suid;
	}


	public Timestamp getSpdt() {
		return spdt;
	}


	public void setSpdt(Timestamp spdt) {
		this.spdt = spdt;
	}


	public String getSccd() {
		return sccd;
	}


	public void setSccd(String sccd) {
		this.sccd = sccd;
	}


	public float getSamt() {
		return samt;
	}


	public void setSamt(float samt) {
		this.samt = samt;
	}


	public Timestamp getTrdt() {
		return trdt;
	}


	public void setTrdt(Timestamp trdt) {
		this.trdt = trdt;
	}


	public String getBccd() {
		return bccd;
	}


	public void setBccd(String bccd) {
		this.bccd = bccd;
	}


	public String getExlo() {
		return exlo;
	}


	public void setExlo(String exlo) {
		this.exlo = exlo;
	}


	public int getStat() {
		return stat;
	}


	public void setStat(int stat) {
		this.stat = stat;
	}
	
	public String getBuid() {
		return buid;
	}


	public void setBuid(String buid) {
		this.buid = buid;
	}

	public float getExlat() {
		return exlat;
	}


	public void setExlat(float exlat) {
		this.exlat = exlat;
	}
	
	public float getExlng() {
		return exlng;
	}


	public void setExlng(float exlng) {
		this.exlng = exlng;
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

	public int getCnt() {
		return cnt;
	}


	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	
	public int getSnum() {
		return snum;
	}


	public void setSnum(int snum) {
		this.snum = snum;
	}


	public int getQnum() {
		return qnum;
	}


	public void setQnum(int qnum) {
		this.qnum = qnum;
	}
	
	
}
