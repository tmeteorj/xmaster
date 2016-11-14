<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/11/12
  Time: 13:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/layout/${js}"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/decisionuishow.js"></script>

<html>

<label class="control-label">${name}</label>
</br>${info}
<c:forEach items="${con}" var="tem" varStatus="i">
  <div id="loadhtml${i.index}">正在载入</div>
  <div id="index${i.index}" style="display: none">${tem}</div>

</c:forEach>
<%--<iframe src="${ctx}/visual/301/showconfig.shtml">--%>
<%--</iframe>--%>
<button id = "cl" style="display: none"/>
<div id="count" style="display: none">${count}</div>
</html>
