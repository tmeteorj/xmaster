/**
 * Created by NING on 2016/10/4.
 */
var pageii = null;
var grid = null;
$(function () {
    grid = lyGrid({
        pagId: 'paging',
        l_column: [{
            colkey: "id",
            name: "id",
            width: "50px",
            hide: false
        }, {
            colkey: "grid_id",
            name: "地块编号",
            width: "200px"
        }, {
            colkey: "lng",
            name: "经度"
        }, {
            colkey: "lat",
            name: "纬度"
        }, {
            colkey: "colx",
            name: "横坐标"
        }, {
            colkey: "coly",
            name: "纵坐标"
        }, {
            colkey: "level",
            name: "评分级别"
        }, {
            colkey: "score",
            name: "分数"
        }],
        jsonUrl: rootPath + '/visualuicreate/showtables.shtml',
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
    $("#createmetadata").click("click", function () {
        createmetadata();
    });
    $("#viewFun").click("click", function () {
        viewFun();
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

function createmetadata(){

    var cbox = grid.getSelectedCheckbox();
    if (cbox.length > 1 || cbox == "") {
        layer.msg("只能选中一个");
        return;
    }
    var url = rootPath + '/dataset/' + cbox + '/createmetadata.shtml';
    var s = CommnUtil.ajax(url, {}, "json");
    if (s == "success") {
        layer.msg('生成成功');
    } else {
        layer.msg('生成失败');
    }
}

function viewFun() {
    var cbox = grid.getSelectedCheckbox();
    if (cbox.length > 1 || cbox == "") {
        layer.msg("只能选中一个");
        return;
    }
    pageii = layer.open({
        title: "快照",
        type: 2,
        area: ["600px", "80%"],
        content: rootPath + '/dataset/' + cbox + '/view.shtml'
    });
}