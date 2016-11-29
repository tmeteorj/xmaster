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

        <div class="form-group">
        <label class="col-sm-3 control-label">对应本体</label>
        <div class="col-sm-9">
          <select  id="pid" style="width: 100%"  onchange="gradeChange()">
            <option value=""></option>
            <option value="人口">人口</option>
            <option value="机构">机构</option>
            <option value="地块">地块</option>
            <option value="街道">街道</option>
            <option value="事件">事件</option>
            <option value="人行为">人行为</option>
            <option value="机构行为">机构行为</option>
          </select>
        </div>
        </div>
          </br>
          <div class="form-group">
          <label class="col-sm-3 control-label">数据列</label>
        <label class="col-sm-9 control-label">对应本体属性</label>

        </div>
        <c:forEach items="${meta}" var="key">

        <div class="form-group">
          <label class="col-sm-3 control-label">${key}</label>

          <div class="col-sm-9">
            <select name="co1" style="width: 100%">
            </select>
          </div>
        </div>
        </c:forEach>


    </div>
    <footer class="panel-footer text-right bg-light lter">
      <button type="submit" class="btn btn-success btn-s-xs">保存</button>
    </footer>
    </div>
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
  function gradeChange(){
    var objS = document.getElementById("pid");
    var grade = objS.options[objS.selectedIndex].value;
    var controls=document.getElementsByName("co1");
    if(grade=="人口") {
      for (var i = 0; i < controls.length; i++)//这里是length还是count记不清了
      {
        controls[i].options.length = 0;
        controls[i].options.add(new Option("公民身份号码","公民身份号码"));
        controls[i].options.add(new Option("姓名","姓名"));
        controls[i].options.add(new Option("性别","性别"));
        controls[i].options.add(new Option("民族","民族"));
        controls[i].options.add(new Option("出生日期","出生日期"));
        controls[i].options.add(new Option("出生地","出生地"));
        controls[i].options.add(new Option("户口类别","户口类别"));
        controls[i].options.add(new Option("常驻户口所在地","常驻户口所在地"));
        controls[i].options.add(new Option("户籍登记地址","户籍登记地址"));
        controls[i].options.add(new Option("户口所在地邮政编码","户口所在地邮政编码"));
        controls[i].options.add(new Option("死亡标识","死亡标识"));
        controls[i].options.add(new Option("死亡日期","死亡日期"));
        controls[i].options.add(new Option("死亡登记日期","死亡登记日期"));
        controls[i].options.add(new Option("曾用名","曾用名"));
        controls[i].options.add(new Option("籍贯","籍贯"));
        controls[i].options.add(new Option("户主身份证号码","户主身份证号码"));
        controls[i].options.add(new Option("与户主关系","与户主关系"));
      }
    }


    if(grade=="机构") {
      for (var i = 0; i < controls.length; i++)//这里是length还是count记不清了
      {
        controls[i].options.length = 0;
        controls[i].options.add(new Option("编号","编号"));
        controls[i].options.add(new Option("名称","名称"));
        controls[i].options.add(new Option("法人","法人"));
        controls[i].options.add(new Option("成立时间","成立时间"));
        controls[i].options.add(new Option("级别","级别"));
        controls[i].options.add(new Option("行政区划","行政区划"));
        controls[i].options.add(new Option("上级ID","上级ID"));
        controls[i].options.add(new Option("地址","地址"));
        controls[i].options.add(new Option("经济类型","经济类型"));
        controls[i].options.add(new Option("其他属性","其他属性"));
      }
    }


    if(grade=="地块") {
      for (var i = 0; i < controls.length; i++)//这里是length还是count记不清了
      {
        controls[i].options.length = 0;
        controls[i].options.add(new Option("地块名称","地块名称"));
        controls[i].options.add(new Option("地址","地址"));
        controls[i].options.add(new Option("中心经度","中心经度"));
        controls[i].options.add(new Option("中心纬度","中心纬度"));
        controls[i].options.add(new Option("国家","国家"));
        controls[i].options.add(new Option("州省","州省"));
        controls[i].options.add(new Option("市郡","市郡"));
        controls[i].options.add(new Option("用地属性","用地属性"));
        controls[i].options.add(new Option("用地面积","用地面积"));
        controls[i].options.add(new Option("边界","边界"));
      }
    }


    if(grade=="街道") {
      for (var i = 0; i < controls.length; i++)//这里是length还是count记不清了
      {
        controls[i].options.length = 0;
        controls[i].options.add(new Option("街道名称","街道名称"));
        controls[i].options.add(new Option("长度","长度"));
        controls[i].options.add(new Option("走向","走向"));
        controls[i].options.add(new Option("级别","级别"));
        controls[i].options.add(new Option("位置","位置"));
      }
    }
    if(grade=="事件") {
      for (var i = 0; i < controls.length; i++)//这里是length还是count记不清了
      {
        controls[i].options.length = 0;
        controls[i].options.add(new Option("编号","编号"));
        controls[i].options.add(new Option("事件名称","事件名称"));
        controls[i].options.add(new Option("起始时间","起始时间"));
        controls[i].options.add(new Option("终止时间","终止时间"));
        controls[i].options.add(new Option("级别","级别"));
        controls[i].options.add(new Option("类型","类型"));
        controls[i].options.add(new Option("描述","描述"));
        controls[i].options.add(new Option("对象列表","对象列表"));
        controls[i].options.add(new Option("地块列表","地块列表"));
        controls[i].options.add(new Option("行为列表","行为列表"));
        controls[i].options.add(new Option("其他属性","其他属性"));
      }
    }
    if(grade=="人行为") {
      for (var i = 0; i < controls.length; i++)//这里是length还是count记不清了
      {
        controls[i].options.length = 0;
        controls[i].options.add(new Option("行为时间","行为时间"));
        controls[i].options.add(new Option("行为类型","行为类型"));
        controls[i].options.add(new Option("个体ID","个体ID"));
        controls[i].options.add(new Option("经度","经度"));
        controls[i].options.add(new Option("纬度","纬度"));
      }
    }
    if(grade=="机构行为") {
      for (var i = 0; i < controls.length; i++)//这里是length还是count记不清了
      {
        controls[i].options.length = 0;
      }
    }
  }
</script>
</body>
</html>
