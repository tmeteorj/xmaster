<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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

  function echartcode3(ss){
    option = {
      title: {
        text: '',
        subtext: '纯属虚构',
        x:'right',
        y:'bottom'
      },
      tooltip: {
        trigger: 'item',
        backgroundColor : 'rgba(0,0,250,0.2)'
      },
      legend: {
        data: (function (){
          var list = [];
          for (var i = 1; i <=28; i++) {
            list.push(i + 2000 + '');
          }
          return list;
        })()
      },
      visualMap: {
        color: ['red', 'yellow']
      },
      radar: {
        indicator : [
          { text: 'IE8-', max: 400},
          { text: 'IE9+', max: 400},
          { text: 'Safari', max: 400},
          { text: 'Firefox', max: 400},
          { text: 'Chrome', max: 400}
        ]
      },
      series : (function (){
        var series = [];
        for (var i = 1; i <= 28; i++) {
          series.push({
            name:'浏览器（数据纯属虚构）',
            type: 'radar',
            symbol: 'none',
            itemStyle: {
              normal: {
                lineStyle: {
                  width:1
                }
              },
              emphasis : {
                areaStyle: {color:'rgba(0,250,0,0.3)'}
              }
            },
            data:[
              {
                value:[
                  (40 - i) * 10,
                  (38 - i) * 4 + 60,
                  i * 5 + 10,
                  i * 9,
                  i * i /2
                ],
                name: i + 2000 + ''
              }
            ]
          });
        }
        return series;
      })()
    };
    if (option && typeof option === "object") {
      myChart.setOption(option, true);
    }
  }
  function echartcode2(ss){
//        var app.title = '柱状图框选';

    var xAxisData = [];
    var data1 = [];
    var data2 = [];
    var data3 = [];
    var data4 = [];

    for (var i = 0; i < 10; i++) {
      xAxisData.push('Class' + i);
      data1.push((Math.random() * 2).toFixed(2));
      data2.push(-Math.random().toFixed(2));
      data3.push((Math.random() * 5).toFixed(2));
      data4.push((Math.random() + 0.3).toFixed(2));
    }

    var itemStyle = {
      normal: {
      },
      emphasis: {
        barBorderWidth: 1,
        shadowBlur: 10,
        shadowOffsetX: 0,
        shadowOffsetY: 0,
        shadowColor: 'rgba(0,0,0,0.5)'
      }
    };

    option = {
      backgroundColor: '#eee',
      legend: {
        data: ['bar', 'bar2', 'bar3', 'bar4'],
        align: 'left',
        left: 10
      },
      brush: {
        toolbox: ['rect', 'polygon', 'lineX', 'lineY', 'keep', 'clear'],
        xAxisIndex: 0
      },
      toolbox: {
        feature: {
          magicType: {
            type: ['stack', 'tiled']
          },
          dataView: {}
        }
      },
      tooltip: {},
      xAxis: {
        data: xAxisData,
        name: 'X Axis',
        silent: false,
        axisLine: {onZero: true},
        splitLine: {show: false},
        splitArea: {show: false}
      },
      yAxis: {
        inverse: true,
        splitArea: {show: false}
      },
      grid: {
        left: 100
      },
      visualMap: {
        type: 'continuous',
        dimension: 1,
        text: ['High', 'Low'],
        inverse: true,
        itemHeight: 200,
        calculable: true,
        min: -2,
        max: 6,
        top: 60,
        left: 10,
        inRange: {
          colorLightness: [0.4, 0.8]
        },
        outOfRange: {
          color: '#bbb'
        },
        controller: {
          inRange: {
            color: '#2f4554'
          }
        }
      },
      series: [
        {
          name: 'bar',
          type: 'bar',
          stack: 'one',
          itemStyle: itemStyle,
          data: data1
        },
        {
          name: 'bar2',
          type: 'bar',
          stack: 'one',
          itemStyle: itemStyle,
          data: data2
        },
        {
          name: 'bar3',
          type: 'bar',
          stack: 'two',
          itemStyle: itemStyle,
          data: data3
        },
        {
          name: 'bar4',
          type: 'bar',
          stack: 'two',
          itemStyle: itemStyle,
          data: data4
        }
      ]
    };

    myChart.on('brushSelected', renderBrushed);

    function renderBrushed(params) {
      var brushed = [];
      var brushComponent = params.batch[0];

      for (var sIdx = 0; sIdx < brushComponent.selected.length; sIdx++) {
        var rawIndices = brushComponent.selected[sIdx].dataIndex;
        brushed.push('[Series ' + sIdx + '] ' + rawIndices.join(', '));
      }

      myChart.setOption({
        title: {
          backgroundColor: '#333',
          text: 'SELECTED DATA INDICES: \n' + brushed.join('\n'),
          bottom: 0,
          right: 0,
          width: 100,
          textStyle: {
            fontSize: 12,
            color: '#fff'
          }
        }
      });
    }
    if (option && typeof option === "object") {
      myChart.setOption(option, true);
    }
  }

  function echartcode(statData){
    option = {
      title: {
        text: '堆叠区域图'
      },
      tooltip : {
        trigger: 'axis'
      },
      legend: {
        data:['本代本取现','本代他取现','本行转账','跨行转账','缴费']
      },
      toolbox: {
        feature: {
          saveAsImage: {}
        }
      },
      grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
      },
      xAxis : [
        {
          type : 'category',
          boundaryGap : false,
          data : ['一月份','二月份','三月份','四月份','五月份','六月份','七月份']
        }
      ],
      yAxis : [
        {
          type : 'value'
        }
      ],
      series : [
        {
          name:'本代本取现',
          type:'line',
          stack: '总量',
          areaStyle: {normal: {}},
          data:[120, 132, 101, 134, 90, 230, 210]
        },
        {
          name:'本代他取现',
          type:'line',
          stack: '总量',
          areaStyle: {normal: {}},
          data:[220, 182, 191, 234, 290, 330, 310]
        },
        {
          name:'本行转账',
          type:'line',
          stack: '总量',
          areaStyle: {normal: {}},
          data:[150, 232, 201, 154, 190, 330, 410]
        },
        {
          name:'跨行转账',
          type:'line',
          stack: '总量',
          areaStyle: {normal: {}},
          data:[320, 332, 301, 334, 390, 330, 320]
        },
        {
          name:'缴费',
          type:'line',
          stack: '总量',
          label: {
            normal: {
              show: true,
              position: 'top'
            }
          },
          areaStyle: {normal: {}},
          data:[820, 932, 901, 934, 1290, 1330, 1320]
        }
      ]
    };



    if (option && typeof option === "object") {
      myChart.setOption(option, true);
    }
  }

  function getStatData() {
    myChart.showLoading();

    var tableName = "<c:out value="${tableName}"/>";
    $.ajax({
      type: 'get',
//            url: '/common/timeStatData/' + tableName + '.shtml',
      url: '/visualuicreate/datarelitu.shtml',
      datatype: 'json',
      error: function () {
        alert('Error occured, please try again later!');



      },
      success: function (statData) {
        myChart.hideLoading();
        echartcode("a");
//                statData = JSON.parse(statData);
      }
    });
  }

</script>