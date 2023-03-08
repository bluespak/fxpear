package com.bluespak.utils.cd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import com.bluespak.common.CommonCD;
import com.bluespak.utils.LogUtils;

public class CityCode implements CommonCD{

	private static final HashMap<String, String> codeMap = new HashMap<String, String>();;
	
	public void build() throws Exception {
		setCode();
		LogUtils.i("Properties Manager loaded %s property entries");
	}
	
	@Override
	public void setCode() {
		codeMap.put("AL", "Alabama");
		codeMap.put("AK", "Alaska");
		codeMap.put("AS", "American Samoa");
		codeMap.put("AZ", "Arizona");
		codeMap.put("AR", "Arkansas");
		codeMap.put("AF", "Armed Forces Africa");
		codeMap.put("AA", "Armed Forces Americas");
		codeMap.put("AC", "Armed Forces Canada");
		codeMap.put("AE", "Armed Forces Europe");
		codeMap.put("AM", "Armed Forces Middle East");
		codeMap.put("AP", "Armed Forces Pacific");
		codeMap.put("CA", "California");
		codeMap.put("CO", "Colorado");
		codeMap.put("CT", "Connecticut");
		codeMap.put("DE", "Delaware");
		codeMap.put("DC", "District of Columbia");
		codeMap.put("FM", "Federated States Of Micronesia");
		codeMap.put("FL", "Florida");
		codeMap.put("GA", "Georgia");
		codeMap.put("GU", "Guam");
		codeMap.put("HI", "Hawaii");
		codeMap.put("ID", "Idaho");
		codeMap.put("IL", "Illinois");
		codeMap.put("IN", "Indiana");
		codeMap.put("IA", "Iowa");
		codeMap.put("KS", "Kansas");
		codeMap.put("KY", "Kentucky");
		codeMap.put("LA", "Louisiana");
		codeMap.put("ME", "Maine");
		codeMap.put("MH", "Marshall Islands");
		codeMap.put("MD", "Maryland");
		codeMap.put("MA", "Massachusetts");
		codeMap.put("MI", "Michigan");
		codeMap.put("MN", "Minnesota");
		codeMap.put("MS", "Mississippi");
		codeMap.put("MO", "Missouri");
		codeMap.put("MT", "Montana");
		codeMap.put("NE", "Nebraska");
		codeMap.put("NV", "Nevada");
		codeMap.put("NH", "New Hampshire");
		codeMap.put("NJ", "New Jersey");
		codeMap.put("NM", "New Mexico");
		codeMap.put("NY", "New York");
		codeMap.put("NC", "North Carolina");
		codeMap.put("ND", "North Dakota");
		codeMap.put("MP", "Northern Mariana Islands");
		codeMap.put("OH", "Ohio");
		codeMap.put("OK", "Oklahoma");
		codeMap.put("OR", "Oregon");
		codeMap.put("PW", "Palau");
		codeMap.put("PA", "Pennsylvania");
		codeMap.put("PR", "Puerto Rico");
		codeMap.put("RI", "Rhode Island");
		codeMap.put("SC", "South Carolina");
		codeMap.put("SD", "South Dakota");
		codeMap.put("TN", "Tennessee");
		codeMap.put("TX", "Texas");
		codeMap.put("UT", "Utah");
		codeMap.put("VT", "Vermont");
		codeMap.put("VI", "Virgin Islands");
		codeMap.put("VA", "Virginia");
		codeMap.put("WA", "Washington");
		codeMap.put("WV", "West Virginia");
		codeMap.put("WI", "Wisconsin");
		codeMap.put("WY", "Wyoming");

	}	
	
	public static String getText(String cd) {
		// TODO Auto-generated method stub
		return codeMap.get(cd);
	}

	public String getCode() {
		// TODO Auto-generated method stub
		return null;
	}

	public static List<String> getKeyList() {
		// TODO Auto-generated method stub
//		HashMap<String, String> hs = (HashMap<String, String>)codeMap.clone() ;
		List<String> list = new ArrayList<String>();
		Iterator<String> i = codeMap.keySet().iterator();
    	while(i.hasNext()){
    		String key = i.next();
    		list.add(key);
    	}
		return list;
	}

}
