$(function () {
    $("#reject").click("click", function () {
        $("#deleted_mark").val(3);//驳回
        submit();
    });
    $("#pass").click("click", function () {
        $("#deleted_mark").val(1);//通过
        submit();
    });
});

function submit() {
    var url = rootPath + '/gsmdataset/save.shtml';
    var s = CommnUtil.ajax(url, {
        gsmDatasetFormMap_id: $("#id").val(),
        gsmDatasetFormMap_remark: $("#remark").val(),
        gsmDatasetFormMap_deleted_mark: $("#deleted_mark").val(),
        gsmDatasetFormMap_audit_user_id:$("#audit_user_id").val(),
        gsmDatasetFormMap_audit_username:$("#audit_username").val()
    }, "json");
    if (s == "success") {
        layer.confirm('操作成功！', {
            btn: ['确定'] //按钮
        }, function (index) {
            parent.grid.loadData();
            parent.layer.close(parent.pageii);
            return false;
        });
    } else {
        layer.msg('操作失败');
    }
}