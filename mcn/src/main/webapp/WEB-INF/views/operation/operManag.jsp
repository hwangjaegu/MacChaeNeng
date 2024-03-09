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
	
	.text-left {
		text-align: left;
	}
	
	#name {
		width: 200px;
	}
	
	#listDiv {
		margin-top: 20px;
	}
	
	#selectedDiv {
		margin-top: 20px;
	}
	
</style>

<script type="text/javascript">

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
							<th scope="col" width="10%">가입일</th>
							<th scope="col" class="custom-width" width="52%">비고</th>
						</tr>
					</thead>
					<tbody id="personList">

					</tbody>
				</table>
			</div>
			<div class="row" id="selectedDiv">
				<div class="row text-left">
					<span>선택된 회원목록</span>
				</div>
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
		</section>
	
		<%@ include file="../form/bottom2.jsp" %>
	</div>
</body>
<%@ include file="../form/bottom.jsp" %>