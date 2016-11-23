<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/echarts3/echarts.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/echarts3/world.js"></script>
<div class="row">
    <div id="barChart" class="col-md-12" style="height:100%;"></div>
</div>
<script>

    var myChart = echarts.init(document.getElementById('barChart'));

    $(function () {
        getStatData();
    });

    function getStatData() {
        myChart.showLoading();

        var tableName = "<c:out value="${tableName}"/>";
        $.ajax({
            type: 'get',
            url: '/common/timeStatData/' + tableName + '.shtml',
            datatype: 'json',
            error: function () {
                alert('Error occured, please try again later!');
            },
            success: function (statData) {
                myChart.hideLoading();
                statData = JSON.parse(statData);

                option = {
                    title: {
                        text: 'Time Statistics',
                    },
                    tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        data: statData.legend
                    },
                    toolbox: {
                        show: true,
                        feature: {
                            //dataView : {show: true, readOnly: false},
                            magicType: {show: true, type: ['line', 'bar']},
                            //restore : {show: true},
                            //saveAsImage : {show: true}
                        }
                    },
                    calculable: true,
                    xAxis: [
                        {
                            type: 'category',
                            data: statData.xAxis
                        }
                    ],
                    yAxis: [
                        {
                            type: 'value'
                        }
                    ],
                    series: [
                        {
                            name: statData.legend[0],
                            type: 'bar',
                            data: statData.yAxis,
                            markPoint: {
                                data: [
                                    {type: 'max', name: 'Maximum value'},
                                    {type: 'min', name: 'Minimum value'}
                                ]
                            },
                            markLine: {
                                data: [
                                    {type: 'average', name: 'Average value'}
                                ]
                            }
                        }
                    ]
                };


                if (option && typeof option === "object") {
                    myChart.setOption(option, true);
                }
            }
        });
    }

</script>