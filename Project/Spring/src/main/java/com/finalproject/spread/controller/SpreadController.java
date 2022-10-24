package com.finalproject.spread.controller;

import com.finalproject.spread.service.SpreadService;
import com.finalproject.spread.vo.SpreadVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SpreadController {
    @Autowired
    SpreadService spreadService;
    @GetMapping("getSpreadInfo")
    @ResponseBody
    public SpreadVO getSpreadInfo(String ccyCode) {
        SpreadVO spreadVO = spreadService.getSpreadInfo(ccyCode);
        return spreadVO;
    }
}
