package com.finalproject.mail.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class MailVO {
    private String address;
    private String title;
    private String message;
}
