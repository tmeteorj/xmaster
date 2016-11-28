<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
  #map {
    height: 400px;
    margin: 0 20px 20px 20px;
  }
</style>

<div class="container-fluid">
  <div class="row">
    <div class="col-md-9"><!--左侧-->
      <div class="row"><!--搜索栏-->
        <div class="col-md-12">
          <div class="panel panel-primary">
            <div class="panel-heading">
              <h3 class="panel-title">
                检索
              </h3>
            </div>
            <div class="panel-body">
              <form id="searchForm" class="navbar-form" role="search">
                <div class="row">
                  <div class="form-group col-md-8">
                    <input id="keyword" name="keyword" value="<c:out value="${keyword}"/>"
                           type="text" class="form-control" style="width: 100%"
                           placeholder="请输入关键字"/>
                  </div>
                    <input type="hidden" value="${databaseName}" name="databaseName" id="databaseName">
                    <%@include file="../common/retrievalDatasetConfig.jsp" %>
                  <button id="search" type="button" class="btn btn-success">
                    检索
                  </button>
                    <%--<button id="clearmap" type="button" class="btn btn-success">--%>
                        <%--清除地图--%>
                    <%--</button>--%>
                </div>
                <div class="line line-dashed pull-in"></div>
                <div class="row ">
                  <div class="col-md-1"></div>
                  <div class="col-md-4">
                    <label class="radio-inline">
                      <input type="radio" name="displayType" value="1"
                             <c:if test="${displayType eq '1'}">checked</c:if>> 集合
                    </label>
                  </div>

                  <div class="col-md-4">
                    <label class="radio-inline">
                      <input type="radio" name="displayType" value="2"
                             <c:if test="${displayType eq '2'}">checked</c:if>> 关系
                    </label>
                  </div>

                  <div class="col-md-3">
                    <label class="radio-inline">
                      <input type="radio" name="displayType" value="3"
                             <c:if test="${displayType eq '3'}">checked</c:if>> 个体
                    </label>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!--搜索栏-->
      <div class="row"><!--地图栏-->
        <div class="col-md-12">
          <div id="map"></div>
        </div>
      </div>
      <!--地图栏-->

      <div class="row"><!--描述栏-->
        <div class="col-md-12">
          <div class="panel panel-primary">
            <div class="panel-heading">
              <h3 class="panel-title">
                描述
              </h3>
            </div>
            <div class="panel-body">
              <div id="description">
                这是 <c:out value="${tableName}"/> 数据。其中的属性包括：
                <c:forEach items="${tableList}" var="table" varStatus="status">
                  <c:if test="${status.index<=10}">
                    <c:if test="${status.index > 0}">，</c:if>
                    <c:choose><c:when
                            test="${!table.columnComment && table.columnComment != ''}"><c:out
                            value="${table.columnComment}"/></c:when><c:otherwise><c:out
                            value="${table.columnName}"/></c:otherwise></c:choose> </c:if>
                </c:forEach>
                等。
              </div>
            </div>
          </div>
        </div>
      </div>
      <!--描述栏-->
      <div class="row"><!--列表栏-->
        <div class="col-md-12">
          <div class="table-responsive">
            <div id="paging" class="pagclass"></div>
          </div>
        </div>
      </div>
      <!--列表栏-->
      <div class="row"><!--详情栏-->
        <div class="col-md-12">
          <div class="panel panel-primary">
            <div class="panel-heading">
              <h3 class="panel-title">
                详情
              </h3>
            </div>
            <div class="panel-body">
              <div id="detailedInfo"></div>
            </div>
          </div>
        </div>
      </div>
      <!--详情栏-->
    </div>
    <!--左侧-->
    <div class="col-md-3"><!--右侧-->
      <div class="row"><!--导航栏-->
        <div class="col-md-12">
          <div class="panel panel-primary">
            <div class="panel-heading">
              <h3 class="panel-title">
                其他
              </h3>
            </div>
            <div class="panel-body"><!--body-->
              <div class="panel-group">
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                        快速分析
                    </h4>
                  </div>
                  <div class="panel-body">
                    <p>
                      <button id="relitu" type="button"
                              class="btn btn-success btn-lg btn-block" style="display:none;">
                        热力图分析
                      </button>
                    </p>
                      <p>
                          <button id="pinlv" type="button"
                                  class="btn btn-success btn-lg btn-block" style="display:none;">
                              交易频率统计
                          </button>
                      </p>
                      <p>
                          <button id="shouru" type="button"
                                  class="btn btn-success btn-lg btn-block" style="display:none;">
                              收益支出统计
                          </button>
                      </p>
                      <p>
                          <button id="zijin" type="button"
                                  class="btn btn-success btn-lg btn-block" style="display:none;">
                              资金流动分析
                          </button>
                      </p>
                      <p>
                          <button id="guanxi" type="button"
                                  class="btn btn-success btn-lg btn-block" style="display:none;">
                              关系分析
                          </button>
                      </p>
                    <p>
                      <button id="labelinfo" type="button" class="btn btn-info btn-lg btn-block">
                        地图标签信息显示
                      </button>
                    </p>
                    <p>
                      <button type="button" class="btn btn-warning btn-lg btn-block">
                        其他统计1
                      </button>
                    </p>
                    <p>
                      <button type="button" class="btn btn-danger btn-lg btn-block">
                        其他统计2
                      </button>
                    </p>
                  </div>
                </div>

              </div>
            </div>
            <!--body-->
          </div>
        </div>
      </div>
      <!--导航栏-->
      <div class="row"><!--限定栏-->
        <div class="col-md-12">
          <div class="panel panel-primary">
            <div class="panel-heading">
              <h3 class="panel-title">
                限定
                <a href="javascript:void(0);" class="pull-right" id="advancedConfig">高级设置</a>
              </h3>
            </div>
            <div class="panel-body">
              <div class="panel-group">
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      数据集限定
                    </h4>
                  </div>
                  <div class="panel-body">
                    <div class="form-group">
                      <label class="col-sm-3 control-label">数据集</label>

                      <div class="col-sm-9">
                        <input type="text" class="form-control" value="ATM选址" readonly>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      时间限定
                    </h4>
                  </div>
                  <div class="panel-body">
                    <div class="form-group">
                      <label class="col-sm-3 control-label">开始</label>

                      <div class="col-sm-9">
                        <input type="text" class="form-control" value="2010-01-02" readonly>
                      </div>
                    </div>

                    <div class="form-group">
                      <label class="col-sm-3 control-label">截止</label>

                      <div class="col-sm-9">
                        <input type="text" class="form-control" value="2016-09-17" readonly>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      空间限定
                    </h4>
                  </div>
                  <div class="panel-body">
                    <div class="form-group">
                      <label class="col-sm-3 control-label">国家</label>

                      <div class="col-sm-9">
                        <input type="text" class="form-control" value="中国" readonly>
                      </div>
                    </div>

                    <div class="form-group">
                      <label class="col-sm-3 control-label">天津</label>

                      <div class="col-sm-9">
                        <input type="text" class="form-control" value="全部" readonly>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

            </div>
          </div>
        </div>
        <!--限定栏-->
      </div>
    </div>
    <!--右侧-->
  </div>
</div>
<script src="http://webapi.amap.com/maps?v=1.3&key=d811dda1aae5e80c64f364d199c05d9b&callback=init"></script>

<script>
  var grid = null;
  var map;
  var flag=true;
  var markers = [];
  var information = [];
  var globaldata;
  function init() {
      map = new AMap.Map('map', {
          center: [117.168199,39.10829],
//          center: [116.23, 39.80],
          zoom: 8
      });
      map.plugin(['AMap.ToolBar', 'AMap.Scale', 'AMap.OverView'], function () {
          map.addControl(new AMap.ToolBar());
          map.addControl(new AMap.Scale());
          map.addControl(new AMap.OverView({isOpen: true}));
      })

      draw_relitu(globaldata);
  }
  var keyword = $("#keyword").val();

  function buttonshow(table_name){
//    alert(table_name);
    if(table_name=="bd_location_atm_bus") {
        $("#relitu").show();
        $("#shouru").show();
        $("#zijin").show();
        $("#pinlv").show();
        $("#guanxi").show();
    }else if(table_name=="bd_location_relitu"){
        $("#relitu").show();
    }else if(table_name=="bd_location_trc_atm"){
        $("#shouru").show();
    }


  }

  $(function () {
      buttonshow("${tableName}");
    grid = lyGrid({
      pagId: 'paging',
      l_column: [
        <c:forEach items="${tableList}" var="table" varStatus="status">
        <c:if test="${status.index<=10}">
        {
          colkey: "<c:out value="${table.columnName}"/>",
          name: "<c:choose><c:when test="${!table.columnComment && table.columnComment != ''}"><c:out value="${table.columnComment}"/></c:when><c:otherwise><c:out value="${table.columnName}"/></c:otherwise></c:choose>",
          <c:if test="${table.columnName == 'id' or table.columnName == 'remark' or table.columnName == 'deleted_mark'}">
          hide: true,
          </c:if>
          <c:if test="${table.dataType == 'timestamp' || table.dataType == 'datetime'}">
          renderData: function (rowindex, data, rowdata, column) {
            return new Date(data).format("yyyy-MM-dd hh:mm:ss");
          }
          </c:if>
        },
        </c:if>
        </c:forEach>
        {
          colkey: "__id__",
          name: "操作"
        }],
      jsonUrl: rootPath + '/common/<c:out value="${tableName}"/>/findByPage/1.shtml?keyword=' + keyword,
      checkbox: false

    }, bindingDetailBtn);


    $("#search").click(function () {
      var displayType = $("input[name='displayType']:checked").val();
      var params = $("#searchForm").serialize();
      var tb = $("#loadhtml");
      tb.html(CommnUtil.loadingImg());
      if (displayType == '1') {
        tb.load(rootPath + "/common/<c:out value="${accountName}"/>/infoRetrieval.shtml?" + params);
      } else if (displayType == '2') {
        tb.load(rootPath + "/common/<c:out value="${accountName}"/>/infoNav.shtml?" + params);
      } else if (displayType == '3') {
        tb.load(rootPath + "/common/<c:out value="${accountName}"/>/infoNavIndividual.shtml?" + params);
      }
    });

    $("#tableName").change(function () {
      $("#keyword").val("");
        var dbName = $("select[name='tableName'] option:selected").attr("dbName");
        $("#databaseName").val(dbName);
    });


    $("#advancedConfig").click(function () {
      advancedConfig();
    });

      $("#relitu").click(function () {
          var tableName = $("select[name='tableName'] option:selected").val();
          if (tableName == "bd_location_relitu") {
              var columnName = "member_since";
              if (tableName == "bd_meetup") {
                  columnName = "time_founded";
              }
              var tb = $("#map");
//              alert("relitu");
              tb.load(rootPath+'/visualuicreate/pinglv.shtml');
              <%--tb.load(rootPath + '/common/<c:out value="${tableName}"/>/timeStat.shtml?columnName=' + columnName);--%>
          }
      });
    $("#timeStat").click(function () {
      var tableName = $("select[name='tableName'] option:selected").val();
      if (tableName == "bd_meetup" || tableName == "bd_member") {
        var columnName = "member_since";
        if (tableName == "bd_meetup") {
          columnName = "time_founded";
        }
        var tb = $("#map");
        tb.load(rootPath + '/common/<c:out value="${tableName}"/>/timeStat.shtml?columnName=' + columnName);
      }
    });

    $("#placeStat").click(function () {
      var tableName = $("select[name='tableName'] option:selected").val();
      if (tableName == "bd_meetup" || tableName == "bd_member") {
        var tb = $("#map");
        tb.load(rootPath + '/common/<c:out value="${tableName}"/>/placeStat.shtml');
      }
    });
  });
  $("#labelinfo").click(function () {
//      alert(markers.length);
      for(var i=0;i<markers.length;++i){
          var marker = markers[i];
//          console.log(information);
      marker.setTitle(information[i].id);
      marker.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
          offset: new AMap.Pixel(20, 20),//修改label相对于maker的位置
          content: information[i].content,
      });
  }


  });
  function draw_relitu(response){
      console.log("here-> response");
      try{
          map.remove(markers);
      }catch(e){

      }
      markers = [];
      information = [];
      for(var i=0;i<response.length;++i){
          pos = [];
          var key='name';
          var temp = {};
          if(!response[i]['name']){
              key='organization';
          }
          pos.push(response[i]['latitude']);
          pos.push(response[i]['longitude']);
          if(response[i]['id']){
              temp['id'] = response[i]['id'];
          }else{
              temp['id'] = "";
          }
          if(response[i][key]){
              temp['content'] = response[i][key];
          }else if(response[i]['address']){
              temp['content'] = response[i]['address'];
          }
          else{
              temp['content'] = "NULL"
          }

          var marker = new AMap.Marker({
              map: map,
              position: pos,
          });
          information.push(temp);
          markers.push(marker);

      }
  }

  function bindingDetailBtn(columns, currentData) {
      globaldata=currentData;
      draw_relitu(currentData);
    $("[dataId]").each(function () {
      $(this).bind("click", function () {
        var dataId = $(this).attr("dataId");
        var index = $(this).attr("index");
        $.ajax({
          type: 'GET',
          url: '/common/<c:out value="${tableName}"/>/' + dataId + '/detail.shtml',
          datatype: 'json',
          async: false,
          error: function () {
            console.info(index);
            index = parseInt(index);
            var rowdata = currentData[index];
            var detailedData = {};
            for (var column in columns) {
              column = columns[column];
              if (column['colkey'] in rowdata) {
                if (!column['name'] || column['name'] == "") {
                  detailedData[column['colkey']] = rowdata[column['colkey']];
                } else {
                  detailedData[column['name']] = rowdata[column['colkey']];
                }
              }
            }
            createHtmlForDetailedInfo(detailedData);
          },
          success: function (detailedData) {
            console.info(dataId);
            detailedData = JSON.parse(detailedData);
            createHtmlForDetailedInfo(detailedData);
          }
        });
      });
    });
  }

  function createHtmlForDetailedInfo(detailedData) {
    var detailedInfo = $("#detailedInfo");
    detailedInfo.html("");
    var html = "";
    $.each(detailedData, function (key) {
      html +=
              "            <div class=\"form-group\">\n" +
              "                <label class=\"col-sm-2 control-label\">"
      ;
      html += key;
      html +=
              "</label>\n" +
              "                <div class=\"col-sm-4\">\n" +
              "                    <input type=\"text\" class=\"form-control\" value=\""
      ;
      html += detailedData[key];
      html +=
              "\" readonly/>\n" +
              "                </div>\n" +
              "            </div>"
      ;
    });
    detailedInfo.html(html);
  }

  function advancedConfig() {
    pageii = layer.open({
      title: "高级设置",
      type: 2,
      area: ["600px", "80%"],
        content: rootPath + '/common/<c:out value="${tableName}"/>/advancedConfig.shtml'
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