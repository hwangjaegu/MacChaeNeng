package com.mcn.MacChaeNeng.person.model;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PersonDAO {
	int idDubCheck(String id);
	int insertAdminId(PersonVO vo);
	PersonVO selectUserNumPwdById(String id);
	String selectSaltByUserNum(int userNum);
}