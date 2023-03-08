package com.bluespak.utils.cd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import com.bluespak.common.CommonCD;
import com.bluespak.utils.LogUtils;

public class CurrencySymbol implements CommonCD{

	private static final HashMap<String, String> codeMap = new HashMap<String, String>();;
	
	public void build() throws Exception {
		setCode();
		LogUtils.i("Properties Manager loaded %s property entries");
	}
	
	@Override
	public void setCode() {

		codeMap.put("AED", "د.إ");
		codeMap.put("AFN'", "؋");
		codeMap.put("ALL", "L");
		codeMap.put("AMD", "դր");
		codeMap.put("AOA", "Kz");
		codeMap.put("ARS", "$");
		codeMap.put("AUD", "$");
		codeMap.put("AWG", "ƒ");
		codeMap.put("AZN", "");
		codeMap.put("BAM", "KM");
		codeMap.put("BBD", "$");
		codeMap.put("BDT", "৳");
		codeMap.put("BGN", "лв");
		codeMap.put("BHD", ".د.ب");
		codeMap.put("BIF", "Fr");
		codeMap.put("BMD", "$");
		codeMap.put("BND", "$");
		codeMap.put("BOB", "Bs");
		codeMap.put("BRL", "R$");
		codeMap.put("BSD", "$");
		codeMap.put("BTN", "Nu");
		codeMap.put("BWP", "P");
		codeMap.put("BYR", "Br");
		codeMap.put("BZD", "$");
		codeMap.put("CAD", "$");
		codeMap.put("CDF", "Fr");
		codeMap.put("CHF", "₣");
		codeMap.put("CLP", "$");
		codeMap.put("CNY", "¥");
		codeMap.put("COP", "$");
		codeMap.put("CRC", "₡");
		codeMap.put("CUP", "$");
		codeMap.put("CVE", "$");
		codeMap.put("CZK", "Kč");
		codeMap.put("DJF", "Fr");
		codeMap.put("DKK", "DK₩");
		codeMap.put("DOP", "$");
		codeMap.put("DZD", "د.ج");
		codeMap.put("EGP", "ج.م");
		codeMap.put("ERN", "Nfk");
		codeMap.put("ETB", "Br");
		codeMap.put("EUR", "€");
		codeMap.put("FJD", "$");
		codeMap.put("FKP", "£");
		codeMap.put("GBP", "£");
		codeMap.put("GEL", "ლ");
		codeMap.put("GHS", "₵");
		codeMap.put("GMD", "D");
		codeMap.put("GNF", "Fr");
		codeMap.put("GTQ", "Q");
		codeMap.put("GYD", "$");
		codeMap.put("HKD", "$");
		codeMap.put("HNL", "L");
		codeMap.put("HRK", "kn");
		codeMap.put("HTG", "G");
		codeMap.put("HUF", "Ft");
		codeMap.put("IDR", "Rp");
		codeMap.put("ILS", "₪");
		codeMap.put("IMP", "£");
		codeMap.put("INR", "");
		codeMap.put("IQD", "ع.د");
		codeMap.put("IRR", "﷼");
		codeMap.put("ISK", "kr");
		codeMap.put("JEP", "£");
		codeMap.put("JMD", "$");
		codeMap.put("JOD", "د.ا");
		codeMap.put("JPY", "¥");
		codeMap.put("KES", "Sh");
		codeMap.put("KGS", "лв");
		codeMap.put("KHR", "៛");
		codeMap.put("KMF", "Fr");
		codeMap.put("KPW", "₩");
		codeMap.put("KRW", "₩");
		codeMap.put("KWD", "د.ك");
		codeMap.put("KYD", "$");
		codeMap.put("KZT", "₸");
		codeMap.put("LAK", "₭");
		codeMap.put("LBP", "ل.ل");
		codeMap.put("LKR", "Rs");
		codeMap.put("LRD", "$");
		codeMap.put("LSL", "L");
		codeMap.put("LTL", "Lt");
		codeMap.put("LVL", "Ls");
		codeMap.put("LYD", "ل.د");
		codeMap.put("MAD", "د.م.");
		codeMap.put("MDL", "L");
		codeMap.put("MGA", "Ar");
		codeMap.put("MKD", "ден");
		codeMap.put("MMK", "Ks");
		codeMap.put("MNT", "₮");
		codeMap.put("MOP", "P");
		codeMap.put("MRO", "UM");
		codeMap.put("MUR", "Rs");
		codeMap.put("MVR", ".ރ");
		codeMap.put("MWK", "MK");
		codeMap.put("MXN", "$");
		codeMap.put("MYR", "MR");
		codeMap.put("MZN", "MT");
		codeMap.put("NAD", "$");
		codeMap.put("NGN", "₦");
		codeMap.put("NIO", "C$");
		codeMap.put("NOK", "kr");
		codeMap.put("NPR", "Rs");
		codeMap.put("NZD", "$");
		codeMap.put("OMR", "ر.ع.");
		codeMap.put("PAB", "B/.");
		codeMap.put("PEN", "S/.");
		codeMap.put("PGK", "K");
		codeMap.put("PHP", "₱");
		codeMap.put("PKR", "Rs");
		codeMap.put("PLN", "zł");
		codeMap.put("PRB", "р.");
		codeMap.put("PYG", "₲");
		codeMap.put("QAR", "ر.ق");
		codeMap.put("RON", "L");
		codeMap.put("RSD", "дин");
		codeMap.put("RUB", "руб.");
		codeMap.put("RWF", "Fr");
		codeMap.put("SAR", "ر.س");
		codeMap.put("SBD", "$");
		codeMap.put("SCR", "Rs");
		codeMap.put("SDG", "$");
		codeMap.put("SEK", "kr");
		codeMap.put("SGD", "$");
		codeMap.put("SHP", "£");
		codeMap.put("SLL", "Le");
		codeMap.put("SOS", "Sh");
		codeMap.put("SRD", "$");
		codeMap.put("SSP", "£");
		codeMap.put("STD", "Db");
		codeMap.put("SVC", "₡");
		codeMap.put("SYP", "£");
		codeMap.put("SZL", "L");
		codeMap.put("THB", "฿");
		codeMap.put("TJS", "SM");
		codeMap.put("TMT", "m");
		codeMap.put("TND", "د.ت");
		codeMap.put("TOP", "T$");
		codeMap.put("TRY", "");
		codeMap.put("TTD", "$");
		codeMap.put("TWD", "$");
		codeMap.put("TZS", "Sh");
		codeMap.put("UAH", "₴");
		codeMap.put("UGX", "Sh");
		codeMap.put("USD", "$");
		codeMap.put("UYU", "$");
		codeMap.put("UZS", "лв");
		codeMap.put("VEF", "Bs F");
		codeMap.put("VND", "₫");
		codeMap.put("VUV", "Vt");
		codeMap.put("WST", "T");
		codeMap.put("XAF", "XAFr");
		codeMap.put("XCD", "XC$");
		codeMap.put("XOF", "XOFr");
		codeMap.put("XPF", "XPFr");
		codeMap.put("YER", "﷼");
		codeMap.put("ZAR", "ZAR");
		codeMap.put("ZMW", "ZK");
		codeMap.put("ZWL", "$");
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
