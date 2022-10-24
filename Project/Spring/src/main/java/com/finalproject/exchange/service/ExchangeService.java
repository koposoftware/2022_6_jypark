package com.finalproject.exchange.service;

import com.finalproject.account.mapper.AccountMapper;
import com.finalproject.account.vo.AccountVO;
import com.finalproject.coolSMS.CoolsmsService;
import com.finalproject.exchange.mapper.ExchangeMapper;
import com.finalproject.exchange.vo.ExcRateVO;
import com.finalproject.exchange.vo.ExcReservationVO;
import com.finalproject.exchange.vo.ExchangeHistoryVO;
import com.finalproject.member.service.MemberService;
import com.finalproject.member.vo.MemberVO;
import com.finalproject.spread.mapper.SpreadMapper;
import com.finalproject.spread.vo.SpreadVO;
import com.finalproject.transfer.mapper.TransferMapper;
import com.finalproject.transfer.vo.TransactionVO;
import com.finalproject.wallet.mapper.WalletMapper;
import com.finalproject.wallet.service.WalletService;
import com.finalproject.wallet.vo.HoldCurrencyVO;
import com.finalproject.wallet.vo.WalletVO;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Service
public class ExchangeService {
    @Autowired
    ExchangeMapper exchangeMapper;
    @Autowired
    TransferMapper transferMapper;
    @Autowired
    SpreadMapper spreadMapper;
    @Autowired
    WalletService walletService;
    @Autowired
    WalletMapper walletMapper;
    @Autowired
    AccountMapper accountMapper;
    @Autowired
    CoolsmsService coolsmsService;

    public List<ExcRateVO> getExcRate(String ccyCode, String nowDate) {
        List<ExcRateVO> excRateVOList = exchangeMapper.selectExcRateByccyCode(ccyCode, nowDate);
        return excRateVOList;
    }

    public List<ExcRateVO> crawlingExchangeRate() {
        String[] ccyName = {"달러", "유로", "엔", "위안", "달러", "달러", "파운드", "리알", "달러", "프랑",
                "크로나", "달러", "달러", "코루나", "페소", "리라", "투그릭", "세켈", "크로네", "크로네",
                "리얄", "디나르", "디나르", "디르함", "디나르", "파운드", "바트", "달러", "링깃", "루피아",
                "리얄", "텡게", "달러", "루피", "루피", "타카", "페소", "페소", "레알", "동",
                "랜드", "루블", "포린트", "즈워티", "루피", "디나르", "실링", "페소", "실링", "루피",
                "레우", "디나르", "파타카", "짯", "비르", "숨", "리엘", "피지 달러"};
        String url = "https://finance.naver.com/marketindex/exchangeList.nhn";
        Document doc = null;
        try {
            doc = Jsoup.connect(url).get();
            LocalDate date = LocalDate.now();
            LocalTime time = LocalTime.now();
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            String nowDate = date.format(dateTimeFormatter);
            dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
            String nowTime = time.format(dateTimeFormatter);
            String renewalRate = nowDate + " " + nowTime;

            Elements country = doc.select(".tit");
            List<ExcRateVO> excRateList = new ArrayList<>();

            for (int i = 0; i < country.size(); i++) {
                Element c_cntryCCY = country.get(i);
                Elements c_basicRate = doc.select("body > div > table > tbody > tr:nth-child(" + (i + 1) + ") > td:nth-child(2)");
                Elements c_buyExcRate = doc.select("body > div > table > tbody > tr:nth-child(" + (i + 1) + ") > td:nth-child(3)");
                Elements c_sellExcRate = doc.select("body > div > table > tbody > tr:nth-child(" + (i + 1) + ") > td:nth-child(4)");
                Elements c_sendExcRate = doc.select("body > div > table > tbody > tr:nth-child(" + (i + 1) + ") > td:nth-child(5)");
                Elements c_recExcRate = doc.select("body > div > table > tbody > tr:nth-child(" + (i + 1) + ") > td:nth-child(6)");
                Elements c_usdRate = doc.select("body > div > table > tbody > tr:nth-child(" + (i + 1) + ") > td:nth-child(7)");
                String cntryCCY = c_cntryCCY.text();
                String ccyCode;
                String cntryKrNm;
                if (cntryCCY.substring(0, cntryCCY.indexOf(" ")).equals("남아프리카")) {
                    ccyCode = cntryCCY.substring(10, 13);
                    cntryKrNm = cntryCCY.substring(0, 9);
                } else {
                    ccyCode = cntryCCY.substring(cntryCCY.indexOf(" ") + 1, cntryCCY.indexOf(" ") + 4);
                    cntryKrNm = cntryCCY.substring(0, cntryCCY.indexOf(" "));
                }
                String basicRate = c_basicRate.text();
                if (basicRate.equals("N/A"))
                    basicRate = "0";
                basicRate = basicRate.replace(",", "");
                String buyExcRate = c_buyExcRate.text();
                if (buyExcRate.equals("N/A"))
                    buyExcRate = "0";
                buyExcRate = buyExcRate.replace(",", "");
                String sellExcRate = c_sellExcRate.text();
                if (sellExcRate.equals("N/A"))
                    sellExcRate = "0";
                sellExcRate = sellExcRate.replace(",", "");
                String sendExcRate = c_sendExcRate.text();
                if (sendExcRate.equals("N/A"))
                    sendExcRate = "0";
                sendExcRate = sendExcRate.replace(",", "");
                String recExcRate = c_recExcRate.text();
                if (recExcRate.equals("N/A"))
                    recExcRate = "0";
                recExcRate = recExcRate.replace(",", "");
                String usdRate = c_usdRate.text();
                if (usdRate.equals("N/A"))
                    usdRate = "0";
                usdRate = usdRate.replace(",", "");
                ExcRateVO excRateVO = new ExcRateVO(ccyCode, ccyName[i], cntryKrNm, renewalRate, Float.parseFloat(buyExcRate), Float.parseFloat(sellExcRate), Float.parseFloat(sendExcRate), Float.parseFloat(recExcRate), Float.parseFloat(basicRate), Float.parseFloat(usdRate));
                excRateList.add(excRateVO);
            }
            return excRateList;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public void exchangeProcess(ExchangeHistoryVO exchangeHistoryVO, TransactionVO transactionVO) {
        String historyNo = "0996" + exchangeHistoryVO.getBuyCcyCode() + "22";
        int randomCode = new Random().nextInt(1000000);
        historyNo += String.format("%06d", randomCode);
        exchangeHistoryVO.setHistoryNo(historyNo);
        exchangeMapper.callExchangeProcedure(exchangeHistoryVO);

        if (exchangeHistoryVO.getSellCcyCode().equals("KRW")) {
            transactionVO.setTransferAmount(exchangeHistoryVO.getSellAmount());
            if (transactionVO.getTransferMemo() == null) {
                transactionVO.setTransferMemo("환전지갑신청(" + historyNo + ")");
            }
            transactionVO.setTransferType("W");
            transferMapper.callTransferProcedure(transactionVO);
        } else {
            transactionVO.setTransferAmount(exchangeHistoryVO.getBuyAmount());
            if (transactionVO.getTransferMemo() == null) {
                transactionVO.setTransferMemo("환전지갑 재환전(" + historyNo + ")");
            }
            transactionVO.setTransferType("D");
            transferMapper.callTransferProcedure(transactionVO);
        }
    }

    public List<ExchangeHistoryVO> getExcHistory(String walletNo) {
        List<ExchangeHistoryVO> exchangeHistoryList = exchangeMapper.selectExcHistoryByNo(walletNo);
        return exchangeHistoryList;
    }

    /**
     * 차익 계산
     *
     * @param walletNo 지갑번호
     * @param ccyCode  통화번호
     * @return 차익(퍼센트)
     */
    public List<Float> calculateYield(String walletNo, String ccyCode) {
        // 거래내역
        List<ExchangeHistoryVO> exchangeHistoryList = exchangeMapper.selectExcHistory(walletNo, ccyCode);
        // 실시간환율
        List<ExcRateVO> excRateList = crawlingExchangeRate();
        //스프레드
        SpreadVO spreadVO = spreadMapper.selectSpreadByCcyCode(ccyCode);
        // 매매 기준율
        float basicRate = 0;
        for (ExcRateVO excRateVO : excRateList) {
            if (ccyCode.equals(excRateVO.getCcyCode()))
                basicRate = excRateVO.getBasicRate();
        }
        float eventSpread = (float) (1.75 * (100 - spreadVO.getEventSpreadRate()) / 100 * basicRate / 100);
        // 팔때 금액
        float excSellRate = basicRate - eventSpread;
        // 통화 구매 총금액(원화)
        float totalAmount = 0;
        // 통화 구매 총 수량
        float totalCount = 0;
        for (ExchangeHistoryVO exchangeHistoryVO : exchangeHistoryList) {
            if (exchangeHistoryVO.getState().equals("D")) {
                totalAmount += exchangeHistoryVO.getApplyExchangeRate() * exchangeHistoryVO.getBuyAmount();
                totalCount += exchangeHistoryVO.getBuyAmount();
            }
        }
        float avgExcRate = totalAmount / totalCount;
        float resultPer = (excSellRate - avgExcRate) / avgExcRate * 100;
        List<Float> resultList = new ArrayList<>();
        resultList.add(resultPer);
        resultList.add(excSellRate - avgExcRate);
        return resultList;
    }

    public void setExcHistory(ExchangeHistoryVO exchangeHistoryVO) {
        SpreadVO spreadVO = spreadMapper.selectSpreadByCcyCode(exchangeHistoryVO.getSellCcyCode());
        int eventSpreadRate = spreadVO.getEventSpreadRate();
        String sellContryKrNm = spreadVO.getCntryNmKr();
        exchangeHistoryVO.setEventSpreadRate(eventSpreadRate);
        exchangeHistoryVO.setBuyCcyCode(sellContryKrNm);

        String ccyCode = exchangeHistoryVO.getSellCcyCode();

        int sellAmount = 0;
        List<HoldCurrencyVO> holdCurrencyList = walletService.getHoldCurrency(exchangeHistoryVO.getWalletNo());
        for (HoldCurrencyVO holdCurrencyVO : holdCurrencyList) {
            if (holdCurrencyVO.getCcyCode().equals(exchangeHistoryVO.getSellCcyCode())) {
                sellAmount = holdCurrencyVO.getBalance();
            }
        }
        exchangeHistoryVO.setSellAmount(sellAmount);
        float sellExchangeRate = calculateSellExcRate(ccyCode);
        exchangeHistoryVO.setApplyExchangeRate(sellExchangeRate);
        float buyAmount = 0;
        if (exchangeHistoryVO.getSellCcyCode().equals("JPY")) {
            buyAmount = sellAmount * sellExchangeRate / 100;
        } else {
            buyAmount = sellAmount * sellExchangeRate;
        }
        exchangeHistoryVO.setBuyAmount((int) buyAmount);
    }

    public ExcReservationVO setExcReservation(ExcReservationVO excReservationVO) {
        String reservationNo = "0995" + excReservationVO.getCcyCode() + "22";
        int randomCode = new Random().nextInt(1000000);
        reservationNo += String.format("%06d", randomCode);
        excReservationVO.setReservationNo(reservationNo);
        exchangeMapper.insertExcReservation(excReservationVO);
        return excReservationVO;
    }

    public List<ExcReservationVO> getReservationList(String walletNo) {
        List<ExcReservationVO> excReservationList = exchangeMapper.selectExcReservationByWalletNo(walletNo);
        return excReservationList;
    }

    /**
     * 2분마다 동작. 예약내역 확인후 구매시 환율보다 작은경우 거래 프로세스 실행
     */
    public void runSchduledExcReservation() {
        List<ExcReservationVO> excReservationList = exchangeMapper.selectExcReservationAll();
        if (excReservationList.size() == 0) {
            System.out.println("내역이 존재하지 않습니다.");
            return;
        }
        for (ExcReservationVO excReservationVO : excReservationList) {
            String ccyCode = excReservationList.get(0).getCcyCode();
            float targetBuyRate = excReservationVO.getTargetBuyRate();  // 구매목표환율
            float buyExcRate = calculateBuyExcRate(ccyCode);            // 실시간 우대율 적용 구매 환율
            if (targetBuyRate >= buyExcRate) {
                executeExcReserveProcess(excReservationVO, buyExcRate);
            }
        }
    }

    /**
     * 예약환전 진행 프로세스
     *
     * @param excReservationVO 예약정보VO
     * @param buyExcRate       우대율 적용 구매시 환율
     */
    public void executeExcReserveProcess(ExcReservationVO excReservationVO, float buyExcRate) {
        String accountNo = excReservationVO.getAccountNo();
        AccountVO accountVO = accountMapper.selectAccountByAccountNo(accountNo);
        int exchangeAmount = excReservationVO.getExchangeAmount();
        int remainAmount = excReservationVO.getTargetBuyAmount() - exchangeAmount; // 남은금액
        int buyAmount = 0;
        if (excReservationVO.getCcyCode().equals("JPY")) {
            buyAmount = (int) (accountVO.getBalance() / buyExcRate * 100);
            buyAmount = buyAmount / 100;
            buyAmount = buyAmount * 100;
            if(buyAmount < 100)
                return;
        } else {
            buyAmount = (int) (accountVO.getBalance() / buyExcRate);
        }
        System.out.println(buyAmount);
        if (buyAmount <= 0) {
            System.out.println("잔액부족");
            return;
        }
        if (buyAmount > remainAmount) {
            buyAmount = remainAmount;
            excReservationVO.setState("C");
        }
        int sellAmount = (int) (buyAmount * buyExcRate);
        if (excReservationVO.getCcyCode().equals("JPY")) {
            sellAmount = sellAmount / 100;
        }
        System.out.println(sellAmount);
        String walletNo = excReservationVO.getWalletNo();
        String buyCcyCode = excReservationVO.getCcyCode();
        TransactionVO transactionVO = new TransactionVO();
        transactionVO.setAccountNo(accountNo);
        transactionVO.setTransferMemo("환전예약신청(" + excReservationVO.getReservationNo() + ")");
        ExchangeHistoryVO exchangeHistoryVO = new ExchangeHistoryVO();
        exchangeHistoryVO.setWalletNo(walletNo);
        exchangeHistoryVO.setSellCcyCode("KRW");
        exchangeHistoryVO.setSellAmount(sellAmount);
        exchangeHistoryVO.setBuyCcyCode(buyCcyCode);
        exchangeHistoryVO.setBuyAmount(buyAmount);
        exchangeHistoryVO.setApplyExchangeRate(buyExcRate);
        exchangeHistoryVO.setId(accountVO.getOwnerId());

        exchangeProcess(exchangeHistoryVO, transactionVO);

        excReservationVO.setExchangeAmount(exchangeAmount + buyAmount);
        exchangeMapper.updateExcReservationState(excReservationVO);
        exchangeMapper.updateExcExchangeAmount(excReservationVO);

        WalletVO walletVO = walletMapper.selectWalletByWalletNo(walletNo);
        List<MemberVO> memberList = accountMapper.selectMemberByAccountNo(walletVO.getAccountNo());
//         지갑 멤버에게 smsqhsorl
//        for(MemberVO memberVO : memberList) {
//            coolsmsService.sendOne(memberVO.getTel(), excReservationVO, buyExcRate, buyAmount);
//        }
    }

    /**
     * 구매시 환율 계산
     *
     * @param ccyCode 통화코드
     * @return 우대율 적용 구매시 환율
     */
    public float calculateBuyExcRate(String ccyCode) {
        List<ExcRateVO> excRateList = crawlingExchangeRate();
        float basicRate = 0;
        for (ExcRateVO excRateVO : excRateList) {
            if (excRateVO.getCcyCode().equals(ccyCode)) {
                basicRate = excRateVO.getBasicRate();
            }
        }
        SpreadVO spread = spreadMapper.selectSpreadByCcyCode(ccyCode);
        int eventSpreadRate = spread.getEventSpreadRate();
        float buyExchangeRate = basicRate + (float) (1.75 * (100 - eventSpreadRate) / 100 * basicRate / 100);
        return buyExchangeRate;
    }

    /**
     * 판매시 환율 계산
     *
     * @param ccyCode 통화코드
     * @return 우대율 적용 판매시 환율
     */
    public float calculateSellExcRate(String ccyCode) {
        List<ExcRateVO> excRateList = crawlingExchangeRate();
        float basicRate = 0;
        for (ExcRateVO excRateVO : excRateList) {
            if (excRateVO.getCcyCode().equals(ccyCode)) {
                basicRate = excRateVO.getBasicRate();
            }
        }
        SpreadVO spread = spreadMapper.selectSpreadByCcyCode(ccyCode);
        int eventSpreadRate = spread.getEventSpreadRate();
        float sellExchangeRate = basicRate - (float) (1.75 * (100 - eventSpreadRate) / 100 * basicRate / 100);
        return sellExchangeRate;
    }

    public List<String> getDenomination(String ccyCode) {
        List<String> denominationList = new ArrayList<>();
        if (ccyCode.equals("USD")) {
            denominationList.add("100");
            denominationList.add("20");
            denominationList.add("10");
            denominationList.add("1");
        } else if (ccyCode.equals("JPY")) {
            denominationList.add("10000");
            denominationList.add("5000");
            denominationList.add("1000");
        } else if (ccyCode.equals("EUR")) {
            denominationList.add("100");
            denominationList.add("20");
            denominationList.add("10");
        }

        return denominationList;
    }

    public void changeHistoryState(String ccyCode, String walletNo) {
        exchangeMapper.updateExcHistoryState(ccyCode, walletNo);
    }

    public void removeHoldCurrency(String ccyCode, String walletNo) {
        exchangeMapper.deleteHoldCurrency(ccyCode, walletNo);
    }
}
