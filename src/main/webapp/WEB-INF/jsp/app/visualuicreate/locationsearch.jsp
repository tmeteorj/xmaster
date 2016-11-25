<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="cn.edu.tju.bigdata.util.ConstMap" %>
<meta charset="utf-8">
<style type="text/css">
    #map {
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
                            <div id="div_control" style="text-align:center">

                                <div id="div_work" style="width:300px;height:40px; display:inline">

                                    <label style="width:auto;height:40px; display:inline">功能:</label>
                                    <select id="sel_work" style="width:120px;height:40px; display:inline">
                                        <option value="0">ATM信息</option>
                                        <option value="1">网点信息</option>
                                    </select>
                                </div>

                                <div id="div_yml" style="width:300px;height:40px; display:inline">

                                    <label style="width:auto;height:40px; display:inline">年份:</label>
                                    <select id="sel_year" style="width:120px;height:40px; display:inline">
                                        <option value="2015">2015</option>
                                        <option value="2015">2014</option>
                                        <option value="2015">2013</option>
                                    </select>

                                    <label style="width:auto;height:40px; display:inline">月份:</label>
                                    <select id="sel_month" style="width:120px;height:40px; display:inline">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>
                                    <label class="attr" id="label_attr" style="width:120px;height:40px; display:inline">类型:</label>
                                    <select class="attr" id="sel_attr" style="width:120px;height:40px; display:inline">
                                        <option value="1">本代本取现交易</option>
                                        <option value="2">本代它取现交易</option>
                                        <option value="3">本行转账</option>
                                        <option value="4">跨行转账转出</option>
                                        <option value="5">跨行转账转入</option>
                                        <option value="6">跨行转账</option>
                                        <option value="7">电费缴费</option>
                                        <option value="8">有线电视缴费</option>
                                        <option value="9">交通罚款缴费</option>
                                        <option value="10">手机充值缴费</option>
                                        <option value="11">固话充值缴费</option>

                                    </select>

                                    <label class="movetype" id="label_movetype"
                                           style="width:120px;height:40px; display:inline">类型:</label>
                                    <select class="movetype" id="sel_movetype"
                                            style="width:120px;height:40px; display:inline">
                                        <option value="0">真实迁徙</option>
                                        <option value="1">预测迁徙</option>
                                    </select>

                                    <input type="button" id="btn_search" value="检索"
                                           style="width:120px;height:40px; display:inline">
                                </div>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--搜索栏-->
            <div class="row"><!--地图栏-->
                <div class="col-md-12">
                    <div id="map">
                        <div id="tooltip" class="tooltip">this is tooltip</div>
                        <div id="panel" class="panel">
                            <div id="close" class="close">×</div>
                            <div id="title" class="title"></div>
                            <div id="main"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!--地图栏-->
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
                                导航
                            </h3>
                        </div>
                        <div class="panel-body"><!--body-->
                            <div class="panel-group">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            时间导航
                                        </h4>
                                    </div>
                                    <div class="panel-body">
                                        <li><a href="#">年</a></li>
                                        <li><a href="#">月</a></li>
                                        <li><a href="#">日</a></li>
                                        <li><a href="#">周次</a></li>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            空间导航
                                        </h4>
                                    </div>
                                    <div class="panel-body">
                                        <li><a href="#">市区/郊区</a></li>
                                        <li><a href="#">区县</a></li>
                                        <li><a href="#">一级支行</a></li>
                                        <li><a href="#">二级支行</a></li>
                                        <li><a href="#">分理处</a></li>
                                        <li><a href="#">营业网点</a></li>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            关系导航
                                        </h4>
                                    </div>
                                    <div class="panel-body">
                                        <li><a href="#">属于同一支行</a></li>
                                        <li><a href="#">属于同一社区</a></li>
                                        <li><a href="#">属于同一分理处</a></li>
                                        <li><a href="#">发生资金往来</a></li>
                                        <li><a href="#">属于同一客户类型</a></li>
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
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">数据集</label>

                                <div class="col-sm-9">
                                    <select class="form-control">
                                        <option>股份制银行</option>
                                        <option>国有四大银行</option>
                                        <option>天津市农商银行</option>
                                        <option>天津郊县区块</option>
                                        <option selected>天津中心城区块</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">起始</label>

                                <div class="col-sm-9">
                                    <div class="input-group date form_date" data-date="" data-date-format="yyyy-MM-dd"
                                         data-link-field="" data-link-format="yyyy-mm-dd">
                                        <input class="form-control" size="16" type="text" value="2009-12-10" readonly>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                    <input type="hidden" value=""/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">截止</label>

                                <div class="col-sm-9">
                                    <div class="input-group date form_date" data-date="" data-date-format="yyyy-MM-dd"
                                         data-link-field="" data-link-format="yyyy-mm-dd">
                                        <input class="form-control" size="16" type="text" value="2016-01-01" readonly>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                    <input type="hidden" value=""/>
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
    var pageii = null;
    var grid = null;
    var keyword = $("#keyword").val();
    var showattr = {
        eng: null,
        chs: null
    };
    var $tooltip = { //tooltip数据模型
        dom: null,
        data: ''
    };
    function bindTooltip(data, callback) {
        $tooltip.data = data;
        $tooltip.dom.innerHTML = 'ID: ' + data.planeid + '<br>' + showattr.chs + ':' + data[showattr.eng] + '<br>';
        callback();
    }
    function max(a, b) {
        if (a < b)return b;
        else return a;
    }
    function showPanel(data) {
        document.getElementById('panel').className = 'panel show';
        document.getElementById('title').innerHTML = data.planename + '-' + showattr.chs;
        generateChart(data.planeid);
    }
    function generateChart(id) {
        var t = id + '-' + showattr.chs;
        console.info("gen " + id);
        $.ajax({
            type: "GET",
            url: "/visualuicreate/" + id + "/" + showattr.eng + "/search-by-pa.shtml",
            datatype: "json",
            success: function (response) {
                document.getElementById('main')
                response = JSON.parse(response);
                console.info(response);
                if (response.code != 0) {
                    document.getElementById('main').innerHTML = "没有该地块的数据";
                } else {
                    var data = response.data;
                    var myChart = echarts.init(document.getElementById('main'));
                    option = {
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
    function handler(e) {
        relocate(e.clientX, e.clientY); //分发事件参数
    }
    function relocate(x, y) {
        $tooltip.dom.style.left = (+x + 3) + 'px';
        $tooltip.dom.style.top = (+y + 3) + 'px';
    }
    function init() {
        map = new AMap.Map('map', {
            resizeEnable: true,
            zoom: 14,
            center: [117.172762, 39.111031]
        });
        $("#sel_work").change(function () {
            initWork();
        });
        $("#btn_search").click(function () {
            updateView();
        });
        initWork();
        if (document.getElementById('panel')) {
            document.getElementById('close').addEventListener('click', function () {
                document.getElementById('panel').className = 'panel';
            });

            document.getElementById('panel').addEventListener('mouseover', function () {
                $tooltip.dom.style.display = 'none';
            });
        }
        $tooltip.dom = document.getElementById('tooltip');
    }
    function initWork() {
        var type = $("#sel_work").val();
        if (type == 0) {
            $(".attr").show();
            $(".movetype").hide();
        } else {
            $(".attr").hide();
            $(".movetype").show();
        }
    }
    ;
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

                AMap.event.addListener(polygon, 'mouseover', function (e) {
                    bindTooltip(JSON.parse(e.target.getExtData()), function () {
                        $tooltip.dom.style.display = 'block';
                    });
                    document.addEventListener('mousemove', handler);
                });

                AMap.event.addListener(polygon, 'mouseout', function (e) {
                    document.removeEventListener('mousemove', handler);
                    $tooltip.dom.style.display = 'none';
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
        console.log("searchAttr " + year + "-" + month + "-" + attr);
        showattr.eng = attr;
        showattr.chs = $("#sel_attr").find("option:selected").text();
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
    function updateView() {
        var type = $("#sel_work").val();
        if (type == 0) {
            searchAttr();
        }
    }
    $(function () {
        console.log("11111111111111111")
        <c:forEach items="${records}" var="table" varStatus="status">
            console.log(11)
        </c:forEach>
        grid = lyGrid({
            pagId: 'paging',
            l_column: [
                <c:forEach items="${tableList}" var="table" varStatus="status">
                {

                    colkey: "<c:out value="${table.columnName}"/>",
                    name: "<c:choose><c:when test="${!table.columnComment && table.columnComment != ''}"><c:out value="${table.columnComment}"/></c:when><c:otherwise><c:out value="${table.columnName}"/></c:otherwise></c:choose>",
                    <c:if test="${table.columnKey == 'PRI' or table.columnName == 'remark' or table.columnName == 'deleted_mark'}">
                    hide: true,
                    </c:if>
                    <c:if test="${table.dataType == 'timestamp' || table.dataType == 'datetime'}">
                    renderData: function (rowindex, data, rowdata, column) {
                        return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                    }
                    </c:if>
                },
                </c:forEach>
                {
                    colkey: "__id__",
                    name: "操作"
                }],
            jsonUrl: rootPath + '/common/bd_location_branch/findByPage/1.shtml',
            checkbox: false
        }, bindingDetailBtn);

        $("#search").click(function () {
            var tableName = $("#tableName").val();
            var keyword = $("#keyword").val();
            var tb = $("#loadhtml");
            tb.html(CommnUtil.loadingImg());
            tb.load(rootPath + "/common/<c:out value="${accountName}"/>/infoRetrieval.shtml?tableName=" + tableName + '&keyword=' + keyword);
        });

        $("#tableName").change(function () {
            $("#keyword").val("");
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
    $('.form_date').datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
</script>

