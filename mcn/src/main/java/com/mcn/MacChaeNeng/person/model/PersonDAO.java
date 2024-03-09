package com.mcn.MacChaeNeng.person.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PersonDAO {
	int idDubCheck(String id);
	int insertAdminId(PersonVO vo);
	PersonVO selectUserNumPwdById(String id);
	String selectSaltByUserNum(int userNum);
	List<PersonVO> selectPersonAll(String name);
	int insertMem(PersonVO vo);
	PersonVO selectByUserNum(int userNum);
	int updatePersonInfo(PersonVO vo);
	int deletePerson(int userNum);
}