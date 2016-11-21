package cn.edu.tju.bigdata.enums;

/**
 * Created by Administrator on 2016/11/21.
 */
public enum EmRetrievalType {

    SET(1, "集合"),
    RELATION(2, "关系"),
    INDIVIDUAL(3, "个体"),;

    private int code;

    private String value;

    EmRetrievalType(int code, String value) {
        this.code = code;
        this.value = value;
    }

    public static EmRetrievalType of(int code) {
        for (EmRetrievalType emRetrievalType : EmRetrievalType.values()) {
            if (emRetrievalType.getCode() == code) {
                return emRetrievalType;
            }
        }
        return null;
    }

    public int getCode() {
        return code;
    }

    public String getValue() {
        return value;
    }
}
