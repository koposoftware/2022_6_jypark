package com.finalproject.exchange.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 환전내역 vo
 */
@Getter @Setter
@ToString
public class ExchangeHistoryVO {
    private String historyNo;           // 환전신청번호
    private String walletNo;            // 지갑번호
    private String exchangeDate;        // 환전일시
    private String sellCcyCode;         // 매도통화코드
    private int sellAmount;             // 매도금액
    private String buyCcyCode;          // 매수통화코드
    private int buyAmount;              // 매수금액
    private float applyExchangeRate;    // 적용환율
    private int eventSpreadRate;        // 우대율
    private String state;               // 거래상태
    private String id;                  // 거래자ID
}
