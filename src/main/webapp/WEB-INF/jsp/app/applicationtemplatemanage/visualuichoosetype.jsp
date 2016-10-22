<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/10/10
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/visualuichoosetype.js"></script>

<label class="control-label">选择可视化展示方式</label>

<header class="panel-heading">
  <div class="doc-buttons">
    <c:forEach items="${res}" var="key">
      ${key.description}
    </c:forEach>
  </div>
</header>

<div class="table-responsive">
  <div id="paging" class="pagclass"></div>
</div>

<div class="doc-buttons">

  <a id="typec" class="btn btn-primary btn-large" href="javascript:void(0)">选择</a>

</div>

<div>
  <p id="selecteddatasetid" style="display: none">
      ${datasetids}
  </p>
</div>
