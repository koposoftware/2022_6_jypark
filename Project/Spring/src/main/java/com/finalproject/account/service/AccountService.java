package com.finalproject.account.service;

import com.finalproject.account.mapper.AccountMapper;
import com.finalproject.account.vo.AccountVO;
import com.finalproject.member.vo.MemberVO;
import com.finalproject.wallet.service.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Service
public class AccountService {
    @Autowired
    private AccountMapper accountMapper;
    @Autowired
    private WalletService walletService;

    /**
     * 계좌개설
     * @param accountVO
     */
    public void openAccount(AccountVO accountVO){
        String accountNo = "";
        int branchCode = new Random().nextInt(800);
        int randomCode = new Random().nextInt(100000000);
        accountNo += "4" + String.format("%03d", branchCode) + String.format("%08d", randomCode) + "09";
        accountVO.setAccountNo(accountNo);
        accountMapper.insertAccount(accountVO);
        addPrtcpInfo(accountVO);

        walletService.openWallet(accountVO.getAccountNo(), accountVO.getOwnerId(), branchCode);
    };

    /**
     * 참여자-통장 매핑
     * @param accountVO
     */
    public void addPrtcpInfo(AccountVO accountVO){
        accountMapper.insertPrtcpInfo(accountVO);
    }

    /**
     * 해당 사용자의 계좌정보 리스트
     * @param id
     * @return
     */
    public List<AccountVO> getAccountList(String id) {
        List<AccountVO> accountList = accountMapper.selectAccountById(id);
        for(AccountVO account : accountList) {
            String accountNo = account.getAccountNo();
            account.setPrtcpList(getMemberList(accountNo));
            account.setAccountNo(accountNo.substring(0, 3) + "-" + accountNo.substring(3,9) + "-" + accountNo.substring(9, 14));
        }
        if(accountList.size() == 0){
            return null;
        }
        return accountList;
    }

    public List<MemberVO> getMemberList(String accountNo) {
        List<MemberVO> memberList = accountMapper.selectMemberByAccountNo(accountNo);
        return memberList;
    }

    public void joinAccount(String id, String accountNo) {
        accountMapper.insertPrtcpMember(id, accountNo);
    }
}
