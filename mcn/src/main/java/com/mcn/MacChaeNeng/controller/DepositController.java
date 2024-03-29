package com.mcn.MacChaeNeng.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mcn.MacChaeNeng.common.DepositListForm;
import com.mcn.MacChaeNeng.deposit.model.DepositService;
import com.mcn.MacChaeNeng.deposit.model.DepositVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class DepositController {
	private final DepositService depositService;
	
	private final Logger logger = LoggerFactory.getLogger(DepositController.class);
	
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
			model.addAttribute("list", list);
			return "deposit";
		}
	}
	
	//회비 수정하기
	@RequestMapping("/deposit/depositEdit")
	@Transactional
	public String depositEdit(@ModelAttribute("depositList") DepositListForm depositListForm, Model model) {
	    List<DepositVO> depositList = depositListForm.getDepositList();
	    String msg = "회비 수정 중 오류가 발생했습니다. 다시 시도해주시기 바랍니다.", url = "/deposit";
	    
	    int count = 0;
	    
	    for(DepositVO item : depositList) {
	        int cnt = depositService.updateDeposit(item);
	        count += cnt;
	    }
	    
	    if(count == depositList.size()) {
	        msg = "회비가 수정되었습니다.";
	    }
	        
	    model.addAttribute("msg", msg);
	    model.addAttribute("url", url);
	    
	    return "common/message";
	}
}
