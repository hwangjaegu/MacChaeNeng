package com.mcn.MacChaeNeng.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateCheck {

	//날짜가 제대로 입력되었는지 확인
	public boolean isFull(String year, String month, String date) {
		return (!(year.isEmpty() || month.isEmpty() || date.isEmpty()));
	}
	
	//String을 Date로 변환
	public Date dateCheck(String year, String month, String date) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		
		String sumDate = year + "/" + month + "/" + date;
		
		try {
			return sdf.parse(sumDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
}
