<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../form/top.jsp" %>

<title>MCN - 모임운영</title>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/base.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/operManag.css'/>">

<script type="text/javascript" src="<c:url value='/js/gameJs.js'/>"></script>
<script type="text/javascript">
	$(function() {
		//선택인원 중복 체크를 위한 배열 생성 - 로컬에 배열이 있으면 해당 배열 사용하고 없으면 새로 선언
		var selectedMemRows = JSON.parse(localStorage.getItem('selectedMemRows')) || [];
		
		//회원목록 불러오기
		getPersonList();
		//선택된 인원 카운트
		personCount();
		
		//선택된 tr 색변화
		updateSelectedClass();
		
		//이미 저장된 인원 수
		personCount();
		
		//로컬에 저장된 회원 목록 불러오기
		savedSelectedMemRows();

		//로컬에 저장된 입금 목록 불러오기
		savedDepositCheckRows(selectedMemRows);
		
		getGameMemList();
		
		getTotalDeposit();
		
		//메모내용 로딩
		getMemo();
		
		//스페이스바 입력 방지
		$('input').on('keydown', function(e) {
			if(e.key === ' ' && $(this).attr('id') !== 'comments'){
				e.preventDefault();
				alert('스페이스바 입력 금지');
			}
		});
		
		//회원이름 검색
		$('#searchBtn').click(function() {
			getPersonList(function() {
				updateSelectedClass();
			});
		});
		
		$('input').keyup(function(e) {
			if(e.key === 'Enter'){
				getPersonList(function() {
					updateSelectedClass();
				});
			}
		});
		
		//선택한 인원 정보 밑으로 내리기
		$('#personList').on('click', 'tr:not([name=emptyTr])', function() {
			let userNum = $(this).find('input[name=userNum]').val();
			let weight = $(this).find('input[name=weight]').val();
			let name = $(this).find('td[name=userName]').html();
		    let gender = $(this).find('td[name=gender]').html();
		    let type = $(this).find('td[name=type]').html();
		    let transDate = $(this).find('td[name=transDate]').html();
		    let comments = $(this).find('td[name=comments]').html();
			
		    selectedMemRows = JSON.parse(localStorage.getItem('selectedMemRows')) || [];
		    
			if (!selectedMemRows.some(item => item.userNum == userNum)) {
				addToLocalStorage(userNum, weight, name, gender, type, transDate, comments);
		        $('#baseTr').css('display', 'none');
		        let newRow = $(this).clone();
		        $('#selectedList').append(newRow);
		        newRow.css('height', '20px');
				
		        updateSelectedClass();
				personCount();
				changeSelectedMem();
		    } else {
		        alert('이미 선택된 회원입니다.');
		    }
		});
		
		//선택된 회원 취소시키기
		$('#selectedList').on('click', 'tr', function() {
			let userNum = $(this).find('input[name=userNum]').val();
			
			removeFromLocalStorage(userNum);
			
		    selectedMemRows = JSON.parse(localStorage.getItem('selectedMemRows')) || [];
		    
			$(this).remove();
			
			if(selectedMemRows.length < 1){
				 $('#baseTr').show();
			}
			
			updateSelectedClass();
			personCount();
			changeSelectedMem();
		});
		
		//선택된 인원 로컬스토리지에 저장, depositCheckRows에 데이터 저장 및 입금리스트 작성
		$('#saveBtn').click(function() {
		    selectedMemRows = JSON.parse(localStorage.getItem('selectedMemRows')) || [];
			
			if(selectedMemRows.length < 1){
				alert('운동에 참여하는 회원을 선택하세요.');
				tr = '<tr><td colspan=3>참여인원이 없습니다. 참여인원을 선택해주세요.</td><tr>'
				
				let depositCheckRows = [];
				localStorage.setItem('depositCheckRows', JSON.stringify(depositCheckRows));
				$('#depositList').html(tr);
				getGameMemList();
			}else{
				if(confirm('참여 인원을 저장하시겠습니까?')){
					alert('참여 인원 저장이 완료되었습니다.');
					$('#member-tab').removeClass('active');
					$('#member').removeClass('show active');
					$('#deposit-tab').addClass('active');
					$('#deposit').addClass('show active');
					selectedBtnClick();

					let depositCheckRows = [];
					
					selectedMemRows.forEach(function(mem) {
						let depositChk = {
							userNum: mem.userNum,
							name: mem.name,
							isDeposit: 'n'
						};
						
						depositCheckRows.push(depositChk);
					});
					
					let tr = '';
					
					let num = 1;
					if(selectedMemRows.length > 0){
						depositCheckRows.forEach(function(mem) {
							tr += "<tr>";
							tr += "<input type='hidden' name='userNum' value='" + mem.userNum + "'>";
							tr += "<td>" + num + "</td>";
							tr += "<td name='userName'>" + mem.name + "</td>";
							tr += "<td name='depositChk'>"
							tr += "<input type='radio' class='btn-check' name='depositChk" + num + "' id='o" + num + "' autocomplete='off' value='o'>";
							tr += "<label class='btn btn-outline-success' for='o" + num + "'>입금완료</label>";
							tr += "<input type='radio' class='btn-check' name='depositChk" + num + "' id='c" + num + "' autocomplete='off' value='c'>";
							tr += "<label class='btn btn-outline-primary' for='c" + num + "'>쿠폰</label>";
							tr += "<input type='radio' class='btn-check' name='depositChk" + num + "' id='g" + num + "' autocomplete='off' value='g'>";
							tr += "<label class='btn btn-outline-success' for='g" + num + "'>게스트</label>";
							tr += "<input type='radio' class='btn-check' name='depositChk" + num + "' id='p" + num + "' autocomplete='off' value='a'>";
							tr += "<label class='btn btn-outline-secondary' for='p" + num + "'>운영진</label>";
							tr += "<input type='radio' class='btn-check' name='depositChk" + num + "' id='a" + num + "' autocomplete='off' value='p'>";
							tr += "<label class='btn btn-outline-secondary' for='a" + num + "'>담당</label>";
							tr += "<input type='radio' class='btn-check' name='depositChk" + num + "' id='n" + num + "' autocomplete='off' value='n' checked>";
							tr += "<label class='btn btn-outline-warning' for='n" + num + "'>미입금</label>";
							tr += "<input type='radio' class='btn-check' name='depositChk" + num + "' id='f" + num + "' autocomplete='off' value='f'>";
							tr += "<label class='btn btn-outline-danger' for='f" + num + "'>벌금</label>";
							tr += "</td>";
							tr += "</tr>";
							
							num++;
						});
					}else{
						tr = '<tr><td colspan=3>참여인원이 없습니다. 참여인원을 선택해주세요.</td><tr>'
					}	
					
					$('#depositList').html(tr);
					
					localStorage.setItem('depositCheckRows', JSON.stringify(depositCheckRows));
					
					getGameMemList();
					getTotalDeposit();
				}
			}
			
		});
		
		
		//선택된 tr 색 변화
		function updateSelectedClass() {
			$('#personList tr').each(function() {
				let userNum = $(this).find('input').val();
				
				if(selectedMemRows.some(item => item.userNum === userNum)){
					$(this).addClass('selected');
				}else{
					$(this).removeClass('selected');
				}
			});
		}
		
		//로컬스토리지에 회원정보 저장
		function addToLocalStorage(userNum, weight, name, gender, type, transDate, comments) {
			
			let selectedMem = {
					userNum: userNum,
					weight: weight,
					name: name,
					gender: gender,
					type: type,
					transDate: transDate,
					comments: comments
			};
			
			selectedMemRows.push(selectedMem);
			
			localStorage.setItem('selectedMemRows', JSON.stringify(selectedMemRows));
			
		};
		
		//로컬스토리지에 회원정보 삭제
		function removeFromLocalStorage(userNum) {
			
			let selectedMemRows = JSON.parse(localStorage.getItem('selectedMemRows')) || [];
			
			selectedMemRows = selectedMemRows.filter(function(mem) {
	            return mem.userNum !== userNum;
	        });
			
			localStorage.setItem('selectedMemRows', JSON.stringify(selectedMemRows));
		};
		
		//로컬스토리지에 저장된 정보로 선택된 회원목록 작성
		function savedSelectedMemRows() {
			let selectedMemRows = JSON.parse(localStorage.getItem('selectedMemRows'));
			
			if(selectedMemRows && selectedMemRows.length > 0){
				$('#baseTr').css('display', 'none');
				
				selectedMemRows.forEach(function(mem) {
					let tr = '<tr>';
					tr += "<input type='hidden' name='userNum' value='" + mem.userNum + "'>";
					tr += "<input type='hidden' name='weight' value='" + mem.weight + "'>";
					tr += "<td name='userName'>" + mem.name + "</td>";
					tr += "<td name='gender'>" + mem.gender + "</td>";
					tr += "<td name='type'>" + mem.type + "</td>";
					tr += "<td name='transDate'>" + mem.transDate + "</td>";
					tr += "<td name='comments'>" + mem.comments + "</td>";
					
					$('#selectedList').append(tr);
					
				});
				
				let cnt = selectedMemRows.length;
				$('#memCnt').html(cnt);
			}
		}
		
		//로컬스토리지에 저장된 정보로 입금목록 작성
		function savedDepositCheckRows(selectedMemRows) {
			let depositCheckRows = JSON.parse(localStorage.getItem('depositCheckRows')) || [];
			
			let tr = '';
			
			if(depositCheckRows.length < 1){
				tr += "<tr>";
				tr += "<td colspan=3>참여인원이 없습니다. 참여인원을 선택해주세요.</td>";
				tr += "</tr>";
			}else{
				let num = 1;
				
				depositCheckRows.forEach(function(depositChk) {
					tr += "<tr>";
					tr += "<input type='hidden' name='userNum' value='" + depositChk.userNum + "'>";
					tr += "<td>" + num + "</td>";
					tr += "<td name=userName>" + depositChk.name + "</td>";
					
					let isDeposit = depositChk.isDeposit;
				
					tr += "<td name='depositChk'>"
					
					let options = [
				    	{ value: 'o', label: '입금완료', class: 'btn-outline-success' },
				    	{ value: 'c', label: '쿠폰', class: 'btn-outline-primary' },
				    	{ value: 'g', label: '게스트', class: 'btn-outline-success' },
				    	{ value: 'a', label: '운영진', class: 'btn-outline-secondary' },
				    	{ value: 'p', label: '담당', class: 'btn-outline-secondary' },
				    	{ value: 'n', label: '미입금', class: 'btn-outline-warning' },
				    	{ value: 'f', label: '벌금', class: 'btn-outline-danger' }
				    ];

				    options.forEach(function (option) {
				    	let checked = depositChk.isDeposit == option.value ? 'checked' : '';
				    	
				    	tr += "<input type='radio' class='btn-check' name='depositChk" + num + "' id='" + option.value + num + "' autocomplete='off' value='" + option.value + "' " + checked + ">";
				    	tr += "<label class='btn " + option.class + "' for='" + option.value + num + "'>" + option.label + "</label>";
				    });
					
					tr += "</td>";
					tr += "</tr>";
					
					num++;
				});
			}
			
			$('#depositList').html(tr);
			
		}
		
		$('#depositList input').change(function() {
			changeDeposit();
			getTotalDeposit();
		});
		
		$('#depositList').on('change', 'input', function() {
			changeDeposit();
			getTotalDeposit();
		});
		
		//입금 여부 체크 후 저장버튼 클릭 시
		$('#saveDepositBtn').click(function() {
			let isSelectedBtnClick = JSON.parse(localStorage.getItem('isSelectedBtnClick'));
			
			if(isSelectedBtnClick == 1){
				if(confirm('입금내역을 저장하시겠습니까?')){
					
					let depositCheckRows = [];
					
					$('#depositList tr').each(function() {
						let depositChk = {
							userNum: $(this).find('input[name=userNum]').val(),
							name: $(this).find('td[name=userName]').text(),
							isDeposit: $(this).find('input:checked').val()
						};
						
						depositCheckRows.push(depositChk);
					});
					
					localStorage.setItem('depositCheckRows', JSON.stringify(depositCheckRows));
					$('#deposit-tab').removeClass('active');
					$('#deposit').removeClass('show active');
					$('#game-tab').addClass('active');
					$('#game').addClass('show active');
					depositBtnClick();
					
					
					localStorage.setItem('totalDeposit', JSON.stringify(parseInt($('#totalDeposit').val().replace(/,/g,''))));
					
					alert('입금 내역을 저장했습니다.');
					
					getGameMemList();
				}
			}else{
				alert('참여인원 탭에서 저장하기 버튼을 눌러야 합니다.');
			}
			
		});
		
		//게임 구성을 위한 tr추가를 위한 tr 클릭
		$('#setGame').click(function() {
			
			//빈 td 확인
			let bool = true;
			
			let cnt = 0;
			
			$('#gameTable tr').each(function() {
				$(this).find('td').each(function() {
					if($(this).text().match(/^Team/)){
						cnt++;
					}						
				});
			});
			
			if(cnt < 1){
				let gameNum = $(this).prev().find('td[name=gameNum]').text() || 0;
				
				gameNum=parseInt(gameNum)+1;
				
				let tr = "<tr name='gameTr'>";
				tr += "<td style='width: 10%' name='gameNum'>" + gameNum + "</td>";
			    tr += "<td style='width: 18.75%' name='team'>Team</td>";
			    tr += "<td style='width: 18.75%' name='team'>Team</td>";
			    tr += "<td style='width: 18.75%' name='team'>Team</td>";
			    tr += "<td style='width: 18.75%' name='team'>Team</td>";
			    tr += "<td style='width: 15%' name='state'>대기</td>";
				tr+="</tr>";
				
				$('#gameList').append(tr);
			    $('#gameList').append($(this));
			}else{
				alert("완전하게 구성되지 못한 게임이 존재합니다.");				
			}
			
			
		});
		
		//참여 인원 tr 눌러서 게임 구성하기
		$('#memDiv tbody').on('click','tr', function() {
			let userNum = $(this).find('input[name=userNum]').val();
			let name = $(this).find('td[name=name]').text();
			let gender = $(this).find('input[name=gender]').val();
			let type = $(this).find('td[name=type]').text();
			let weight = $(this).find('input[name=weight]').val();
			
			let genClass = (gender === '남')? 'men':'women';
			
			$('#gameTable tbody tr td').each(function() {
				if($(this).text().match(/^Team/)){
					if(checkDubMem($(this), userNum)){
						alert("이미 등록된 회원입니다.");
						
						return false;
					}
					
					let td = "";
					td += "<td class='" + genClass + "'>";
					td += "<input type=hidden name='userNum' value='"+userNum+"'>";
					td += "<input type=hidden name='gender' value='"+gender+"'>";
					td += "<input type=hidden name='type' value='"+type+"'>";
					td += "<input type=hidden name='weight' value='"+weight+"'>";
					td += name+"</td>";
					
					$(this).html(td);
					
					gameBalanceCheck($(this));
					
					return false;
				}	
			});
			
			countGameSet();
		});
		
		//게임목록 저장을 위한 dom 변화 감지
		// 변경을 감지할 노드 선택
		const targetNode = document.getElementById("gameTable");

		// 감지 옵션 (감지할 변경)
		const config = { attributes: true, childList: true, subtree: true };

		// 변경 감지 시 실행할 콜백 함수
		const callback = (mutationList, observer) => {
			for (const mutation of mutationList) {
		    	if (mutation.type === "childList") {
					alert();
		    	}else{
		    		alert('dd');
		    	}
		  	}
		};

		// 콜백 함수에 연결된 감지기 인스턴스 생성
		const observer = new MutationObserver(callback);

		// 설정한 변경의 감지 시작
		observer.observe(targetNode, config);
		
		
		//구성된 게임에서 인원 빼기
		$('#gameTable tbody').on('click', 'td', function() {
			if ($(this).parent().is('#setGame') || $(this).is('td[name=gameNum]') || $(this).is('td[name=state]')) {
		        return;
		    }
			
			let td="Team";
			
			$(this).html(td);
		});
		
		//게임 진행 여부 확인
		$('#gameTable tbody').on('click', 'td[name=state]', function() {
			if($(this).text() == '대기'){
				$(this).addClass('text-green').text("진행");
			}else if($(this).text() == '진행'){
				$(this).removeClass('text-green').addClass('text-red').text("완료");
			}else{
				$(this).removeClass('text-red').text("대기");
			}
		});
		
		//메모 저장 버튼 클릭 시
		$('#memoSaveBtn').click(function() {
			let memoText = $('textarea').val();
			
			localStorage.setItem('memoText', JSON.stringify(memoText));
		});
		
		//확대 버튼 클릭 시 모달 출력
		$('#plusBtn').click(function() {
			$('#gameTable tbody tr').each(function() {
				
			});
		});
		
		//모임 종료 버튼 클릭 시
		$('#endOperation').click(function() {
			if(confirm('모임을 종료하시겠습니까?')){
			
			}
		});
		
		//gameTab에 게임 참여 인원 현황 만들기
		function getGameMemList() {
			let gameSetMemList = JSON.parse(localStorage.getItem('selectedMemRows'));
			let depositCheckRows = JSON.parse(localStorage.getItem('depositCheckRows')) || [];
			
			depositCheckRows.forEach(function(deMem) {
				if (deMem.isDeposit === 'f' && gameSetMemList.some(mem => mem.userNum === deMem.userNum)) {
					gameSetMemList = gameSetMemList.filter(mem => mem.userNum !== deMem.userNum);
				}
			});
			
			let mTr = '';
			let wTr = '';
			
			if(depositCheckRows && depositCheckRows.length > 0){
				let mN = 1;
				let wN = 1;
				
				gameSetMemList.forEach(function(mem) {
					let cnt = 0;
					
					$('#gameTable input[name=userNum]').each(function() {
						let userNum = $(this).val();
						if(mem.userNum == userNum){
							cnt++
						}
					});
					
					if(mem.gender == '남'){
						mTr += "<tr class=men>";
						mTr += "<input type='hidden' name='userNum' value='"+mem.userNum+"'>";
						mTr += "<input type='hidden' name='weight' value='"+mem.weight+"'>";
						mTr += "<input type='hidden' name='gender' value='"+mem.gender+"'>";
						mTr += "<td>"+mN+"</td>";
						mTr += "<td name='name'>"+mem.name+"</td>";
						mTr += "<td name='type'>"+mem.type+"</td>";
						mTr += "<td name='gameCnt'>"+cnt+"</td>";
						mTr += '</tr>';
						
						mN++;
					}else{
						wTr += "<tr class=women>";
						wTr += "<input type='hidden' name='userNum' value='"+mem.userNum+"'>";
						wTr += "<input type='hidden' name='weight' value='"+mem.weight+"'>";
						wTr += "<input type='hidden' name='gender' value='"+mem.gender+"'>";
						wTr += '<td>'+wN+'</td>';
						wTr += "<td name='name'>"+mem.name+"</td>";
						wTr += "<td name='type'>"+mem.type+"</td>";
						wTr += "<td name='gameCnt'>"+cnt +"</td>";
						wTr += '</tr>';
						
						wN++;
					}
				});
				
			}else{
				mTr = '<tr>';	
				mTr += '<td colspan=3>선택된 인원이 없습니다.</td>';	
				mTr += '</tr>';
				
				wTr = mTr;
			}
			
			$('#menList').html(mTr);
			$('#womenList').html(wTr);
		}
		
		//참여인원 저장 버튼 클릭 시
		function selectedBtnClick() {
			let isSelectedBtnClick = 1;
			localStorage.setItem('isSelectedBtnClick', JSON.stringify(isSelectedBtnClick));
		}
		
		//참여인원 상태 변화 시
		function changeSelectedMem() {
			let isSelectedBtnClick = 0;
			localStorage.setItem('isSelectedBtnClick', JSON.stringify(isSelectedBtnClick));
		}
		
		//입금 내역 저장 버튼 클릭 시
		function depositBtnClick() {
			let isDepositBtnClick = 1;
			localStorage.setItem('isDepositBtnClick', JSON.stringify(isDepositBtnClick));
		}
		
		//입금 내역 저장 버튼 클릭 시
		function changeDeposit() {
			let isDepositBtnClick = 0;
			localStorage.setItem('isDepositBtnClick', JSON.stringify(isDepositBtnClick));
		}
		
		// 회비 합계 구하는 함수
		function getTotalDeposit() {
		    let totalDeposit = 0;
			
		    let options = [
		    	{ value: 'o', fee: $("input[name='일반회원']").val() },
		    	{ value: 'c', fee: $("input[name='쿠폰']").val() },
		    	{ value: 'g', fee: $("input[name='게스트']").val() },
		    	{ value: 'a', fee: $("input[name='운영진']").val() },
		    	{ value: 'p', fee: $("input[name='담당']").val() },
		    	{ value: 'f', fee: $("input[name='벌금']").val() }
		    ];
		    
		    $('#depositList input:checked').each(function() {
				let selectedOption = options.find(option => option.value === $(this).val());
		    	
				if(selectedOption){
					let fee = parseInt(selectedOption.fee);
					totalDeposit += fee;
				}
			});
		    
		    let formattedTotalDeposit = numberWithCommas(totalDeposit);
		    $('input[name=totalDeposit]').val(formattedTotalDeposit);
		}
		
		//천단위 기호 삭제 함수
		function numberWithCommas(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		//회원 리스트 가져오는 ajax
		function getPersonList() {
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

							if(selectedMemRows.some(item => item.userNum == this.userNum)){
								str += "<tr class='selected'>";
							}else{
								str += "<tr>";
							}
							str	+= "<input type='hidden' name='userNum' value='"+this.userNum+"'>";
							str	+= "<input type='hidden' name='weight' value='"+this.weight+"'>";
							str	+= "<td name='userName'>"+this.name+"</td>";
							str	+= "<td name='gender'>"+this.gender+"</td>";
							str	+= "<td name='type'>"+this.type+"</td>";
							str	+= "<td name='transDate'>"+transDate(this.joinDate)+"</td>";
							str	+= "<td name='comments'>"+this.comments+"</td>";
							str	+= "</tr>";
							
							num++;
						});
					}else{
						str = "<tr name='emptyTr'>"
							+ "<td colspan = '7'>검색된 회원이 없습니다.<td>"
							+ "</tr>";
					}
					
					$('#personList').html(str);
				},
				error:function(xhr, status, error){
					alert(status + " : " + error);
				}
					
			});	
		}
		
		//선택된 인원 카운트
		function personCount() {
			let cnt = 0;
			
			$('#selectedList input[name=userNum]').each(function() {
				cnt++;
			});
			
			$('#memCnt').html(cnt);
		}
		
		//인원당 들어간 게임 수 확인
		function countGameSet() {
			let gameSetMemList = JSON.parse(localStorage.getItem('selectedMemRows'));
			let depositCheckRows = JSON.parse(localStorage.getItem('depositCheckRows'));
			
			depositCheckRows.forEach(function(deMem) {
				if (deMem.isDeposit === 'f' && gameSetMemList.some(mem => mem.userNum === deMem.userNum)) {
					gameSetMemList = gameSetMemList.filter(mem => mem.userNum !== deMem.userNum);
				}
			});
			
			gameSetMemList.forEach(function(mem) {
				let cnt = 0;
				
				$('#gameTable input[name=userNum]').each(function() {
					if($(this).val() == mem.userNum){
						cnt++;
					}
				});
				
				$('#memDiv input[name=userNum]').each(function() {
					if($(this).val() == mem.userNum){
						$(this).parent().find('td[name=gameCnt]').text(cnt);
						return false;
					}
				});
			});
		}
		
		//한 게임에 같은 사람이 두명 들어갔는지 확인
		function checkDubMem(tdElement, userNum) {
			let dubChk = false;
			
			let trElement = tdElement.parent();
			
			let cnt=0;
			
			trElement.find('input[name=userNum]').each(function() {
				if($(this).val() == userNum){
					cnt++;
				}
			});
			
			if(cnt > 0){
				dubChk = true;
			}
			
			return dubChk;
		}
		
		//저장된 메모내용 로딩
		function getMemo() {
			let memoText = JSON.parse(localStorage.getItem('memoText')) || '';
			
			$('textarea').val(memoText);
		}
		
		//게임 밸런스 체크
		function gameBalanceCheck(tdElement) {
			let trElement = tdElement.parent();
			
			let cnt = 0;
			
			trElement.find('td').each(function() {
				if($(this).text() == 'Team') cnt++;
			});
			
			if(cnt == 0){
				let genderList = trElement.find('input[name=gender]'); 
				let gradeList = trElement.find('input[name=type]'); 
				let weightList = trElement.find('input[name=weight]');
				
				let grade1 = transPoint(genderList.eq(0).val(), gradeList.eq(0).val(), weightList.eq(0).val()); 
				let grade2 = transPoint(genderList.eq(1).val(), gradeList.eq(1).val(), weightList.eq(1).val()); 
				let grade3 = transPoint(genderList.eq(2).val(), gradeList.eq(2).val(), weightList.eq(2).val()); 
				let grade4 = transPoint(genderList.eq(3).val(), gradeList.eq(3).val(), weightList.eq(3).val());
				if(Math.abs((grade1 + grade2)-(grade3 + grade4))>1){
					alert('게임 밸런스가 맞지 않습니다. 게임 수정을 권장합니다.');
				}
			}
		}
		
		

	});
	
	//날짜 변경 함수 yyyy-MM-dd
	function transDate(date) {
		let transDate = new Date(date);
		
		let month = (transDate.getMonth() + 1).toString().padStart(2, '0');
		let day = transDate.getDate().toString().padStart(2, '0');
		
		return transDate.getFullYear() + '-' + month + '-' + day;
	}
	
	/* window.onload = function() {
	    // 로컬 스토리지에서 selectedMemRows 데이터 삭제
	    localStorage.removeItem('selectedMemRows');
	}; */
	

</script>

</head>

<body>
	<div id="wrapper">
		<%@ include file="../form/header.jsp" %>
		<%@ include file="../form/aside.jsp" %>
		<section>
			<div class="row" id="headerTag">
				/모임운영			
			</div>
			<div class="card">
				<div class="card-body">

					<!-- Default Tabs -->
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" id="member-tab"
								data-bs-toggle="tab" data-bs-target="#member" type="button"
								role="tab" aria-controls="member" aria-selected="true">참여인원관리</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="deposit-tab" data-bs-toggle="tab"
								data-bs-target="#deposit" type="button" role="tab"
								aria-controls="deposit" aria-selected="false">회비관리</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="game-tab" data-bs-toggle="tab"
								data-bs-target="#game" type="button" role="tab"
								aria-controls="game" aria-selected="false">게임관리</button>
						</li>
					</ul>
					
					<div class="tab-content pt-2" id="myTabContent">
						<!-- 회원 선택 시 보여야 할 항목들 -->
						<div class="tab-pane fade show active" id="member" role="tabpanel" aria-labelledby="home-tab">
							<div class="row text-left">
								<p>운동에 참여할 인원을 클릭하세요.</p>
							</div>
							<div class="row mt10">
								<div class="col-auto mt10">
									<label for="searchName" class="visually-hidden">searchName</label> <input
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
								<p id="selectedSpan">선택된 회원목록(총: <span id="memCnt"></span>명)</p>
							</div>
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
							<div class="row">
								<div class="col align-self-center" >
									<button class="btn btn-success saveBtn" id="saveBtn">저장하기</button>
								</div>
							</div>
						</div>
						<!-- 회원 선택 시 보여야 할 항목들 끝-->
						
						<!-- 회비 입금여부 확인 시 보여야 할 항목들-->
						<div class="tab-pane fade" id="deposit" role="tabpanel" aria-labelledby="game-tab">
							<div class="row">
								<p>회비 입금 여부를 확인하고 해당하는 버튼을 눌러주세요.</p>
							</div>
							<div class="row" id="depositDiv">
								<c:forEach items="${depositList }" var="item">
									<input type="hidden" name="${item.depositCategory }" value="${item.fee }">
								</c:forEach>
								<table class="table table-hover">
									<thead class="table-light">
										<tr>
											<th scope="col" width="6%">번호</th>
											<th scope="col" width="14%">이름</th>
											<th scope="col" width="80%">입금여부</th>
										</tr>
									</thead>
									<tbody id="depositList">
									
									</tbody>
								</table>
							</div>
							<div class="row justify-content-end">
								<div class="col-2" id="totalDepositLabelDiv">
									<label for="totalDeposit" class="col-form-label">회비 총액 : </label>
								</div>
								<div class="col-2" id="totalDepositDiv">
									<input type="text" name="totalDeposit" id="totalDeposit" class="form-control" value="0" readonly>&nbsp;원
								</div>
							</div>
							<div class="row">
								<div class="col align-self-center" >
									<button class="btn btn-success saveBtn" id="saveDepositBtn">저장하기</button>
								</div>
							</div>
						</div>
						<!-- 회비 입금여부 확인 시 보여야 할 항목들 끝-->
						
						<!-- 게임 설정 시 보여야 할 항목들 -->
						<div class="tab-pane fade" id="game" role="tabpanel" aria-labelledby="game-tab">
							<div class="row">
								<p>"⊕게임 생성" 버튼을 누른 후 게임을 구성할 인원을 4명 선택하세요.
									게임이 진행될 경우 진행여부를 클릭하세요.</p>
							</div>
							<div class="row" id="memoDiv">
								<textarea class="form-control" name="etcMemo" placeholder="기타 메모란 ex)홍길동 귀가"></textarea>
								<button class="btn btn-secondary" id="memoSaveBtn">메모 저장</button>
							</div>
							<div class="row">
								<div class="col-5" id="gameDiv">
									게임현황
									<table class="table" id="gameTable">
										<thead class="table-light">
											<tr>
												<th scope="col" width="10%">순서</th>
												<th scope="col" width="75%" colspan="4">인원</th>
												<th scope="col" width="15%">진행<br>여부</th>
											</tr>
										</thead>
										<tbody id="gameList">
											<tr id="setGame">
												<td colspan="6" id="gameSetTr">⊕게임 생성</td>
											</tr>
										</tbody>
									</table>
									<button class="btn btn-success" id="plusBtn" data-bs-toggle="modal" data-bs-target="#modal1">확대모드</button>
								</div>
								<div class="col-7" id="gameMemDiv">
									게임 참여 인원 현황
									<div class="row" id="memDiv">
										<div class="col">
											<table class="table" id="menTable">
												<thead class="table-light">
													<tr>
														<th scope="col" width="20%">번호</th>
														<th scope="col" width="40%">이름</th>
														<th scope="col" width="20%">급수</th>
														<th scope="col" width="20%">게임<br>횟수</th>
													</tr>
												</thead>
												<tbody id="menList">
												
												</tbody>
											</table>
										</div>
										<div class="col">
											<table class="table" id="womenTable">
												<thead class="table-light">
													<tr>
														<th scope="col" width="20%">번호</th>
														<th scope="col" width="40%">이름</th>
														<th scope="col" width="20%">급수</th>
														<th scope="col" width="20%">게임<br>횟수</th>
													</tr>
												</thead>
												<tbody id="womenList">
												
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col align-self-center">
									<button class="btn btn-success" id="endOperation">모임종료</button>
								</div>
							</div>
						</div>
						<!-- 게임 설정 시 보여야 할 항목들 끝-->
					</div>
					<!-- End Default Tabs -->

				</div>
			</div>
		</section>
		
		<!-- modal -->
		<div class="modal fade" id="modal1" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="staticBackdropLabel">게임 대기 순서 -- 자신의 게임 순서를 반드시 확인하세요.</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<table class="table" id="plusTable">
							<thead class="table-light">
								<tr>
									<th scope="col" width="10%">순서</th>
									<th scope="col" width="75%" colspan="4">인원</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../form/bottom2.jsp" %>
	</div>
</body>
<%@ include file="../form/bottom.jsp" %>