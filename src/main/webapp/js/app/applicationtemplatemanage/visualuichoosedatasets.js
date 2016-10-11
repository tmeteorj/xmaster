/**
 * Created by NING on 2016/10/9.
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
            colkey: "coded_format",
            name: "编码格式"
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

    $("#datasetc").bind("click", function () {
        createFun();
    });

    $("#viewFun").click("click", function () {
        viewFun();
    });

    $("#addFun").click("click", function () {
        addFun();
    });

    $("#delFun").click("click", function () {
        delFun();
    });
});

function createFun() {

    var td = $("#selecteddatasetid");
    var tdc = td.html();
    var tb = $("#loadhtml");
    tb.html(CommnUtil.loadingImg());
    tb.load(rootPath + '/visual/' + tdc.trim() + '/choosetype.shtml');
}

function addFun() {
    var cbox = grid.getSelectedCheckbox();
    var cname = grid.selectRow();
    if (cbox.length > 1 || cbox == "") {
        layer.msg("只能选中一个");
        return;
    }

    var tb = $("#selecteddataset");
    var td = $("#selecteddatasetid");
    var tdc = td.html();
    var tds = tdc.split(",");
    for (var i=0;i<tds.length;i++)
    {
        if(tds[i].trim()==cbox){
            layer.msg("已选过");
            return;
        }
    }
    //console.log(cname);
    tb.append("<strong><u>"+cname[0].title+"</u></strong> ");
    td.append(cbox+",");
}

function delFun() {

    var tb = $("#selecteddataset");
    var td = $("#selecteddatasetid");
    tb.text("已选数据集：");
    td.text("");
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