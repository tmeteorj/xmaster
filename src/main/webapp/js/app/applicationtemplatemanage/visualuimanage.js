
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
            colkey: "info",
            name: "可视化界面"
        }, {
            colkey: "typeid",
            name: "可视化类型"
        }, {
            colkey: "datasetids",
            name: "使用数据库"
        }, {
            colkey: "config",
            name: "可视化配置"
        },{
            colkey: "methodid",
            name: "可视化方法"
        }, {
            colkey: "operatorconfigid",
            name: "可视化使用算子"
        }, {
            colkey: "remark",
            name: "备注"
        },{
            colkey: "meta_created",
            name: "创建时间",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
            }
        }],
        jsonUrl: rootPath + '/visual/findvisualuiByPage.shtml',
        checkbox: true
    });

    $("#search").click("click", function () {// 绑定查询按扭
        var searchParams = $("#searchForm").serializeJson();
        grid.setOptions({
            data: searchParams
        });
    });
    $("#viewFun").click("click", function () {
        viewFun();
    });


});


function viewFun() {
    var cbox = grid.getSelectedCheckbox();
    if (cbox.length > 1 || cbox == "") {
        layer.msg("只能选中一个");
        return;
    }
    var tb = $("#loadhtml");
    tb.html(CommnUtil.loadingImg());
    tb.load(rootPath + '/visual/' + cbox + '/showconfig.shtml');
}