package com.finalproject.member.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter @Setter
@ToString
public class MemberVO {
    private String id;
    private String password;
    private String name;
    private String email;
    private String tel;
    private String address;
    private String regDate;
}
