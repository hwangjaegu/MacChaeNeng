<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../form/top.jsp" %>


<title>MCN - 회원 상세정보</title>

<style type="text/css">
	body {
	    text-align: center; /* 수평 가운데 정렬 */
	    display: flex;
	    flex-direction: column;
	    justify-content: center; /* 수직 가운데 정렬 */
	    align-items: center;
	    margin: 0; /* body의 기본 마진 제거 */
	}
	
	.right {
		text-align: right;
	}
	
	.left {
		text-align: left;
	}
	
	/* div 확인용*/
	/* * {
		border: 1px solid #000;
	} */
	
	.row {
		margin-left: 0px;
	}
	
	aside {
		float: left;
		width: 15%;
		border-top: 2px solid gray;
		border-right: 2px solid gray;
	}
	
	section {
		flex: 1;
		width: 85%;
		min-height: 300px;
		border-top: 2px solid gray;
		float: right;
		justify-content: center;
		align-items: center;
	}
	
	#wrapper {
		width: 100%;
	}
	
	#bottom{
		clear: both;
	}
	
	#headerTag {
		width: 100%;
		margin-left: 0px;
		padding-left: 10px;
	}
	
	.custom-checkbox {
    	width: 20px;
	   	height: 20px;
	}
	
	.table {
		width: 97%;
		margin: 0px 0px 0px 20px;
	}
	
	tbody {
		cursor: pointer;
	}
	
	.algin-right {
		
	}
	
	.clear {
		clear: both;
	}
	
	#deleteMemBtn {
		margin-right: 20px;
	}
	
	#chkFrm {
		margin-top: 20px;
	}
	
	#searchByNameFrm {
		margin-left: 10px;
	}
	
	#registMemModal {
		text-align: left;
	}
	
	#name {
		width: 200px;
	}
	
	#birthYear, #joinYear {
		width: 80px;
	}
	
	#birthMonth, #birthDate, #joinMonth, #joinDay {
		width: 50px;
	}
	
	#day1 * {
		float: left;
		margin: 0px 5px 15px 0px;
		text-align: right;
	}
	
	#left {
		float: left;
	}
	
	#birthDay {
		width: 400px;
	}
</style>

<script type="text/javascript">
	$(function() {
		var wValue = ${person.weight};
		var tValue = "${person.type}".trim();
		var gValue = "${person.gender}";
		var contextPath = "<%= request.getContextPath() %>";
		
		//날짜 유효성 검정을 위한 변수 선언
		var currentDate = new Date();
		var currentYear = currentDate.getFullYear();
		var currentMonth = currentDate.getMonth()+1;
		var transCurrentMonth = currentMonth < 10? '0'+currentMonth : currentMonth;
		var currentDate = currentDate.getDate();
		var transCurrentDate = currentDate < 10? '0'+currentDate : currentDate;
		
		//초기 input 상태 세팅
		$('input[type=text]').prop('readonly', true);
		$('input[type=radio]').prop('disabled', true);
		$('.b').prop('hidden', true);
		
		$("input[name=weight]").each(function() {
			if($(this).val() == wValue){
				$(this).prop("checked", true);
			}
		});
		
		$("input[name=type]").each(function() {
			if($(this).val() == tValue){
				$(this).prop("checked", true);
			}
		});
		
		$("input[name=gender]").each(function() {
			if($(this).val() == gValue){
				$(this).prop("checked", true);
			}
		});
		
		//수정버튼 클릭 시 활성화되는 부분
		$('#editBtn').click(function() {
			$('.b').prop('hidden', false);
			$('.a').prop('hidden', true);
			$('input').prop('readonly', false).prop('disabled', false);
		});
		
		//회원목록버튼 클릭 시
		$('#listBtn').click(function() {
			location.href = contextPath + '/memberManag';
		});
		
		//취소버튼 클릭 시
		$('#cancelBtn').click(function() {
			if(confirm("작성 내용은 저장되지 않으며 회원목록으로 이동합니다. \n취소하시겠습니까?")){
				location.href = contextPath + '/memberManag';
			};
		});
		
		//스페이스바 입력 방지
		$('input').on('keydown', function(e) {
			if(e.key === ' ' && $(this).attr('id') !== 'comments'){
				e.preventDefault();
				alert('스페이스바 입력 금지');
			}
		});
		
		//날짜 숫자 이외 입력 금지 - 정규식 사용
		$('div#day1 input').on('keyup', function() {
			let str = $(this).val();
			let transStr = str.replace(/[^0-9]/g, '');
			
			if(str !== transStr){
				alert('문자열 입력 금지');
				$(this).val('');
				$(this).focus();
				event.preventDefault();
			}
		});
		
		//년도 4자리, 유효성 검사
		$('#birthYear').on('blur', function() {
			let year = $(this).val();
			
			if(!(year.length == 4 || year.length == 0)){
				alert('년도는 4자리 수를 입력해야 합니다.(ex. 2022)');
				$(this).val('');
				$(this).focus();
			}else{
				if(!((year <= currentYear && year >= 1900) || year == '')){
					alert('년도는 1900년부터 현재년도까지만 입력 가능합니다.');
					$(this).val('');
					$(this).focus();
				}
			} 
		});
		
		//월 2자리, 유효성 검사
		$('#birthMonth').on('blur', function() {
			let year = $('#birthYear').val();
			let month = parseInt($('#birthMonth').val());
			
			//2자리 검사
			if(!(month > 0 && month < 13)){
				if (!isNaN(month)) {
		            alert('해당 월은 존재하지 않습니다.');
		            $(this).val('');
		            $(this).focus();
		        }	
				
			}else{
				//유효성 검사
				if(year == currentYear){
					if(month > currentMonth){
						alert('현재보다 미래의 시간을 입력할 수 없습니다.');
						$(this).val('');
						$(this).focus();
					}else{
						month = month < 10? '0'+month : month;
						$(this).val(month);
					}
				}else{
					month = month < 10? '0'+month : month;
					$(this).val(month);
				}		
			}
		});
		
		//일 2자리, 유효성 검사
		 $('#birthDate').on('blur', function() {
			let year = $('#birthYear').val();
			let month = $('#birthMonth').val();
			let date = parseInt($('#birthDate').val());
			let yun = (year%4==0 && year%100 != 0) || (year%400 == 0);
						
			if(year == currentYear && month == transCurrentMonth){
				if(date > currentDate){
					alert('현재보다 미래의 시간을 입력할 수 없습니다.');
					$(this).val('');
					$(this).focus();
				}else{
					date = date < 10? '0'+date : date;
					$(this).val(date);
				}	
			}else{
				if(month=='01' || month=='03' || month=='05' || month=='07' || month=='08' || month=='10' || month=='12'){
					if(!(date>0 && date<32)){
						if(!isNaN(date)){
							alert('해당 월은 31일까지 존재합니다.');
							$(this).val('');
							$(this).focus();
						}
					}else{
						date = date < 10? '0'+date : date;
						$(this).val(date);
					}
				}else if(month=='02'){
					let fNum = 28;
					if(yun){
						fNum = 29;
					}
					if(!(date>0 && date<fNum+1)){
						if(!isNaN(date)){
							alert('해당 월은 ' + fNum + '일까지 존재합니다.');
							$(this).val('');
							$(this).focus();
						}
					}else{
						date = date < 10? '0'+date : date;
						$(this).val(date);
					}
				}else{
					if(!(date>0 && date<31)){
						if(!isNaN(date)){
							alert('해당 월은 30일까지 존재합니다.');
							$(this).val('');
							$(this).focus();
						}
					}else{
						date = date < 10? '0'+date : date;
						$(this).val(date);
					}
						
				}
			}
		});
		
		//년도 4자리, 유효성 검사
		$('#joinYear').on('blur', function() {
			let year = $(this).val();
				
			if(!(year.length == 4 || year.length == 0)){
				alert('년도는 4자리 수를 입력해야 합니다.(ex. 2022)');
				$(this).val('');
				$(this).focus();
			}else{
				if(!((year <= currentYear && year >= 1900) || year == '')){
					alert('년도는 1900년부터 현재년도까지만 입력 가능합니다.');
					$(this).val('');
					$(this).focus();
				}
			} 
		});
			
		//월 2자리, 유효성 검사
		$('#joinMonth').on('blur', function() {
			let year = $('#joinYear').val();
			let month = parseInt($('#joinMonth').val(), 10);
			
			//2자리 검사
			if(!(month > 0 && month < 13)){
				if (!isNaN(month)) {
		            alert('해당 월은 존재하지 않습니다.');
		            $(this).val('');
		            $(this).focus();
		        }	
				
			}else{
				//유효성 검사
				if(year == currentYear){
					if(month > currentMonth){
						alert('현재보다 미래의 시간을 입력할 수 없습니다.');
						$(this).val('');
						$(this).focus();
					}else{
						month = month < 10? '0'+month : month;
						$(this).val(month);
					}
				}else{
					month = month < 10? '0'+month : month;
					$(this).val(month);
				}		
			}
			
		});
			
		//일 2자리, 유효성 검사
		 $('#joinDay').on('blur', function() {
			 let year = $('#joinYear').val();
				let month = $('#joinMonth').val();
				let date = parseInt($('#joinDay').val());
				let yun = (year%4==0 && year%100 != 0) || (year%400 == 0);
							
				if(year == currentYear && month == transCurrentMonth){
					if(date > currentDate){
						alert('현재보다 미래의 시간을 입력할 수 없습니다.');
						$(this).val('');
						$(this).focus();
					}else{
						date = date < 10? '0'+date : date;
						$(this).val(date);
					}	
				}else{
					if(month=='01' || month=='03' || month=='05' || month=='07' || month=='08' || month=='10' || month=='12'){
						if(!(date>0 && date<32)){
							if(!isNaN(date)){
								alert('해당 월은 31일까지 존재합니다.');
								$(this).val('');
								$(this).focus();
							}
						}else{
							date = date < 10? '0'+date : date;
							$(this).val(date);
						}
					}else if(month=='02'){
						let fNum = 28;
						if(yun){
							fNum = 29;
						}
						if(!(date>0 && date<fNum+1)){
							if(!isNaN(date)){
								alert('해당 월은 ' + fNum + '일까지 존재합니다.');
								$(this).val('');
								$(this).focus();
							}
						}else{
							date = date < 10? '0'+date : date;
							$(this).val(date);
						}
					}else{
						if(!(date>0 && date<31)){
							if(!isNaN(date)){
								alert('해당 월은 30일까지 존재합니다.');
								$(this).val('');
								$(this).focus();
							}
						}else{
							date = date < 10? '0'+date : date;
							$(this).val(date);
						}
							
					}
				}
		});
		
		//저장하기버튼 클릭 시
		$('#saveBtn').click(function() {
			if($('#name').val() == null || $('#name').val() == ''){
				alert('이름을 입력하세요.');
				$('#name').focus();
				return;
			}
			
			if($('#birthYear').val() == '' || $('#birthMonth').val() == '' || $('#birthDate').val() == ''){
				if (!confirm('생일이 정상적으로 입력되지 않았습니다. 계속 진행할 경우 생년월일은 입력되지 않습니다. 진행하시겠습니까?')) {
					return;
				}		        	
			}
			
			if($('#joinYear').val() == '' || $('#joinMonth').val() == '' || $('#joinDate').val() == ''){
				if (!confirm('가입일이 정상적으로 입력되지 않았습니다. 계속 진행할 경우 가입일은 현재 날짜로 입력됩니다. 진행하시겠습니까?')) {
					return;
				}		        	
			}
			
			let gen = '';
			let wei = '';
			
			if($('input[name=gender]:checked').val() == 'M'){
				gen = '남';
			}else{
				gen = '여';
			}
			
			if($('input[name=weight]:checked').val() == 1){
				wei = '하';
			}else if($('input[name=weight]:checked').val() == 2){
				wei = '중';
			}else{
				wei = '상';
			}
			
			if(!confirm('입력한 정보가 정확한지 확인해주세요. \n\n이름 : ' + $('#name').val()
					+ '\n생년월일 : ' + $('#birthYear').val() + '년 ' + $('#birthMonth').val() + '월 ' + $('#birthDate').val() + '일'
					+ '\n성별 : '+ gen
					+ '\n급수 : ' + $('input[name=type]:checked').val()
					+ '\n가중치 : ' + wei
					+ '\n가입일 : ' + $('#joinYear').val() + '년 ' + $('#joinMonth').val() + '월 ' + $('#joinDay').val() + '일'
					+ '\n비고 : ' + $('#comments').val())){
				return
			}
			
			$('#updateMemFrm').submit();
		});
		
		//회원삭제 클릭시 
		$('#delBtn').click(function() {
			if(confirm('해당 회원정보를 삭제하시겠습니까? \n삭제 시 해당 정보는 복원되지 않습니다.')){
				$('#deleteMemFrm').submit();
			}
		});
	});
</script>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../form/header.jsp" %>
		<%@ include file="../form/aside.jsp" %>
		<section>
			<div class="row" id="headerTag">
				/회원관리/회원 상세정보			
			</div>
				
			<div class="row">
				<form action="<c:url value='/memberManag/deletePerson'/>" method="get" id="deleteMemFrm">
					<input type="hidden" id="userNum" name="userNum" value="${param.userNum }">
				</form>
				<form action="<c:url value='/memberManag/updatePerson'/>" method="post" id="updateMemFrm">
					<input type="hidden" id="userNum" name="userNum" value="${param.userNum }">
					<div class="mb-3 row">
						<div class="col-auto">
							<label for="name" class="col-form-label"><span>*</span>이름:</label>
						</div>
						<div class="col-auto">
							<input type="text" id="name" name="name" class="form-control" value="${person.name }">
						</div>
					</div>
					<div class="row" id="birthDay">
						<div class="col-auto" id=left>
							<label class="col-form-label"><span> </span>생년월일:</label>
						</div>
						<div class="col-auto" id="day1">
							<fmt:formatDate var="birth" value="${person.birth }" pattern="yyyy-MM-dd"/>
							<input type="text" id="birthYear" name="birthYear" class="form-control col" value="${fn:substring(birth, 0, 4) }"><span>년</span>
							<input type="text" id="birthMonth" name="birthMonth" class="form-control col" value="${fn:substring(birth, 5, 7) }"><span>월</span>
							<input type="text" id="birthDate" name="birthDate" class="form-control col" value="${fn:substring(birth, 8, 10) }"><span>일</span>
						</div>
					</div>
					<div class="mb-3 row clear">
						<div class="col-auto">
							<label class="col-form-label"><span>*</span>성별:</label> 
						</div>
						<div class="col-auto">
							<input type="radio" class="btn-check" name="gender" id="g1" autocomplete="off" value="M">
							<label class="btn btn-outline-secondary" for="g1">남</label> 
							<input type="radio" class="btn-check" name="gender" id="g2" autocomplete="off" value="W">
							<label class="btn btn-outline-secondary" for="g2">여</label> 
						</div>
					</div>
					<div class="mb-3 row">
						<div class="col-auto">
							<label class="col-form-label"><span>*</span>급수:</label> 
						</div>
						<div class="col-auto">
							<input type="radio" class="btn-check" name="type" id="t1" autocomplete="off" value="A"> 
							<label class="btn btn-outline-secondary" for="t1">A</label> 
							<input type="radio" class="btn-check" name="type" id="t2" autocomplete="off" value="B"> 
							<label class="btn btn-outline-secondary" for="t2">B</label>
							<input type="radio" class="btn-check" name="type" id="t3" autocomplete="off" value="C"> 
							<label class="btn btn-outline-secondary" for="t3">C</label>
							<input type="radio" class="btn-check" name="type" id="t4" autocomplete="off" value="D"> 
							<label class="btn btn-outline-secondary" for="t4">D</label>
							<input type="radio" class="btn-check" name="type" id="t5" autocomplete="off" value="E"> 
							<label class="btn btn-outline-secondary" for="t5">E</label>
						</div>
					</div>
					<div class="mb-3 row">
						<div class="col-auto">
							<label class="col-form-label"><span>*</span>가중치:</label> 
						</div>
						<div class="col-auto">
							<input type="radio" class="btn-check" name="weight" id="w1" autocomplete="off" value="3"> 
							<label class="btn btn-outline-secondary" for="w1">상</label> 
							<input type="radio" class="btn-check" name="weight" id="w2" autocomplete="off" value="2"> 
							<label class="btn btn-outline-secondary" for="w2">중</label> 
							<input type="radio" class="btn-check" name="weight" id="w3" autocomplete="off" value="1"> 
							<label class="btn btn-outline-secondary" for="w3">하</label> 
						</div>
					</div>
					<div class="row" id="birthDay">
						<div class="col-auto" id=left>
							<label class="col-form-label"><span> </span>가입일:</label>
						</div>
						<div class="col-auto" id="day1">
							<fmt:formatDate var="joinDate" value="${person.joinDate }" pattern="yyyy-MM-dd"/>
							<input type="text" id="joinYear" name="joinYear" class="form-control col" value="${fn:substring(joinDate, 0, 4) }"><span>년</span>
							<input type="text" id="joinMonth" name="joinMonth" class="form-control col" value="${fn:substring(joinDate, 5 , 7) }"><span>월</span>
							<input type="text" id="joinDay" name="joinDay" class="form-control col" value="${fn:substring(joinDate, 8 , 10) }"><span>일</span>
						</div>
					</div>
					<div class="mb-3 row">
						<div class="col-auto">
							<label for="comments" class="col-form-label"><span>&nbsp;</span>비고:</label>
						</div>
						<div class="col-10">
							<input type="text" class="form-control" name="comments" id="comments" value="${person.comments }">
						</div>
					</div>
						
					<div class="mb-3 row">
						<p class="b"> * : 필수 입력란 입니다. 반드시 입력해주세요.</p>
					</div>
					<div class="mb-3">
						<button type="button" class="btn btn-primary a" id="editBtn">수정하기</button>
						<button type="button" class="btn btn-secondary a" id="listBtn">회원목록</button>
						<button type="button" class="btn btn-outline-danger a" id="delBtn">회원삭제</button>
						<button type="button" class="btn btn-success b" id="saveBtn">저장하기</button>
						<button type="button" class="btn btn-secondary b" id="cancelBtn">취소</button>
					</div>
				</form>
			</div>

			<div class="row">
			
			</div>	
		</section>
	
		<%@ include file="../form/bottom2.jsp" %>
	</div>
</body>

<%@ include file="../form/bottom.jsp" %>