<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-7">
            <div id="graph" class="col-md-12" style="height:800px;"></div>
        </div>
        <!-- left -->
        <div class="col-md-5">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        网络属性
                    </h3>
                </div>
                <div class="panel-body">
                    <div id="loglog" style="height: 350px;"></div>
                </div>
                <div class="panel-footer">

                </div>
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        小世界效应
                    </h3>
                </div>
                <div class="panel-body">
                    <div id="line" style="height: 350px;"></div>
                </div>
                <div class="panel-footer">
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<script src="${pageContext.request.contextPath}/echarts3/echarts.min.js" type="text/javascript"></script>

<script>
    var myGraph = echarts.init(document.getElementById('graph'));
    $(function () {

        getGraph();
        getLogLogData();

        /*
         $('#loglog').highcharts({
         title: {
         text: '网络度分布'
         },
         xAxis: {
         type: 'logarithmic',
         title:{
         text:'Degree'
         }
         //minorTickInterval: 0.1
         },
         yAxis: {
         type: 'logarithmic',
         minorTickInterval: 0.1,
         title:{
         text:'Percentage'
         }
         },
         tooltip: {
         headerFormat: '<b>{series.name}</b><br />',
         pointFormat: 'x = {point.x}, y = {point.y}'
         },
         series: [{
         type:"scatter",
         data: [0.0, 0.0, 0.0, 0.5454545454545454, 0.0, 0.0, 0.22727272727272727, 0.08893280632411067, 0.0, 0.017786561264822136, 0.047430830039525695, 0.015810276679841896, 0.009881422924901184, 0.007905138339920948, 0.003952569169960474, 0.01185770750988142, 0.005928853754940711, 0.007905138339920948, 0.001976284584980237, 0.003952569169960474, 0.0, 0.0, 0.0, 0.001976284584980237, 0.0],
         pointStart: 1
         }]
        });
         */

        getLineData({
            data: {
                name: "Josh T.",
                value: "17411181"
            }
        });

        myGraph.on('click', function (param) {
            if (typeof param.data.value == 'undefined') {
                layer.msg("You miss it~");
                return;
            }
            getLineData(param);
        });
    });

    function getLogLogData() {
        var myLog = echarts.init(document.getElementById('loglog'));
        myLog.showLoading();
        var legend = '顶点度';
        $.ajax({
            type: 'GET',
            url: '/visualuicreate/network/attributes.shtml',
            datatype: 'json',
            async: false,
            error: function () {
                alert('Error occured, please try again later!');
            },
            success: function (loglogData) {
                myLog.hideLoading();

                loglogData = JSON.parse(loglogData);
                loglogData = JSON.parse(loglogData);

                option = {
                    title: {
                        text: '网络度分布',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: '{a} <br/>{b} : {c}'
                    },
                    legend: {
                        left: 'left',
                        data: [legend]
                    },
                    xAxis: {
                        type: 'category',
                        name: 'Degree',
                        splitLine: {show: true},
                        data: loglogData.xAxis
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    yAxis: {
                        type: 'log',
                        name: 'Percentage'
                    },
                    series: [
                        {
                            name: legend,
                            type: 'scatter',
                            data: loglogData.data
                        }
                    ]
                };
                myLog.setOption(option);
            }
        });
    }

    function getLineData(param) {
        var myLine = echarts.init(document.getElementById('line'));
        myLine.showLoading();
        console.info(param.data);
        var legend = param.data.name;
        $.ajax({
            type: 'GET',
            url: '/visualuicreate/' + param.data.value + '/connectivity.shtml',
            datatype: 'json',
            async: false,
            error: function () {
                alert('Error occured, please try again later!');
            },
            success: function (lineData) {
                myLine.hideLoading();

                lineData = JSON.parse(lineData);
                lineData = JSON.parse(lineData);

                option = {
                    title: {
                        text: '人物关系可达性分析',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: '{a} <br/>{b} : {c}'
                    },
                    legend: {
                        left: 'left',
                        data: [legend]
                    },
                    xAxis: {
                        type: 'category',
                        name: 'Degree',
                        splitLine: {show: true},
                        data: lineData.xAxis
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    yAxis: {
                        type: 'value',
                        name: 'Number'
                    },
                    series: [
                        {
                            name: legend,
                            type: 'line',
                            data: lineData.data
                        }
                    ]
                };
                myLine.setOption(option);
            }
        });
    }

    function getGraph(data) {
        myGraph.showLoading();

        $.ajax({
            type: 'post',
            url: '/visualuicreate/getGraph.shtml',
            datatype: 'json',
            data: data,
            error: function () {
                alert('Error occured, please try again later!');
            },
            success: function (myGraphData) {
                myGraph.hideLoading();
                myGraphData = JSON.parse(myGraphData);
                myGraphData = JSON.parse(myGraphData);
                option = {
                    legend: myGraphData.legend,
                    series: [{
                        type: 'graph',
                        layout: 'force',
                        animation: false,
                        label: {
                            normal: {
                                position: 'right',
                                formatter: '{b}'
                            }
                        },
                        draggable: true,
                        data: myGraphData.nodes.map(function (node, idx) {
                            node.id = idx;
                            return node;
                        }),
                        categories: myGraphData.categories,
                        force: {
                            initLayout: 'circular',
                            edgeLength: 5,
                            repulsion: 20
                        },
                        edges: myGraphData.links
                    }]
                };

                myGraph.setOption(option);
            }
        });
    }

</script>