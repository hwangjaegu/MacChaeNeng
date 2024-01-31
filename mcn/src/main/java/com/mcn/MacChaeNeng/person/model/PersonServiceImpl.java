package com.mcn.MacChaeNeng.person.model;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.mcn.MacChaeNeng.common.SAH256;
import com.mcn.MacChaeNeng.salt.model.SaltDAO;
import com.mcn.MacChaeNeng.salt.model.SaltVo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PersonServiceImpl implements PersonService{
	private final PersonDAO personDao;
	private final SaltDAO saltDao;
	
	private static final Logger logger = LoggerFactory.getLogger(PersonService.class);
	
	//아이디 중복 확인
	@Override
	public int idDubCheck(String id) {
		int idCheck = personDao.idDubCheck(id);
		
		if(idCheck > 0) {
			return PersonService.ID_DUB;
		}else {
			return PersonService.ID_OK;
			
		}
	}
	
	//회원가입 처리
	@Override
	public int insertAdminId(String id, String pwd) {
		SAH256 sah256 = new SAH256();

		String salt = sah256.getSalt();

		String trasPwd = sah256.getEncrypt(pwd, salt);

		PersonVO vo = new PersonVO();
		vo.setId(id);
		vo.setPw(trasPwd);

		int cnt = personDao.insertAdminId(vo);
		
		vo = personDao.selectUserNumPwdById(id);
		
		SaltVo saltVo = new SaltVo();
		saltVo.setUserNum(vo.getUserNum());
		saltVo.setSalt(salt);
		
		cnt = saltDao.insertAdminSalt(saltVo);

		
		return cnt;
	}
	
	//로그인 처리
	@Override
	public int login(String id, String pwd) {
		int result = 0;
		
		PersonVO vo = personDao.selectUserNumPwdById(id);
		
		if(vo == null) {
			result = USERID_NONE;
		}else {
			
			String salt = saltDao.selectSaltByUserNum(vo.getUserNum());
			
			SAH256 sah256 = new SAH256();
			
			String trasPwd = sah256.getEncrypt(pwd, salt);
			
			if(vo.getPw().trim().equals(trasPwd.trim())) {
				result = LOGIN_OK;
			}else {
				result = PWD_DISAGREE;
			}
		}
		
		return result;
	}
	
	//회원정보 전체 조회
	@Override
	public List<PersonVO> selectPersonAll(String name) {
		
		return personDao.selectPersonAll(name);
	}

	//신규회원등록
	@Override
	public int insertMem(PersonVO vo) {
		
		return personDao.insertMem(vo);
	}
	
	
	
	
}
