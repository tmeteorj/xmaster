<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/10/10
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/visualuiconfig.js"></script>
<label class="control-label">配置可视化界面</label>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${ctx}/visual/save.shtml">
    <div class="panel-body">
      <div class="form-group">
        <label class="col-sm-3 control-label">可视化界面描述</label>

        <div class="col-sm-9">
          <input type="text" class="form-control"
                 placeholder="请描述这个可视化界面" value=""
                 name="visualConfigFormMap.info" id="info">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">可视化类型</label>

        <div class="col-sm-9">
          <input type="text" class="form-control" value="${typeid}" readOnly="true"
                 name="visualConfigFormMap.typeid" id="typeid">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">所使用数据库</label>

        <div class="col-sm-9">
          <input type="text" class="form-control" value="${datasetids}" readOnly="true"
                 name="visualConfigFormMap.datasetids" id="datasetids">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">所使用算法</label>

        <div class="col-sm-9">
          <input type="text" class="form-control" value="${operatorconfigid}" readOnly="true"
                 name="visualConfigFormMap.operatorconfigid" id="operatorconfigid">
        </div>
      </div>

      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">
        <label class="col-sm-3 control-label">选择可视化工具</label>

        <div class="col-sm-9">
          <select id="methodid" name="visualConfigFormMap.methodid"  class="form-control">
            <c:forEach var="visualmethod" items="${visualmethods}">
              <option value="${visualmethod.id}">${visualmethod.name}</option>
            </c:forEach>
          </select>
        </div>
      </div>

      <label class="control-label">请配置参数</label>
      <c:forEach var="visualparameter" items="${visualparameters}">
      <div class="line line-dashed line-lg pull-in"></div>
      <div class="form-group">

        <div class="col-sm-3">
        <label class="control-label">${visualparameter.name}</label>
          </br>${visualparameter.discription}
        </div>
        <div class="col-sm-9">
          <select id="${visualparameter.id}" name="${visualparameter.id}"  class="form-control">
            <c:forEach var="metadata" items="${metadatas}">
              <option value="meta:${metadata.id}">${metadata.meta}:${metadata.remark}</option>
            </c:forEach>
            <c:forEach var="operatorOutputFromMap" items="${operatorOutputFromMaps}">
              <option value="opte:${operatorOutputFromMap.id}">${operatorOutputFromMap.name}:${operatorOutputFromMap.discription}</option>
            </c:forEach>
          </select>
        </div>
      </div>
      </c:forEach>
    </div>
    <footer class="panel-footer text-right bg-light lter">
      <button type="submit" class="btn btn-success btn-s-xs" id="createconfig">创建</button>
    </footer>
</form>

