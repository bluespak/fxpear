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
public class FxbCatVO implements CommonBO {
	@Autowired
	private CommonDAO basicDAO;
	
	private String catid;	
	private String catname;
	private String repyn;
	private String adminid;
	private String desc;

	
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
		return "FxbCatVO [basicDAO=" + basicDAO + ", catid=" + catid
				+ ", catname=" + catname + ", repyn=" + repyn + ", adminid="
				+ adminid + ", desc=" + desc + "]";
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



	public String getCatid() {
		return catid;
	}



	public void setCatid(String catid) {
		this.catid = catid;
	}



	public String getCatname() {
		return catname;
	}



	public void setCatname(String catname) {
		this.catname = catname;
	}



	public String getRepyn() {
		return repyn;
	}



	public void setRepyn(String repyn) {
		this.repyn = repyn;
	}



	public String getAdminid() {
		return adminid;
	}



	public void setAdminid(String adminid) {
		this.adminid = adminid;
	}



	public String getDesc() {
		return desc;
	}



	public void setDesc(String desc) {
		this.desc = desc;
	}

	
}
