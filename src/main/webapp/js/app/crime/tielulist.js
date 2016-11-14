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
            colkey: "id_kind",
            name: "证件类型"
        }, {
            colkey: "id_no",
            name: "证件号码",
            width: "200px"
        }, {
            colkey: "id_name",
            name: "姓名"
        }, {
            colkey: "train_date",
            name: "发车日期",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
            }
        }, {
            colkey: "from_station_name",
            name: "发站"
        }, {
            colkey: "to_station_name",
            name: "到站"
        }, {
            colkey: "ticket_no",
            name: "票号",
            width: "100px"
        }, {
            colkey: "coach_no",
            name: "车厢号",
            width: "100px"
        }, {
            colkey: "seat_no",
            name: "座位号",
            width: "100px"
        }],
        jsonUrl: rootPath + '/tielu/findByPage.shtml',
        checkbox: false
    });

    $("#search").click("click", function () {// 绑定查询按扭
        var searchParams = $("#searchForm").serializeJson();
        grid.setOptions({
            data: searchParams
        });
    });
});