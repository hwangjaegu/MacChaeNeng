<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
	#bottom {
		margin-top: 20px;
		border-top: 2px solid gray;
		padding-top: 10px;
	}
	p {
		text-align: left;
	}

	p span:hover {
		cursor: pointer;
		text-decoration: underline;
	}
	
</style>

<script type="text/javascript">
	$(function() {
		$("#instagram").click(function() {
			let mcnInstagramLink = 'https://www.instagram.com/mac_c_n?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==';
			window.open(mcnInstagramLink, '_blank');
		});
		
		$("#somoim").click(function() {
			let mcnSomoimLink = 'https://somoim.friendscube.com/g/0a80a8c8-5145-11e9-b792-0a8846dcf6501';
			window.open(mcnSomoimLink, '_blank');
		});
	});
</script>

<div id="bottom">
	<div class="row">
		<div class="col" id="str">
			<p class="text-center">
				모임장소 : (01866) 서울특별시 노원구 마들로5가길 113<br>
				인스타그램 : <span id="instagram">mac_c_n</span><br>
				소모임 : <span id="somoim">우리동네 막체능 @MAC_c_n</span><br>
				Copyright © 2024 MacChaeNeng. All rights reserved
			</p>
		</div>
	</div>
</div>