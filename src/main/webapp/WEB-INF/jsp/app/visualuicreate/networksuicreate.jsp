<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-3">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        人物关系情报分析
                    </h3>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label>数据集选择：</label>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">数据集</label>

                            <div class="col-sm-9">
                                <select class="form-control">
                                    <option>请选择数据集</option>
                                    <option selected>生物黑客活动</option>
                                    <option>生物黑客组织</option>
                                    <option>生物黑客成员</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">起始时间</label>

                            <div class="col-sm-9">
                                <div class="input-group date form_date" data-date="" data-date-format="yyyy-MM-dd"
                                     data-link-field="" data-link-format="yyyy-mm-dd">
                                    <input class="form-control" size="16" type="text" value="2009-12-10" readonly>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                </div>
                                <input type="hidden" value=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">截止时间</label>

                            <div class="col-sm-9">
                                <div class="input-group date form_date" data-date="" data-date-format="yyyy-MM-dd"
                                     data-link-field="" data-link-format="yyyy-mm-dd">
                                    <input class="form-control" size="16" type="text" value="2016-01-01" readonly>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                </div>
                                <input type="hidden" value=""/>
                            </div>
                        </div>

                        <hr>

                        <div class="form-group">
                            <label>网络定义：</label>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">结点定义</label>

                            <div class="col-sm-9">
                                <select class="form-control">
                                    <option>请选择</option>
                                    <option selected>成员编号</option>
                                    <option>主键ID</option>
                                    <option>成员姓名</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">关系定义</label>

                            <div class="col-sm-9">
                                <select class="form-control">
                                    <option>请选择</option>
                                    <option selected>共现关系</option>
                                    <option>成员关系</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">拓扑类型</label>

                            <div class="col-sm-9">
                                <label class="radio-inline">
                                    <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1" checked>
                                    无权无向
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                                    无权有向
                                </label>
                                <br/>
                                <label class="radio-inline">
                                    <input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3">
                                    有权无向
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="inlineRadioOptions" id="inlineRadio4" value="option4">
                                    有权有向
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">网络类型</label>

                            <div class="col-sm-9">
                                <label class="radio-inline">
                                    <input type="radio" name="networksType" id="inlineRadio5" value="option5" checked>
                                    静态网络
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="networksType" id="inlineRadio6" value="option6">
                                    动态网络
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">时间片数</label>

                            <div class="col-sm-9">
                                <input type="text" class="form-control" value="1" placeholder="仅数字"/>
                            </div>
                        </div>
                        <hr>

                        <div class="form-group">
                            <label>算法选择：</label>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">检测算法</label>

                            <div class="col-sm-9">
                                <select class="form-control">
                                    <option>请选择</option>
                                    <option selected>Non-negative Matrix Factorization</option>
                                    <option>InfoMap</option>
                                    <option>Label Rank</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">社区个数</label>

                            <div class="col-sm-9">
                                <input type="text" class="form-control" value="15" placeholder="仅数字"/>
                            </div>
                        </div>


                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                                <button id="get-graph" type="button" class="btn btn-success">提交分析</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- left -->
        <div class="col-md-6">
            <div id="chart" class="col-md-12" style="height:800px;"></div>
        </div>
        <div class="col-md-3">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        基本人物信息
                    </h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-4">
                            <p class="pull-right">姓名：</p>
                        </div>
                        <div class="col-sm-8">
                            <p id="member-name">Eri G.</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4">
                            <p class="pull-right">成员编号：</p>
                        </div>
                        <div class="col-sm-8">
                            <p id="member-number">3316180</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4">
                            <p class="pull-right">地址：</p>
                        </div>
                        <div class="col-sm-8">
                            <p id="member-address"><a href="#" target="_blank">Palo Alto, CA, USA</a></p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4">
                            <p class="pull-right">介绍：</p>
                        </div>
                        <div class="col-sm-8">
                            <p id="member-intro">We started this meetup after meeting fellow science-loving
                                locals
                                and realizing there was a common need. This seemed like a great way for these
                                people
                                to meet, work and learn with one another.</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4">
                            <p class="pull-right">加入的组织：</p>
                        </div>
                        <div id="member-meetup" class="col-sm-8">
                            <ul class="list-unstyled">
                                <li>2010-01-02 - BioCurious</li>
                                <li>2013-07-26 - Counter Culture Labs</li>
                                <li>2012-10-31 - Dutch DIY Bio Group</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">

                </div>
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        地理信息
                    </h3>
                </div>
                <div class="panel-body">
                    <div id="map" style="height: 40%;"></div>
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
    var myChart = echarts.init(document.getElementById('chart'));
    $(function () {

        getGraph();

        $("#get-graph").on('click', function (){
            getGraph();
        });

        myChart.on('click', function (param) {
            if (typeof param.data.value == 'undefined') {
                layer.msg("You miss it~");
                return;
            }
            console.log(param.data);
            $.ajax({
                type: 'GET',
                url: '/member/' + param.data.value + '/list.shtml',
                datatype: 'json',
                async: false,
                error: function () {
                    alert('Error occured, please try again later!');
                },
                success: function (dataList) {
                    dataList = JSON.parse(dataList);
                    // 显示人物信息
                    var data = dataList[0];
                    $("#member-name").html(data.name);
                    $("#member-number").html(data.number);
                    $("#member-address").children("a").html(data.locality + ', ' + data.region + ', ' + data.country);
                    $("#member-address").children("a").attr("href", data.address_url);
                    if (typeof data.introduction == 'undefined')
                        $("#member-intro").html("No introduction yet!");
                    else
                        $("#member-intro").html(data.introduction);

                    var memberMeetup = "<ul class=\"list-unstyled\">";
                    $.each(dataList, function (i, item) {
                        memberMeetup += "<li>";
                        memberMeetup += new Date(item.member_since).format("yyyy-MM-dd");
                        memberMeetup += " - ";
                        memberMeetup += item.meetup;
                        memberMeetup += "</li>";
                    });
                    memberMeetup += "</ul>";
                    $("#member-meetup").html(memberMeetup);

                    // 地图定位
                    var geocoder = new google.maps.Geocoder();
                    var address = data.locality + ', ' + data.region + ', ' + data.country;
                    geocoder.geocode({'address': address}, function (results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            //alert(results[0].geometry.location);
                            map.setCenter(results[0].geometry.location);
                        }
                    })

                }
            });
        });
    });

    function getGraph (data) {
        myChart.showLoading();

        $.ajax({
            type: 'post',
            url: '/visualuicreate/getGraph.shtml',
            datatype: 'json',
            data: data,
            error: function () {
                alert('Error occured, please try again later!');
            },
            success: function (myGraph) {
                myChart.hideLoading();
                myGraph = JSON.parse(myGraph);
                myGraph = JSON.parse(myGraph);
                option = {
                    legend: myGraph.legend,
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
                        data: myGraph.nodes.map(function (node, idx) {
                            node.id = idx;
                            return node;
                        }),
                        categories: myGraph.categories,
                        force: {
                            initLayout: 'circular',
                            edgeLength: 5,
                            repulsion: 20
                        },
                        edges: myGraph.links
                    }]
                };

                myChart.setOption(option);
            }
        });
    }

</script>
<script>
    $('.form_date').datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
</script>
<script>
    var map;
    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
//            center: {lat:35.86166, lng: 104.195397},
            center: {lat: 37.4418834, lng: -122.14301949999998},
            zoom: 4
        });
    }
</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCJAZFHarSBlboid2Qlv4FyVh3QmIL3Y2Q&callback=initMap">
</script>