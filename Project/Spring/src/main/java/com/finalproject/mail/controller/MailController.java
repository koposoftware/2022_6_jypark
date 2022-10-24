package com.finalproject.mail.controller;

import com.finalproject.mail.service.MailService;
import com.finalproject.mail.vo.MailVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MailController {
    @Autowired
    private MailService mailService;

    @GetMapping("/send")
    public String sendMail() {
        MailVO mailVO = new MailVO();
        mailVO.setAddress("pjy2958@naver.com");
        mailVO.setTitle("테스트에용");
        mailVO.setMessage("테스트입니당");
        mailService.sendMail(mailVO);
        return "redirect:/";
    }
}