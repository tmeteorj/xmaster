<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/10/4
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <%@include file="/common/common.jspf" %>
  <script type="text/javascript" src="${ctx}/js/app/resourcemanage/datasetedit.js"></script>

  <style type="text/css">
    .col-sm-3 {
      width: 15%;
      float: left;
    }

    .col-sm-9 {
      width: 85%;
      float: left;
    }
  </style>
</head>
<body>
<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${ctx}/dataset/save.shtml">
  <input type="hidden" class="form-control"
         value="${dataset.id}" name="datasetFormMap.id" id="id">
  <section class="panel panel-default">
    <div class="panel-body">
      <div class="form-group">
        <label class="col-sm-3 control-label">数据表名</label>

        <div class="col-sm-9">
          <input type="text" class="form-control"
                 placeholder="请输入数据表名" value="${dataset.title}"
                 name="datasetFormMap.title" id="title">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">数据表描述</label>

        <div class="col-sm-9">
          <input type="text" class="form-control"
                 placeholder="请输入数据表描述" value="${dataset.info}"
                 name="datasetFormMap.info" id="info">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">数据库连接</label>

        <div class="col-sm-9">
          <input type="text" class="form-control"
                 placeholder="请输入数据库连接" value="${dataset.dataset_url}"
                 name="datasetFormMap.dataset_url" id="dataset_url">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">数据库类型</label>

        <div class="col-sm-9">
          <input type="text" class="form-control"
                 placeholder="请输入数据库类型" value="${dataset.dataset_type}"
                 name="datasetFormMap.dataset_type" id="dataset_type">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">用户名</label>

        <div class="col-sm-9">
          <input type="text" class="form-control"
                 placeholder="请输入用户名" value="${dataset.username}"
                 name="datasetFormMap.username" id="username">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">密码</label>

        <div class="col-sm-9">
          <input type="text" class="form-control"
                 placeholder="请输入密码" value="${dataset.psw}"
                 name="datasetFormMap.psw" id="psw">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">数据表来源机构</label>

        <div class="col-sm-9">
          <input type="text" class="form-control"
                 placeholder="请输入数据表来源机构" value="${dataset.src}"
                 name="datasetFormMap.src" id="src">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">数据表发布者</label>

        <div class="col-sm-9">
          <input type="text" class="form-control"
                 placeholder="请输入数据表发布者" value="${dataset.publisher}"
                 name="datasetFormMap.publisher" id="publisher">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">数据表大小</label>

        <div class="col-sm-9">
          <input type="text" class="form-control"
                 placeholder="请输入数据表大小" value="${dataset.size}"
                 name="datasetFormMap.size" id="size">
        </div>
      </div>
    </div>
    <footer class="panel-footer text-right bg-light lter">
      <button type="submit" class="btn btn-success btn-s-xs">保存</button>
    </footer>
  </section>
</form>
<script type="text/javascript">
  onloadurl();
  $('.form_date').datetimepicker({
    language: 'zh-CN',
    weekStart: 1,
    todayBtn: 1,
    autoclose: 1,
    todayHighlight: 1,
    startView: 2,
    minView: 2,
    forceParse: 0
  });
</script>
</body>
</html>
