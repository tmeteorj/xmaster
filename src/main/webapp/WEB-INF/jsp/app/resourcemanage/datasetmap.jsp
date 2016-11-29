<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/11/28
  Time: 21:29
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
  <section class="panel panel-default">
    <div class="panel-body">
      <div class="form-group">
        <label class="col-sm-3 control-label">数据列</label>
        <label class="col-sm-9 control-label">对应本体属性</label>
        <div class="form-group">
          <label class="col-sm-3 control-label">姓名</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">身份证号</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">性别</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">家庭住址</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">出生日期</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">民族</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">婚姻状态</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">文化程度</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">血型</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">曾用名</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">照片</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">行政区域</label>

          <div class="col-sm-9">
            <select id="co1" name="co1" style="width: 100%">
              <option value="">公民身份号码</option>
              <option value="">姓名</option>
              <option value="">性别</option>
              <option value="">民族</option>
              <option value="">出生日期</option>
              <option value="">出生地</option>
              <option value="">户口类别</option>
              <option value="">常驻户口所在地</option>
              <option value="">户籍登记地址</option>
              <option value="">户口所在地邮政编码</option>
              <option value="">死亡标识</option>
              <option value="">死亡日期</option>
              <option value="">死亡登记日期</option>
              <option value="">曾用名</option>
              <option value="">籍贯</option>
              <option value="">户主身份证号码</option>
              <option value="">与户主关系</option>
            </select>
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
