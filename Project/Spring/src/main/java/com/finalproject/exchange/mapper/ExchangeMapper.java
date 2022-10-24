package com.finalproject.exchange.mapper;

import com.finalproject.exchange.vo.ExcRateVO;
import com.finalproject.exchange.vo.ExcReservationVO;
import com.finalproject.exchange.vo.ExchangeHistoryVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ExchangeMapper {
    List<ExcRateVO> selectExcRateByccyCode(String ccyCode, String nowDate);
    void callExchangeProcedure(ExchangeHistoryVO exchangeHistoryVO);
    List<ExchangeHistoryVO> selectExcHistory(String walletNo, String ccyCode);
    List<ExchangeHistoryVO> selectExcHistoryByNo(String walletNo);
    void insertExcReservation(ExcReservationVO excReservationVO);
    List<ExcReservationVO> selectExcReservationByWalletNo(String walletNo);
    List<ExcReservationVO> selectExcReservationAll();
    void updateExcReservationState(ExcReservationVO excReservationVO);
    void updateExcExchangeAmount(ExcReservationVO excReservationVO);
    void updateExcHistoryState(String ccyCode, String walletNo);
    void deleteHoldCurrency(String ccyCode, String walletNo);
}
