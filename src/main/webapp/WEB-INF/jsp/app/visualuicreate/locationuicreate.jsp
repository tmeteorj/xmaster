<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app/mapplaneuicreate.css"/>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
    <script src="http://webapi.amap.com/maps?v=1.3&key=e87c9dc2ceb569b35152f633c4e768a9&callback=init"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/echarts/echarts-all.js"></script>
    <link href="${ctx}/js/date/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript">

    </script>
</head>
<body>
<div>
    <div id="div_control">
        <div class="tabbable" id="tabs-85140" style="margin-left:10px"> <!-- Only required for left/right tabs -->
            <ul class="nav nav-tabs">
                <li class="active"><a href="#panel-952955" data-toggle="tab">数据预览</a></li>
                <li><a href="#panel-177581" data-toggle="tab">数据可视化</a></li>
                <li><a href="#panel-177582" data-toggle="tab">设施选址</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="panel-952955" contenteditable="false">
                    <br>
                    <b>
                        地块数据(test)
                        hihihihihihi
                    </b>

                    <table class="table table-bordered" style="margin-top:10px">
                        <thead>
                        <tr>
                            <th>编号</th>
                            <th>产品</th>
                            <th>交付时间</th>
                            <th>状态</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>1</td>
                            <td>TB - Monthly</td>
                            <td>01/04/2012</td>
                            <td>Default</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>TB - Monthly</td>
                            <td>01/04/2012</td>
                            <td>Approved</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>TB - Monthly</td>
                            <td>02/04/2012</td>
                            <td>Declined</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>TB - Monthly</td>
                            <td>03/04/2012</td>
                            <td>Pending</td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>TB - Monthly</td>
                            <td>04/04/2012</td>
                            <td>Call in to confirm</td>
                        </tr>
                        </tbody>
                    </table>

                    <br>
                    <b>
                        ATM数据
                    </b>

                    <table class="table table-bordered" style="margin-top:10px">
                        <thead>
                        <tr>
                            <th>编号</th>
                            <th>产品</th>
                            <th>交付时间</th>
                            <th>状态</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>1</td>
                            <td>TB - Monthly</td>
                            <td>01/04/2012</td>
                            <td>Default</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>TB - Monthly</td>
                            <td>01/04/2012</td>
                            <td>Approved</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>TB - Monthly</td>
                            <td>02/04/2012</td>
                            <td>Declined</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>TB - Monthly</td>
                            <td>03/04/2012</td>
                            <td>Pending</td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>TB - Monthly</td>
                            <td>04/04/2012</td>
                            <td>Call in to confirm</td>
                        </tr>
                        </tbody>
                    </table>

                </div>
                <div class="tab-pane" id="panel-177581" contenteditable="false">
                    <br>

                    <div class="btn-group">
                        <button type="button" class="btn btn-default">地块划分</button>
                        <button type="button" class="btn btn-default">已有设施</button>
                        <button type="button" class="btn btn-default">需求热力图</button>
                    </div>

                    <div id="mymap" style="margin-top:10px;margin-left:auto;margin-right:auto;width: 100%;height: 94%">
                    </div>
                    <script>

                        var map = new AMap.Map('mymap', {
                            resizeEnable: true,
                            zoom: 11,
                            center: [116.397428, 39.90923]

                        });

                        var markers = [], positions = [[116.405467, 39.907761], [116.415467, 39.907761], [116.415467, 39.917761], [116.425467, 39.907761], [116.385467, 39.907761]];
                        for (var i = 0, marker; i < positions.length; i++) {
                            marker = new AMap.Marker({
                                map: map,
                                position: positions[i]
                            });
                            markers.push(marker);
                        }

                    </script>

                </div>

                <div class="tab-pane" id="panel-177582">
                    <div class="row">
                        <br>

                        <div class="col-xs-3 col-md-2">
                            <div id="div_work" style="display:inline">
                                <label>选址类型:</label>
                                <select id="sel_work" class="form-control">
                                    <option value="0">ATM选址</option>
                                    <option value="1">网点选址</option>
                                    <option value="2">消防站选址</option>
                                    <!-- 			  <option value="1">人口迁徙</option> -->
                                </select>
                            </div>
                        </div>
                        <div class="col-xs-3 col-md-2">
                            <div id="div_model" style="display:inline">
                                <label>选址模型:</label>
                                <select id="sel_model" class="form-control">
                                    <option value="0">卷积模型</option>
                                    <option value="1">经验模型</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-xs-3 col-md-2">
                            <div style="display:inline">
                                <label>选址数量:</label>
                                <br>
                                <input class="form-control" id="exampl" placeholder="请输入数字">
                            </div>
                        </div>
                        <div class="col-xs-3 col-md-2">
                            <div style="display:inline">
                                <label>开始选址:</label>
                                <br>
                                <button type="button" class="form-control">
                                    确认
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-8">
                            <div id="mymap1"
                                 style="margin-top:10px;margin-left:auto;margin-right:auto;width: 100%;height: 94%">
                            </div>
                            <script>

                                var map = new AMap.Map('mymap1', {
                                    resizeEnable: true,
                                    zoom: 11,
                                    center: [116.397428, 39.90923]

                                });

                                var markers = [], positions = [[116.405467, 39.907761], [116.415467, 39.907761], [116.415467, 39.917761], [116.425467, 39.907761], [116.385467, 39.907761]];
                                for (var i = 0, marker; i < positions.length; i++) {
                                    marker = new AMap.Marker({
                                        map: map,
                                        position: positions[i]
                                    });
                                    markers.push(marker);
                                }

                            </script>
                        </div>
                        <div class="col-md-4">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>编号</th>
                                    <th>产品</th>
                                    <th>交付时间</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>TB - Monthly</td>
                                    <td>01/04/2012</td>
                                    <td>Default</td>
                                </tr>
                                <tr>
                                    <td>1</td>
                                    <td>TB - Monthly</td>
                                    <td>01/04/2012</td>
                                    <td>Approved</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>TB - Monthly</td>
                                    <td>02/04/2012</td>
                                    <td>Declined</td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>TB - Monthly</td>
                                    <td>03/04/2012</td>
                                    <td>Pending</td>
                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td>TB - Monthly</td>
                                    <td>04/04/2012</td>
                                    <td>Call in to confirm</td>
                                </tr>
                                </tbody>
                            </table>

                        </div>

                    </div>


                </div>

            </div>
        </div>
    </div>


    <%--<div id="container" style="margin-top:40px;margin-left:auto;margin-right:auto;width: 100%;height: 94%">--%>
    <%--<div id="tooltip" class="tooltip">this is tooltip</div>--%>
    <%--</div>--%>
    <%--<div id="panel" class="panel">--%>
    <%--<div id="close" class="close">×</div>--%>
    <%--<div id="title" class="title"></div>--%>
    <%--<div id="main" style="width:600px;height:300px;margin-top:0px;"></div>--%>
    <%--</div>--%>


    <%--<div id="mymap" style="margin-top:40px;margin-left:auto;margin-right:auto;width: 100%;height: 94%">--%>
    <%--</div>--%>
    <%--<script>--%>
    <%--var map = new AMap.Map('mymap', {--%>
    <%--resizeEnable: true,--%>
    <%--zoom:11,--%>
    <%--center: [116.397428, 39.90923]--%>

    <%--});--%>

    <%--</script>--%>


</body>

</html>