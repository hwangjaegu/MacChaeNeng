<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="form/top.jsp" %>

<title>MCN - 회비관리</title>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/base.css'/>">

<style type="text/css">
	#labelDiv {
		width: 150px;
	}
	
	#inputDiv {
		width: 200px;
		align-items: baseline;
		display: flex;
	}
	
	.form-control {
		width: 120px;
		float: left;
	}
	
	button {
		margin-top: 50px;
		width: 400px;
		height: 50px;
	}
	
	input {
		text-align: right;
	}
	
	
</style>

<script type="text/javascript">
	$(function() {
		//수정하기 버튼 클릭 시
		$('#editBtn').click(function() {
			let saveBtn = "<button class='btn btn-success' id='saveBtn'>저장하기</button>"
			$('#buttonDiv').html(saveBtn);
			$('input[type=text]').prop('readonly', false);
			
			//숫자 이외 버튼 입력 금지
			$('input').on('keyup', function(e) {
			    if ((e.key >= '0' && e.key <= '9') || e.key === 'ArrowLeft' || e.key === 'ArrowRight' || e.key === 'Backspace' || e.key === 'Delete') {
			        return true;
			    } else {
			        e.preventDefault();
			        alert('숫자만 입력 가능합니다.');
			        $(this).val('');
			    }
			});
			
			//0001 같은 숫자 변환
			$('input').on('blur', function() {
			    let value = parseInt($(this).val(), 10);

			    if (isNaN(value)) {
			        value = 0;
			    }

			    $(this).val(value);
			});

			
		});
		
		//저장하기 버튼 클릭 시
		$(document).on('click', '#saveBtn', function() {
		    if(confirm('입력 사항을 저장하시겠습니까?')){
		    	$('#depositFrm').submit();
		    }
		});
		
		

	});
</script>
</head>
<body>
	<div id="wrapper">
		<%@ include file="form/header.jsp" %>
		<%@ include file="form/aside.jsp" %>
		<section>
			<div class="row" id="headerTag">
				/회비관리			
			</div>
			<form action="<c:url value='/deposit/depositEdit'/>" id="depositFrm" method="post">
				<div class="row" id="depositList">
					<c:forEach items="${list}" var="item" varStatus="loop">
						<div class="row g-3 align-items-center 10">
							<div id="labelDiv">
								<label for="depositNum_${loop.index}" class="col-form-label">${item.depositCategory}</label>
							</div>
							<div id="inputDiv">
								<input type="hidden"
									name="depositList[${loop.index}].depositNum"
									id="depositNum_${loop.index}" value="${item.depositNum}">
								<input type="text" name="depositList[${loop.index}].fee"
									class="form-control" value="${item.fee}" readonly>&nbsp;원
							</div>
						</div>
					</c:forEach>
				</div>
			</form>
			<div class="row">
				<div class="col align-self-center" id="buttonDiv">
					<button class="btn btn-primary" id="editBtn">수정하기</button>
				</div>
			</div>
		</section>
	</div>
</body>
<%@ include file="form/bottom.jsp"%>