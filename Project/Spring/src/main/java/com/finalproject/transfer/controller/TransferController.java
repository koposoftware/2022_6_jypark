package com.finalproject.transfer.controller;

import com.finalproject.account.service.AccountService;
import com.finalproject.account.vo.AccountVO;
import com.finalproject.member.vo.MemberVO;
import com.finalproject.transfer.service.TransferService;
import com.finalproject.transfer.vo.TotalAmountVO;
import com.finalproject.transfer.vo.TransactionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TransferController {
    @Autowired
    private AccountService accountService;

    @Autowired
    private TransferService transferService;

    @GetMapping("transfer")
    public String getTransferForm(HttpSession session, Model model) {
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
        List<AccountVO> accountList = accountService.getAccountList(memberVO.getId());
        model.addAttribute("accountList", accountList);
        return "forms/transferForm";
    }

    @PostMapping("transferProcess")
    public String transferProcess(HttpServletRequest req) {
        TransactionVO withdrawTransaction = new TransactionVO();
        TransactionVO depositTransaction = new TransactionVO();
        withdrawTransaction.setAccountNo(req.getParameter("withdrawAccountNo"));
        withdrawTransaction.setTransferAmount(Integer.valueOf(req.getParameter("transferAmount")));
        withdrawTransaction.setTransferMemo(req.getParameter("withdrawTransMemo"));
        withdrawTransaction.setTransferType("W");
        depositTransaction.setAccountNo(req.getParameter("depositAccountNo"));
        depositTransaction.setTransferAmount(Integer.valueOf(req.getParameter("transferAmount")));
        depositTransaction.setTransferMemo(req.getParameter("depositTransMemo"));
        depositTransaction.setTransferType("D");
        transferService.writeTransferHistory(withdrawTransaction, depositTransaction);
        return "redirect:/account";
    }

    @GetMapping("transactionHistory")
    public String getAccountHistory(HttpSession session, Model model) {
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
        List<AccountVO> accountList = accountService.getAccountList(memberVO.getId());
        model.addAttribute("accountList", accountList);
        return "views/transationHistoryView";
    }

    @ResponseBody
    @GetMapping("transactionHistory/{accountNo}")
    public List<TransactionVO> getAlltransaction(@PathVariable("accountNo") String accountNo, HttpServletRequest req) {
        String date = req.getParameter("date");
        List<TransactionVO> transactionList = transferService.getTransactionList(accountNo, date);
        return transactionList;
    }

    @ResponseBody
    @PostMapping("getMemberDepositList")
    public List<TotalAmountVO> getMemberDepositList(HttpServletRequest req) {
        String accountNo = req.getParameter("accountNo");
        List<TotalAmountVO> totalAmountList = transferService.getMemberDepositList(accountNo);
        return totalAmountList;
    }
}
