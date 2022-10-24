package com.finalproject.member.mapper;

import com.finalproject.member.vo.MemberVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
    void insertMember(MemberVO memberVO);
    MemberVO selectMemberByIdPassword(MemberVO memberVO);
}
