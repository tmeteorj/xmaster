<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/crime/rkxxlist.js"></script>

<div class="m-b-md">
    <form class="form-inline" role="form" id="searchForm"
          name="searchForm">
        <div class="form-group">
            <label class="control-label">
                <span class="h4 font-thin v-middle">姓名:</span></label> <input
                class="input-medium ui-autocomplete-input" id="name"
                name="rkxxFormMap.XM">
        </div>
        <div class="form-group">
            <label class="control-label">
                <span class="h4 font-thin v-middle">身份证号:</span></label> <input
                class="input-medium ui-autocomplete-input" id="gmsfhm"
                name="rkxxFormMap.GMSFHM">
        </div>
        <div class="form-group">
            <label class="control-label">
                <span class="h4 font-thin v-middle">身高:</span></label> <input
                class="input-medium ui-autocomplete-input" id="sg"
                name="rkxxFormMap.SG">
        </div>
        <div class="form-group">
            <label class="control-label"> <span
                    class="h4 font-thin v-middle">性别:</span></label>
            <select style="width:120px;height:30px; display:inline" id="type" name="rkxxFormMap.XBDM">
                <option value="1">男</option>
                <option value="2">女</option>
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