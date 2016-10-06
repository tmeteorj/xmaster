<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/10/6
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="${pageContext.request.contextPath}/js/date/bootstrap.min.css" rel="stylesheet">
<html>
<head>
    <title></title>
</head>
<body>
<div>
  <table class="table">
    <thead>
    <tr>
      <c:forEach items="${meta}" var="keyword">
        <th class="">${keyword}</th>
      </c:forEach>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${data}" var="dataitem">

      <tr>
        <c:forEach items="${dataitem}" var="da">
          <td class="">${da}</td>
        </c:forEach>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>
