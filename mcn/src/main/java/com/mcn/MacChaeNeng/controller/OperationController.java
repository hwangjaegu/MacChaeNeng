package com.mcn.MacChaeNeng.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mcn.MacChaeNeng.deposit.model.DepositService;
import com.mcn.MacChaeNeng.deposit.model.DepositVO;
import com.mcn.MacChaeNeng.person.model.PersonService;
import com.mcn.MacChaeNeng.person.model.PersonVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/operation")
public class OperationController {
	
	private final static Logger logger = LoggerFactory.getLogger(OperationController.class);
	
	private final PersonService personService;
	
	private final DepositService depositService;
	
	//회원목록 Ajax 조회
	@ResponseBody
	@RequestMapping("/AjaxGetMemList")
	public List<PersonVO> getPersonList(@RequestParam String searchName) {
		
		List<PersonVO> list = personService.selectPersonAll(searchName);
		
		return list;
	}
	
	@RequestMapping("/operManag")
	public void operManag(Model model) {
		//회비 기준 불러오기
		List<DepositVO> depositList = depositService.selectDeposit();
		
		model.addAttribute("depositList", depositList);
	}
	
}
