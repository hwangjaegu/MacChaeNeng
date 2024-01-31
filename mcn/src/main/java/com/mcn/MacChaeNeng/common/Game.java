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
김지영 C 여자
이승우 B 남자
박지은 D 여자
정민호 A 남자
송지현 C 여자
강승우 B 남자
윤가영 D 여자
백도훈 A 남자
임지원 C 여자
홍성민 B 남자
정다솔 A 여자
강태우 B 남자
신유진 C 여자
김태희 B 여자
이준호 D 남자
장서윤 A 여자
박승준 B 남자
한수빈 C 여자
	 */
	
	public static class  Person {
		String name;
		String grade;
		String gender;
		double detailGrade;
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
			p.gender = st.nextToken();
			
			int numGrade = 0; //급수별 점수
			double weight = 0.0; //성별 가중치
			
			//가중치 부여
			if(p.gender.equals("남자")) {
				weight = 1.0;
			}else {
				weight = 0.5;
			}
			
			//급수별 점수부여
			switch (p.grade) {
				case "A":
					numGrade = 4;
					break;
				case "B":
					numGrade = 3;
					break;
				case "C":
					numGrade = 2;
					break;
				case "D":
					numGrade = 1;
					break;
			}
			
			p.detailGrade = numGrade*weight;
			
			list.add(p);
		}
		
		for(Person p : list) {
			System.out.println("이름 = " + p.name + ", " + "가중치 = " + p.detailGrade);
		}
		
		Collections.shuffle(list);
		
		List<Person[]> pArrList = new ArrayList<>(); //pArr을 기억해서 저장할 list

		int dump = num%4;
		
		for(int i=0; i<list.size()-dump; i+=4) {
			Person[] pArr = new Person[4]; //한 게임에 4명씩 편성
			for(int j=0; j<pArr.length; j++) {
				
				pArr[j] = list.get(i+j);
			}
			pArrList.add(pArr);
		}
		
		//결과 출력
		System.out.println("게임 배정 인원");
		for(int i=0; i<pArrList.size(); i++) {
			for(int j=0; j<pArrList.get(i).length; j++) {
				System.out.print(pArrList.get(i)[j].name + " ");
			}
			
			System.out.println();
		}
		
		System.out.println("남은 인원");
		for(int i=list.size()-dump; i<list.size(); i++) {
			System.out.print(list.get(i).name + " ");
		}
		
	}

}
