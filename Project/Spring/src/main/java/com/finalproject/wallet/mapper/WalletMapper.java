package com.finalproject.wallet.mapper;

import com.finalproject.exchange.vo.ExcRateVO;
import com.finalproject.exchange.vo.ExcReservationVO;
import com.finalproject.exchange.vo.ExchangeHistoryVO;
import com.finalproject.wallet.vo.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface WalletMapper {
    WalletVO selectWalletByWalletNo(String walletNo);
    void insertWallet(WalletVO walletVO);
    List<WalletAccountVO> selectWalletJoinPassbook(String loginId);
    List<HoldCurrencyVO> selectHoldCurrencyById(String walletNo);
}
