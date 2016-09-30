<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="/common/common.jspf" %>

    <style type="text/css">
        .col-sm-3 {
            width: 15%;
            float: left;
            text-align: right;
        }

        .col-sm-9 {
            width: 85%;
            float: left;
            text-align: left;
        }

        label[class^="btn btn-default"] {
            margin-top: -4px;
        }
    </style>
</head>
<body>
<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${ctx}/table/<c:out value="${tableName}"/>/save.shtml">
    <input type="hidden" class="form-control"
           value="${tabledata.id}" name="<c:out value="${tableName}"/>.id" id="id">
    <input type="hidden" class="form-control"
           value="${tabledata.deleted_mark}" name="<c:out value="${tableName}"/>.deleted_mark" id="deleted_mark">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">备注</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control" placeholder="请输入备注"
                           name="<c:out value="${tableName}"/>.remark" id="remark">
                </div>
            </div>
        </div>
        <footer class="panel-footer text-right bg-light lter">
            <button id="reject" type="button" class="btn btn-danger btn-s-xs">驳回</button>
            <button id="pass" type="button" class="btn btn-success btn-s-xs">通过</button>
        </footer>
    </section>
</form>
<script type="text/javascript">
    onloadurl();
</script>
<script type="text/javascript"
        src="${ctx}/notebook/notebook_files/bootstrap-filestyle.min.js"></script>
<script type="application/javascript">
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
        var url = rootPath + '/table/<c:out value="${tableName}"/>/save.shtml';
        var s = CommnUtil.ajax(url, {
            <c:out value="${tableName}"/>_id: $("#id").val(),
            <c:out value="${tableName}"/>_remark: $("#remark").val(),
            <c:out value="${tableName}"/>_deleted_mark: $("#deleted_mark").val()
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
</script>
</body>
</html>