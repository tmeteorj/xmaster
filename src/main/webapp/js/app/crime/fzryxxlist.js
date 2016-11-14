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
            colkey: "gmsfhm",
            name: "身份证号",
            width: "200px"
        }, {
            colkey: "xm",
            name: "姓名",
            width: "100px"
        }, {
            colkey: "xb",
            name: "性别"
        }, {
            colkey: "csrq",
            name: "出生日期",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
            }
        }, {
            colkey: "whcd",
            name: "文化程度"
        }, {
            colkey: "mz",
            name: "民族"
        }, {
            colkey: "ajlb",
            name: "案件类别"
        }, {
            colkey: "rsrq",
            name: "入所日期"
        }, {
            colkey: "cljg",
            name: "处理结果"
        }, {
            colkey: "cljgflwsh",
            name: "文书号"
        }],
        jsonUrl: rootPath + '/fzryxx/findByPage.shtml',
        checkbox: false
    });

    $("#search").click("click", function () {// 绑定查询按扭
        var searchParams = $("#searchForm").serializeJson();
        grid.setOptions({
            data: searchParams
        });
    });
});