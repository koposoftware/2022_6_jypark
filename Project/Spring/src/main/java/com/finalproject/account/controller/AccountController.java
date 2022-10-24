package com.finalproject.account.controller;

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
public class AccountController {
    @Autowired
    private AccountService accountService;
    @Autowired
    private MemberService memberService;

    @GetMapping("account")
    public String getAccountView(Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        List<AccountVO> accountList = accountService.getAccountList(loginMember.getId());
        if(accountList == null) {
            return "forms/openAccountForm";
        }
        model.addAttribute("accountList", accountList);
        return "views/myAccountView";
    }

    @GetMapping("openAccount")
    public String getOpenAccountForm() {
        return "forms/openAccountForm";
    }

    // 통장 개설 및 환전지갑 생성
    @PostMapping("openAccountProcess")
    public String openPassbookProcess(HttpSession session, AccountVO accountVO) {
        if(accountVO.getAlias().equals("")) {
            accountVO.setAlias("모임통장");
        }
        // 모임통장 개설
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
        accountVO.setOwnerId(memberVO.getId());
        accountService.openAccount(accountVO);
        return "redirect:/account";
    }

    @GetMapping("joinAccount")
    public String getJoinAccountView(HttpServletRequest req, HttpSession session, Model model){
        String accountNo = req.getParameter("accountNo").replaceAll("-","");
        String ownerName = req.getParameter("name");
        model.addAttribute("accountNo", accountNo);
        model.addAttribute("ownerName", ownerName);
        return "views/joinAccountView";
    }

    @PostMapping("joinAccountProcess")
    public String joinAccountProcess(HttpServletRequest req, MemberVO memberVO, Model model) {
        MemberVO member = memberService.login(memberVO);
        if(member == null) {
            return "redirect:/";
        }
        String accountNo = req.getParameter("accountNo");
        accountService.joinAccount(member.getId(), accountNo);
        return "redirect:/certifySuccess";
    }

    @GetMapping("certifySuccess")
    public String getPrtcpSuccessView(){
        return "views/prtcpSuccessView";
    }
}