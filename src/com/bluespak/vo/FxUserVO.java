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
public class FxUserVO implements CommonBO {
	@Autowired
	private CommonDAO basicDAO;
	
	private String id;
	private String password;
	private String fname;
	private String lname;
	private String nation;
	private String currency;
	private String city;
	private String email;
	private String address1;
	private String address2;	
	private String fbuid;
	private String auth;
	private Timestamp regdt;	
	
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
		return "FxUserVO [basicDAO=" + basicDAO + ", id=" + id + ", password="
				+ password + ", fname=" + fname + ", lname=" + lname
				+ ", nation=" + nation + ", currency=" + currency + ", city="
				+ city + ", email=" + email + ", address1=" + address1
				+ ", address2=" + address2 + ", fbuid=" + fbuid + ", auth="
				+ auth + ", regdt=" + regdt + "]";
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

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFname() {
		return this.fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}
	
	public String getLname() {
		return this.lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}	

	public String getNation() {
		return this.nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getCurrency() {
		return this.currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	public String getCity() {
		return this.city;
	}

	public void setCITY(String city) {
		this.city = city;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getAddress1() {
		return this.address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	
	public String getAddress2() {
		return this.address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}	
	
	public String getFbuid() {
		return this.fbuid;
	}
 
	public void setFbuid(String fbuid) {
		this.fbuid = fbuid;
	}	
	
	public String getAuth() {
		return this.auth;
	}
 
	public void setAuth(String auth) {
		this.auth = auth;
	}
	
	public Timestamp getRegdt() {
		return regdt;
	}


	public void setRegdt(Timestamp regdt) {
		this.regdt = regdt;
	}

}
