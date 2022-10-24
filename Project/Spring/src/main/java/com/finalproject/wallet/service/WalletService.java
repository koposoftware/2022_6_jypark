package com.finalproject.wallet.service;

import com.finalproject.exchange.vo.ExcRateVO;
import com.finalproject.spread.mapper.SpreadMapper;
import com.finalproject.spread.service.SpreadService;
import com.finalproject.spread.vo.SpreadVO;
import com.finalproject.transfer.mapper.TransferMapper;
import com.finalproject.wallet.mapper.WalletMapper;
import com.finalproject.wallet.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

@Service
public class WalletService {
    @Autowired
    WalletMapper walletMapper;
    @Autowired
    TransferMapper transferMapper;
    @Autowired
    SpreadMapper spreadMapper;
    @Autowired
    SpreadService spreadService;

    public void openWallet(String accountNo, String id, int branchCode) {
        WalletVO walletVO = new WalletVO();
        int randomCode = new Random().nextInt(100000000);
        String walletNo = "4" + String.format("%03d", branchCode) + String.format("%08d", randomCode) + "08";
        walletVO.setWalletNo(walletNo);
        walletVO.setAccountNo(accountNo);
        walletVO.setId(id);
        walletMapper.insertWallet(walletVO);
    }

    public List<WalletAccountVO> getWalletJoinInfo(String loginId) {
        List<WalletAccountVO> walletAccountList = walletMapper.selectWalletJoinPassbook(loginId);
        return walletAccountList;
    }
    /**
     * 지갑이 가지고 있는 보유통화 목록 조회
     *
     * @param walletNo 지갑번호
     * @return 보유중인 통화 리스트
     */
    public List<HoldCurrencyVO> getHoldCurrency(String walletNo) {
        System.out.println(walletNo);
        List<HoldCurrencyVO> holdCurrencyList = walletMapper.selectHoldCurrencyById(walletNo);
        List<SpreadVO> spreadList = spreadMapper.selectSpread();
        for (HoldCurrencyVO holdCurrencyVO : holdCurrencyList) {
            for (SpreadVO spreadVO : spreadList) {
                if (holdCurrencyVO.getCcyCode().equals(spreadVO.getCcyCode())) {
                    holdCurrencyVO.setContryKrNm(spreadVO.getCntryNmKr());
                }
            }
        }
        return holdCurrencyList;
    }

    /**
     * 미화환산율 계산
     *
     * @param holdCurrencyList 보유중인 환율정보 리스트
     * @param excRateList      실시간 환율정보 리스트
     * @return 계산된 미화환산율통합
     */
    public float usdConversion(List<HoldCurrencyVO> holdCurrencyList, List<ExcRateVO> excRateList) {
        float usdTotal = 0;
        for (HoldCurrencyVO holdCurrency : holdCurrencyList) {
            for (ExcRateVO excRateVO : excRateList) {
                if (holdCurrency.getCcyCode().equals(excRateVO.getCcyCode()) && holdCurrency.getCcyCode().equals("JPY")) {
                    usdTotal += holdCurrency.getBalance() * excRateVO.getUsdRate() / 100;
                }
                if (holdCurrency.getCcyCode().equals(excRateVO.getCcyCode()) && !holdCurrency.getCcyCode().equals("JPY")) {
                    usdTotal += holdCurrency.getBalance() * excRateVO.getUsdRate();
                }
            }
        }
        return usdTotal;
    }
}