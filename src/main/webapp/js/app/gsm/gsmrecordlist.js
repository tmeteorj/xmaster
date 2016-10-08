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
            colkey: "dataset_id",
            name: "数据集ID"
        }, {
            colkey: "remark",
            name: "描述",
            width: "200px"
        }, {
            colkey: "type",
            name: "记录类型",
            renderData: function (rowindex, data, rowdata, column) {
                if(data==1)return "打电话";
                else if(data==3)return "接电话";
                else if(data==6)return "发短信";
                else if(data==7)return "收短信";
                else if(data==12)return "小区切换";
                else if(data==13)return "周期性位置更新";
                else return "未知类型";
            }
        }, {
            colkey: "time",
            name: "记录时间",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
            }
        }, {
            colkey: "subject",
            name: "主体ID"
        }, {
            colkey: "object",
            name: "客体ID"
        }, {
            colkey: "lng",
            name: "经度"
        }, {
            colkey: "lat",
            name: "纬度"
        }],
        jsonUrl: rootPath + '/gsmrecord/findByPage.shtml',
        checkbox: false
    });

    $("#search").click("click", function () {// 绑定查询按扭
        var searchParams = $("#searchForm").serializeJson();
        grid.setOptions({
            data: searchParams
        });
    });
});