package com.finalproject.travel.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class PlanVO {
    private String accountNo;       // 계좌번호
    private String countryCode;     // ISO국가코드2자리
    private String departureDate;   // 출국예정일
    private String entryDate;       // 입국예정일
    private int targetAmount;       // 목표금액
    private int prtcpMemberNum;     // 여행참여인원수
}
