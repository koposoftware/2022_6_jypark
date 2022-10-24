package com.finalproject.wallet.controller;

import com.finalproject.account.service.AccountService;
import com.finalproject.account.vo.AccountVO;
import com.finalproject.exchange.service.ExchangeService;
import com.finalproject.exchange.vo.ExcRateVO;
import com.finalproject.member.vo.MemberVO;
import com.finalproject.spread.service.SpreadService;
import com.finalproject.wallet.service.WalletService;
import com.finalproject.wallet.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class WalletController {
    @Autowired
    WalletService walletService;
    @Autowired
    AccountService accountService;
    @Autowired
    SpreadService spreadService;
    @Autowired
    ExchangeService exchangeService;

    /**
     * 고객의 지갑정보를 가져옴
     * @param model
     * @param session
     * @return
     */
    @GetMapping("walletInfo")
    public String getWalletInfoView(Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
        String id = loginMember.getId();

        List<AccountVO> accountList = accountService.getAccountList(id);
        List<WalletAccountVO> walletAccountList = walletService.getWalletJoinInfo(id);
        for(WalletAccountVO walletAccountVO : walletAccountList) {
            for(AccountVO accountVO : accountList) {
                if(walletAccountVO.getAccountNo().equals(accountVO.getAccountNo().replaceAll("-", ""))) {
                    walletAccountVO.setAccountAlias(accountVO.getAlias());
                }
            }
        }
        model.addAttribute("walletAccountList", walletAccountList);
        model.addAttribute("accountList", accountList);
        return "views/walletInfoView";
    }

    @ResponseBody
    @PostMapping("getHoldCurrency")
    public List<HoldCurrencyVO> getHoldCurrency(String walletNo){
        List<HoldCurrencyVO> holdCurrencyList = walletService.getHoldCurrency(walletNo);
        List<ExcRateVO> excRateList = exchangeService.crawlingExchangeRate();
        if(holdCurrencyList.size() != 0) {
            float usdTotal = walletService.usdConversion(holdCurrencyList, excRateList);
            holdCurrencyList.get(0).setUsdTotal(usdTotal);
        }
        return holdCurrencyList;
    }
}
