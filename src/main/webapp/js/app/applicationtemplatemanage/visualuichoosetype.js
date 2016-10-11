/**
 * Created by NING on 2016/10/10.
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
            name: "可视化类型"
        }, {
            colkey: "discription",
            name: "该类型描述"
        }, {
            colkey: "url",
            name: "该类型连接"
        }, {
            colkey: "meta_created",
            name: "创建时间",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
            }
        }],
        jsonUrl: rootPath + '/visual/findvisualtypeByPage.shtml',
        checkbox: true
    });


    $("#typec").bind("click", function () {
        createFun();
    });


});

function createFun() {
    var cbox = grid.getSelectedCheckbox();
    var td = $("#selecteddatasetid");
    var tdc = td.html();
    var tb = $("#loadhtml");
    tb.html(CommnUtil.loadingImg());
    tb.load(rootPath + '/visual/' + tdc.trim() + '/' + cbox + '/config.shtml');
}
