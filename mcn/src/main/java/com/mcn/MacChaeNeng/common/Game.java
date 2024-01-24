package com.mcn.MacChaeNeng.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import com.oracle.wls.shaded.org.apache.xalan.xsltc.compiler.sym;

public class Game {
	
	public static class  Person {
		String name;
		String grade;
		String gender;
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
			
			list.add(p);
		}
		
		Person[] pArr = new Person[4]; //한 게임에 4명씩 편성
		List<Person[]> pArrList = new ArrayList<>(); //pArr을 기억해서 저장할 list
		int[] intArr = new int[list.size()];
		int cnt = 0;
		
		while(num > 3) {
			for(int i=0; i<pArr.length; i++) {
				int setNum;
				//난수 중복없이 생성
				while(true) { 
					setNum = (int)(Math.random()*num); 
					int dub = 0;
					
					for(int j=0; j>intArr.length; j++) {
						if(intArr[j] == setNum) {
							dub++;
						}
					}
					
					if(dub > 0) {
						continue;
					}else {
						intArr[cnt] = setNum;
						cnt++;
						break;
					}
				}
				
				Person person = list.get(setNum);
				pArr[i] = person;
			}
			
			pArrList.add(pArr);
			num-=4;
		}
		
		System.out.println(pArrList.size());
		
		for(int k : intArr) {
			System.out.print(k + " ");
		}
		
		for(int i=0; i<pArrList.size(); i++) {
			Person[] pA = pArrList.get(i);
			for(int j=0; j<pA.length; j++) {
				System.out.print(pA[j].name + " ");
			}
			System.out.println();
		}
		
	}

}
