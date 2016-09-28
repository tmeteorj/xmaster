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
            name: "名称"
        }, {
            colkey: "num_member",
            name: "成员人数"
        }, {
            colkey: "num_past_meetups",
            name: "活动数"
        }, {
            colkey: "time_founded",
            name: "成立时间",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd");
            }
        }, {
            colkey: "place_name",
            name: "地址"
        }, {
            colkey: "country",
            name: "国家"
        }, {
            colkey: "region",
            name: "地区"
        }, {
            colkey: "meta_created",
            name: "创建时间",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
            }
        }],
        jsonUrl: rootPath + '/meetup/findByPage.shtml',
        checkbox: true
    });

    $("#search").click("click", function () {// 绑定查询按扭
        var searchParams = $("#searchForm").serializeJson();
        grid.setOptions({
            data: searchParams
        });
    });

    $("#addFun").click("click", function () {
        addFun();
    });
    $("#editFun").click("click", function () {
        editFun();
    });
    $("#delFun").click("click", function () {
        delFun();
    });
});

function editFun() {
    var cbox = grid.getSelectedCheckbox();
    if (cbox.length > 1 || cbox == "") {
        layer.msg("只能选中一个");
        return;
    }
    alert(cbox);
    pageii = layer.open({
        title: "编辑",
        type: 2,
        area: ["600px", "80%"],
        content: rootPath + '/meetup/' + cbox + '/edit.shtml'
    });
}
function addFun() {
    pageii = layer.open({
        title: "新增",
        type: 2,
        area: ["600px", "80%"],
        content: rootPath + '/meetup/add.shtml'
    });
}
function delFun() {
    var cbox = grid.getSelectedCheckbox();
    if (cbox.length > 1 || cbox == "") {
        layer.msg("只能选中一个");
        return;
    }
    layer.confirm('是否删除？', function (index) {
        var url = rootPath + '/meetup/' + cbox + '/delete.shtml';
        var s = CommnUtil.ajax(url, {}, "json");
        if (s == "success") {
            layer.msg('删除成功');
            grid.loadData();
        } else {
            layer.msg('删除失败');
        }
    });
}