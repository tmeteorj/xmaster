/**
 * Created by NING on 2016/10/12.
 */
var pageii = null;
var grid = null;
$(function () {

    $("#operatorc").bind("click", function () {
        createFun();
    });


    $("#nooFun").click("click", function () {
        nooFun();
    });
});

function nooFun() {
    var td = $("#selectedoperatorid");
    td.text("0");
}

function createFun() {
    var td = $("#selectedoperatorid");
    var tdc = td.html();
    var td1 = $("#datasetids");
    var tdc1 = td1.html();
    var td2 = $("#typeid");
    var tdc2 = td2.html();
    var tb = $("#loadhtml");
    tb.html(CommnUtil.loadingImg());
    tb.load(rootPath + '/visual/' + tdc1.trim() + '/' + tdc2.trim() + '/' + tdc.trim() + '/config.shtml');
}