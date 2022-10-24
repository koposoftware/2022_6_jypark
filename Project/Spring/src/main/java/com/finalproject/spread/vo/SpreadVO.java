package com.finalproject.spread.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class SpreadVO {
    private String ccyCode;         // 통화코드
    private String cntryNmKr;       // 국가한글명
    private int basicSpreadRate;    // 기본우대율
    private int eventSpreadRate;    // 이벤트우대율
    private int exchangeMinAmount;  // 환전최소단위
    private int exchangeMinInput;   // 환전입력최소단위
    private String eventStartDate;  // 이벤트시작일
    private String eventEndDate;    // 이벤트종료일
}
