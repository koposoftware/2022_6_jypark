package com.finalproject.spread.mapper;

import com.finalproject.spread.vo.SpreadVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SpreadMapper {
    List<SpreadVO> selectSpread();
    SpreadVO selectSpreadByCcyCode(String ccyCode);
}
