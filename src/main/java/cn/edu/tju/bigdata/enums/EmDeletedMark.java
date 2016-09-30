package cn.edu.tju.bigdata.enums;

public enum EmDeletedMark {

    VALID(1, "有效"),
    TO_BE_AUDITED(2, "待审核"),
    REJECTED(3, "审核未通过"),
    INVALID(0, "无效"),;
    
    private int code;

    private String value;

    EmDeletedMark(int code, String value) {
        this.code = code;
        this.value = value;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}