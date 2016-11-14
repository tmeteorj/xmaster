<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/11/12
  Time: 10:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/decisionuiconfig.js"></script>
<label class="control-label">生成决策可视化界面</label>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${ctx}/visual/savedecisionui.shtml">
  <div class="panel-body">
    <div class="form-group">
      <label class="col-sm-3 control-label">选择决策界面要服务的用户</label>

      <div class="col-sm-9">
        <select id="userid" name="decisionUiFormMap.userid"  class="form-control">
          <c:forEach var="user" items="${users}">
            <option value="${user.id}">${user.userName}</option>
          </c:forEach>
        </select>
      </div>
    </div>

    <div class="form-group">
      <label class="col-sm-3 control-label">选择决策界面所使用的布局方式</label>

      <div class="col-sm-9">
        <select id="layoutid" name="decisionUiFormMap.layoutid"  class="form-control">
          <c:forEach var="layout" items="${layouts}">
            <option value="${layout.id}">${layout.name}</option>
          </c:forEach>
        </select>
      </div>
    </div>
    <div class="line line-dashed line-lg pull-in"></div>
    <div class="form-group">
      <label class="col-sm-3 control-label">命名决策可视化界面</label>

      <div class="col-sm-9">
        <input type="text" class="form-control" value="${name}"
               name="decisionUiFormMap.name" id="name">
      </div>
    </div>
    <div class="line line-dashed line-lg pull-in"></div>
    <div class="form-group">
      <label class="col-sm-3 control-label">描述决策可视化界面</label>

      <div class="col-sm-9">
        <textarea rows="5" id="info" style="width: 100%" name = "decisionUiFormMap.info" class="w780"></textarea>

      </div>
    </div>
    <div class="line line-dashed line-lg pull-in"></div>
    <div class="form-group">
      <label class="col-sm-3 control-label">添加子可视化界面</label>

      <div class="col-sm-9">
        <input type="button" onClick="addRow();" style="font-size:16px;" value="+"/>

        <table id="oTable" border="0"cellpadding="0"cellspacing="0">

          <tbody>
          <tr>
            <label class="control-label" contenteditable="true">第1部分</label>
            <div class="controls" style="width: 100%;">

              <select id="co1" name="co1">
                <c:forEach var="vi" items="${vis}">
                  <option value="${vi.id}">${vi.info}</option>
                </c:forEach>
              </select>
            </div>
          </tr>
          </tbody>
        </table>
      </div>
    </div>

    <input id="count" name = "count" style="display:none;">

    </input>
  </div>
  <footer class="panel-footer text-right bg-light lter">
    <button type="submit" class="btn btn-success btn-s-xs" id="createconfig">创建</button>
  </footer>
</form>
<script>
  var countnum=1;
  function addRow(){
    var oTable = document.getElementById("oTable");
    var tBodies = oTable.tBodies;
    countnum=countnum+1;
    var tbody = tBodies[0];
    var tr = tbody.insertRow(tbody.rows.length);
    var td = tr.insertCell(0);
    td.innerHTML = "<label class='control-label' contenteditable='true' for='inputEmail'>第"+countnum+"部分</label><div class='controls'  style='width: 100%;'> <select id='co"+countnum+"' name='co"+countnum+"'><c:forEach var='vi' items='${vis}'><option value='${vi.id}'>${vi.info}</option></c:forEach></select></div>";
    var count= document.getElementById("count");
    count.value = countnum;
  }
</script>