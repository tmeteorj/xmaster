/**
 * Created by NING on 2016/10/19.
 */

var show = function(data) {
    var nodes = new Array(data.id.length);
    var links = new Array(data.source.length);
    for(var i = 0;i<data.id.length;i++){
        nodes[i]={'itemStyle':null,'symbolSize': 10,'category':i,
        'x':null,'y':null,'name':data.label[i],'id':data.id[i],'draggable':true};
    }
    for(var i = 0;i<data.source.length;i++){
        links[i]={'name':null,'id':i,'source':data.source[i],'target':data.target[i]};
    }
    var categories = data.label;
    var myChart = echarts.init(document.getElementById('con'));

    option = {
        title: {
            subtext: 'Default layout',
            top: 'bottom',
            left: 'right'
        },
        tooltip: {},
        animation: false,
        series : [
            {
                type: 'graph',
                layout: 'force',
                data: nodes,
                links: links,
                categories: categories,
                roam: true,
                label: {
                    normal: {
                        position: 'right'
                    }
                },
                force: {
                    repulsion: 100
                }
            }
        ]
    };
    myChart.setOption(option);
}