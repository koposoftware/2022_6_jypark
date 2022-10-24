package com.finalproject.transfer.mapper;

import com.finalproject.transfer.vo.TotalAmountVO;
import com.finalproject.transfer.vo.TransactionVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface TransferMapper {
    void callTransferProcedure(TransactionVO transactionVO);
    List<TransactionVO> selectTransByAccountNo(String accountNo, String startDate, String endDate);
    List<TransactionVO> selectTransByAccountNoOne(String accountNo, String startDate);
    List<TotalAmountVO> selectMemberTransfer(String accountNo);
}
