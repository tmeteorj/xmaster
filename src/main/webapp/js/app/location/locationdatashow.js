/**
 * Created by aloha on 2016/10/13.
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
            hide: false
        }, {
            colkey: "description",
            name: "数据集描述",
            width: "200px"
        }, {
            colkey: "upload_user_id",
            name: "上传者ID"
        }, {
            colkey: "upload_username",
            name: "上传者账号"
        }, {
            colkey: "audit_user_id",
            name: "审核者ID"
        }, {
            colkey: "audit_username",
            name: "审核者账号"
        }, {
            colkey: "remark",
            name: "审核回复"
        }, {
            colkey: "path",
            name: "文件路径"
        }, {
            colkey: "meta_created",
            name: "创建时间",
            renderData: function (rowindex, data, rowdata, column) {
                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
            }
        }, {
            colkey: "deleted_mark",
            name: "当前状态",
            renderData: function (rowindex, data, rowdata, column) {
                if(data==0)return "无效";
                else if(data==1)return "有效";
                else if(data==2)return "待审核";
                else if(data==3)return "审核未通过";
                else return "未知状态";
            }
        }],
        jsonUrl: rootPath + '/gsmdataset/findByPage.shtml',
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
});
function addFun() {
    pageii = layer.open({
        title: "新增",
        type: 2,
        area: ["600px", "80%"],
        content: rootPath + '/gsmdataset/add.shtml'
    });
}