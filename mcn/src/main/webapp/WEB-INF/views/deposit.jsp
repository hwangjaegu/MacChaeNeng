<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="form/top.jsp" %>

<title>MCN - 회비관리</title>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/base.css'/>">

<style type="text/css">

</style>

<script type="text/javascript">
	$(function() {
		
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
			
			<c:forEach items="${list }" var="item">
    			<div class="row g-3 align-items-center">
       				 <div class="col-auto">
       				 <script type="text/javascript">alert(${item});</script>
			            <label for="${item.criteria_name }" class="col-form-label">${item.criteria_name}</label>
			        </div>
			        <div class="col-auto">
			            <input type="text" name="${item.criteria_name }" class="form-control" value="">
			        </div>
			    </div>
			</c:forEach>
		</section>
	</div>
</body>
<%@ include file="form/bottom.jsp"%>