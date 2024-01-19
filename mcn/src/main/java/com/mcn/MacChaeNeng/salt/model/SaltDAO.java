package com.mcn.MacChaeNeng.salt.model;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SaltDAO {
	int insertAdminSalt(SaltVo vo);
	String selectSaltByUserNum(int userNum);
}
