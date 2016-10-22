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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/visualuimanage.js"></script>


<header class="panel-heading">
  <div class="doc-buttons">
    <button type="button" id="viewFun" class="btn btn-info marR10">查看</button>
    <c:forEach items="${res}" var="key">
      ${key.description}
    </c:forEach>
  </div>
</header>

<div class="table-responsive">
  <div id="paging" class="pagclass"></div>
</div>
