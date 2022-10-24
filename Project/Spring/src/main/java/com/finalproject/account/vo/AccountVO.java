package com.finalproject.account.vo;

import com.finalproject.member.vo.MemberVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter @Setter
@ToString
public class AccountVO {
    private String accountNo;
    private String password;
    private String ownerId;
    private List<MemberVO> prtcpList;
    private String alias;
    private String openDate;
    private int balance;
    private char exResStatus;
}