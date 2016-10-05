/**
 * Created by NING on 2016/10/4.
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
            colkey: "title",
            name: "数据表名"
        }, {
            colkey: "info",
            name: "数据表描述"
        }, {
            colkey: "dataset_url",
            name: "数据库连接"
        }, {
            colkey: "dataset_type",
            name: "数据库类型"
        },{
            colkey: "username",
            name: "用户名"
        }, {
            colkey: "psw",
            name: "密码"
        }, {
            colkey: "src",
            name: "数据表来源机构"
        },{
            colkey: "publisher",
            name: "数据表发布者"
        },{
            colkey: "size",
            name: "数据表大小"
        },{
            colkey: "meta_created",
            name: "创建时间",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
            }
        }],
        jsonUrl: rootPath + '/dataset/findByPage.shtml',
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
    $("#auditFun").click("click", function () {
        auditFun();
    });
    $("#linkFun").click("click", function () {
        linkFun();
    });
});

function editFun() {
    var cbox = grid.getSelectedCheckbox();
    if (cbox.length > 1 || cbox == "") {
        layer.msg("只能选中一个");
        return;
    }
    pageii = layer.open({
        title: "编辑",
        type: 2,
        area: ["600px", "80%"],
        content: rootPath + '/dataset/' + cbox + '/edit.shtml'
    });
}
function addFun() {
    pageii = layer.open({
        title: "新增",
        type: 2,
        area: ["600px", "80%"],
        content: rootPath + '/dataset/add.shtml'
    });
}
function delFun() {
    var cbox = grid.getSelectedCheckbox();
    if (cbox.length > 1 || cbox == "") {
        layer.msg("只能选中一个");
        return;
    }
    layer.confirm('是否删除？', function (index) {
        var url = rootPath + '/dataset/' + cbox + '/delete.shtml';
        var s = CommnUtil.ajax(url, {}, "json");
        if (s == "success") {
            layer.msg('删除成功');
            grid.loadData();
        } else {
            layer.msg('删除失败');
        }
    });
}

function auditFun() {
    var cbox = grid.getSelectedCheckbox();
    if (cbox.length > 1 || cbox == "") {
        layer.msg("只能选中一个");
        return;
    }
    var url = rootPath + '/dataset/' + cbox + '/check.shtml';
    var s = CommnUtil.ajax(url, {}, "json");
    if (!s) {
        layer.msg('已审核过，无需再审！');
        grid.loadData();
        return;
    }
    pageii = layer.open({
        title: "审核",
        type: 2,
        area: ["600px", "20%"],
        content: rootPath + '/dataset/' + cbox + '/audit.shtml'
    });
}

function linkFun(){
    var cbox = grid.getSelectedCheckbox();
    if (cbox.length > 1 || cbox == "") {
        layer.msg("只能选中一个");
        return;
    }
    var url = rootPath + '/dataset/' + cbox + '/link.shtml';
    var s = CommnUtil.ajax(url, {}, "json");
    if (s == "success") {
        layer.msg('链接成功');
    } else {
        layer.msg('链接失败');
    }
}