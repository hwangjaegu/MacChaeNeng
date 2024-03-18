package com.mcn.MacChaeNeng.deposit.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DepositDAO {
	//회비 수정
	int updateDeposit(DepositVO vo);
	//회비 목록 불러오기
	List<DepositVO> selectDeposit();
}
