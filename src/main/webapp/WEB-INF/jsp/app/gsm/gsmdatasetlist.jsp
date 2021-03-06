<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/gsm/gsmdatasetlist.js"></script>

<div class="m-b-md">
  <form class="form-inline" role="form" id="searchForm"
        name="searchForm">
    <div class="form-group">
      <label class="control-label"> <span
              class="h4 font-thin v-middle">上传者ID:</span></label> <input
            class="input-medium ui-autocomplete-input" id="name"
            name="gsmdatasetFormMap.upload_user_id">
    </div>
    <div class="form-group">
      <label class="control-label"> <span
              class="h4 font-thin v-middle">审核者ID:</span></label> <input
            class="input-medium ui-autocomplete-input" id="country"
            name="gsmdatasetFormMap.audit_user_id">
    </div>
    <a href="javascript:void(0)" class="btn btn-info" id="search">查询</a>
  </form>
</div>

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