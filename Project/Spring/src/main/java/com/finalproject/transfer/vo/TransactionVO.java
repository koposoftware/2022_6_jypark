package com.finalproject.transfer.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class TransactionVO {
    private int historyNo;              // 거래식별번호
    private String accountNo;           // 거래계좌번호
    private int transferAmount;         // 거래금액
    private int balance;                // 거래 후 잔액
    private String transferMemo;        // 거래메모
    private String transferDate;        // 거래일자
    private String transferType;        // 거래구분
}