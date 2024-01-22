<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="form/top.jsp"%>

<title>MCN - 회원가입</title>

<style type="text/css">
	body {
	    text-align: center; /* 수평 가운데 정렬 */
	    display: flex;
	    flex-direction: column;
	    justify-content: center; /* 수직 가운데 정렬 */
	    align-items: center;
	    margin: 0; /* body의 기본 마진 제거 */
	}

	.button{
		height: 70px;
		width: 200px;
		margin: 5px;
	}
	
	.right {
		text-align: right;
	}
	
	.left {
		text-align: left;
	}
	
	label{
		text-align: right;
	}
	
	form {
		width: 1000px;
		text-align: center;
		padding: 30px 0px 30px 0px;
		
	}
	
	/* div 확인용*/
	/* div {
		border: 1px solid #000;
	} */
	
	.form-control {
		width: 300px;
	}
	
	#dubChkBtn{
		float: left;
		margin-left: -40px;
	}
	
	hr {
		margin-top: 50px;
	}
	
	#pwd {
		margin-bottom: 5px;
	}	
</style>

<script type="text/javascript">
	$(function() {
		$('#dub').val('N');
		
		
		$('#dubChkBtn').click(function() {
			if($('#id').val().length < 6){
				alert("아이디는 6자리 이상 입력해야 합니다.");
			}else{
				$.idDubChk();
			}
		});
		
		$('#id').keyup(function() {
			$('#dub').val('N');
			$('#dubChk').html('*아이디 중복을 확인하세요.');
			$('#dubChk').css('color', 'black');
		});
		
		$('#pwd').keyup(function() {
			if($('#pwd').val().length < 8){
				$('#pwdChkSpan').html('*비밀번호는 최소 8자리 이상 입력하세요.');
				$('#pwdChkSpan').css('color', 'red');
			}else{
				$('#pwdChkSpan').html('');
			}
		});
		
		$('#pwdChk').keyup(function() {
			if($('#pwd').val() != $('#pwdChk').val()){
				$('#pwdChkSpan').html('*비밀번호가 일치하지 않습니다.');
				$('#pwdChkSpan').css('color', 'red');
			}else{
				$('#pwdChkSpan').html('');
			}
		});
		
		$('form').submit(function() {
			if($('#id').val().length<1){
				event.preventDefault();
				alert("아이디를 입력해주세요.");
				$('#id').focus();
			}else if($('#pwd').val().length<1){
				event.preventDefault();
				alert("비밀번호를 입력해주세요.");
				$('#pwd').focus();
			}else if($('#pwd').val() != $('#pwdChk').val()){
				event.preventDefault();
				alert("비밀번호가 일치하지 않습니다.");
				$('#pwd').val('');
				$('#pwdChk').val('');
				$('#pwd').focus();
			}else if($('#dub').val() != 'Y'){
				event.preventDefault();
				alert("아이디 중복을 확인하세요.");
				$('#id').focus();
			}
		});
	
		$('#cancel').click(function() {
			confirm("회원가입을 중단하시겠습니까? 작성 내용은 저장되지 않습니다.");
			location.href = "<c:url value = '/main'/>";
		});
		
		
	});
	
	
	$.idDubChk = function() {
		$.ajax({
			url: "<c:url value='/ajaxIdDubCheck'/>",
			type: 'get',
			data: { userId: $('#id').val() },
			dataType: 'json',
			success:function(res){
				$('#dub').val(res.dub);
				$('#dubChk').html(res.str);
				idColor();
			},
			error:function(xhr, status, error){
				alert(status + " : " + error);
			}
		});
	};
	
	function idColor() {
		if($('#dub').val() === 'Y'){
			$('#dubChk').css('color', 'green');
		}else{
			$('#dubChk').css('color', 'red');
		}
	}
</script>

</head>

<body>
	<%@ include file="form/header.jsp" %>
	<div id="body" class="justify-content-center">
		<form name="frm" action="<c:url value='/signin'/>" method="post">
			<div class="row mb-5">
				<div class="col-4 right">
			    	<label for="id" class="col-form-label">아이디</label>
				</div>
		    	<div class="col">
		    		<div class="row">
			      		<input type="text" class="form-control" id="id" name="id">
			      		<input type="hidden" id="dub">
		    		</div>
		    		<div class="row left">
						<span id="dubChk">*아이디 중복을 확인하세요.</span>
		    		</div>
				</div>
				<div class="col">
					<button type="button" class="btn btn-secondary" id="dubChkBtn">ID 중복확인</button>			
				</div>
	  		</div>
			<div class="row mb-3">
				<div class="col-4 right">
		    		<label for="pwd" class="col-form-label">비밀번호</label>
				</div>
	    		<div class="col">
	    			<div class="row">
		      			<input type="password" class="form-control" name="pwd" id="pwd">
	    			</div>
	    			<div class="row">
						<input type="password" class="form-control" name="pwdChk" id="pwdChk">
	    			</div>
	    			<div class="row left">
		    			<span id="pwdChkSpan">*비밀번호를 입력하세요.</span>
	    			</div>
	    		</div>
	    		
	  		</div>
	  		<hr>
	  		<div class="row justify-content-center btnDiv">
				<button type="button" class="btn btn-secondary button" id="cancel">취소</button>
				<button type="submit" class="btn btn-primary button" id="signIn">회원가입</button>
	  		</div>
		</form>
	</div>
	<%@ include file="form/bottom2.jsp" %>
</body>
<%@ include file="form/bottom.jsp"%>