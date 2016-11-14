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
            colkey: "yycsmc",
            name: "营业场所名称",
        }, {
            colkey: "dzqh",
            name: "营业场所地址区划"
        }, {
            colkey: "dz",
            name: "营业场所地址"
        }, {
            colkey: "swryxm",
            name: "上网人员姓名"
        }, {
            colkey: "zjlx",
            name: "证件类型"
        }, {
            colkey: "zjhm",
            name: "证件号码"
        }, {
            colkey: "swkssj",
            name: "上网开始时间",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
            }
        }, {
            colkey: "xwsj",
            name: "下网时间"
        }],
        jsonUrl: rootPath + '/wbsw/findByPage.shtml',
        checkbox: false
    });

    $("#search").click("click", function () {// 绑定查询按扭
        var searchParams = $("#searchForm").serializeJson();
        grid.setOptions({
            data: searchParams
        });
    });
});