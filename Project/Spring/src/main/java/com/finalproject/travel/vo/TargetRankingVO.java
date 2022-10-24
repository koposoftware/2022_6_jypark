package com.finalproject.travel.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class TargetRankingVO {
    private int ranking;
    private String countryNm;
    private String countryKrNm;
    private int countMember;
}
