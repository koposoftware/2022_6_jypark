package com.finalproject.travel.service;

import com.finalproject.exchange.service.ExchangeService;
import com.finalproject.exchange.vo.ExcRateVO;
import com.finalproject.travel.mapper.TravelMapper;
import com.finalproject.travel.vo.ContryCodeVO;
import com.finalproject.travel.vo.PlanVO;
import com.finalproject.travel.vo.TargetRankingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TravelService {
    @Autowired
    TravelMapper travelMapper;
    @Autowired
    ExchangeService exchangeService;

    public void setTravelPlan(PlanVO planVO) {
        planVO.setEntryDate(planVO.getDepartureDate().substring(13, 23));
        planVO.setDepartureDate(planVO.getDepartureDate().substring(0, 10));
        travelMapper.insertTravelPlan(planVO);
    }

    public PlanVO getTravelPlan(PlanVO planVO) {
        PlanVO plan = travelMapper.selectTravelPlan(planVO.getAccountNo());
        return plan;
    }

    public List<TargetRankingVO> getRankingOfTarget(){
        List<TargetRankingVO> targetRanking = travelMapper.countTargetCountry();
        List<ContryCodeVO> contryCodeList = travelMapper.selectContryCode();
        for(TargetRankingVO targetRankingVO : targetRanking) {
            for(ContryCodeVO contryCodeVO : contryCodeList) {
                if(targetRankingVO.getCountryNm().equals(contryCodeVO.getCountryCode())) {
                    targetRankingVO.setCountryKrNm(contryCodeVO.getCountryKrNm());
                }
            }
        }
        return targetRanking;
    }
    public List<ExcRateVO> getRankingOfExcRate() {
        List<ExcRateVO> excRateList = exchangeService.crawlingExchangeRate();
        excRateList = excRateList.stream().sorted(Comparator.comparing(ExcRateVO::getUsdRate)).collect(Collectors.toList());
        int index = 0;
        while (index < excRateList.size()) {
            if(excRateList.get(index).getUsdRate() < 0.6) {
                excRateList.remove(index);
                index = 0;
            } else {
                index ++;
            }
        }
        return excRateList;
    }
}
