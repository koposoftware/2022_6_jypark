package com.finalproject.wallet.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HoldCurrencyVO {
    private String walletNo;        // 지갑번호
    private String contryKrNm;      // 국가한글이름
    private String ccyCode;         // 통화코드
    private int balance;            // 보유금액
    private String receiptStatus;   // 수령 상태
    private float usdTotal;         // 미화변환총합
}
