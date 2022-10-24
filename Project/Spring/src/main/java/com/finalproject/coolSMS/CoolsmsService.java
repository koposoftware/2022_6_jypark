package com.finalproject.coolSMS;

import com.finalproject.exchange.vo.ExcReservationVO;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import java.util.HashMap;
@Service
public class CoolsmsService {
    public void sendOne(String phoneNum, ExcReservationVO excReservationVO, float buyExcRate, int buyAmount) {
        String api_key = "api_key";
        String api_secret = "secret_key";
        Message coolsms = new Message(api_key, api_secret);

        String text = "<환전원큐>\n" + "[" + excReservationVO.getReservationNo() + "] 환전완료\n" + "적용환율[" + String.format("%.2f", buyExcRate) + "] 구매량[" + buyAmount + "]";

        // 4 params(to, from, type, text) are mandatory. must be filled
        HashMap<String, String> params = new HashMap<String, String>();
        params.put("to", phoneNum); // 수신번호
        params.put("from", "발신번호"); // 발신번호
        params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
        params.put("text", text); // 문자내용

        try {
            JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
    }
}
