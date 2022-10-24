package com.finalproject.travel.mapper;

import com.finalproject.travel.vo.ContryCodeVO;
import com.finalproject.travel.vo.PlanVO;
import com.finalproject.travel.vo.TargetRankingVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TravelMapper {
    void insertTravelPlan(PlanVO planVO);
    PlanVO selectTravelPlan(String accountNo);
    List<TargetRankingVO> countTargetCountry();
    List<ContryCodeVO> selectContryCode();
}
