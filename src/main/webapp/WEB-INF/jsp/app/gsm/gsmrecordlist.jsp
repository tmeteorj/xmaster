<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/gsm/gsmrecordlist.js"></script>

<div class="m-b-md">
  <form class="form-inline" role="form" id="searchForm"
        name="searchForm">
    <div class="form-group">
      <label class="control-label">
        <span class="h4 font-thin v-middle">主体ID:</span></label> <input
            class="input-medium ui-autocomplete-input" id="name"
            name="gsmrecordFormMap.subject">
    </div>
    <div class="form-group">
      <label class="control-label"> <span
              class="h4 font-thin v-middle">客体ID:</span></label> <input
            class="input-medium ui-autocomplete-input" id="country"
            name="gsmrecordFormMap.object">
    </div>
    <div class="form-group">
      <label class="control-label"> <span
              class="h4 font-thin v-middle">记录类型:</span></label>
      <select style="width:120px;height:30px; display:inline" id="type" name="gsmrecordFormMap.type">
        <option value="1">打电话</option>
        <option value="3">接电话</option>
        <option value="6">发短信</option>
        <option value="7">收短信</option>
        <option value="12">小区切换</option>
        <option value="13">周期性位置更新</option>
      </select>
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