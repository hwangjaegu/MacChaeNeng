package com.mcn.MacChaeNeng.deposit.model;

import java.util.List;

public interface DepositService {
	//회비 수정
	int updateDeposit(DepositVO vo);
	//회비 목록 불러오기
	List<DepositVO> selectDeposit();
}
