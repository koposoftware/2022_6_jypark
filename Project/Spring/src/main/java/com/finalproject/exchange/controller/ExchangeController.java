package com.finalproject.exchange.controller;

import com.finalproject.account.service.AccountService;
import com.finalproject.account.vo.AccountVO;
import com.finalproject.exchange.service.ExchangeService;
import com.finalproject.exchange.vo.DeliveryVO;
import com.finalproject.exchange.vo.ExcRateVO;
import com.finalproject.exchange.vo.ExcReservationVO;
import com.finalproject.exchange.vo.ExchangeHistoryVO;
import com.finalproject.member.vo.MemberVO;
import com.finalproject.spread.service.SpreadService;
import com.finalproject.spread.vo.SpreadVO;
import com.finalproject.transfer.vo.TransactionVO;
import com.finalproject.wallet.service.WalletService;
import com.finalproject.wallet.vo.HoldCurrencyVO;
import com.finalproject.wallet.vo.WalletAccountVO;
import com.finalproject.wallet.vo.WalletVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ExchangeController {
    @Autowired
    ExchangeService exchangeService;
    @Autowired
    SpreadService spreadService;
    @Autowired
    WalletService walletService;
    @Autowired
    AccountService accountService;

    @GetMapping("exchange")
    public String exchangeView(Model model) {
        List<SpreadVO> spreadList = spreadService.getSpreadList();
        model.addAttribute("spreadList", spreadList);
        return "views/exchangeView";
    }

    @GetMapping("exchangeRateInfo")
    public String getExchangeInfoView(Model model) {
        List<ExcRateVO> excRateList = crawlingExchangeRate();
        model.addAttribute("excRateList", excRateList);
        return "views/exchangeInfoView";
    }

    public List<ExcRateVO> crawlingExchangeRate() {
        List<ExcRateVO> excRateList = exchangeService.crawlingExchangeRate();
        return excRateList;
    }

    @GetMapping("getExcRate")
    @ResponseBody
    public List<ExcRateVO> getExcRateAjax(String ccyCode, String nowDate) {
        List<ExcRateVO> excRateList = exchangeService.getExcRate(ccyCode, nowDate);
        return excRateList;
    }

    @GetMapping("exchange/chooseCntry")
    public String getExchangeCntryForm(Model model, HttpSession session) {
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
        List<SpreadVO> spreadList = spreadService.getSpreadList();
        model.addAttribute("spreadList", spreadList);
        List<ExcRateVO> excRateList = exchangeService.crawlingExchangeRate();
        model.addAttribute("excRateList", excRateList);
        List<WalletAccountVO> walletAccountList = walletService.getWalletJoinInfo(memberVO.getId());
        List<AccountVO> accountList = accountService.getAccountList(memberVO.getId());

        for (WalletAccountVO walletAccountVO : walletAccountList) {
            for (AccountVO accountVO : accountList) {
                if (walletAccountVO.getAccountNo().equals(accountVO.getAccountNo().replaceAll("-", ""))) {
                    walletAccountVO.setAccountAlias(accountVO.getAlias());
                }
            }
        }
        model.addAttribute("accountList", accountList);
        model.addAttribute("walletAccountList", walletAccountList);
        return "forms/excChooseCntryForm";
    }

    @PostMapping("exchangeProcess")
    public String exchangeProcess(HttpSession session, ExchangeHistoryVO exchangeHistoryVO, TransactionVO transactionVO, RedirectAttributes re, String sellCntryKrNm, String buyCntryKrNm) {
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
        exchangeHistoryVO.setId(memberVO.getId());

        exchangeService.exchangeProcess(exchangeHistoryVO, transactionVO);
        re.addFlashAttribute("exchangeHistoryVO", exchangeHistoryVO);
        re.addFlashAttribute("sellCntryKrNm", sellCntryKrNm);
        re.addFlashAttribute("buyCntryKrNm", buyCntryKrNm);
        return "redirect:/exchange/exchangeComplete";
    }

    @GetMapping("exchange/exchangeComplete")
    public String getExchangeCompleteView(Model model) {
        ExchangeHistoryVO exchangeHistoryVO = (ExchangeHistoryVO) model.getAttribute("exchangeHistoryVO");
        String sellCntryKrNm = (String) model.getAttribute("sellCntryKrNm");
        String buyCntryKrNm = (String) model.getAttribute("buyCntryKrNm");
        model.addAttribute("exchangeHistoryVO", exchangeHistoryVO);
        model.addAttribute("sellCntryKrNm", sellCntryKrNm);
        model.addAttribute("buyCntryKrNm", buyCntryKrNm);
        return "views/exchangeCompleteView";
    }

    @ResponseBody
    @PostMapping("getExcHistory")
    public List<ExchangeHistoryVO> getExcHistory(String walletNo) {
        List<ExchangeHistoryVO> exchangeHistoryList = exchangeService.getExcHistory(walletNo);
        return exchangeHistoryList;
    }

    @ResponseBody
    @PostMapping("calculaterYield")
    public List<Float> calculaterYield(String walletNo, String ccyCode) {
        List<Float> resultList = exchangeService.calculateYield(walletNo, ccyCode);
        return resultList;
    }

    @ResponseBody
    @PostMapping("getHistoryData")
    public ExchangeHistoryVO getHistoryVO(ExchangeHistoryVO exchangeHistoryVO, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        exchangeHistoryVO.setId(loginMember.getId());
        exchangeService.setExcHistory(exchangeHistoryVO);
        return exchangeHistoryVO;
    }

    @GetMapping("excReservation")
    public String getExcReservationForm(Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        String id = loginMember.getId();
        List<WalletAccountVO> walletAccountList = walletService.getWalletJoinInfo(id);
        List<AccountVO> accountList = accountService.getAccountList(id);
        List<SpreadVO> spreadList = spreadService.getSpreadList();
        for (WalletAccountVO walletAccountVO : walletAccountList) {
            for (AccountVO accountVO : accountList) {
                if (walletAccountVO.getAccountNo().equals(accountVO.getAccountNo().replaceAll("-", ""))) {
                    walletAccountVO.setAccountAlias(accountVO.getAlias());
                }
            }
        }
        model.addAttribute("walletAccountList", walletAccountList);
        model.addAttribute("accountList", accountList);
        model.addAttribute("spreadList", spreadList);
        return "forms/excReservationForm";
    }

    @ResponseBody
    @PostMapping("getExcReservationList")
    public List<ExcReservationVO> getExcReservationList(String walletNo) {
        List<ExcReservationVO> excReservationList = exchangeService.getReservationList(walletNo);
        return excReservationList;
    }

    @PostMapping("excReservationProcess")
    public String excReservationProcess(ExcReservationVO excReservationVO, RedirectAttributes re) {
        excReservationVO = exchangeService.setExcReservation(excReservationVO);
        re.addFlashAttribute("excReservation", excReservationVO);
        return "redirect:/excReservationComplete";
    }

    @GetMapping("excReservationComplete")
    public String getExcReservationCompleteView(Model model) {
        ExcReservationVO excReservationVO = (ExcReservationVO) model.getAttribute("excReservation");
        SpreadVO spread = spreadService.getSpreadInfo(excReservationVO.getCcyCode());
        model.addAttribute("excReservation", excReservationVO);
        model.addAttribute("buyCntryKrNm", spread.getCntryNmKr());
        return "views/exchangeReservationCompleteView";
    }

    @PostMapping("postDeliveryForm")
    public String getCurrencyDeliveryForm(String walletNo, String ccyCode, Model model, HttpSession session) {
        List<String> denominationList = exchangeService.getDenomination(ccyCode);
        SpreadVO spreadVO = spreadService.getSpreadInfo(ccyCode);
        List<HoldCurrencyVO> holdCurrencyList = walletService.getHoldCurrency(walletNo);
        int balance = 0;
        for (HoldCurrencyVO holdCurrencyVO : holdCurrencyList) {
            if (holdCurrencyVO.getCcyCode().equals(ccyCode))
                balance = holdCurrencyVO.getBalance();
        }
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
        model.addAttribute("walletNo", walletNo);
        model.addAttribute("ccyCode", ccyCode);
        model.addAttribute("cntryKrNm", spreadVO.getCntryNmKr());
        model.addAttribute("balance", balance);
        model.addAttribute("member", memberVO);
        model.addAttribute("denominationList", denominationList);
        return "forms/currencyDeliveryForm";
    }

    @PostMapping("deliveryProcess")
    public String deliveryProcess(DeliveryVO deliveryVO, HttpSession session, Model model, RedirectAttributes re) {
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
        System.out.println(deliveryVO.toString());
        deliveryVO.setOrderName(memberVO.getName());
        String deliveryCcyCode = deliveryVO.getCcyCode();
        String ccyCode = deliveryCcyCode.substring(deliveryCcyCode.length() - 3, deliveryCcyCode.length());
        String walletNo = deliveryVO.getWalletNo();
        exchangeService.changeHistoryState(ccyCode, walletNo);
        exchangeService.removeHoldCurrency(ccyCode, walletNo);
        re.addFlashAttribute("delivery", deliveryVO);
        return "redirect:/deliveryComplete";
    }

    @GetMapping("deliveryComplete")
    public String getDeliveryCompleteView(Model model) {
        DeliveryVO deliveryVO = (DeliveryVO) model.getAttribute("delivery");
        model.addAttribute("delivery", deliveryVO);
        return "views/deliveryCompleteView";
    }

    @Scheduled(cron = "0 */2 * * * *")
    public void schedulerExcReservation() {
        exchangeService.runSchduledExcReservation();
    }
}
