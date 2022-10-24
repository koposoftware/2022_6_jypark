package com.finalproject.travel.controller;

import com.finalproject.account.service.AccountService;
import com.finalproject.account.vo.AccountVO;
import com.finalproject.exchange.service.ExchangeService;
import com.finalproject.exchange.vo.ExcRateVO;
import com.finalproject.member.vo.MemberVO;
import com.finalproject.travel.service.TravelService;
import com.finalproject.travel.vo.PlanVO;
import com.finalproject.travel.vo.TargetRankingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class TravelController {
    @Autowired
    AccountService accountService;
    @Autowired
    TravelService travelService;

    @GetMapping("myTravelInfo")
    public String getTravelInfoView(HttpSession session, Model model) {
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
        List<AccountVO> accountList = accountService.getAccountList(memberVO.getId());
        model.addAttribute("accountList", accountList);
        return "views/myTravelInfoView";
    }

    @ResponseBody
    @PostMapping("travelPlanProcess")
    public void travelPlanProcess(PlanVO planVO) {
        travelService.setTravelPlan(planVO);
    }

    @ResponseBody
    @PostMapping("getTravelPlan")
    public PlanVO getTravelPlan(PlanVO planVO) {
        PlanVO plan = travelService.getTravelPlan(planVO);
        return plan;
    }

    @GetMapping("recommendTravel")
    public String getRecommendTravelView(Model model) {
        List<TargetRankingVO> targetRanking = travelService.getRankingOfTarget();
        List<ExcRateVO> excRateRanking = travelService.getRankingOfExcRate();
        model.addAttribute("targetRanking", targetRanking);
        model.addAttribute("excRateRanking", excRateRanking);
        return "views/recommendTravelView";
    }
}
