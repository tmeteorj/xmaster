<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/location/locationscore.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/location/locationatm.js"></script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/resourcemanage/datasetmanage.js"></script>--%>
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
        var map;
        $(function(){
            $("#relitu").click(function() {
                show_relitu();
            });
            $("#grid_cut").click(function() {
                show_grid();
            });
            $("#clearmap").click(function() {
                init();
            });

        });
        function add_line(a_lng, a_lat, b_lng, b_lat){
            console.log(a_lng);
            var lineArr = [
                [a_lng, a_lat],
                [b_lng, b_lat],
            ];
            var polyline = new AMap.Polyline({
                path: lineArr,          //设置线覆盖物路径
                strokeColor: "#3366FF", //线颜色
                strokeOpacity: 1,       //线透明度
                strokeWeight: 2,        //线宽
                strokeStyle: "solid",   //线样式
                strokeDasharray: [10, 5] //补充线样式
            });
            polyline.setMap(map);
        }
        function show_grid(){
            var left_up_lng = 117.119114;
            var left_up_lat = 39.200131;
            var right_dw_lng = 117.324593;
            var right_dw_lat = 39.06018;
            var level = 80;
            var gap_lng = (right_dw_lng-left_up_lng)/level;
            var gap_lat = (left_up_lat-right_dw_lat)/level;
            var temp=left_up_lng;
            for(var i=0;i<level;++i){
                temp += gap_lng;
                add_line(temp, left_up_lat, temp, right_dw_lat);
            }
            temp = left_up_lat;
            for(var i=0;i<level;++i){
                temp -= gap_lat;
                add_line(left_up_lng, temp, right_dw_lng, temp);
            }

        }
        function init() {
            map = new AMap.Map('mymap', {
                resizeEnable: true,
                zoom: 14,
                center: [117.172762, 39.163204]

            });
        }
        function draw_relitu(response){
            map.clearMap();
            response=JSON.parse(response);
//            response=JSON.parse(response);
            console.log("here-> response");
            console.log(response);
            if(response.code!=0){
                alert(response.msg);
            }else {
                var data = response.data;

                map.plugin(["AMap.Heatmap"], function() {
                    //初始化heatmap对象
                    heatmap = new AMap.Heatmap(map, {
                        radius: 50, //给定半径
                        opacity: [0, 0.8]
                    });
                        heatmap.setDataSet({
                        data: data,
                        max: 100
                    });
                });
            }
        }
        function show_relitu(){
            $.ajax({
                type : "GET",
                url : "/visualuicreate/datarelitu.shtml",
                datatype:"json",
                success : function(data) {
                    //console.log(data);
                    draw_relitu(data);

                },
                error : function() {
                    alert("Error");
                }
            });
        }

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
                    <div>
                        <b>
                            地块数据
                        </b>
                    </div>


                    <div class="table-responsive">
                    <div id="paging" class="pagclass"></div>
                    </div>
                    <br>
                    <div>
                        <b>
                            ATM数据
                        </b>
                    </div>

                    <div class="table-responsive">
                        <div id="paging2" class="pagclass"></div>
                    </div>



                </div>
                <div class="tab-pane" id="panel-177581" contenteditable="false">
                    <br>

                    <div class="btn-group">
                        <button id="grid_cut" type="button" class="btn btn-default">地块划分</button>
                        <button id="device_ex" type="button" class="btn btn-default">已有设施</button>
                        <button id="relitu" type="button" class="btn btn-default">需求热力图</button>
                        <button id="clearmap" type="button" class="btn btn-default">清除地图</button>
                    </div>

                    <div id="mymap" style="margin-top:10px;margin-left:10px;margin-right:10px;width: 100%;height: 94%">
                    </div>

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
                                    center: [117.137322,39.089485]

                                });

                                var markers = [], positions = [[117.137322,39.089485],[117.119946,39.067454],[117.102569,39.093891],[117.270544,38.895611],[117.038854,39.076267],[117.148907,39.067454],[117.229998,39.045423],[116.975139,39.093891],[117.096776,39.129141],[117.264752,38.988142]];
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
                                    <th>经度</th>
                                    <th>纬度</th>
                                    <th>推荐指数</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>117.137322</td>
                                    <td>39.089485</td>
                                    <td>10</td>
                                </tr>
                                <tr>
                                    <td>1</td>
                                    <td>117.119946</td>
                                    <td>39.067454</td>
                                    <td>9</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>117.102569</td>
                                    <td>39.093891</td>
                                    <td>8</td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>117.270544</td>
                                    <td>38.895611</td>
                                    <td>7</td>
                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td>117.038854</td>
                                    <td>39.076267</td>
                                    <td>6</td>
                                </tr>
                                </tbody>
                            </table>

                        </div>

                    </div>


                </div>

            </div>
        </div>
    </div>
</div>
</body>

</html>