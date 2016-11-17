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
<div class="table-responsive">
    <div id="paging" class="pagclass"></div>
</div>
<script>
    $(function () {
        grid = lyGrid({
            pagId: 'paging',
            l_column: [
                <c:forEach items="${tableList}" var="table" varStatus="status">
                <c:if test="${status.index<=10}">
                {
                    colkey: "<c:out value="${table.columnName}"/>",
                    name: "<c:choose><c:when test="${!table.columnComment && table.columnComment != ''}"><c:out value="${table.columnComment}"/></c:when><c:otherwise><c:out value="${table.columnName}"/></c:otherwise></c:choose>",
                    <c:if test="${table.columnName == 'id' or table.columnName == 'remark' or table.columnName == 'deleted_mark'}">
                    hide: true,
                    </c:if>
                    <c:if test="${table.dataType == 'timestamp' || table.dataType == 'datetime'}">
                    renderData: function (rowindex, data, rowdata, column) {
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    }
                    </c:if>
                },
                </c:if>
                </c:forEach>
                {
                    colkey: "__id__",
                    name: "操作"
                }],
            jsonUrl: rootPath + '/common/<c:out value="${tableName}"/>/showData.shtml',
            checkbox: false
        });
        $("[dataId]").each(function () {
            $(this).bind("click", function () {
                var dataId = $(this).attr("dataId");
                console.info(dataId);
                $.ajax({
                    type: 'GET',
                    url: '/common/<c:out value="${tableName}"/>/' + dataId + '/detail1.shtml',
                    datatype: 'json',
                    async: false,
                    error: function () {
                        alert('Error occured, please try again later!');
                    },
                    success: function (detailedData) {
                        var detailedInfo = $("#detailedInfo");
                        detailedInfo.html("");
                        detailedData = JSON.parse(detailedData);
                        var html = "";
                        $.each(detailedData, function (key) {
                            html +=
                                    "            <div class=\"form-group\">\n" +
                                    "                <label class=\"col-sm-2 control-label\">"
                            ;
                            html += key;
                            html +=
                                    "</label>\n" +
                                    "                <div class=\"col-sm-4\">\n" +
                                    "                    <input type=\"text\" class=\"form-control\" value=\""
                            ;
                            html += detailedData[key];
                            html +=
                                    "\" readonly/>\n" +
                                    "                </div>\n" +
                                    "            </div>"
                            ;
                        });
                        detailedInfo.html(html);
                    }
                });
            });
        });
    });

</script>