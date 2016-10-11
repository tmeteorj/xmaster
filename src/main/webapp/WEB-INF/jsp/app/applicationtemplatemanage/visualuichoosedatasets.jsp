<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/10/9
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/visualuichoosedatasets.js"></script>


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

  <button type="button" id="addFun" class="btn btn-info marR10">选择</button>

  <button type="button" id="viewFun" class="btn btn btn-grey marR10">数据集快照</button>

  <button type="button" id="delFun" class="btn btn-danger marR10">重置</button>

  <a id="datasetc" class="btn btn-primary btn-large" href="javascript:void(0)">选择完成</a>

</div>

<div>
  <p id="selecteddataset">
    已选数据集：
  </p>
  <p id="selecteddatasetid" style="display: none">

  </p>
</div>