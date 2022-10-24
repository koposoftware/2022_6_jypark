package com.finalproject.member.controller;

import com.finalproject.account.service.AccountService;
import com.finalproject.account.vo.AccountVO;
import com.finalproject.member.service.MemberService;
import com.finalproject.member.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MemberController {
    @Autowired
    private MemberService memberService;
    @Autowired
    private AccountService accountService;

    @GetMapping("frame")
    public String getFrame() {
        return "frame";
    }

    @PostMapping("loginProcess")
    public String loginProcess(MemberVO memberVO, HttpSession session) {
        MemberVO loginMember = memberService.login(memberVO);

        if(loginMember == null) {
            return "redirect:/";
        }
        session.setAttribute("loginMember", loginMember);
        return "redirect:/account";
    }

    @GetMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    @PostMapping("registerProcess")
    public String registerProcess(MemberVO memberVO, HttpServletRequest req) {
        String email = req.getParameter("email");
        String basicAddr = req.getParameter("basicAddr");
        String detailAddr = req.getParameter("detailAddr");
        memberVO.setEmail(email);
        memberVO.setAddress(basicAddr + " " + detailAddr);

        memberService.register(memberVO);

        return "redirect:/";
    }
    @GetMapping("accountMember")
    public String getAccountMemberView(HttpSession session, Model model){
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        List<AccountVO> accountList = accountService.getAccountList(loginMember.getId());
        model.addAttribute("accountList", accountList);
        return "views/accountMemberView";
    }
}