<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="cn.edu.tju.bigdata.util.ConstMap"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app/mapplaneuicreate.css"/>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
    <script src="http://webapi.amap.com/maps?v=1.3&key=您申请的key值&callback=init"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/echarts/echarts-all.js"></script>
    <script type="text/javascript">
        var map ;

        var showattr={
            eng:null,
            chs:null
        };

        var $tooltip = { //tooltip数据模型
            dom: null,
            data: ''
        };
        function bindTooltip(data, callback) {
            $tooltip.data = data ;
            $tooltip.dom.innerHTML = 'ID: '+data.planeid+'<br>'+showattr.chs+':'+data[showattr.eng]+'<br>';
            callback();
        }
        function max(a,b){
            if(a<b)return b;
            else return a;
        }
        function showPanel(data) {
            document.getElementById('panel').className = 'panel show';
            document.getElementById('title').innerHTML = data.planeid+'-'+showattr.chs;
            generateChart(data.planeid);
        }
        function generateChart(id) {
            var t=id+'-'+showattr.chs;
            console.info("gen "+id);
            $.ajax({
                type : "GET",
                url : "/visualuicreate/"+id+"/"+showattr.eng+"/search-by-pa.shtml",
                datatype:"json",
                success : function(response) {
                    document.getElementById('main')
                    response=JSON.parse(response);
                    console.info(response);
                    if(response.code!=0){
                        document.getElementById('main').innerHTML="没有该地块的数据";
                    }else{
                        var data=response.data;
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
                error : function() {
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
        function init(){
            map= new AMap.Map('container', {
                resizeEnable: true,
                zoom:14,
                center: [117.172762, 39.111031]
            });
            initWork();
            if(document.getElementById('panel')){
                document.getElementById('close').addEventListener('click', function() {
                    document.getElementById('panel').className = 'panel';
                });

                document.getElementById('panel').addEventListener('mouseover', function() {
                    $tooltip.dom.style.display = 'none';
                });
            }
            $tooltip.dom = document.getElementById('tooltip');
        }
        function initWork(){
            var type = $("#sel_work").val();
            if (type == 0) {
                $(".attr").show();
                $(".movetype").hide();
            } else {
                $(".attr").hide();
                $(".movetype").show();
            }
        };

        function drawPolygon(attr,response){
            console.info("draw->"+attr);
            map.clearMap();
            response=JSON.parse(response);
            if(response.code!=0){
                alert(response.msg);
            }else{
                var data=response.data;
                var maxval=1.0;
                for(var i=0;i<data.length;i++){
                    for(var v in data[i].attr){
                        maxval=max(data[i].attr[v],maxval);
                    }
                }
                maxval=maxval*1.5;
                for(var i=0;i<data.length;i++){
                    var arr=new Array();
                    for(var j=0;j<data[i].polygon.length;j++){
                        arr.push([data[i].polygon[j].lng,data[i].polygon[j].lat]);
                    }
                    var value=0.0,planeid=data[i].planeid;
                    for(var v in data[i].attr){
                        value=max(data[i].attr[v],value);
                    }
                    var polygon = new AMap.Polygon({
                        path: arr,//设置多边形边界路径
                        strokeColor: "#F33", //线颜色
                        strokeOpacity: 1, //线透明度
                        strokeWeight: 3,    //线宽
                        fillColor: "#ee2200", //填充色
                        fillOpacity: value/maxval//填充透明度
                    });

                    var extD = '{"planeid":'+planeid+',"'+attr+'":'+value+'}';
                    polygon.setExtData(extD);
                    polygon.setMap(map);
                    polygon.emit('mouseover mouseout click', {
                        target: polygon
                    });

                    AMap.event.addListener(polygon, 'mouseover', function(e) {
                        bindTooltip(JSON.parse(e.target.getExtData()), function() {
                            $tooltip.dom.style.display = 'block';
                        });
                        document.addEventListener('mousemove', handler);
                    });

                    AMap.event.addListener(polygon, 'mouseout', function(e) {
                        document.removeEventListener('mousemove', handler);
                        $tooltip.dom.style.display = 'none';
                    });

                    AMap.event.addListener(polygon, 'click', function(e) {
                        showPanel(JSON.parse(e.target.getExtData()));
                    });
                }

            }
        }
        function searchAttr(){
            var year=$("#sel_year").val();
            var month=$("#sel_month").val();
            var attr=$("#sel_attr").val();
            console.log("searchAttr "+year+"-"+month+"-"+attr);
            showattr.eng=attr;
            showattr.chs=$("#sel_attr").find("option:selected").text();
            $.ajax({
                type : "GET",
                url : "/visualuicreate/"+year+"/"+month+"/"+attr+"/search-by-yma.shtml",
                datatype:"json",
                success : function(data) {
                    //console.log(data);
                    drawPolygon(attr,data);
                },
                error : function() {
                    alert("Error");
                }
            });
        }

        function updateView(){
            var type=$("#sel_work").val();
            if(type==0){
                searchAttr();
            }
        }

        $(function(){
            //init();
            $("#sel_work").change(function() {
                initWork();
            });
            $("#btn_search").click(function() {
                updateView();
            });
            $("#btn_compute").click(function() {
                var year=$("#sel_year").val();
                var month=$("#sel_month").val();
                var attr=$("#sel_attr").val();
                console.log("computeAttr "+year+"-"+month+"-"+attr);
                showattr.eng=attr;
                showattr.chs=$("#sel_attr").find("option:selected").text();
                $.ajax({
                    type : "GET",
                    url : "/plane/"+year+"/"+month+"/"+attr+"/compute-by-yma.shtml",
                    datatype:"json",
                    success : function(data) {
                        alert("计算"+year+"年"+month+"月"+showattr.chs+"成功");
                    },
                    error : function() {
                        alert("计算失败，请核对数据是否正确");
                    }
                });
                alert("计算中...请勿重复点击");
            });
        });
    </script>
</head>
<body>
<div>
    <div id="div_control" style="text-align:center">

        <div id="div_work" style="width:300px;height:40px; display:inline">

            <label style="width:auto;height:40px; display:inline">功能:</label>
            <select id="sel_work" style="width:120px;height:40px; display:inline">
                <option value="0">地块特征</option>
                <!-- 			  <option value="1">人口迁徙</option> -->
            </select>
        </div>

        <div id="div_yml" style="width:300px;height:40px; display:inline">

            <label style="width:auto;height:40px; display:inline">年份:</label>
            <select id="sel_year" style="width:120px;height:40px; display:inline">
                <option value="2014">2014</option>
                <option value="2015">2015</option>
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
            <label class="attr" id="label_attr" style="width:120px;height:40px; display:inline">属性:</label>
            <select class="attr" id="sel_attr" style="width:120px;height:40px; display:inline">
                <%
                    for(String[] items:ConstMap.attrMap){
                        out.println(String.format("<option value=\"%s\">%s</option>",items[0],items[1]));
                    }
                %>
            </select>

            <label class="movetype" id="label_movetype" style="width:120px;height:40px; display:inline">类型:</label>
            <select class="movetype" id="sel_movetype" style="width:120px;height:40px; display:inline">
                <option value="0">真实迁徙</option>
                <option value="1">预测迁徙</option>
            </select>

            <input type="button" id="btn_search" value="搜索" style="width:120px;height:40px; display:inline">
            <input type="button" id="btn_compute" value="计算" style="width:120px;height:40px; display:inline">
        </div>


    </div>
    <div id="container" style="margin-top:40px;margin-left:auto;margin-right:auto;width: 100%;height: 94%">
        <div id="tooltip" class="tooltip" >this is tooltip</div>
    </div>
    <div id="panel" class="panel">
        <div id="close" class="close">×</div>
        <div id="title" class="title"></div>
        <div id="main" style="width:600px;height:300px;margin-top:0px;"></div>
    </div>
</div>
</body>
</html>