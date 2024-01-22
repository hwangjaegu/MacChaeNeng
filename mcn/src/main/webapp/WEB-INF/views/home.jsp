<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="form/top.jsp" %>

<title>MCN - 홈</title>

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
	
	aside {
		float: left;
		width: 15%;
		border-top: 2px solid gray;
	}
	
	section {
		width: 85%;
		min-height: 300px;
		border-top: 2px solid gray;
		float: right;
	}
	
	#wrapper {
		width: 100%;
	}
	
	#bottom{
		clear: both;
	}
</style>

<script type="text/javascript">

</script>

</head>
<body>
	<div id="wrapper">
		<%@ include file="form/header.jsp" %>
		<%@ include file="form/aside.jsp" %>
		<section>
		dd
		</section>
	
		<%@ include file="form/bottom2.jsp" %>
	</div>
	
</body>
<%@ include file="form/bottom.jsp"%>