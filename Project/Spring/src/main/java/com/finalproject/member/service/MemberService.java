package com.finalproject.member.service;

import com.finalproject.member.mapper.MemberMapper;
import com.finalproject.member.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
    @Autowired
    private MemberMapper memberMapper;

    public MemberVO login(MemberVO memberVO) {
        MemberVO loginMember = memberMapper.selectMemberByIdPassword(memberVO);
        return loginMember;
    }

    /**
     * 회원가입
     * @param memberVO
     */
    public void register(MemberVO memberVO) {
        memberMapper.insertMember(memberVO);
    }
}
