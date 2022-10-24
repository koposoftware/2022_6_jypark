package com.finalproject.spread.service;

import com.finalproject.spread.mapper.SpreadMapper;
import com.finalproject.spread.vo.SpreadVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SpreadService {
    @Autowired
    SpreadMapper spreadMapper;
    public List<SpreadVO> getSpreadList() {
        List<SpreadVO> spreadList = spreadMapper.selectSpread();
        return spreadList;
    }

    public SpreadVO getSpreadInfo(String ccyCode) {
        SpreadVO spreadVO = spreadMapper.selectSpreadByCcyCode(ccyCode);
        return spreadVO;
    }
}
