package cn.edu.tju.bigdata.enums;

/**
 * Created by Administrator on 2016/11/21.
 */
public enum EmLayer {

    ACTION("行为"),
    AGENT("对象"),
    EVENT("事件"),
    PLACE("地块"),;

    private String value;

    EmLayer(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
