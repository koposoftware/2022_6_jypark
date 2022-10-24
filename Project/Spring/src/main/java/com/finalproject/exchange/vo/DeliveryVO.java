package com.finalproject.exchange.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class DeliveryVO {
    private String walletNo;
    private String ccyCode;
    private String reserveAmount;
    private String orderName;
    private String basicAddr;
    private String detailAddr;
    private String tel1;
    private String tel2;
    private String tel3;
    private String receiptDate;
}
