<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div class="row">
    <form id="searchForm" class="navbar-form navbar-left" role="search">
        <div class="form-group">
            <input id="keyword" name="<c:out value="${tableName}"/>.name" value="<c:out value="${keyword}"/>"
                   type="text" class="form-control" placeholder="请输入关键字"/>
        </div>
        <select id="tableName" name="tableName" class="form-control">
            <option value="">请选择</option>
            <option value="bd_dataset" <c:if test="${tableName eq 'bd_dataset'}">selected</c:if>>数据集</option>
            <option value="bd_event" <c:if test="${tableName eq 'bd_event'}">selected</c:if>>活动</option>
            <option value="bd_meetup" <c:if test="${tableName eq 'bd_meetup'}">selected</c:if>>组织</option>
            <option value="bd_member" <c:if test="${tableName eq 'bd_member'}">selected</c:if>>成员</option>
        </select>
        <button id="search" type="button" class="btn btn-success">
            检索
        </button>
    </form>
</div>

<div class="table-responsive">
    <div id="paging" class="pagclass"></div>
</div>

<script>
    var pageii = null;
    var grid = null;
    var keyword = $("#keyword").val();
    $(function () {
        grid = lyGrid({
            id: 'paging',
            l_column: [
                <c:forEach items="${tableList}" var="table" varStatus="status">
                {
                    colkey: "<c:out value="${table.columnName}"/>",
                    name: "<c:choose><c:when test="${!table.columnComment && table.columnComment != ''}"><c:out value="${table.columnComment}"/></c:when><c:otherwise><c:out value="${table.columnName}"/></c:otherwise></c:choose>",
                    <c:if test="${table.columnKey == 'PRI'}">
                    hide: true,
                    </c:if>
                    <c:if test="${table.dataType == 'timestamp' || table.dataType == 'datetime'}">
                    renderData: function (rowindex, data, rowdata, column) {
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    }
                    </c:if>
                },
                </c:forEach>],
            jsonUrl: rootPath + '/table/<c:out value="${tableName}"/>/findByPage/1.shtml?<c:out value="${tableName}"/>.name=' + keyword,
            checkbox: false
        });

        $("#search").click(function () {
            var tableName = $("#tableName").val();
            var keyword = $("#keyword").val();
            var tb = $("#loadhtml");
            tb.html(CommnUtil.loadingImg());
            tb.load(rootPath + "/common/<c:out value="${accountName}"/>/infoRetrieval.shtml?tableName=" + tableName + '&keyword=' + keyword);
        });
    });

</script>