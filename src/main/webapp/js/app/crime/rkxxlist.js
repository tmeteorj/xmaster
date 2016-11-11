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
            colkey: "GMSFHM",
            name: "身份证号",
            width: "200px"
        }, {
            colkey: "XM",
            name: "姓名",
            width: "100px"
        }, {
            colkey: "XBDM",
            name: "性别",
            renderData: function (rowindex, data, rowdata, column) {
                if (data == 1)return "男";
                else return "女";
            }
        }, {
            colkey: "CSRQ",
            name: "出生日期",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
            }
        }, {
            colkey: "MZDM",
            name: "民族代码"
        }, {
            colkey: "XLDM",
            name: "学历代码"
        }, {
            colkey: "SG",
            name: "身高"
        }],
        jsonUrl: rootPath + '/rkxx/findByPage.shtml',
        checkbox: false
    });

    $("#search").click("click", function () {// 绑定查询按扭
        var searchParams = $("#searchForm").serializeJson();
        grid.setOptions({
            data: searchParams
        });
    });
});