package com.bluespak.utils.cd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import com.bluespak.common.CommonCD;
import com.bluespak.utils.LogUtils;

public class CurrencyCode implements CommonCD{

	private static final HashMap<String, String> codeMap = new HashMap<String, String>();;
	
	public void build() throws Exception {
		setCode();
		LogUtils.i("Properties Manager loaded %s property entries");
	}
	
	@Override
	public void setCode() {
		codeMap.put("AED", "United Arab Emirates dirham");
		codeMap.put("AFN", "Afghan afghani");
		codeMap.put("ALL", "Albanian lek");
		codeMap.put("AMD", "Armenian dram");
		codeMap.put("AOA", "Angolan kwanza");
		codeMap.put("ARS", "Argentine peso");
		codeMap.put("AUD", "Australian dollar");
		codeMap.put("AWG", "Aruban florin");
		codeMap.put("AZN", "Azerbaijani manat");
		codeMap.put("BAM", "Bosnia and Herzegovina convertible mark");
		codeMap.put("BBD", "Barbadian dollar");
		codeMap.put("BDT", "Bangladeshi taka");
		codeMap.put("BGN", "Bulgarian lev");
		codeMap.put("BHD", "Bahraini dinar");
		codeMap.put("BIF", "Burundian franc");
		codeMap.put("BMD", "Bermudian dollar");
		codeMap.put("BND", "Brunei dollar");
		codeMap.put("BOB", "Bolivian boliviano");
		codeMap.put("BRL", "Brazilian real");
		codeMap.put("BSD", "Bahamian dollar");
		codeMap.put("BTN", "Bhutanese ngultrum");
		codeMap.put("BWP", "Botswana pula");
		codeMap.put("BYR", "Belarusian ruble");
		codeMap.put("BZD", "Belize dollar");
		codeMap.put("CAD", "Canadian dollar");
		codeMap.put("CDF", "Congolese franc");
		codeMap.put("CHF", "Swiss franc");
		codeMap.put("CLP", "Chilean peso");
		codeMap.put("CNY", "Chinese yuan");
		codeMap.put("COP", "Colombian peso");
		codeMap.put("CRC", "Costa Rican col�n");
		codeMap.put("CUP", "Cuban convertible peso");
		codeMap.put("CVE", "Cape Verdean escudo");
		codeMap.put("CZK", "Czech koruna");
		codeMap.put("DJF", "Djiboutian franc");
		codeMap.put("DKK", "Danish krone");
		codeMap.put("DOP", "Dominican peso");
		codeMap.put("DZD", "Algerian dinar");
		codeMap.put("EGP", "Egyptian pound");
		codeMap.put("ERN", "Eritrean nakfa");
		codeMap.put("ETB", "Ethiopian birr");
		codeMap.put("EUR", "Euro");
		codeMap.put("FJD", "Fijian dollar");
		codeMap.put("FKP", "Falkland Islands pound");
		codeMap.put("GBP", "British pound");
		codeMap.put("GEL", "Georgian lari");
		codeMap.put("GHS", "Ghana cedi");
		codeMap.put("GMD", "Gambian dalasi");
		codeMap.put("GNF", "Guinean franc");
		codeMap.put("GTQ", "Guatemalan quetzal");
		codeMap.put("GYD", "Guyanese dollar");
		codeMap.put("HKD", "Hong Kong dollar");
		codeMap.put("HNL", "Honduran lempira");
		codeMap.put("HRK", "Croatian kuna");
		codeMap.put("HTG", "Haitian gourde");
		codeMap.put("HUF", "Hungarian forint");
		codeMap.put("IDR", "Indonesian rupiah");
		codeMap.put("ILS", "Israeli new shekel");
		codeMap.put("IMP", "Manx pound");
		codeMap.put("INR", "Indian rupee");
		codeMap.put("IQD", "Iraqi dinar");
		codeMap.put("IRR", "Iranian rial");
		codeMap.put("ISK", "Icelandic kr�na");
		codeMap.put("JEP", "Jersey pound");
		codeMap.put("JMD", "Jamaican dollar");
		codeMap.put("JOD", "Jordanian dinar");
		codeMap.put("JPY", "Japanese yen");
		codeMap.put("KES", "Kenyan shilling");
		codeMap.put("KGS", "Kyrgyzstani som");
		codeMap.put("KHR", "Cambodian riel");
		codeMap.put("KMF", "Comorian franc");
		codeMap.put("KPW", "North Korean won");
		codeMap.put("KRW", "South Korean won");
		codeMap.put("KWD", "Kuwaiti dinar");
		codeMap.put("KYD", "Cayman Islands dollar");
		codeMap.put("KZT", "Kazakhstani tenge");
		codeMap.put("LAK", "Lao kip");
		codeMap.put("LBP", "Lebanese pound");
		codeMap.put("LKR", "Sri Lankan rupee");
		codeMap.put("LRD", "Liberian dollar");
		codeMap.put("LSL", "Lesotho loti");
		codeMap.put("LTL", "Lithuanian litas");
		codeMap.put("LVL", "Latvian lats");
		codeMap.put("LYD", "Libyan dinar");
		codeMap.put("MAD", "Moroccan dirham");
		codeMap.put("MDL", "Moldovan leu");
		codeMap.put("MGA", "Malagasy ariary");
		codeMap.put("MKD", "Macedonian denar");
		codeMap.put("MMK", "Burmese kyat");
		codeMap.put("MNT", "Mongolian t�gr�g");
		codeMap.put("MOP", "Macanese pataca");
		codeMap.put("MRO", "Mauritanian ouguiya");
		codeMap.put("MUR", "Mauritian rupee");
		codeMap.put("MVR", "Maldivian rufiyaa");
		codeMap.put("MWK", "Malawian kwacha");
		codeMap.put("MXN", "Mexican peso");
		codeMap.put("MYR", "Malaysian ringgit");
		codeMap.put("MZN", "Mozambican metical");
		codeMap.put("NAD", "Namibian dollar");
		codeMap.put("NGN", "Nigerian naira");
		codeMap.put("NIO", "Nicaraguan c�rdoba");
		codeMap.put("NOK", "Norwegian krone");
		codeMap.put("NPR", "Nepalese rupee");
		codeMap.put("NZD", "New Zealand dollar");
		codeMap.put("OMR", "Omani rial");
		codeMap.put("PAB", "Panamanian balboa");
		codeMap.put("PEN", "Peruvian nuevo sol");
		codeMap.put("PGK", "Papua New Guinean kina");
		codeMap.put("PHP", "Philippine peso");
		codeMap.put("PKR", "Pakistani rupee");
		codeMap.put("PLN", "Polish z?oty");
		codeMap.put("PRB", "Transnistrian ruble");
		codeMap.put("PYG", "Paraguayan guaran�");
		codeMap.put("QAR", "Qatari riyal");
		codeMap.put("RON", "Romanian leu");
		codeMap.put("RSD", "Serbian dinar");
		codeMap.put("RUB", "Russian ruble");
		codeMap.put("RWF", "Rwandan franc");
		codeMap.put("SAR", "Saudi riyal");
		codeMap.put("SBD", "Solomon Islands dollar");
		codeMap.put("SCR", "Seychellois rupee");
		codeMap.put("SDG", "Singapore dollar");
		codeMap.put("SEK", "Swedish krona");
		codeMap.put("SGD", "Singapore dollar");
		codeMap.put("SHP", "Saint Helena pound");
		codeMap.put("SLL", "Sierra Leonean leone");
		codeMap.put("SOS", "Somali shilling");
		codeMap.put("SRD", "Surinamese dollar");
		codeMap.put("SSP", "South Sudanese pound");
		codeMap.put("STD", "S�o Tom� and Pr�ncipe dobra");
		codeMap.put("SVC", "Salvadoran col�n");
		codeMap.put("SYP", "Syrian pound");
		codeMap.put("SZL", "Swazi lilangeni");
		codeMap.put("THB", "Thai baht");
		codeMap.put("TJS", "Tajikistani somoni");
		codeMap.put("TMT", "Turkmenistan manat");
		codeMap.put("TND", "Tunisian dinar");
		codeMap.put("TOP", "Tongan pa?anga");
		codeMap.put("TRY", "Turkish lira");
		codeMap.put("TTD", "Trinidad and Tobago dollar");
		codeMap.put("TWD", "New Taiwan dollar");
		codeMap.put("TZS", "Tanzanian shilling");
		codeMap.put("UAH", "Ukrainian hryvnia");
		codeMap.put("UGX", "Ugandan shilling");
		codeMap.put("USD", "United States dollar");
		codeMap.put("UYU", "Uruguayan peso");
		codeMap.put("UZS", "Uzbekistani som");
		codeMap.put("VEF", "Venezuelan bol�var");
		codeMap.put("VND", "Vietnamese ??ng");
		codeMap.put("VUV", "Vanuatu vatu");
		codeMap.put("WST", "Samoan t?l?");
		codeMap.put("XAF", "Central African CFA franc");
		codeMap.put("XCD", "East Caribbean dollar");
		codeMap.put("XOF", "West African CFA franc");
		codeMap.put("XPF", "CFP franc");
		codeMap.put("YER", "Yemeni rial");
		codeMap.put("ZAR", "South African rand");
		codeMap.put("ZMW", "Zambian kwacha");
		codeMap.put("ZWL", "Zimbabwean dollar");
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
