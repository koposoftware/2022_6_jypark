package com.finalproject.wallet.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class WalletVO {
    private String walletNo;      // 지갑번호
    private String accountNo;     // 계좌번호
    private String id;            // 계좌 소유주 아이디
}
