package com.finalproject.account.mapper;

import com.finalproject.account.vo.AccountVO;
import com.finalproject.member.vo.MemberVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AccountMapper {
    AccountVO selectAccountByAccountNo(String accountNo);
    void insertAccount(AccountVO accountVO);
    void insertPrtcpInfo(AccountVO accountVO);
    List<AccountVO> selectAccountById(String id);
    List<MemberVO> selectMemberByAccountNo(String accountNo);
    void insertPrtcpMember(String id, String accountNo);
}
