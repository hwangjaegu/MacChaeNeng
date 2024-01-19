<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="form/top.jsp" %>
<style type="text/css">

</style>
<script type="text/javascript">
	$(function() {
		//로그인
		$('#loginBtn').click(function() {
			$('form').submit();
		});
		
		//회원가입 - 일시적으로 허용
		$('#signin').click(function() {
			location.href = "<c:url value='/signin'/>";
		});
	})
</script>
<title>MCN - 로그인</title>
</head>
<body class="container text-center">
	<div class="row align-items-center">
		<form class="col-4" name="frm" action="<c:url value='/login'/>" method="post">
			<div class="form-floating mb-3">
				<input type="email" class="form-control" placeholder="ID" id="id" name="id">
				<label for="floatingInput">ID</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="password" placeholder="Password" name="pwd">
				<label for="floatingPassword">Password</label>
			</div>
		</form>
		<div class="col-4">
			<button type="button" class="btn btn-primary" id="loginBtn">Login</button>
		</div>
		<button type="button" id="signin">회원가입</button>
	</div>
</body>
<%@ include file="form/bottom.jsp" %>
