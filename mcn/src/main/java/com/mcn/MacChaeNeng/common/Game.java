package com.mcn.MacChaeNeng.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.StringTokenizer;

public class Game {
	/*
	 *게임 대입용 데이터 
김지영 C 2 여자
이승우 B 3 남자
박지은 D 1 여자
정민호 A 3 남자
송지현 C 2 여자
강승우 B 3 남자
윤가영 D 1 여자
백도훈 A 3 남자
임지원 C 2 여자
홍성민 B 3 남자
정다솔 A 3 여자
강태우 B 3 남자
신유진 C 2 여자
김태희 B 2 여자
이준호 D 1 남자
장서윤 A 3 여자
박승준 B 3 남자
한수빈 C 2 여자

	 */

	public static class  Person {
		String name;
		String grade;
		String gender;
		int dGrade;
		double detailGrade;
		boolean dub;
	}

	public static void main(String[] args) throws IOException {

		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		StringTokenizer st = new StringTokenizer(br.readLine());

		int num = Integer.parseInt(st.nextToken()); //참석 인원 수
		List<Person> list = new ArrayList<>(); //인원 수 만큼 사람 정보 입력(참석 인원 정보)

		for(int i=0; i<num; i++) {
			st = new StringTokenizer(br.readLine());

			Person p = new Person();

			p.name = st.nextToken();
			p.grade = st.nextToken();
			p.dGrade = Integer.parseInt(st.nextToken());
			p.gender = st.nextToken();
			p.dub = false;

			double bGrade = 0.0;

			//가중치 부여
			if(p.gender.equals("남자")) {
				switch (p.grade) {
				case "A":
					bGrade = (p.dGrade == 3)? 3:4;
					break;
				case "B":
					bGrade = (p.dGrade == 1)? 4:(p.dGrade == 2)? 3:2;
					break;
				case "C":
					bGrade = (p.dGrade == 1)? 3:(p.dGrade == 2)? 2:1;
					break;
				case "D":
					bGrade = (p.dGrade == 1)? 2:1;
					break;
				}

			}else {
				switch (p.grade) {
				case "A":
					bGrade = (p.dGrade == 3)? 2:3;
					break;
				case "B":
					bGrade = (p.dGrade == 1)? 3:(p.dGrade == 2)? 2:1;
					break;
				case "C":
					bGrade = (p.dGrade == 1)? 2:(p.dGrade == 2)? 1:0.5;
					break;
				case "D":
					bGrade = (p.dGrade == 1)? 1:0.5;
					break;
				}
			}

			p.detailGrade = bGrade;
			//급수별 점수부여

			list.add(p);
		}

		for(Person p : list) {
			System.out.println("이름 = " + p.name + ", " + "가중치 = " + p.detailGrade);
		}

		Collections.shuffle(list);

		List<Person[]> pArrList = new ArrayList<>(); //pArr을 기억해서 저장할 list

		int listSize = list.size();

		// 게임 팀 구성
		for (int i = 0; i < listSize - 3; i++) {
			Person[] team1 = new Person[2];
		    if (list.get(i).dub) {
		    	continue; // 이미 사용된 선수는 건너뜁니다.
		    }else {
		    	team1[0] = list.get(i);
		    }
		    
		    	
		    
		    for (int j = i + 1; j < listSize - 2; j++) {
		        if (list.get(j).dub) continue; // 이미 사용된 선수는 건너뜁니다.
		        
		        team1[1] = list.get(j);
		        
		        for (int k = j + 1; k < listSize - 1; k++) {
		            if (list.get(k).dub) continue; // 이미 사용된 선수는 건너뜁니다.
		            
		            Person[] team2 = new Person[2];
		            team2[0] = list.get(k);
		            
		            for (int m = k + 1; m < listSize; m++) {
		                if (list.get(m).dub) continue; // 이미 사용된 선수는 건너뜁니다.
		                
		                team2[1] = list.get(m);
		                
		                double team1Total = calculateTotal(team1);
		                double team2Total = calculateTotal(team2);
		                
		                if (Math.abs(team1Total - team2Total) <= 0.5) {
		                    pArrList.add(team1);
		                    pArrList.add(team2);
		                    
		                    list.get(i).dub = true;
		                    list.get(j).dub = true;
		                    list.get(k).dub = true;
		                    list.get(m).dub = true;
		                    
		                    break; // 새로운 팀을 찾았으므로 현재 루프 탈출
		                }
		            }
		        }
		    }
		}
		
		//결과 출력
		System.out.println("게임 배정 인원");
		for(int i=0; i<pArrList.size()-1; i+=2) {
			for(int j=0; j<pArrList.get(i).length; j++) {
				System.out.print(pArrList.get(i)[j].name + "("+ pArrList.get(i)[j].detailGrade +")");
				System.out.print(pArrList.get(i+1)[j].name + "("+ pArrList.get(i+1)[j].detailGrade +")");
			}

			System.out.println();
		}

		System.out.println("남은 인원");
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).dub == false) {
				System.out.print(list.get(i).name + " ");
			}
		}

	}

	// 팀의 detailGrade 합을 계산하는 메서드
	private static double calculateTotal(Person[] team) {
		double total = 0;
		for (Person person : team) {
			total += person.detailGrade;
		}
		return total;
	}

}
