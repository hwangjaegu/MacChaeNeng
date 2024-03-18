package com.mcn.MacChaeNeng.deposit.model;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DepositServiceImpl implements DepositService{
	private final DepositDAO depositDao;

	@Override
	public int updateDeposit(DepositVO vo) {
		return depositDao.updateDeposit(vo);
	}

	@Override
	public List<DepositVO> selectDeposit() {
		return depositDao.selectDeposit();
	}

}
