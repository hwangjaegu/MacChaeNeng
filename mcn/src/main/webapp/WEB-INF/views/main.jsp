<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="form/top.jsp" %>

<title>MCN - 로그인</title>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/base.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/main.css'/>">


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

</head>

<body class="container text-center">
	<%@ include file="form/header.jsp" %>
	<div id="body" class="row justify-content-center">
		<form class="col" name="frm" action="<c:url value='/login'/>" method="post">
			<div class="form-floating mb-3">
				<input type="text" class="form-control" placeholder="ID" id="id" name="id">
				<label for="floatingInput">ID</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="password" placeholder="Password" name="pwd">
				<label for="floatingPassword">Password</label>
			</div>
			<div class="buttonDiv">
				<button type="submit" class="btn btn-primary" id="loginBtn">로그인</button>
				<button type="button" class="btn btn-secondary" id="signin">회원가입</button>
			</div>
		</form>
	</div>
	
	<%@ include file="form/bottom2.jsp" %>
		
</body>
<%@ include file="form/bottom.jsp" %>
