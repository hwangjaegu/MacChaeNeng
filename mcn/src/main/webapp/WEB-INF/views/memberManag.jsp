<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="form/top.jsp" %>

<title>MCN - 회원관리</title>

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
	
	.divPage {
		margin-top: 20px;
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
		//날짜 유효성 검정을 위한 변수 선언
		var currentDate = new Date();
		var currentYear = currentDate.getFullYear();
		var currentMonth = currentDate.getMonth()+1;
		var transCurrentMonth = currentMonth < 10? '0'+currentMonth : currentMonth;
		var currentDate = currentDate.getDate();
		var transCurrentDate = currentDate < 10? '0'+currentDate : currentDate;
		
		$.getPersonList();
		
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

		
		//회원등록 유효성 검사
		$('#registBtn').click(function() {
			if($('#name').val() == null || $('#name').val() == ''){
				alert('이름을 입력하세요.');
				$('#name').focus();
			}else if($('input[name=gender]:checked').val() == null){
				alert('성별을 선택하세요.');
			}else if($('input[name=type]:checked').val() == null){
				alert('급수를 선택하세요.');
			}else if($('input[name=weight]:checked').val() == null){
				alert('가중치를 선택하세요.');
			}else if($('#birthYear').val() == '' || $('#birthMonth').val() == '' || $('#birthDate').val() == ''){
				if (!confirm('생일이 정상적으로 입력되지 않았습니다. 계속 진행할 경우 생년월일은 입력되지 않습니다. 진행하시겠습니까?')) {
		            return; // 사용자가 확인을 누르지 않으면 함수 종료
		        }else if($('#joinYear').val() == '' || $('#joinMonth').val() == '' || $('#joinDay').val() == ''){
			        if (!confirm('가입일이 정상적으로 입력되지 않았습니다. 계속 진행할 경우 가입일은 현재 날짜로 입력됩니다. 진행하시겠습니까?')) {
			        	return;
			        }else{
			        	$('#registMemFrm').submit();
			        }		        	
		        }
		    }else if($('#joinYear').val() == '' || $('#joinMonth').val() == '' || $('#joinDay').val() == '') {
		        if (!confirm('가입일이 정상적으로 입력되지 않았습니다. 계속 진행할 경우 가입일은 현재 날짜로 입력됩니다. 진행하시겠습니까?')) {
		            return; // 사용자가 확인을 누르지 않으면 함수 종료
		        }else{
		        	$('#registMemFrm').submit();
		        }
			}else{
				$('#registMemFrm').submit();
			}
		});
		
		//체크박스 전체 선택
		$('#chkAll').on('change', function() {
			let isChecked = $(this).prop('checked');
			
			$('input[type=checkbox]').prop('checked', isChecked);
		});
		
		//회원정보 상세조회
		$('#personList').on('click', 'td:not(.userNum)', function() {
			location.href = 'memberManag/personDetail?userNum=' + $(this).parent().find('input').val();
		});
		
		//회원삭제 버튼 클릭 시
		$('#deleteMemBtn').click(function() {
			if($('td>input[type=checkbox]:checked').length<1){
				alert('삭제시킬 회원을 선택하세요.');
			}else{
				if(confirm('선택된 회원정보를 삭제하시겠습니까? \n삭제 시 해당 정보는 복원되지 않습니다.')){
					$('#chkFrm').submit();
				}
			}
		});
		
		//회원이름 검색
		$('#searchBtn').click(function() {
			$.getPersonList();
		});
		
		//엔터키 입력해서 회원이름 검색
		$('#searchName').keypress(function(event) {
		    if (event.which === 13) { 
		        $.getPersonList();
		    }
		});
		
	});
	
	//날짜 변경 함수 yyyy-MM-dd
	function transDate(date) {
		let transDate = new Date(date);
		
		let month = (transDate.getMonth() + 1).toString().padStart(2, '0');
		let day = transDate.getDate().toString().padStart(2, '0');
		
		return transDate.getFullYear() + '-' + month + '-' + day;
	}
	
	//회원 리스트 가져오는 ajax
	$.getPersonList = function() {
		$.ajax({
			url: "<c:url value='/memberManag/AjaxGetMemList'/>",
			type: 'get',
			data: { searchName: $('#searchName').val() },
			dataType: 'json',
			success:function(res){
				let str = "";
				let num = 1;
				if(res != null && res.length>0){
					$.each(res, function() {
						let transJoinDate = new Date(this.joinDate);
						
						str += "<tr>";
						str	+= "<td class='userNum'>" +"<input type='checkbox' class='form-check-input' name = 'userNum' value = '"+this.userNum+"'>" + "</td>";
						str	+= "<td>" + num + "</td>";
						str	+= "<td>" + this.name + "</td>";
						str	+= "<td>" + this.gender + "</td>";
						str	+= "<td>" + this.type + "</td>";
						str	+= "<td>" + transDate(this.joinDate) + "</td>";
						str	+= "<td>" + this.comments + "</td>";
						str	+= "</tr>";
						
						num++;
					});
				}else{
					str = "<tr>"
						+ "<td colspan = '7'>등록된 회원이 없습니다. 회원을 등록해주세요.<td>"
						+ "</tr>";
				}
				
				$('#personList').html(str);
			},
			error:function(xhr, status, error){
				alert(status + " : " + error);
			}
				
		});	
	};
	
</script>
</head>

<body>
	<div id="wrapper">
		<%@ include file="form/header.jsp" %>
		<%@ include file="form/aside.jsp" %>
		<section>
			<div class="row" id="headerTag">
				/회원관리			
			</div>

			<div class="row">
				<!-- <form action=""  class="row" id="searchByNameFrm"> -->
					<div class="col-auto">
						<label for="searchName" class="visually-hidden">name</label> <input
							type="text" class="form-control" id="searchName" name="searchName"
							placeholder="이름으로 검색">
					</div>
					<div class="col-auto">
						<button type="button" class="btn btn-primary" id="searchBtn">검색</button>
						<button type="button" class="btn btn-success" id="registMemBtn" data-bs-toggle="modal"
		data-bs-target="#registMemModal">회원등록</button>
						<button type="button" class="btn btn-outline-danger" id="deleteMemBtn">회원삭제</button>
					</div>
				<!-- </form> -->
			</div>

			<div class="row">
				<form action="<c:url value="/memberManag/deletePerson"/>" id="chkFrm" method="post">
					<table class="table table-hover">
						<thead class="table-light">
							<tr>
								<th scope="col" width="6%"><input type="checkbox" class="form-check-input" id="chkAll"></th>
								<th scope="col" width="6%">연번</th>
								<th scope="col" width="14%">이름</th>
								<th scope="col" width="6%">성별</th>
								<th scope="col" width="6%">급수</th>
								<th scope="col" width="10%">가입일</th>
								<th scope="col" class="custom-width" width="52%">비고</th>
							</tr>
						</thead>
						<tbody id="personList">
							
						</tbody>
					</table>
				</form>
			</div>
			<div class="divPage row">
				<nav aria-label="...">
					<ul class="pagination justify-content-center">
						<c:if test="${pagingInfo.firstPage>1 }">
							<li
								class="page-item <c:if test='${pagingInfo.firstPage <=1 }'>disabled</c:if>">
								<a class="page-link" href="#" aria-label="Previous"
								onclick="pageFunc(${pagingInfo.firstPage-1})">이전</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${pagingInfo.firstPage }"
							end="${pagingInfo.lastPage }">
							<c:if test="${i == pagingInfo.currentPage }">
								<li class="page-item active" aria-current="page"><a
									class="page-link" href="#">${i}</a></li>
							</c:if>
							<c:if test="${i != pagingInfo.currentPage }">
								<li class="page-item"><a class="page-link"
									aria-label="Previous" href="#" onclick="pageFunc(${i})">${i }</a>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${pagingInfo.lastPage < pagingInfo.totalPage }">
							<li
								class="page-item <c:if test='${pagingInfo.lastPage >= pagingInfo.totalPage }'>disabled</c:if>">
								<a class="page-link" href="#"
								onclick="pageFunc(${pagingInfo.lastPage+1})">다음</a>
							</li>
						</c:if>
					</ul>
				</nav>
			</div>
		</section>
	
		<%@ include file="form/bottom2.jsp" %>
	</div>
	
	<!-- 모달창 -->
	<div class="modal fade" id="registMemModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">신규회원등록</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="<c:url value='/memberManag/registMem'/>" method="post" id="registMemFrm">
						<div class="mb-3 row">
							<div class="col-auto">
								<label for="name" class="col-form-label"><span>*</span>이름:</label>
							</div>
							<div class="col-auto">
								<input type="text" id="name" name="name" class="form-control">
							</div>
						</div>
						<div class="row" id="birthDay">
							<div class="col-auto" id=left>
								<label class="col-form-label"><span> </span>생년월일:</label>
							</div>
							<div class="col-auto" id="day1">
								<input type="text" id="birthYear" name="birthYear" class="form-control col"><span>년</span>
								<input type="text" id="birthMonth" name="birthMonth" class="form-control col"><span>월</span>
								<input type="text" id="birthDate" name="birthDate" class="form-control col"><span>일</span>
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
								<input type="text" id="joinYear" name="joinYear" class="form-control col"><span>년</span>
								<input type="text" id="joinMonth" name="joinMonth" class="form-control col"><span>월</span>
								<input type="text" id="joinDay" name="joinDay" class="form-control col"><span>일</span>
							</div>
						</div>
						<div class="mb-3 row">
							<div class="col-auto">
								<label for="comments" class="col-form-label"><span>&nbsp;</span>비고:</label>
							</div>
							<div class="col-10">
								<input type="text" class="form-control" name="comments" id="comments">
							</div>
						</div>
						
						<div class="mb-3 row">
							<p> * : 필수 입력란 입니다. 반드시 입력해주세요.</p>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="cancelBtn">닫기</button>
					<button type="button" class="btn btn-success" id="registBtn">등록</button>
				</div>
			</div>
		</div>
	</div>
</body>
<%@ include file="form/bottom.jsp" %>