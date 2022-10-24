package com.finalproject.exchange.vo;

import lombok.*;

@Getter @Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ExcRateVO {
    private String ccyCode;     //통화코드
    private String ccyKrName;   //통화단위
    private String cntryKrNm;   //국가한글이름
    private String renewalRate; //기준일시
    private float buyExcRate;   //구매시환율
    private float sellExcRate;  //판매시환율
    private float sendExcRate;  //송금보낼때환율
    private float recExcRate;   //송금받을때환율
    private float basicRate;    //매매기준율
    private float usdRate;      //미화환산율

    public ExcRateVO(String ccyCode, String renewalRate, float basicRate) {
        this.ccyCode = ccyCode;
        this.renewalRate = renewalRate;
        this.basicRate = basicRate;
    }
}
