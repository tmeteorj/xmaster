<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/10/9
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        }, bindingDetailBtn);
    });

    function bindingDetailBtn(columns, currentData) {
        $("[dataId]").each(function () {
            $(this).bind("click", function () {
                var dataId = $(this).attr("dataId");
                var index = $(this).attr("index");
                $.ajax({
                    type: 'GET',
                    url: '/common/<c:out value="${tableName}"/>/' + dataId + '/detail1.shtml',
                    datatype: 'json',
                    async: false,
                    error: function () {
                        console.info(index);
                        index = parseInt(index);
                        var rowdata = currentData[index];
                        var detailedData = {};
                        for (var column in columns) {
                            column = columns[column];
                            if (column['colkey'] in rowdata) {
                                if (!column['name'] || column['name'] == "") {
                                    detailedData[column['colkey']] = rowdata[column['colkey']];
                                } else {
                                    detailedData[column['name']] = rowdata[column['colkey']];
                                }
                            }
                        }
                        createHtmlForDetailedInfo(detailedData);
                    },
                    success: function (detailedData) {
                        console.info(dataId);
                        detailedData = JSON.parse(detailedData);
                        createHtmlForDetailedInfo(detailedData);
                    }
                });

                $.ajax({
                    type: 'GET',
                    url: '/common/<c:out value="${tableName}"/>/' + dataId + '/' + 4 + '/getGraphbykey.shtml',
                    datatype: 'json',
                    async: false,
                    error: function () {
                    },
                    success: function (myGraph) {
                        myChart.hideLoading();
                        myGraph = JSON.parse(myGraph);
                        myGraph = JSON.parse(myGraph);
                        option = {
                            tooltip: {
                                trigger: 'item'
                            },

                            animation: false,
                            legend: {
                                data: ['地块', '事件', '机构', '人', '行为', '当前选择']
                            },
                            series: [
                                {
                                    type: 'graph',
                                    layout: 'force',
                                    animation: false,
                                    data: myGraph.nodes,
                                    links: myGraph.links,
                                    categories: myGraph.categories,
                                    draggable: true,
                                    roam: true,
                                    label: {
                                        normal: {
                                            position: 'right',
                                            formatter: '{b}'
                                        }
                                    },
                                    force: {
                                        edgeLength: 120,
                                        repulsion: 20
                                    }
                                }
                            ]
                        };
                        myChart.setOption(option);
                    }
                });
            });
        });
    }

    function createHtmlForDetailedInfo(detailedData) {
        var detailedInfo = $("#detailedInfo");
        detailedInfo.html("");
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

</script>