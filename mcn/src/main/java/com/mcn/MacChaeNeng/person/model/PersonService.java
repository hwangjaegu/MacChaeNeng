package com.mcn.MacChaeNeng.person.model;

import java.util.List;

public interface PersonService {
	//로그인 관련 상수
	int LOGIN_OK=1; //로그인 성공
	int PWD_DISAGREE=2; //비밀번호 불일치
	int USERID_NONE=3; //아이디 없음
	
	//회원가입 관련 상수
	int ID_DUB = 4;
	int ID_OK = 5;
	
	int idDubCheck(String id);
	int insertAdminId(String id, String pwd);
	int login(String id, String pwd);
	List<PersonVO> selectPersonAll(String name);
	int insertMem(PersonVO vo, String birhYear, String birthMonth, String birthDate,
				String joinYear, String joinMonth, String joinDay);
	PersonVO selectByUserNum(int userNum);
	int updatePersonInfo(PersonVO vo, String birhYear, String birthMonth, String birthDate,
			String joinYear, String joinMonth, String joinDay);
	int deletePerson(int userNum);
}
