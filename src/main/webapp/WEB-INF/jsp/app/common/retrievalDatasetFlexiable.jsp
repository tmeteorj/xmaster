<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<select id="tableName" name="tableName" class="form-control">
    <c:forEach var="mapOfTableName" items="${tableNameList}">
        <option value="<c:out value="${mapOfTableName.tableName}"/>"
                <c:if test="${tableName eq mapOfTableName.tableName}">selected</c:if>
                dbName="<c:out value="${mapOfTableName.tableSchema}"/>">
            <c:out value="${mapOfTableName.tableComment}"/></option>
    </c:forEach>
</select>