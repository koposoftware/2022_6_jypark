package com.finalproject.wallet.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 지갑과 연결 통장 정보 VO
 */
@Getter @Setter
@ToString
public class WalletAccountVO {
    private String walletNo;        // 지갑번호
    private String accountNo;       // 통장번호
    private String accountAlias;    // 통장별칭
    private String id;              // 지갑소유주 ID
}
