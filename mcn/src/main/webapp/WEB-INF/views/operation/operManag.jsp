<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../form/top.jsp" %>

<title>MCN - 모임운영</title>

<style>
	body {
	    text-align: center; /* 수평 가운데 정렬 */
	    display: flex;
	    flex-direction: column;
	    justify-content: center; /* 수직 가운데 정렬 */
	    align-items: center;
	    margin: 0; /* body의 기본 마진 제거 */
	}
	
	/* div 확인용*/
	 /* * {
		border: 1px solid #000;
	}  */
	
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
	
	
	.table {
		width: 97%;
		margin: 0px 0px 0px 20px;
	}
	
	tbody tr {
		cursor: pointer;
	}
	
	.text-left {
		text-align: left;
	}
	
	#name {
		width: 200px;
	}
	
	#listDiv {
		margin-top: 20px;
		height: 250px;
		overflow: auto; 
	}
	
	table {
		width: 100%; /* 테이블의 너비를 100%로 설정하여 부모 요소에 맞춤 */
	}
   
	thead {
    	position: sticky; /* 헤더를 고정 */
        top: 0; /* 헤더를 창의 상단에 고정 */
        z-index: 1; /* 다른 요소 위에 표시 */
    }
    
    tbody tr {
    	height: 20px;
    }
	
	#selectedDiv {
		height: 250px;
	}
	
	#selectedSpan {
		margin-top: 20px;
	}
	
</style>

<script type="text/javascript">
	$(function() {
		$.getPersonList();
		
		//스페이스바 입력 방지
		$('input').on('keydown', function(e) {
			if(e.key === ' ' && $(this).attr('id') !== 'comments'){
				e.preventDefault();
				alert('스페이스바 입력 금지');
			}
		});
		
		//회원이름 검색
		$('#searchBtn').click(function() {
			$.getPersonList();
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
		<%@ include file="../form/header.jsp" %>
		<%@ include file="../form/aside.jsp" %>
		<section>
			<div class="row" id="headerTag">
				/회원관리			
			</div>
			<div class="row">
				<div class="col-auto">
					<label for="searchName" class="visually-hidden">name</label> <input
						type="text" class="form-control" id="searchName" name="searchName"
						placeholder="이름으로 검색">
				</div>
				<div class="col-auto">
					<button type="button" class="btn btn-primary" id="searchBtn">검색</button>
				</div>
			</div>
			
			<div class="row" id="listDiv">
				<table class="table table-hover">
					<thead class="table-light">
						<tr>
							<th scope="col" width="14%">이름</th>
							<th scope="col" width="6%">성별</th>
							<th scope="col" width="6%">급수</th>
							<th scope="col" width="18%">가입일</th>
							<th scope="col" class="custom-width" width="52%">비고</th>
						</tr>
					</thead>
					<tbody id="personList">

					</tbody>
				</table>
			</div>
			<div class="row text-left">
				<span id="selectedSpan">선택된 회원목록</span>
			</div>
			<form action="<c:url value='/operation/operationManag/saveSelectedMemFrm'/>" method="post" id="selectedMem">
				<div class="row" id="selectedDiv">
					
						<table class="table table-hover">
							<thead class="table-light">
								<tr>
									<th scope="col" width="14%">이름</th>
									<th scope="col" width="6%">성별</th>
									<th scope="col" width="6%">급수</th>
									<th scope="col" width="10%">가입일</th>
									<th scope="col" class="custom-width" width="52%">비고</th>
								</tr>
							</thead>
	
							<tbody id="selectedList">
	
							</tbody>
						</table>
				</div>
			</form>
		</section>
	
		<%@ include file="../form/bottom2.jsp" %>
	</div>
</body>
<%@ include file="../form/bottom.jsp" %>