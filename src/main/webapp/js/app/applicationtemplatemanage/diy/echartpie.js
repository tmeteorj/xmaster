/**
 * Created by NING on 2016/10/19.
 */
var show = function(data,divid){
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById(divid));
    var data1 = new Array(data.label.length);
    console.log(data.label);
    for(var i=0 ;i<data.label.length;i++){
        var t1 = data.data[i];
        var t2 = data.label[i];
        data1[i]={'value':t1,'name': t2};
    }
    console.log(data1);
    option = {
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: data.label
        },
        series : [
            {
                name: ' ',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:data1,
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    myChart.setOption(option);
}