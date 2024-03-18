package com.mcn.MacChaeNeng.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mcn.MacChaeNeng.deposit.model.DepositService;
import com.mcn.MacChaeNeng.deposit.model.DepositVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class DepositController {
	private final DepositService depositService;
	
	//회비 기준 불러오기
	@RequestMapping("/deposit")
	public String getDepositList(Model model) {
		List<DepositVO> list = depositService.selectDeposit();
		
		if(list.isEmpty()) {
			String msg = "회비를 불러오는데 문제가 발생하였습니다. \n다시 시도해주시기 바랍니다.", url = "main";
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			
			return "common/message";
		}else {
			return "deposit";
		}
	}
	
	//회비 수정하기
	public void name() {
		
	}
}
