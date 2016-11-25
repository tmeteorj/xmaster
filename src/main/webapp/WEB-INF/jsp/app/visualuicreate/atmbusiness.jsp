<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="http://webapi.amap.com/maps?v=1.3&key=7ea83963cea996848fd247e67ed8501f"></script>
<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&ak=vYqY1p0N8melwlfnLqBwlVmy&services=&t=20160928173929"></script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/diy/${js}"></script>--%>
<body>
<div style="width:1200px;">
<br>
<div style="height:500px;">
  <div class="col-xs-3 col-md-2">
    <div id="div_work" style="display:inline">
      <label>类型:</label>
      <select id="sel_work" class="form-control">
        <option value="0">ATM</option>
        <option value="1">网点</option>
        <!-- 			  <option value="1">人口迁徙</option> -->
      </select>
    </div>
  </div>
  <div class="col-xs-3 col-md-2">
    <div id="div_model" style="display:inline">
      <label>衡量方式:</label>
      <select id="sel_model" class="form-control">
        <option value="0">交易次数</option>
        <option value="1">交易金额</option>
      </select>
    </div>
  </div>
  <div class="col-xs-3 col-md-2">
    <div style="display:inline">
      <label>开始分析:</label>
      <br>
      <button type="button" class="form-control">
        分析
      </button>
    </div>
  </div>
  <div  id="line" style="height:400px;"></div>
</div>
<br>
<div style="height:500px;">
  <div class="col-xs-3 col-md-2">
    <div id="div_work" style="display:inline">
      <label>类型:</label>
      <select id="sel_work" class="form-control">
        <option value="0">一级支行</option>
        <option value="1">二级支行</option>
        <option value="2">分理处</option>
        <!-- 			  <option value="1">人口迁徙</option> -->
      </select>
    </div>
  </div>
  <div class="col-xs-3 col-md-2">
    <div style="display:inline">
      <label>开始分析:</label>
      <br>
      <button type="button" class="form-control">
        分析
      </button>
    </div>
  </div>
  <div  id="bar" style="height:400px;"></div>
</div>
<br>
<div style="height:600px;">
  <div class="col-xs-3 col-md-2">
    <div id="div_work" style="display:inline">
      <label>类型:</label>
      <select id="sel_work" class="form-control">
        <option value="0">资金流入</option>
        <option value="1">资金流出</option>
        <option value="2">总资金流动</option>
        <!-- 			  <option value="1">人口迁徙</option> -->
      </select>
    </div>
  </div>
  <div class="col-xs-3 col-md-2">
    <div id="div_model" style="display:inline">
      <label>时间:</label>
      <select id="sel_model" class="form-control">
        <option value="0">2015</option>
        <option value="1">2016</option>
      </select>
    </div>
  </div>
  <div class="col-xs-3 col-md-2">
    <div style="display:inline">
      <label>开始分析:</label>
      <br>
      <button type="button" class="form-control">
        分析
      </button>
    </div>
  </div>
  <div  id="map" style="height:400px;"></div>
</div>
<br>
<br>
<div style="height:600px;">
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
  <div  id="force" style="height:400px;"></div>
</div>
</div>
</body>
<%--<div id="eventRiver" style="height:400px;"></div>--%>
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
</body>
