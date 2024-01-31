package com.mcn.MacChaeNeng.person.model;


import java.util.Date;

import lombok.Data;

@Data
public class PersonVO {
	private int userNum;
	private String id;
	private String pw;
	private String name;
	private Date birth;
	private String gender;
	private String address;
	private String type;
	private int weight;
	private String hp;
	private String email;
	private String comments;
	private String authority;
	private Date joinDate;
}

