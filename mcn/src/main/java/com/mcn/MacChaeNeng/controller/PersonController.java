package com.mcn.MacChaeNeng.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mcn.MacChaeNeng.person.model.PersonService;
import com.mcn.MacChaeNeng.person.model.PersonVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class PersonController {
	private static final Logger logger = LoggerFactory.getLogger(PersonController.class);
	
	private final PersonService personService;
	
	@GetMapping("/main")
	public String mcnLogin() {
		logger.info("로그인 화면 출력");
		
		return "main";
	}
	
	//일반 유저 고려한 회원가입
	@GetMapping("/signin")
	public void mcnSignIn() {
		logger.info("회원가입 화면 출력");
	}
	
	//아이디 중복 확인
	@ResponseBody
	@RequestMapping("/ajaxIdDubCheck")
	public Map<String, Object> ajaxIdDubCheck(@RequestParam String userId) {
		logger.info("아이디 중복 확인 파라미터 userId = {}", userId);
		
		int result = personService.idDubCheck(userId);
		
		String dub = "N";
		String str = "*이미 사용중인 아이디 입니다.";
		
		if(result == PersonService.ID_OK) {
			dub = "Y";
			str = "*사용 가능한 아이디 입니다.";
		}
		
		logger.info("아이디 중복 확인 결과, result = {}, dub = {}", result, dub);
		
		Map<String, Object> response = new HashMap<>();
		
		response.put("str", str);
		response.put("dub", dub);
		
		return response;
	}
	
	//일반 유저 회원가입 처리
	@PostMapping("/signin")
	public String mcnSignIn(@RequestParam String id, @RequestParam String pwd, HttpServletRequest request, Model model) {
		logger.info("회원가입 처리, 파라미터 id={}, pwd={}", id, pwd);
		
		String msg = "회원가입 중 오류가 발생하였습니다. <br>관리자에게 문의해주시기 바랍니다.", url = "/main";
		
		int cnt = personService.insertAdminId(id, pwd);
		
		if(cnt>0) {
			msg = "회원가입이 완료되었습니다.";
			url = "/main";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	//로그인 처리
	@PostMapping("/login")
	public String login(@RequestParam String id, @RequestParam String pwd, HttpServletRequest request, HttpServletResponse response, Model model) {
		logger.info("로그인처리, 파라미터 id = {}, pwd = {}", id, pwd);
		
		String msg = "로그인 중 오류가 발생하였습니다. 다시 시도해주시기 바랍니다.", url = "/main";
		
		int loginResult = personService.login(id, pwd);
		
		if(loginResult == PersonService.LOGIN_OK) {
			msg = "안녕하세요. 막체능 전산입니다.";
			url = "/home";
			
			//로그인 성공 시 세션 저장
			HttpSession session = request.getSession();
			session.setAttribute("id", id);
			
		}else if(loginResult == PersonService.PWD_DISAGREE || loginResult == PersonService.USERID_NONE) {
			msg = "아이디 또는 비밀번호가 존재하지 않거나 일치하지 않습니다.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	//로그인 시 홈으로 이동
	@GetMapping("/home")
	public void home() {
		logger.info("홈 화면 이동");
	}
	
	//회원관리 화면 이동
	@GetMapping("/memberManag")
	public void memberManag() {
		logger.info("회원 관리 화면 이동");
	}
	
	//회원 리스트 조회
	@ResponseBody
	@RequestMapping("/memberManag/AjaxGetMemList")
	public List<PersonVO> getPersonList(@RequestParam String searchName) {
		logger.info("회원 리스트 조회, 파라미터 searchName = {}", searchName);
		
		List<PersonVO> list = personService.selectPersonAll(searchName);
		
		return list;
	}
	
	@RequestMapping("/memberManag/registMem")
	public String registMem(@RequestParam PersonVO vo, Model model) {
		logger.info("회원등록, 파라미터 vo = {}", vo);
		
		int cnt = personService.insertMem(vo);
		
		String msg = "회원등록 중 문제가 발생했습니다. 다시 시도해주시기 바랍니다.", 
				url = "/memberManag";
		
		if(cnt>0) {
			msg = "회원등록이 완료되었습니다.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
}
