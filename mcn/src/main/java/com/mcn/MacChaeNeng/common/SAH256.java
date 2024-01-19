package com.mcn.MacChaeNeng.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class SAH256 {
	//salt 구하기
	public String getSalt() {
		SecureRandom sr = new SecureRandom();
		byte[] salt = new byte[20];
		
		sr.nextBytes(salt);
		
		StringBuilder sb = new StringBuilder();
		
		for(byte b : salt) {
			sb.append(String.format("%02x", b));
		}
		
		return sb.toString();
	}
	
	//SHA-256 암호화
	public String getEncrypt(String pwd, String salt) {
		String result = "";
		
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			
			md.update((pwd+salt).getBytes());
			byte[] pwdSalt = md.digest();
			
			StringBuilder sb = new StringBuilder();
			for(byte b : pwdSalt) {
				sb.append(String.format("%02x", b));
			}
			
			result = sb.toString();
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
