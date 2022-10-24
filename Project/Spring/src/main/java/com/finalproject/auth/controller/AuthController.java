package com.finalproject.auth.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {
    @PostMapping("loginSessionTime")
    @ResponseBody
    public long postSessionTime(HttpSession session) {
        long time = System.currentTimeMillis();
        return 1800 - (time - session.getCreationTime())/1000;
    }
}
