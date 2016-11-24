<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">
    #map {
        height: 400px;
        margin: 0 20px 20px 20px;
    }
    #panelFigure {
        height: 400px;
        margin: 0 20px 20px 20px;
    }
</style>
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
<script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
<script src="http://webapi.amap.com/maps?v=1.3&key=d811dda1aae5e80c64f364d199c05d9b&callback=init"></script>
<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/echarts/echarts-all.js"></script>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-9"><!--左侧-->
            <div class="row"><!--搜索栏-->
                <div class="col-md-12">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                检索
                            </h3>
                        </div>
                        <div class="panel-body">
                            <form id="searchForm" class="navbar-form" role="search">
                                <div class="row">
                                    <div class="form-group col-md-7">
                                        <input id="keyword" name="keyword" value="<c:out value="${keyword}"/>"
                                               type="text" class="form-control" style="width: 100%"
                                               placeholder="请输入关键字"/>
                                    </div>
                                    <input type="hidden" value="${databaseName}" name="databaseName" id="databaseName">
                                    <select id="tableName" name="tableName" class="form-control">
                                        <c:forEach var="mapOfTableName" items="${tableNameList}">
                                            <option value="<c:out value="${mapOfTableName.tableName}"/>"
                                                    <c:if test="${tableName eq mapOfTableName.tableName}">selected</c:if>
                                                    dbName="<c:out value="${mapOfTableName.tableSchema}"/>">
                                                <c:out value="${mapOfTableName.tableComment}"/></option>
                                        </c:forEach>
                                    </select>
                                    <button id="search" type="button" class="btn btn-success">
                                        检索
                                    </button>
                                </div>
                                <div class="line line-dashed pull-in"></div>
                                <div class="row ">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-4">
                                        <label class="radio-inline">
                                            <input type="radio" name="displayType" value="1"
                                                   <c:if test="${displayType eq '1'}">checked</c:if>> 集合
                                        </label>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="radio-inline">
                                            <input type="radio" name="displayType" value="2"
                                                   <c:if test="${displayType eq '2'}">checked</c:if>> 关系
                                        </label>
                                    </div>

                                    <div class="col-md-3">
                                        <label class="radio-inline">
                                            <input type="radio" name="displayType" value="3"
                                                   <c:if test="${displayType eq '3'}">checked</c:if>> 个体
                                        </label>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!--搜索栏-->
            <div class="row"><!--地图栏-->
                <div class="col-md-12">
                    <div id="map"></div>
                </div>
            </div>
            <!--地图栏-->

            <div class="row"><!--描述栏-->
                <div class="col-md-12">
                    <div id="dataDetail" class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                描述
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div id="description">
                                中心城区的概念是相对于滨海新区的，一般指市内六区，和平、河西、河北、河东、南开、红桥，包括2742个地块。
                            </div>
                        </div>
                    </div>
                    <div id="dataFigure" class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                统计图
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div id="panelFigure"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!--描述栏-->
            <div class="row"><!--列表栏-->
                <div class="col-md-12">
                    <div class="table-responsive">
                        <div id="paging" class="pagclass"></div>
                    </div>
                </div>
            </div>
            <!--列表栏-->
            <div class="row"><!--详情栏-->
                <div class="col-md-12">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                详情
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div id="detailedInfo"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!--详情栏-->
        </div>
        <!--左侧-->
        <div class="col-md-3"><!--右侧-->
            <div class="row"><!--导航栏-->
                <div class="col-md-12">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                其他
                            </h3>
                        </div>
                        <div class="panel-body"><!--body-->
                            <div class="panel-group">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            统计分析
                                        </h4>
                                    </div>
                                    <div class="panel-body">
                                        <p>
                                            <button id="TimeStat" type="button"
                                                    class="btn btn-success btn-lg btn-block">
                                                时间统计
                                            </button>
                                        </p>
                                        <p>
                                            <button id="PlaceStat" type="button" class="btn btn-info btn-lg btn-block">
                                                空间统计
                                            </button>
                                        </p>
                                        <p>
                                            <button id="btn_planeDisplay" type="button"
                                                    class="btn btn-warning btn-lg btn-block">
                                                地图展示
                                            </button>
                                        </p>
                                        <p>
                                            <button type="button" class="btn btn-danger btn-lg btn-block">
                                                其他统计2
                                            </button>
                                        </p>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!--body-->
                    </div>
                </div>
            </div>
            <!--导航栏-->
            <div class="row"><!--限定栏-->
                <div class="col-md-12">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                限定
                                <a href="javascript:void(0);" class="pull-right" id="advancedConfig">高级设置</a>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="panel-group">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            数据集限定
                                        </h4>
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">数据集</label>

                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" value="中心城区块" readonly>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            时间限定
                                        </h4>
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">年份</label>
                                            <%
                                                if (session.getAttribute("sel_year") == null) {
                                                    session.setAttribute("sel_year", 2015);
                                                }
                                            %>
                                            <div id="re_year" class="col-sm-9">
                                                <input type="text" class="form-control"
                                                       value="<%=session.getAttribute("sel_year")%>" readonly>
                                                <input type="hidden" id="sel_year"
                                                       value="<%=session.getAttribute("sel_year")%>">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">月份</label>
                                            <%
                                                if (session.getAttribute("sel_month") == null) {
                                                    session.setAttribute("sel_month", 1);
                                                }
                                            %>
                                            <div id="re_month" class="col-sm-9">
                                                <input type="text" class="form-control"
                                                       value="<%=session.getAttribute("sel_month")%>" readonly>
                                                <input type="hidden" id="sel_month"
                                                       value="<%=session.getAttribute("sel_month")%>">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            空间限定
                                        </h4>
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">国家</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" value="中国" readonly>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">州省</label>

                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" value="天津" readonly>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            属性限定
                                        </h4>
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">属性</label>

                                            <div class="col-sm-9">
                                                <%
                                                    if (session.getAttribute("sel_attr") == null) {
                                                        session.setAttribute("sel_attr", "Price");
                                                        session.setAttribute("sel_attr_chs", "房价");
                                                    }
                                                %>
                                                <div id="re_attr" class="col-sm-9">
                                                    <input type="text" id="sel_attr_chs" class="form-control"
                                                           value="<%=session.getAttribute("sel_attr_chs")%>" readonly>
                                                    <input type="hidden" id="sel_attr"
                                                           value="<%=session.getAttribute("sel_attr")%>">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <!--限定栏-->
            </div>
        </div>
        <!--右侧-->
    </div>
</div>

<script>
    var grid = null;
    var keyword = $("#keyword").val();
    var showattr = {
        eng: null,
        chs: null
    }
    function max(a, b) {
        if (a < b)return b;
        else return a;
    }

    function showPanel(response) {
        var id = response.planeid;
        var name = response.planename;
        var t = id + '-' + showattr.chs;
        console.info("gen " + id);
        $.ajax({
            type: "GET",
            url: "/visualuicreate/" + id + "/" + showattr.eng + "/search-by-pa.shtml",
            datatype: "json",
            success: function (response) {
                response = JSON.parse(response);
                console.info(response);
                if (response.code != 0) {
                    document.getElementById('panelFigure').innerHTML = "没有该地块的数据";
                } else {
                    var data = response.data;
                    var myChart = echarts.init(document.getElementById('panelFigure'));
                    option = {
                        title: {
                            text: name + '-' + showattr.chs,
                            left: 'center',
                        },
                        xAxis: {
                            type: 'category',
                            boundaryGap: false,
                            data: data.time
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            name: t,
                            type: 'line',
                            stack: '总量',
                            data: data.value
                        }]
                    };
                    myChart.setOption(option);
                }
            },
            error: function () {
                alert("Error");
            }
        });
    }
    function init() {
        map = new AMap.Map('map', {
            resizeEnable: true,
            zoom: 14,
            center: [117.172762, 39.111031]
        });
        $("#dataDetail").show();
        $("#dataFigure").hide();
    }
    function drawPolygon(attr, response) {
        console.info("draw->" + attr);
        map.clearMap();
        response = JSON.parse(response);
        if (response.code != 0) {
            alert(response.msg);
        } else {
            var data = response.data;
            var maxval = 1.0;
            for (var i = 0; i < data.length; i++) {
                for (var v in data[i].attr) {
                    maxval = max(data[i].attr[v], maxval);
                }
            }
            maxval = maxval * 1.5;
            for (var i = 0; i < data.length; i++) {
                var arr = new Array();
                for (var j = 0; j < data[i].polygon.length; j++) {
                    arr.push([data[i].polygon[j].lng, data[i].polygon[j].lat]);
                }
                var value = 0.0, planename = data[i].planename, planeid = data[i].planeid;
                for (var v in data[i].attr) {
                    value = max(data[i].attr[v], value);
                }
                var polygon = new AMap.Polygon({
                    path: arr,//设置多边形边界路径
                    strokeColor: "#F33", //线颜色
                    strokeOpacity: 1, //线透明度
                    strokeWeight: 3,    //线宽
                    fillColor: "#ee2200", //填充色
                    fillOpacity: value / maxval//填充透明度
                });

                var extD = '{"planeid":' + planeid + ',"planename":"' + planename + '","' + attr + '":' + value + '}';
                polygon.setExtData(extD);
                polygon.setMap(map);
                polygon.emit('mouseover mouseout click', {
                    target: polygon
                });
                AMap.event.addListener(polygon, 'click', function (e) {
                    showPanel(JSON.parse(e.target.getExtData()));
                });
            }

        }
    }
    function searchAttr() {
        var year = $("#sel_year").val();
        var month = $("#sel_month").val();
        var attr = $("#sel_attr").val();
        showattr.eng = attr;
        showattr.chs = $("#sel_attr_chs").val();

        console.log("searchAttr " + year + "-" + month + "-" + attr);
        $.ajax({
            type: "GET",
            url: "/visualuicreate/" + year + "/" + month + "/" + attr + "/search-by-yma.shtml",
            datatype: "json",
            success: function (data) {
                //console.log(data);
                drawPolygon(attr, data);
            },
            error: function () {
                alert("Error");
            }
        });
    }
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
            jsonUrl: rootPath + '/common/bd_plane/findByPage/1.shtml',
            checkbox: false
        }, bindingDetailBtn);

        $("#search").click(function () {
            var displayType = $("input[name='displayType']:checked").val();
            var params = $("#searchForm").serialize();
            var tb = $("#loadhtml");
            tb.html(CommnUtil.loadingImg());
            if (displayType == '1') {
                tb.load(rootPath + "/common/<c:out value="${accountName}"/>/infoRetrieval.shtml?" + params);
            } else if (displayType == '2') {
                tb.load(rootPath + "/common/<c:out value="${accountName}"/>/infoNav.shtml?" + params);
            } else if (displayType == '3') {
                tb.load(rootPath + "/common/<c:out value="${accountName}"/>/infoNavIndividual.shtml?" + params);
            }
        });
        $("#btn_planeDisplay").click(function () {
            $("#dataDetail").hide();
            $("#dataFigure").show();
            searchAttr();
        })
        $("#tableName").change(function () {
            $("#keyword").val("");
            var dbName = $("select[name='tableName'] option:selected").attr("dbName");
            $("#databaseName").val(dbName);
        });

        $("#advancedConfig").click(function () {
            advancedConfig();
        });
    });

    function bindingDetailBtn(columns, currentData) {
        $("[dataId]").each(function () {
            $(this).bind("click", function () {
                var dataId = $(this).attr("dataId");
                var index = $(this).attr("index");
                $.ajax({
                    type: 'GET',
                    url: '/common/<c:out value="${tableName}"/>/' + dataId + '/detail.shtml',
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

    function advancedConfig() {
        pageii = layer.open({
            title: "高级设置",
            type: 2,
            area: ["600px", "80%"],
            content: rootPath + '/common/bd_plane/advancedConfig.shtml'
        });
    }
</script>

