/**
 * Created by NING on 2016/10/12.
 */
var pageii = null;
var grid = null;
$(function () {
    grid = lyGrid({
        id: 'paging',
        l_column: [{
            colkey: "id",
            name: "id",
            width: "50px",
            hide: true
        }, {
            colkey: "name",
            name: "算子名"
        }, {
            colkey: "discription",
            name: "算子描述"
        }, {
            colkey: "class",
            name: "算子所在类"
        }, {
            colkey: "method",
            name: "算子使用函数"
        },{
            colkey: "meta_created",
            name: "创建时间",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
            }
        }],
        jsonUrl: rootPath + '/visual/findoperatorByPage.shtml',
        checkbox: true
    });

    $("#operatorc").bind("click", function () {
        createFun();
    });


    $("#nooFun").click("click", function () {
        nooFun();
    });
});

function nooFun() {
    var td1 = $("#datasetids");
    var tdc1 = td1.html();
    var td2 = $("#typeid");
    var tdc2 = td2.html();
    var tb = $("#loadhtml");
    var cbox = grid.getSelectedCheckbox();
    tb.html(CommnUtil.loadingImg());
    tb.load(rootPath + '/visual/' + tdc1.trim() + '/' + tdc2.trim() + '/0/config.shtml');

}

function createFun() {
    var td = $("#selectedoperatorid");
    var cbox = grid.getSelectedCheckbox();
    td.text(cbox);
    var td1 = $("#datasetids");
    var tdc1 = td1.html();
    var td2 = $("#typeid");
    var tdc2 = td2.html();
    var tb = $("#loadhtml");
    var cbox = grid.getSelectedCheckbox();
    tb.html(CommnUtil.loadingImg());
    tb.load(rootPath + '/visual/' + tdc1.trim() + '/' + tdc2.trim() + '/' + cbox + '/operatorconfig.shtml');
}
