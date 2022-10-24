package com.finalproject.exchange.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class ExcReservationVO {
    private String reservationNo;       // 예약번호
    private String accountNo;           // 출금계좌번호
    private String walletNo;            // 환전받을 지갑번호
    private String ccyCode;             // 환전할 통화코드
    private float targetBuyRate;        // 목표구매 환율
    private int targetBuyAmount;        // 목표구매 총 수량
    private int exchangeAmount;         // 현재까지 환전한 수량
    private String expirationDate;      // 예약 만료일
    private int eventSpread;            // 우대율
    private String alarm;               // 알람 수신여부  'Y': 알람수신   'N': 알람거부
    private String state;               // 환전상태 'D': 환전중  'C': 환전완료
}
