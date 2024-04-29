
//게임구성이 완료되면 localStorage에 저장
	function saveGame(tdElement) {
			
			let trElement = tdElement.parent();
			
			let tbody = trElement.parent();
			
			let cnt = 0;
			
			trElement.find('td').each(function() {
				if($(this).text() == 'Team'){
					cnt++;
				}
			});
			
			if(cnt < 1){
				let gameArr = [];
				
				tbody.find('tr[name=gameTr]').each(function() {
				
					
					$(this).find('td:not([name=state])').each(function() {
						let userNum = $('input[name=userNum]').val();
						let gender =$('input[name=gender]').val();
						let type =$('input[name=type]').val();
						let weight =$('input[name=weight]').val();
						let name = $(this).text();
						
						let mem = {
								userNum: userNum,
								name: name,
								gender: gender,
								type: type,
								weight: weight
						};
						
						gameArr.push(mem);
					});
				});
				
				localStorage.setItem('gameArr', JSON.stringify(gameArr));
			}
		}
		
//등급에 따른 점수 환산 함수
		function transPoint(gender, grade, weight) {
			
			let totalPoint = 0;
		    
		    if (gender == '남') {
		        switch (grade) {
		            case 'A ':
		                totalPoint = (weight == 3) ? 3 : 4;
		                break;
		            case 'B ':
		                totalPoint = (weight == 1) ? 4 : (weight == 2) ? 3 : 2;
		                break;
		            case 'C ':
		                totalPoint = (weight == 1) ? 3 : (weight == 2) ? 2 : 1;
		                break;
		            case 'D ':
		                totalPoint = (weight == 1) ? 2 : 1;
		                break;
		            default:
		                totalPoint = 0;
		        }
		    } else {
		        switch (grade) {
		            case 'A ':
		                totalPoint = (weight == 3) ? 2 : 3;
		                break;
		            case 'B ':
		                totalPoint = (weight == 1) ? 3 : (weight == 2) ? 2 : 1;
		                break;
		            case 'C ':
		                totalPoint = (weight == 1) ? 2 : (weight == 2) ? 1 : 0.5;
		                break;
		            case 'D ':
		                totalPoint = (weight == 1) ? 1 : 0.5;
		                break;
		            default:
		                totalPoint = 0;
		        }
		    }
		    
		    
		    return totalPoint;
		}