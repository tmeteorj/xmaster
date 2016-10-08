<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="/common/common.jspf" %>

    <script type="text/javascript" src="${ctx}/js/app/gsm/gsmdatasetaudit.js"></script>

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
      action="${ctx}/gsmdataset/save.shtml">
    <input type="hidden" class="form-control"
           value="${gsmdataset.id}" name="gsmDatasetFormMap.id" id="id">
    <input type="hidden" class="form-control"
           value="${sessionScope.userSessionId}" name="gsmDatasetFormMap.audit_user_id" id="audit_user_id">
    <input type="hidden" class="form-control"
           value="${sessionScope.userSessionAccountName}" name="gsmDatasetFormMap.audit_username" id="audit_username">
    <input type="hidden" class="form-control"
           value="${gsmdataset.deleted_mark}" name="gsmDatasetFormMap.deleted_mark" id="deleted_mark">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">备注</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control" placeholder="请输入备注"
                           name="gsmDatasetFormMap.remark" id="remark">
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
</body>
</html>