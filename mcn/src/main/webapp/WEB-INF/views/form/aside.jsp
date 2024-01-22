<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style type="text/css">
 
 	li {
		list-style: none;
 	}
 	
 	ul ul{
 		display: none;
 	}
 	
 	aside>ul {
 		margin-top: 30px;
 	}
 	
 	aside>ul>li {
 		margin: 40px 0px 40px 0px;
 	}
 	
 	a {
 		text-decoration: none;
 		color: rgb(30, 30, 30);
 		font-size: 20px;
 	}
 </style>
 
 <script type="text/javascript">
	$(function() {
		$('aside > ul > li').hover(
			function(){
				$(this).children('ul').slideDown('fast');
				$(this).css('font-weight', 'bold');
            },
            function(){
            	$(this).children('ul').slideUp('fast');
            	$(this).css('font-weight', 'normal');
            }
        );
		
		$('li > ul > li').hover(
				function(){
					$(this).css('font-weight', 'bold');
	            },
	            function(){
	            	$(this).css('font-weight', 'normal');
	            }
	        );

	}); 
 </script>

<aside>
	<ul>
		<li>
			<a href="<c:url value='/home'/>">Home</a>
		</li>
		<li>
			<a href="">모임운영</a>
			<ul>
				<li>모임운영</li>
				<li>모임운영이력조회</li>
			</ul>
		</li>
		<li>
			<a href="">회원관리</a>
		</li>
		<li>
			<a href="">게임관리</a>
			<ul>
				<li>게임설정</li>
				<li>게임이력관리</li>
			</ul>
		</li>
		<li>
			<a href="">회비관리</a>
		</li>
		<li>
			<a href="">설정관리</a>
		</li>
	</ul>
</aside>