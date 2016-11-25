<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="http://webapi.amap.com/maps?v=1.3&key=7ea83963cea996848fd247e67ed8501f"></script>
<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&ak=vYqY1p0N8melwlfnLqBwlVmy&services=&t=20160928173929"></script>
<%--<script src="${pageContext.request.contextPath}/echarts3/echarts.min.js" type="text/javascript"></script>--%>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/echarts3/world.js"></script>--%>

<div  id="line" style="height:400px;"></div>



<script src="${pageContext.request.contextPath}/js/dist/echarts.js"></script>
<script type="text/javascript">

  require.config({
    paths: {
      echarts: '${pageContext.request.contextPath}/js/dist'
    }
  });
  require(
          [
            'echarts',
            'echarts/chart/line',   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
            'echarts/chart/bar',
            'echarts/chart/map',
            'echarts/chart/force',
            'echarts/chart/eventRiver'
          ],
          function (ec) {
//            alert(3333);
            var myChart = ec.init(document.getElementById('line'));
            option = {
              title : {
                text : '交易频率图',
              },
              tooltip : {
                trigger: 'item',
                formatter : function (params) {
                  var date = new Date(params.value[0]);
                  data = date.getFullYear() + '-'
                          + (date.getMonth() + 1) + '-'
                          + date.getDate() + ' '
                          + date.getHours() + ':'
                          + date.getMinutes();
                  return data + '<br/>'
                          + params.value[1] + ', '
                          + params.value[2];
                }
              },
              dataZoom: {
                show: true,
                start : 70
              },
              legend : {
                data : ['series1']
              },
              grid: {
                y2: 80
              },
              xAxis : [
                {
                  type : 'time',
                  splitNumber:10
                }
              ],
              yAxis : [
                {
                  type : 'value'
                }
              ],
              series : [
                {
                  name: 'series1',
                  type: 'line',
                  showAllSymbol: true,
                  symbolSize: function (value){
                    return Math.round(value[2]/10) + 2;
                  },
                  data: (function () {
                    var d = [];
                    var len = 0;
                    var now = new Date();
                    var value;
                    while (len++ < 200) {
                      d.push([
                        new Date(2014, 9, 1, 0, len * 10000),
                        (Math.random()*30).toFixed(2) - 0,
                        (Math.random()*100).toFixed(2) - 0
                      ]);
                    }
                    return d;
                  })()
                }
              ]
            };
            myChart.setOption(option);
            //柱状图
            var myChart = ec.init(document.getElementById('bar'));
            option = {
              title : {
                text : '各支行收入支出图频率图',
              },
              tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                  type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
              },
              legend: {
                data:['利润', '支出', '收入']
              },
              calculable : true,
              xAxis : [
                {
                  type : 'value'
                }
              ],
              yAxis : [
                {
                  type : 'category',
                  axisTick : {show: false},
                  data : ['天津农商银行东丽支行','天津农商银行津南支行','天津农商银行西青支行','天津农商银行营业部','天津农商银行北辰支行','天津农商银行宝坻支行','天津农商银行蓟县支行']
                }
              ],
              series : [
                {
                  name:'利润',
                  type:'bar',
                  itemStyle : { normal: {label : {show: true, position: 'inside'}}},
                  data:[200, 170, 240, 244, 200, 220, 210]
                },
                {
                  name:'收入',
                  type:'bar',
                  stack: '总量',
                  barWidth : 5,
                  itemStyle: {normal: {
                    label : {show: true}
                  }},
                  data:[320, 302, 341, 374, 390, 450, 420]
                },
                {
                  name:'支出',
                  type:'bar',
                  stack: '总量',
                  itemStyle: {normal: {
                    label : {show: true, position: 'left'}
                  }},
                  data:[-120, -132, -101, -134, -190, -230, -210]
                }
              ]
            };
            myChart.setOption(option);
            var myChart = ec.init(document.getElementById('map'));
            option = {
              title : {
                text : '国内资金往来图',
              },
              title : {
                text: '地区分布',
//                subtext: '纯属虚构',
                x:'center'
              },
              tooltip : {
                trigger: 'item'
              },
              legend: {
                orient: 'vertical',
                x:'left',
                data:['农信银渠道','银联渠道','电子支付渠道']
              },
              dataRange: {
                min: 0,
                max: 2500,
                x: 'left',
                y: 'bottom',
                text:['高','低'],           // 文本，默认为数值文本
                calculable : true
              },
              toolbox: {
                show: true,
                orient : 'vertical',
                x: 'right',
                y: 'center',
                feature : {
                  mark : {show: true},
                  dataView : {show: true, readOnly: false},
                  restore : {show: true},
                  saveAsImage : {show: true}
                }
              },
              roamController: {
                show: true,
                x: 'right',
                mapTypeControl: {
                  'china': true
                }
              },
              series : [
                {
                  name: '农信银渠道',
                  type: 'map',
                  mapType: 'china',
                  roam: false,
                  itemStyle:{
                    normal:{label:{show:true}},
                    emphasis:{label:{show:true}}
                  },
                  data:[
                    {name: '北京',value: Math.round(Math.random()*1000)},
                    {name: '天津',value: Math.round(Math.random()*1000)},
                    {name: '上海',value: Math.round(Math.random()*1000)},
                    {name: '重庆',value: Math.round(Math.random()*1000)},
                    {name: '河北',value: Math.round(Math.random()*1000)},
                    {name: '河南',value: Math.round(Math.random()*1000)},
                    {name: '云南',value: Math.round(Math.random()*1000)},
                    {name: '辽宁',value: Math.round(Math.random()*1000)},
                    {name: '黑龙江',value: Math.round(Math.random()*1000)},
                    {name: '湖南',value: Math.round(Math.random()*1000)},
                    {name: '安徽',value: Math.round(Math.random()*1000)},
                    {name: '山东',value: Math.round(Math.random()*1000)},
                    {name: '新疆',value: Math.round(Math.random()*1000)},
                    {name: '江苏',value: Math.round(Math.random()*1000)},
                    {name: '浙江',value: Math.round(Math.random()*1000)},
                    {name: '江西',value: Math.round(Math.random()*1000)},
                    {name: '湖北',value: Math.round(Math.random()*1000)},
                    {name: '广西',value: Math.round(Math.random()*1000)},
                    {name: '甘肃',value: Math.round(Math.random()*1000)},
                    {name: '山西',value: Math.round(Math.random()*1000)},
                    {name: '内蒙古',value: Math.round(Math.random()*1000)},
                    {name: '陕西',value: Math.round(Math.random()*1000)},
                    {name: '吉林',value: Math.round(Math.random()*1000)},
                    {name: '福建',value: Math.round(Math.random()*1000)},
                    {name: '贵州',value: Math.round(Math.random()*1000)},
                    {name: '广东',value: Math.round(Math.random()*1000)},
                    {name: '青海',value: Math.round(Math.random()*1000)},
                    {name: '西藏',value: Math.round(Math.random()*1000)},
                    {name: '四川',value: Math.round(Math.random()*1000)},
                    {name: '宁夏',value: Math.round(Math.random()*1000)},
                    {name: '海南',value: Math.round(Math.random()*1000)},
                    {name: '台湾',value: Math.round(Math.random()*1000)},
                    {name: '香港',value: Math.round(Math.random()*1000)},
                    {name: '澳门',value: Math.round(Math.random()*1000)}
                  ]
                },
                {
                  name: '银联渠道',
                  type: 'map',
                  mapType: 'china',
                  itemStyle:{
                    normal:{label:{show:true}},
                    emphasis:{label:{show:true}}
                  },
                  data:[
                    {name: '北京',value: Math.round(Math.random()*1000)},
                    {name: '天津',value: Math.round(Math.random()*1000)},
                    {name: '上海',value: Math.round(Math.random()*1000)},
                    {name: '重庆',value: Math.round(Math.random()*1000)},
                    {name: '河北',value: Math.round(Math.random()*1000)},
                    {name: '安徽',value: Math.round(Math.random()*1000)},
                    {name: '新疆',value: Math.round(Math.random()*1000)},
                    {name: '浙江',value: Math.round(Math.random()*1000)},
                    {name: '江西',value: Math.round(Math.random()*1000)},
                    {name: '山西',value: Math.round(Math.random()*1000)},
                    {name: '内蒙古',value: Math.round(Math.random()*1000)},
                    {name: '吉林',value: Math.round(Math.random()*1000)},
                    {name: '福建',value: Math.round(Math.random()*1000)},
                    {name: '广东',value: Math.round(Math.random()*1000)},
                    {name: '西藏',value: Math.round(Math.random()*1000)},
                    {name: '四川',value: Math.round(Math.random()*1000)},
                    {name: '宁夏',value: Math.round(Math.random()*1000)},
                    {name: '香港',value: Math.round(Math.random()*1000)},
                    {name: '澳门',value: Math.round(Math.random()*1000)}
                  ]
                },
                {
                  name: '电子支付渠道',
                  type: 'map',
                  mapType: 'china',
                  itemStyle:{
                    normal:{label:{show:true}},
                    emphasis:{label:{show:true}}
                  },
                  data:[
                    {name: '北京',value: Math.round(Math.random()*1000)},
                    {name: '天津',value: Math.round(Math.random()*1000)},
                    {name: '上海',value: Math.round(Math.random()*1000)},
                    {name: '广东',value: Math.round(Math.random()*1000)},
                    {name: '台湾',value: Math.round(Math.random()*1000)},
                    {name: '香港',value: Math.round(Math.random()*1000)},
                    {name: '澳门',value: Math.round(Math.random()*1000)}
                  ]
                }
              ]
            };
            myChart.setOption(option);


            var myChart = ec.init(document.getElementById('force'));
            option = {
              title : {
                text : '银行资金关系图',
                x:'middle',

              },
//              title : {
//                text: '人物关系：天津市农商银行',
//                subtext: '数据来自人立方',
//                x:'right',
//                y:'bottom'
//              },
              tooltip : {
                trigger: 'item',
                formatter: '{a} : {b}'
              },
              toolbox: {
                show : true,
                feature : {
                  restore : {show: true},
                  magicType: {show: true, type: ['force', 'chord']},
                  saveAsImage : {show: true}
                }
              },
              legend: {
                x: 'right',
                y: 'bottom',
                data:['合作','竞争']
              },
              series : [
                {
                  type:'force',
                  name : "人物关系",
                  ribbonType: false,
                  categories : [
                    {
                      name: '人物'
                    },
                    {
                      name: '家人'
                    },
                    {
                      name:'朋友'
                    }
                  ],
                  itemStyle: {
                    normal: {
                      label: {
                        show: true,
                        textStyle: {
                          color: '#333'
                        }
                      },
                      nodeStyle : {
                        brushType : 'both',
                        borderColor : 'rgba(255,215,0,0.4)',
                        borderWidth : 1
                      },
                      linkStyle: {
                        type: 'curve'
                      }
                    },
                    emphasis: {
                      label: {
                        show: false
                        // textStyle: null      // 默认使用全局文本样式，详见TEXTSTYLE
                      },
                      nodeStyle : {
                        //r: 30
                      },
                      linkStyle : {}
                    }
                  },
                  useWorker: false,
                  minRadius : 15,
                  maxRadius : 25,
                  gravity: 1.1,
                  scaling: 1.1,
                  roam: 'move',
                  nodes:[
                    {category:0, name: '天津市农商银行', value : 10, label: '天津市农商银行\n（主要）'},
                    {category:1, name: '光大银行',value : 2},
                    {category:1, name: '工商银行',value : 3},
                    {category:1, name: '建设银行',value : 3},
                    {category:1, name: '农业银行',value : 7},
                    {category:2, name: '广发银行',value : 5},
                    {category:2, name: '中国银行',value : 8},
                    {category:2, name: '四川银行',value : 9},
                    {category:2, name: '浦发银行',value : 4},
                    {category:2, name: '渤海银行',value : 4},
                    {category:2, name: '北京银行',value : 1},
                  ],
                  links : [
                    {source : '光大银行', target : '天津市农商银行', weight : 1, name: '合作'},
                    {source : '工商银行', target : '天津市农商银行', weight : 2, name: '合作'},
                    {source : '建设银行', target : '天津市农商银行', weight : 1, name: '合作'},
                    {source : '农业银行', target : '天津市农商银行', weight : 2},
                    {source : '广发银行', target : '天津市农商银行', weight : 3, name: '合作'},
                    {source : '中国银行', target : '天津市农商银行', weight : 1},
                    {source : '四川银行', target : '天津市农商银行', weight : 6, name: '合作'},
                    {source : '浦发银行', target : '天津市农商银行', weight : 1, name: '合作'},
                    {source : '渤海银行', target : '天津市农商银行', weight : 1},
                    {source : '北京银行', target : '天津市农商银行', weight : 1},
                    {source : '建设银行', target : '工商银行', weight : 1},
                    {source : '中国银行', target : '工商银行', weight : 1},
                    {source : '中国银行', target : '建设银行', weight : 1},
                    {source : '中国银行', target : '农业银行', weight : 1},
                    {source : '中国银行', target : '广发银行', weight : 1},
                    {source : '四川银行', target : '中国银行', weight : 6},
                    {source : '四川银行', target : '建设银行', weight : 1},
                    {source : '渤海银行', target : '中国银行', weight : 1}
                  ]
                }
              ]
            };


            var ecConfig = require('echarts/config');
            function focus(param) {
              var data = param.data;
              var links = option.series[0].links;
              var nodes = option.series[0].nodes;
              if (
                      data.source !== undefined
                      && data.target !== undefined
              ) { //点击的是边
                var sourceNode = nodes.filter(function (n) {return n.name == data.source})[0];
                var targetNode = nodes.filter(function (n) {return n.name == data.target})[0];
                console.log("选中了边 " + sourceNode.name + ' -> ' + targetNode.name + ' (' + data.weight + ')');
              } else { // 点击的是点
                console.log("选中了" + data.name + '(' + data.value + ')');
              }
            }
            myChart.on(ecConfig.EVENT.CLICK, focus)

            myChart.on(ecConfig.EVENT.FORCE_LAYOUT_END, function () {
              console.log(myChart.chart.force.getPosition());
            });
            myChart.setOption(option);
            var myChart = ec.init(document.getElementById('eventRiver'));

            option = {
              title : {
                text: 'Event River',
//                subtext: '纯属虚构'
              },
              tooltip : {
                trigger: 'item',
                enterable: true
              },
              legend: {
                data:['财经事件', '政治事件']
              },
              toolbox: {
                show : true,
                feature : {
                  mark : {show: true},
                  restore : {show: true},
                  saveAsImage : {show: true}
                }
              },
              xAxis : [
                {
                  type : 'time',
                  boundaryGap: [0.05,0.1]
                }
              ],
              series : [
                {
                  "name": "财经事件",
                  "type": "eventRiver",
                  "weight": 123,
                  "data": [
                    {
                      "name": "阿里巴巴上市",
                      "weight": 123,
                      "evolution": [
                        {
                          "time": "2014-05-01",
                          "value": 14,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-02",
                          "value": 34,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-03",
                          "value": 60,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-04",
                          "value": 40,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-05",
                          "value": 10,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        }
                      ]
                    },
                    {
                      "name": "阿里巴巴上市2",
                      "weight": 123,
                      "evolution": [
                        {
                          "time": "2014-05-02",
                          "value": 10,
                          "detail": {
                            "link": "www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-03",
                          "value": 34,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-04",
                          "value": 40,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-05",
                          "value": 10,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        }
                      ]
                    },
                    {
                      "name": "三星业绩暴跌",
                      "weight": 123,
                      "evolution": [
                        {
                          "time": "2014-05-03",
                          "value": 24,
                          "detail": {
                            "link": "www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-04",
                          "value": 34,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-05",
                          "value": 50,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-06",
                          "value": 30,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-07",
                          "value": 20,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        }
                      ]
                    }
                  ]
                },
                {
                  "name": "政治事件",
                  "type": "eventRiver",
                  "weight": 123,
                  "data": [
                    {
                      "name": "Apec峰会",
                      "weight": 123,
                      "evolution": [
                        {
                          "time": "2014-05-06",
                          "value": 14,
                          "detail": {
                            "link": "www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-07",
                          "value": 34,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-08",
                          "value": 60,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-09",
                          "value": 40,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-10",
                          "value": 20,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        }
                      ]
                    },
                    {
                      "name": "运城官帮透视",
                      "weight": 123,
                      "evolution": [
                        {
                          "time": "2014-05-08",
                          "value": 4,
                          "detail": {
                            "link": "www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-09",
                          "value": 14,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-10",
                          "value": 30,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-11",
                          "value": 20,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-12",
                          "value": 10,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        }
                      ]
                    },
                    {
                      "name": "底层公务员收入超过副部长",
                      "weight": 123,
                      "evolution": [
                        {
                          "time": "2014-05-11",
                          "value": 4,
                          "detail": {
                            "link": "www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-12",
                          "value": 24,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-13",
                          "value": 40,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-14",
                          "value": 20,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-15",
                          "value": 15,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        },
                        {
                          "time": "2014-05-16",
                          "value": 10,
                          "detail": {
                            "link": "http://www.baidu.com",
                            "text": "百度指数",
                            "img": '../asset/ico/favicon.png'
                          }
                        }
                      ]
                    }
                  ]
                }
              ]
            };

            myChart.setOption(option);

          }
  );
</script>

<script src="${pageContext.request.contextPath}/echarts3/echarts.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/echarts3/world.js"></script>

<script>
  var myChart = echarts.init(document.getElementById('chart'));
  $(function () {
    getGeoData();
    $("#search").on('click', function () {
      getGeoData();
    });
  });
  function getGeoData() {
    myChart.showLoading();
    var tableName = $("#tableName").val();
    var year = $("#year").val();
    $.ajax({
      type: 'get',
      url: '/visualuicreate/geoData/' + tableName + '/' + year + '.shtml',
      datatype: 'json',
      //data: data,
      error: function () {
        alert('Error occured, please try again later!');
      },
      success: function (mapData) {
        myChart.hideLoading();
        mapData = JSON.parse(mapData);
        mapData = JSON.parse(mapData);
        var max = -Infinity;
        var min = Infinity;
        mapData.forEach(function (itemOpt) {
          if (itemOpt.value > max) {
            max = itemOpt.value;
          }
          if (itemOpt.value < min) {
            min = itemOpt.value;
          }
        });
        option = {
          backgroundColor: '#404a59',
          title: {
            text: '地理区域分布图',
            //subtext: 'From Gapminder',
            left: 'center',
            top: 'top',
            textStyle: {
              color: '#fff'
            }
          },
          tooltip: {
            trigger: 'item',
            formatter: function (params) {
//                            var value = (params.value + '').split('.');
//                            value = value[0].replace(/(\d{1,3})(?=(?:\d{3})+(?!\d))/g, '$1,')
//                                    + '.' + value[1];
              var value = params.value[2];
              return params.name + ' : ' + value;
            }
          },
          visualMap: {
            show: false,
            min: 0,
            max: max,
            inRange: {
              symbolSize: [6, 60]
            }
          },
          geo: {
            name: '地理区域分布图',
            type: 'map',
            map: 'world',
            roam: true,
            label: {
              emphasis: {
                show: false
              }
            },
            itemStyle: {
              normal: {
                areaColor: '#323c48',
                borderColor: '#111'
              },
              emphasis: {
                areaColor: '#2a333d'
              }
            }
          },
          series: [
            {
              type: 'scatter',
              coordinateSystem: 'geo',
              data: mapData.map(function (itemOpt) {
                return {
                  name: itemOpt.name,
                  value: [
                    latlong[itemOpt.code].longitude,
                    latlong[itemOpt.code].latitude,
                    itemOpt.value
                  ],
                  label: {
                    emphasis: {
                      position: 'right',
                      show: true
                    }
                  },
                  itemStyle: {
                    normal: {
                      color: itemOpt.color
                    }
                  }
                };
              })
            }
          ]
        };
        if (option && typeof option === "object") {
          myChart.setOption(option, true);
        }
      }
    });
  }
  var latlong = {};
  latlong.AD = {'latitude': 42.5, 'longitude': 1.5};
  latlong.AE = {'latitude': 24, 'longitude': 54};
  latlong.AF = {'latitude': 33, 'longitude': 65};
  latlong.AG = {'latitude': 17.05, 'longitude': -61.8};
  latlong.AI = {'latitude': 18.25, 'longitude': -63.1667};
  latlong.AL = {'latitude': 41, 'longitude': 20};
  latlong.AM = {'latitude': 40, 'longitude': 45};
  latlong.AN = {'latitude': 12.25, 'longitude': -68.75};
  latlong.AO = {'latitude': -12.5, 'longitude': 18.5};
  latlong.AP = {'latitude': 35, 'longitude': 105};
  latlong.AQ = {'latitude': -90, 'longitude': 0};
  latlong.AR = {'latitude': -34, 'longitude': -64};
  latlong.AS = {'latitude': -14.3333, 'longitude': -170};
  latlong.AT = {'latitude': 47.3333, 'longitude': 13.3333};
  latlong.AU = {'latitude': -27, 'longitude': 133};
  latlong.AW = {'latitude': 12.5, 'longitude': -69.9667};
  latlong.AZ = {'latitude': 40.5, 'longitude': 47.5};
  latlong.BA = {'latitude': 44, 'longitude': 18};
  latlong.BB = {'latitude': 13.1667, 'longitude': -59.5333};
  latlong.BD = {'latitude': 24, 'longitude': 90};
  latlong.BE = {'latitude': 50.8333, 'longitude': 4};
  latlong.BF = {'latitude': 13, 'longitude': -2};
  latlong.BG = {'latitude': 43, 'longitude': 25};
  latlong.BH = {'latitude': 26, 'longitude': 50.55};
  latlong.BI = {'latitude': -3.5, 'longitude': 30};
  latlong.BJ = {'latitude': 9.5, 'longitude': 2.25};
  latlong.BM = {'latitude': 32.3333, 'longitude': -64.75};
  latlong.BN = {'latitude': 4.5, 'longitude': 114.6667};
  latlong.BO = {'latitude': -17, 'longitude': -65};
  latlong.BR = {'latitude': -10, 'longitude': -55};
  latlong.BS = {'latitude': 24.25, 'longitude': -76};
  latlong.BT = {'latitude': 27.5, 'longitude': 90.5};
  latlong.BV = {'latitude': -54.4333, 'longitude': 3.4};
  latlong.BW = {'latitude': -22, 'longitude': 24};
  latlong.BY = {'latitude': 53, 'longitude': 28};
  latlong.BZ = {'latitude': 17.25, 'longitude': -88.75};
  latlong.CA = {'latitude': 54, 'longitude': -100};
  latlong.CC = {'latitude': -12.5, 'longitude': 96.8333};
  latlong.CD = {'latitude': 0, 'longitude': 25};
  latlong.CF = {'latitude': 7, 'longitude': 21};
  latlong.CG = {'latitude': -1, 'longitude': 15};
  latlong.CH = {'latitude': 47, 'longitude': 8};
  latlong.CI = {'latitude': 8, 'longitude': -5};
  latlong.CK = {'latitude': -21.2333, 'longitude': -159.7667};
  latlong.CL = {'latitude': -30, 'longitude': -71};
  latlong.CM = {'latitude': 6, 'longitude': 12};
  latlong.CN = {'latitude': 35, 'longitude': 105};
  latlong.CO = {'latitude': 4, 'longitude': -72};
  latlong.CR = {'latitude': 10, 'longitude': -84};
  latlong.CU = {'latitude': 21.5, 'longitude': -80};
  latlong.CV = {'latitude': 16, 'longitude': -24};
  latlong.CX = {'latitude': -10.5, 'longitude': 105.6667};
  latlong.CY = {'latitude': 35, 'longitude': 33};
  latlong.CZ = {'latitude': 49.75, 'longitude': 15.5};
  latlong.DE = {'latitude': 51, 'longitude': 9};
  latlong.DJ = {'latitude': 11.5, 'longitude': 43};
  latlong.DK = {'latitude': 56, 'longitude': 10};
  latlong.DM = {'latitude': 15.4167, 'longitude': -61.3333};
  latlong.DO = {'latitude': 19, 'longitude': -70.6667};
  latlong.DZ = {'latitude': 28, 'longitude': 3};
  latlong.EC = {'latitude': -2, 'longitude': -77.5};
  latlong.EE = {'latitude': 59, 'longitude': 26};
  latlong.EG = {'latitude': 27, 'longitude': 30};
  latlong.EH = {'latitude': 24.5, 'longitude': -13};
  latlong.ER = {'latitude': 15, 'longitude': 39};
  latlong.ES = {'latitude': 40, 'longitude': -4};
  latlong.ET = {'latitude': 8, 'longitude': 38};
  latlong.EU = {'latitude': 47, 'longitude': 8};
  latlong.FI = {'latitude': 62, 'longitude': 26};
  latlong.FJ = {'latitude': -18, 'longitude': 175};
  latlong.FK = {'latitude': -51.75, 'longitude': -59};
  latlong.FM = {'latitude': 6.9167, 'longitude': 158.25};
  latlong.FO = {'latitude': 62, 'longitude': -7};
  latlong.FR = {'latitude': 46, 'longitude': 2};
  latlong.GA = {'latitude': -1, 'longitude': 11.75};
  latlong.GB = {'latitude': 54, 'longitude': -2};
  latlong.GD = {'latitude': 12.1167, 'longitude': -61.6667};
  latlong.GE = {'latitude': 42, 'longitude': 43.5};
  latlong.GF = {'latitude': 4, 'longitude': -53};
  latlong.GH = {'latitude': 8, 'longitude': -2};
  latlong.GI = {'latitude': 36.1833, 'longitude': -5.3667};
  latlong.GL = {'latitude': 72, 'longitude': -40};
  latlong.GM = {'latitude': 13.4667, 'longitude': -16.5667};
  latlong.GN = {'latitude': 11, 'longitude': -10};
  latlong.GP = {'latitude': 16.25, 'longitude': -61.5833};
  latlong.GQ = {'latitude': 2, 'longitude': 10};
  latlong.GR = {'latitude': 39, 'longitude': 22};
  latlong.GS = {'latitude': -54.5, 'longitude': -37};
  latlong.GT = {'latitude': 15.5, 'longitude': -90.25};
  latlong.GU = {'latitude': 13.4667, 'longitude': 144.7833};
  latlong.GW = {'latitude': 12, 'longitude': -15};
  latlong.GY = {'latitude': 5, 'longitude': -59};
  latlong.HK = {'latitude': 22.25, 'longitude': 114.1667};
  latlong.HM = {'latitude': -53.1, 'longitude': 72.5167};
  latlong.HN = {'latitude': 15, 'longitude': -86.5};
  latlong.HR = {'latitude': 45.1667, 'longitude': 15.5};
  latlong.HT = {'latitude': 19, 'longitude': -72.4167};
  latlong.HU = {'latitude': 47, 'longitude': 20};
  latlong.ID = {'latitude': -5, 'longitude': 120};
  latlong.IE = {'latitude': 53, 'longitude': -8};
  latlong.IL = {'latitude': 31.5, 'longitude': 34.75};
  latlong.IN = {'latitude': 20, 'longitude': 77};
  latlong.IO = {'latitude': -6, 'longitude': 71.5};
  latlong.IQ = {'latitude': 33, 'longitude': 44};
  latlong.IR = {'latitude': 32, 'longitude': 53};
  latlong.IS = {'latitude': 65, 'longitude': -18};
  latlong.IT = {'latitude': 42.8333, 'longitude': 12.8333};
  latlong.JM = {'latitude': 18.25, 'longitude': -77.5};
  latlong.JO = {'latitude': 31, 'longitude': 36};
  latlong.JP = {'latitude': 36, 'longitude': 138};
  latlong.KE = {'latitude': 1, 'longitude': 38};
  latlong.KG = {'latitude': 41, 'longitude': 75};
  latlong.KH = {'latitude': 13, 'longitude': 105};
  latlong.KI = {'latitude': 1.4167, 'longitude': 173};
  latlong.KM = {'latitude': -12.1667, 'longitude': 44.25};
  latlong.KN = {'latitude': 17.3333, 'longitude': -62.75};
  latlong.KP = {'latitude': 40, 'longitude': 127};
  latlong.KR = {'latitude': 37, 'longitude': 127.5};
  latlong.KW = {'latitude': 29.3375, 'longitude': 47.6581};
  latlong.KY = {'latitude': 19.5, 'longitude': -80.5};
  latlong.KZ = {'latitude': 48, 'longitude': 68};
  latlong.LA = {'latitude': 18, 'longitude': 105};
  latlong.LB = {'latitude': 33.8333, 'longitude': 35.8333};
  latlong.LC = {'latitude': 13.8833, 'longitude': -61.1333};
  latlong.LI = {'latitude': 47.1667, 'longitude': 9.5333};
  latlong.LK = {'latitude': 7, 'longitude': 81};
  latlong.LR = {'latitude': 6.5, 'longitude': -9.5};
  latlong.LS = {'latitude': -29.5, 'longitude': 28.5};
  latlong.LT = {'latitude': 55, 'longitude': 24};
  latlong.LU = {'latitude': 49.75, 'longitude': 6};
  latlong.LV = {'latitude': 57, 'longitude': 25};
  latlong.LY = {'latitude': 25, 'longitude': 17};
  latlong.MA = {'latitude': 32, 'longitude': -5};
  latlong.MC = {'latitude': 43.7333, 'longitude': 7.4};
  latlong.MD = {'latitude': 47, 'longitude': 29};
  latlong.ME = {'latitude': 42.5, 'longitude': 19.4};
  latlong.MG = {'latitude': -20, 'longitude': 47};
  latlong.MH = {'latitude': 9, 'longitude': 168};
  latlong.MK = {'latitude': 41.8333, 'longitude': 22};
  latlong.ML = {'latitude': 17, 'longitude': -4};
  latlong.MM = {'latitude': 22, 'longitude': 98};
  latlong.MN = {'latitude': 46, 'longitude': 105};
  latlong.MO = {'latitude': 22.1667, 'longitude': 113.55};
  latlong.MP = {'latitude': 15.2, 'longitude': 145.75};
  latlong.MQ = {'latitude': 14.6667, 'longitude': -61};
  latlong.MR = {'latitude': 20, 'longitude': -12};
  latlong.MS = {'latitude': 16.75, 'longitude': -62.2};
  latlong.MT = {'latitude': 35.8333, 'longitude': 14.5833};
  latlong.MU = {'latitude': -20.2833, 'longitude': 57.55};
  latlong.MV = {'latitude': 3.25, 'longitude': 73};
  latlong.MW = {'latitude': -13.5, 'longitude': 34};
  latlong.MX = {'latitude': 23, 'longitude': -102};
  latlong.MY = {'latitude': 2.5, 'longitude': 112.5};
  latlong.MZ = {'latitude': -18.25, 'longitude': 35};
  latlong.NA = {'latitude': -22, 'longitude': 17};
  latlong.NC = {'latitude': -21.5, 'longitude': 165.5};
  latlong.NE = {'latitude': 16, 'longitude': 8};
  latlong.NF = {'latitude': -29.0333, 'longitude': 167.95};
  latlong.NG = {'latitude': 10, 'longitude': 8};
  latlong.NI = {'latitude': 13, 'longitude': -85};
  latlong.NL = {'latitude': 52.5, 'longitude': 5.75};
  latlong.NO = {'latitude': 62, 'longitude': 10};
  latlong.NP = {'latitude': 28, 'longitude': 84};
  latlong.NR = {'latitude': -0.5333, 'longitude': 166.9167};
  latlong.NU = {'latitude': -19.0333, 'longitude': -169.8667};
  latlong.NZ = {'latitude': -41, 'longitude': 174};
  latlong.OM = {'latitude': 21, 'longitude': 57};
  latlong.PA = {'latitude': 9, 'longitude': -80};
  latlong.PE = {'latitude': -10, 'longitude': -76};
  latlong.PF = {'latitude': -15, 'longitude': -140};
  latlong.PG = {'latitude': -6, 'longitude': 147};
  latlong.PH = {'latitude': 13, 'longitude': 122};
  latlong.PK = {'latitude': 30, 'longitude': 70};
  latlong.PL = {'latitude': 52, 'longitude': 20};
  latlong.PM = {'latitude': 46.8333, 'longitude': -56.3333};
  latlong.PR = {'latitude': 18.25, 'longitude': -66.5};
  latlong.PS = {'latitude': 32, 'longitude': 35.25};
  latlong.PT = {'latitude': 39.5, 'longitude': -8};
  latlong.PW = {'latitude': 7.5, 'longitude': 134.5};
  latlong.PY = {'latitude': -23, 'longitude': -58};
  latlong.QA = {'latitude': 25.5, 'longitude': 51.25};
  latlong.RE = {'latitude': -21.1, 'longitude': 55.6};
  latlong.RO = {'latitude': 46, 'longitude': 25};
  latlong.RS = {'latitude': 44, 'longitude': 21};
  latlong.RU = {'latitude': 60, 'longitude': 100};
  latlong.RW = {'latitude': -2, 'longitude': 30};
  latlong.SA = {'latitude': 25, 'longitude': 45};
  latlong.SB = {'latitude': -8, 'longitude': 159};
  latlong.SC = {'latitude': -4.5833, 'longitude': 55.6667};
  latlong.SD = {'latitude': 15, 'longitude': 30};
  latlong.SE = {'latitude': 62, 'longitude': 15};
  latlong.SG = {'latitude': 1.3667, 'longitude': 103.8};
  latlong.SH = {'latitude': -15.9333, 'longitude': -5.7};
  latlong.SI = {'latitude': 46, 'longitude': 15};
  latlong.SJ = {'latitude': 78, 'longitude': 20};
  latlong.SK = {'latitude': 48.6667, 'longitude': 19.5};
  latlong.SL = {'latitude': 8.5, 'longitude': -11.5};
  latlong.SM = {'latitude': 43.7667, 'longitude': 12.4167};
  latlong.SN = {'latitude': 14, 'longitude': -14};
  latlong.SO = {'latitude': 10, 'longitude': 49};
  latlong.SR = {'latitude': 4, 'longitude': -56};
  latlong.ST = {'latitude': 1, 'longitude': 7};
  latlong.SV = {'latitude': 13.8333, 'longitude': -88.9167};
  latlong.SY = {'latitude': 35, 'longitude': 38};
  latlong.SZ = {'latitude': -26.5, 'longitude': 31.5};
  latlong.TC = {'latitude': 21.75, 'longitude': -71.5833};
  latlong.TD = {'latitude': 15, 'longitude': 19};
  latlong.TF = {'latitude': -43, 'longitude': 67};
  latlong.TG = {'latitude': 8, 'longitude': 1.1667};
  latlong.TH = {'latitude': 15, 'longitude': 100};
  latlong.TJ = {'latitude': 39, 'longitude': 71};
  latlong.TK = {'latitude': -9, 'longitude': -172};
  latlong.TM = {'latitude': 40, 'longitude': 60};
  latlong.TN = {'latitude': 34, 'longitude': 9};
  latlong.TO = {'latitude': -20, 'longitude': -175};
  latlong.TR = {'latitude': 39, 'longitude': 35};
  latlong.TT = {'latitude': 11, 'longitude': -61};
  latlong.TV = {'latitude': -8, 'longitude': 178};
  latlong.TW = {'latitude': 23.5, 'longitude': 121};
  latlong.TZ = {'latitude': -6, 'longitude': 35};
  latlong.UA = {'latitude': 49, 'longitude': 32};
  latlong.UG = {'latitude': 1, 'longitude': 32};
  latlong.UM = {'latitude': 19.2833, 'longitude': 166.6};
  latlong.US = {'latitude': 38, 'longitude': -97};
  latlong.UY = {'latitude': -33, 'longitude': -56};
  latlong.UZ = {'latitude': 41, 'longitude': 64};
  latlong.VA = {'latitude': 41.9, 'longitude': 12.45};
  latlong.VC = {'latitude': 13.25, 'longitude': -61.2};
  latlong.VE = {'latitude': 8, 'longitude': -66};
  latlong.VG = {'latitude': 18.5, 'longitude': -64.5};
  latlong.VI = {'latitude': 18.3333, 'longitude': -64.8333};
  latlong.VN = {'latitude': 16, 'longitude': 106};
  latlong.VU = {'latitude': -16, 'longitude': 167};
  latlong.WF = {'latitude': -13.3, 'longitude': -176.2};
  latlong.WS = {'latitude': -13.5833, 'longitude': -172.3333};
  latlong.YE = {'latitude': 15, 'longitude': 48};
  latlong.YT = {'latitude': -12.8333, 'longitude': 45.1667};
  latlong.ZA = {'latitude': -29, 'longitude': 24};
  latlong.ZM = {'latitude': -15, 'longitude': 30};
  latlong.ZW = {'latitude': -20, 'longitude': 30};
</script>