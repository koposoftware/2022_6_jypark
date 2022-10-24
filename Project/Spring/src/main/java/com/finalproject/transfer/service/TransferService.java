package com.finalproject.transfer.service;

import com.finalproject.transfer.mapper.TransferMapper;
import com.finalproject.transfer.vo.TotalAmountVO;
import com.finalproject.transfer.vo.TransactionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TransferService {
    @Autowired
    private TransferMapper transferMapper;

    public void writeTransferHistory(TransactionVO withdrawTransaction, TransactionVO depositTransaction){
        String newAccountNo = withdrawTransaction.getAccountNo().replaceAll("-", "");
        withdrawTransaction.setAccountNo(newAccountNo);
        transferMapper.callTransferProcedure(depositTransaction);
        transferMapper.callTransferProcedure(withdrawTransaction);
    }

    public List<TransactionVO> getTransactionList(String accountNo, String date) {
        String startDate = date.substring(0, 10);
        String endDate = date.substring(13,23);
        if(startDate.equals(endDate)) {
            List<TransactionVO> transactionList = transferMapper.selectTransByAccountNoOne(accountNo, startDate);
            return transactionList;
        }
        List<TransactionVO> transactionList = transferMapper.selectTransByAccountNo(accountNo, startDate, endDate);
        return transactionList;
    }

    public List<TotalAmountVO> getMemberDepositList(String accountNo) {
        List<TotalAmountVO> totalAmountList = transferMapper.selectMemberTransfer(accountNo);
        return totalAmountList;
    }
}