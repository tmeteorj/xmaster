<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/10/12
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/visualuichooseoperator.js"></script>

<label class="control-label">选择算子</label>

<div id = "ch" >
  <div class="table-responsive">
    <div id="paging" class="pagclass"></div>
  </div>

  <div class="doc-buttons">

    <button type="button" id="nooFun" class="btn btn-info marR10">不使用算子</button>
    <a id="operatorc" class="btn btn-primary btn-large" href="javascript:void(0)">选择</a>

  </div>
</div>

<div>
  <p id="selectedoperatorid" style="display: none">
    0
  </p>
  <p id="datasetids" style="display: none">
    ${datasetids}
  </p>
  <p id="typeid" style="display: none">
    ${typeid}
  </p>

</div>
