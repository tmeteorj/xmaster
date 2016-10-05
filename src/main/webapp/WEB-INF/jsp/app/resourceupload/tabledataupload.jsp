<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
    #map {
        height: 350px;
        margin: 0 20px 20px 20px;
    }
</style>
<div class="row">
    <div id="map"></div>
</div>
<div class="m-b-md">
    <form class="form-inline" role="form" id="searchForm"
          name="searchForm">
        <c:forEach items="${searchList}" var="table">
            <div class="form-group">
                <label class="control-label"> <span
                        class="h4 font-thin v-middle"><c:out value="${table.columnComment}"/>:</span></label> <input
                    class="input-medium ui-autocomplete-input" id="<c:out value="${table.columnName}"/>"
                    name="<c:out value="${table.tableName}"/>.<c:out value="${table.columnName}"/>">
            </div>
        </c:forEach>
        <a href="javascript:void(0)" class="btn btn-primary" id="search">查询</a>
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
<script>
    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: -34.397, lng: 150.644},
            // center: {lat: 39.80, lng: 116.23}, // Beijing
            zoom: 8
        });
    }
</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCJAZFHarSBlboid2Qlv4FyVh3QmIL3Y2Q&callback=initMap">
</script>
<script>
    var pageii = null;
    var grid = null;
    $(function () {
        grid = lyGrid({
            id: 'paging',
            l_column: [
                <c:forEach items="${tableList}" var="table" varStatus="status">
                {
                    colkey: "<c:out value="${table.columnName}"/>",
                    name: "<c:out value="${table.columnComment}"/>",
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
            jsonUrl: rootPath + '/table/<c:out value="${tableName}"/>/findByPage.shtml',
            checkbox: true
        });

        $("#search").click("click", function () {// 绑定查询按扭
            var searchParams = $("#searchForm").serializeJson();
            grid.setOptions({
                data: searchParams
            });
        });

        $("#addFun").click("click", function () {
            addFun();
        });
        $("#editFun").click("click", function () {
            editFun();
        });
        $("#delFun").click("click", function () {
            delFun();
        });
        $("#auditFun").click("click", function () {
            auditFun();
        });
    });

    function editFun() {
        var cbox = grid.getSelectedCheckbox();
        if (cbox.length > 1 || cbox == "") {
            layer.msg("只能选中一个");
            return;
        }
        pageii = layer.open({
            title: "编辑",
            type: 2,
            area: ["600px", "80%"],
            content: rootPath + '/table/<c:out value="${tableName}"/>/' + cbox + '/edit.shtml'
        });
    }
    function addFun() {
        pageii = layer.open({
            title: "新增",
            type: 2,
            area: ["600px", "80%"],
            content: rootPath + '/table/<c:out value="${tableName}"/>/add.shtml'
        });
    }
    function delFun() {
        var cbox = grid.getSelectedCheckbox();
        if (cbox.length > 1 || cbox == "") {
            layer.msg("只能选中一个");
            return;
        }
        layer.confirm('是否删除？', function (index) {
            var url = rootPath + '/table/<c:out value="${tableName}"/>/' + cbox + '/delete.shtml';
            var s = CommnUtil.ajax(url, {}, "json");
            if (s == "success") {
                layer.msg('删除成功');
                grid.loadData();
            } else {
                layer.msg('删除失败');
            }
        });
    }

    function auditFun() {
        var cbox = grid.getSelectedCheckbox();
        if (cbox.length > 1 || cbox == "") {
            layer.msg("只能选中一个");
            return;
        }
        var url = rootPath + '/table/<c:out value="${tableName}"/>/' + cbox + '/check.shtml';
        var s = CommnUtil.ajax(url, {}, "json");
        if (!s) {
            layer.msg('已审核过，无需再审！');
            grid.loadData();
            return;
        }
        pageii = layer.open({
            title: "审核",
            type: 2,
            area: ["600px", "20%"],
            content: rootPath + '/table/<c:out value="${tableName}"/>/' + cbox + '/audit.shtml'
        });
    }
</script>