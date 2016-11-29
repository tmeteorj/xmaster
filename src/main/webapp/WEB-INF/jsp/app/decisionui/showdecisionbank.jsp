<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/11/23
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">
  #mapcontainer {
    height: 350px;
    margin: 0 20px 20px 20px;
  }
</style>
<style>
  html, body { font-family: Segoe, "Segoe UI", "DejaVu Sans", "Trebuchet MS", Verdana, sans-serif;}
  ul, ol { padding: 0;}

  .banner { position: relative; overflow: auto; text-align: center;}
  .banner li { list-style: none; }
  .banner ul li { float: left; }
</style>
<script src="//code.jquery.com/jquery-latest.min.js"></script>
<script src="//unslider.com/unslider.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/Chart.js"></script>
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
                  <select id="tableName" name="tableName" class="form-control">
                    <c:forEach var="mapOfTableName" items="${tableNameList}">
                      <option value="<c:out value="${mapOfTableName.tableName}"/>"
                              <c:if test="${tableName eq mapOfTableName.tableName}">selected</c:if>>
                        <c:out
                                value="${mapOfTableName.tableComment}"/></option>
                    </c:forEach>
                  </select>
                  <button id="search" type="button" class="btn btn-success">
                    检索
                  </button>
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
          <div id="myCarousel" class="carousel slide">
            <!-- 轮播（Carousel）指标 -->
            <ol class="carousel-indicators">
              <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
              <li data-target="#myCarousel" data-slide-to="1"></li>
              <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>
            <!-- 轮播（Carousel）项目 -->
            <div class="carousel-inner">
              <div class="item active">
                <div align="center" >
                  <h3 style="opacity: 1; top: 0px;">地图ATM展示</h3>
                  <p style="opacity: 1; top: 0px;">本行ATM取款机分布，及每个取款机效率</p>
                </div>
                <div align="center" id="mapcontainer" alt="First slide"></div>
              </div>
              <div class="item">
                <div align="center" >
                  <h3 style="opacity: 1; top: 0px;">ATM区内分布展示</h3>
                  <p style="opacity: 1; top: 0px;">本行ATM在市内各区分布情况</p>
                  <img  src="${pageContext.servletContext.contextPath }/images/fade.png" alt="Second slide">
                </div>

              </div>
              <div class="item">
                <img src="${pageContext.servletContext.contextPath }/images/galaxy.png" alt="Third slide">
              </div>
            </div>
            <!-- 轮播（Carousel）导航 -->
          </div>


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
                这是银行网点数据。
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
                      统计分析
                    </h4>
                  </div>
                  <div class="panel-body">
                    <p>
                      <button id="TimeStat" type="button"
                              class="btn btn-success btn-lg btn-block">
                        时间统计
                      </button>
                    </p>
                    <p>
                      <button id="PlaceStat" type="button" class="btn btn-info btn-lg btn-block">
                        空间统计
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
                        <input type="text" class="form-control" value="生物黑客" readonly>
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
                        <input type="text" class="form-control" value="全部" readonly>
                      </div>
                    </div>

                    <div class="form-group">
                      <label class="col-sm-3 control-label">州省</label>

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

<script>
  var grid = null;
  var keyword = $("#keyword").val();
  $(function () {
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
      jsonUrl: rootPath + '/common/<c:out value="${tableName}"/>/showData.shtml',
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
    });

    $("#advancedConfig").click(function () {
      advancedConfig();
    });

  });

  function bindingDetailBtn(columns, currentData) {
    $("[dataId]").each(function () {
      $(this).bind("click", function () {
        var dataId = $(this).attr("dataId");
        var index = $(this).attr("index");
        $.ajax({
          type: 'GET',
          url:'/common/<c:out value="${tableName}"/>/' + dataId + '/detail.shtml',
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
      content: rootPath + '/common/advancedConfig.shtml'
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
<script language="JavaScript">
  var map = new AMap.Map('mapcontainer',{
    zoom: 10,
    center: [117.20,39.13],
    mapStyle: 'fresh'
  });
  var cluster, markers = [];

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津水木天成支行'+"\n效率："+10

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津本溪路支行'+"\n效率："+11

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津泰达城支行'+"\n效率："+12

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津中嘉支行'+"\n效率："+13

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.179911, 39.184588],
    title: '中国银行天津先春园支行'+"\n效率："+14

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.157879, 39.161373],
    title: '中国银行天津立交桥支行'+"\n效率："+15

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.167524, 39.17566],
    title: '中国银行天津洪湖雅园支行'+"\n效率："+16

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.15682, 39.148077],
    title: '中国银行天津水畔花园支行'+"\n效率："+17

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津大胡同支行'+"\n效率："+18

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.165441, 39.152183],
    title: '中国银行天津红桥支行'+"\n效率："+19

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.506999, 39.048683],
    title: '中国银行天津无瑕支行'+"\n效率："+20

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.504507, 39.04635],
    title: '中国银行天津津钢支行'+"\n效率："+21

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [116.944254, 38.937769],
    title: '中国银行天津静海新城支行'+"\n效率："+22

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.314598, 39.093767],
    title: '中国银行天津东方红路支行'+"\n效率："+23

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [116.929464, 38.94503],
    title: '中国银行天津大邱庄支行'+"\n效率："+24

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [116.929464, 38.94503],
    title: '中国银行天津静海支行'+"\n效率："+25

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.156288, 39.078196],
    title: '中国银行天津燕山路支行'+"\n效率："+26

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津兴华大街支行'+"\n效率："+27

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.230476, 39.110587],
    title: '中国银行天津文昌街支行'+"\n效率："+28

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.419719, 40.041041],
    title: '中国银行天津商贸街支行'+"\n效率："+29

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津鼓楼支行'+"\n效率："+30

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津邦均支行'+"\n效率："+31

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.156288, 39.078196],
    title: '中国银行天津西关支行'+"\n效率："+32

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.426505, 40.05654],
    title: '中国银行天津蓟县支行'+"\n效率："+33

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.790236, 39.217706],
    title: '中国银行天津栖霞街支行'+"\n效率："+34

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.162969, 39.116137],
    title: '中国银行天津新开南路支行'+"\n效率："+35

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.82187, 39.260006],
    title: '中国银行天津东风路支行'+"\n效率："+36

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.815723, 39.254404],
    title: '中国银行天津汉沽支行'+"\n效率："+37

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.318483, 39.721872],
    title: '中国银行天津津围支行'+"\n效率："+38

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.311805, 39.715892],
    title: '中国银行天津宝苑支行'+"\n效率："+39

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.302819, 39.702626],
    title: '中国银行天津开元支行'+"\n效率："+40

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.302819, 39.702626],
    title: '中国银行天津凯旋支行'+"\n效率："+41

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.30974, 39.729433],
    title: '中国银行天津宝坻支行'+"\n效率："+42

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津中信广场支行'+"\n效率："+43

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.066421, 39.410742],
    title: '中国银行天津泉州路支行'+"\n效率："+44

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津振华西道支行'+"\n效率："+45

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [116.915129, 39.185259],
    title: '中国银行天津王庆坨支行'+"\n效率："+46

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津武清开发区支行'+"\n效率："+47

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.060782, 39.39214],
    title: '中国银行天津武清支行'+"\n效率："+48

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津凌奥支行'+"\n效率："+49

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.229734, 39.034861],
    title: '中国银行天津梅江康城支行'+"\n效率："+50

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.128555, 39.102468],
    title: '中国银行天津高新支行'+"\n效率："+51

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.156288, 39.078196],
    title: '中国银行天津阳光新城支行'+"\n效率："+52

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.232272, 39.057719],
    title: '中国银行天津梅江蓝水支行'+"\n效率："+53

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.214166, 39.215358],
    title: '中国银行天津华苑支行'+"\n效率："+54

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.403139, 39.155274],
    title: '中国银行天津杨柳青支行'+"\n效率："+55

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.715151, 39.035477],
    title: '中国银行天津西营门支行'+"\n效率："+56

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.403139, 39.155274],
    title: '中国银行天津津兰支行'+"\n效率："+57

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.214166, 39.215358],
    title: '中国银行天津中北支行'+"\n效率："+58

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.23654, 39.024736],
    title: '中国银行天津西青支行'+"\n效率："+59

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.275833, 39.123541],
    title: '中国银行天津第六大道支行'+"\n效率："+60

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.214166, 39.215358],
    title: '中国银行天津华明支行'+"\n效率："+61

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.314598, 39.093767],
    title: '中国银行天津福东里支行'+"\n效率："+62

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.314598, 39.093767],
    title: '中国银行天津利津路支行'+"\n效率："+63

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.668325, 39.033109],
    title: '中国银行天津东丽开发区支行'+"\n效率："+64

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.354396, 39.126668],
    title: '中国银行天津机场支行'+"\n效率："+65

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.321882, 39.095328],
    title: '中国银行天津东丽支行'+"\n效率："+66

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.171556, 39.192586],
    title: '中国银行天津天辰大厦支行'+"\n效率："+67

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.127565, 39.208865],
    title: '中国银行天津瑞景支行'+"\n效率："+68

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.214166, 39.215358],
    title: '中国银行天津北辰科技园区支行'+"\n效率："+69

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.214166, 39.215358],
    title: '中国银行天津果园东路支行'+"\n效率："+70

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.171556, 39.192586],
    title: '中国银行天津安达路支行'+"\n效率："+71

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.214166, 39.215358],
    title: '中国银行天津北辰开发区支行'+"\n效率："+72

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.227544, 39.198605],
    title: '中国银行天津宜兴埠支行'+"\n效率："+73

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.13855, 39.227984],
    title: '中国银行天津北辰支行'+"\n效率："+74

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.395627, 38.994394],
    title: '中国银行天津津沽路支行'+"\n效率："+75

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.321534, 39.054854],
    title: '中国银行天津双港支行'+"\n效率："+76

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.29884, 39.06204],
    title: '中国银行天津海天馨苑支行'+"\n效率："+77

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.504763, 38.996063],
    title: '中国银行天津葛沽支行'+"\n效率："+78

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.444705, 38.921778],
    title: '中国银行天津小站支行'+"\n效率："+79

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.389225, 38.993055],
    title: '中国银行天津津南支行'+"\n效率："+80

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.26239, 39.149427],
    title: '中国银行天津卫国道支行'+"\n效率："+81

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.25748, 39.135841],
    title: '中国银行天津成林道支行'+"\n效率："+82

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.224817, 39.146733],
    title: '中国银行天津新开路支行'+"\n效率："+83

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.254213, 39.116445],
    title: '中国银行天津大桥道支行'+"\n效率："+84

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.235198, 39.147293],
    title: '中国银行天津华昌街支行'+"\n效率："+85

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.283751, 39.162079],
    title: '中国银行天津太阳城支行'+"\n效率："+86

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.165441, 39.152183],
    title: '中国银行天津唐口新村支行'+"\n效率："+87

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.272836, 39.112603],
    title: '中国银行天津中心北道支行'+"\n效率："+88

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.229443, 39.164394],
    title: '中国银行天津万东路支行'+"\n效率："+89

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津常州道支行'+"\n效率："+90

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.403139, 39.155274],
    title: '中国银行天津万达支行'+"\n效率："+91

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津盘山道支行'+"\n效率："+92

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.258537, 39.099304],
    title: '中国银行天津富民路支行'+"\n效率："+93

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.23102, 39.127221],
    title: '中国银行天津十一经路支行'+"\n效率："+94

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津中山门支行'+"\n效率："+95

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.235198, 39.147293],
    title: '中国银行天津真理道支行'+"\n效率："+96

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.314598, 39.093767],
    title: '中国银行天津天山路支行'+"\n效率："+97

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.221576, 39.146747],
    title: '中国银行天津华兴街支行'+"\n效率："+98

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.234139, 39.129873],
    title: '中国银行天津河东支行'+"\n效率："+99

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.214166, 39.215358],
    title: '中国银行天津北城街支行'+"\n效率："+100

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.259605, 39.190314],
    title: '中国银行天津金钟支行'+"\n效率："+102

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.214166, 39.215358],
    title: '中国银行天津万科新城支行'+"\n效率："+103

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.171556, 39.192586],
    title: '中国银行天津乐金电子支行'+"\n效率："+104

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津胜利路支行'+"\n效率："+105

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.214166, 39.215358],
    title: '中国银行天津建国道支行'+"\n效率："+106

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.20369, 39.165045],
    title: '中国银行天津三马路支行'+"\n效率："+107

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津黄纬路支行'+"\n效率："+108

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.203244, 39.160037],
    title: '中国银行天津昆纬路支行'+"\n效率："+109

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津建昌道支行'+"\n效率："+110

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.668325, 39.033109],
    title: '中国银行天津北宁支行'+"\n效率："+111

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.229443, 39.164394],
    title: '中国银行天津桂江道支行'+"\n效率："+112

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津中山路支行'+"\n效率："+113

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.229443, 39.164394],
    title: '中国银行天津王串场支行'+"\n效率："+116

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.203244, 39.160037],
    title: '中国银行天津江都路支行'+"\n效率："+117

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津河北支行'+"\n效率："+118

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.090702, 39.131944],
    title: '中国银行天津中北大道支行'+"\n效率："+119

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.162969, 39.116137],
    title: '中国银行天津迎水道支行'+"\n效率："+120

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.137071, 39.137429],
    title: '中国银行天津长江道支行'+"\n效率："+121

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.156288, 39.078196],
    title: '中国银行天津奥城支行'+"\n效率："+122

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.188086, 39.144005],
    title: '中国银行天津西马路支行'+"\n效率："+123

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津西广开支行'+"\n效率："+124

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.162969, 39.116137],
    title: '中国银行天津信美道支行'+"\n效率："+125

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.181113, 39.126598],
    title: '中国银行天津万德庄支行'+"\n效率："+126

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.156288, 39.078196],
    title: '中国银行天津五金城支行'+"\n效率："+127

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.156288, 39.078196],
    title: '中国银行天津山海天支行'+"\n效率："+128

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.314598, 39.093767],
    title: '中国银行天津晋宁道支行'+"\n效率："+129

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.162969, 39.116137],
    title: '中国银行天津白堤路支行'+"\n效率："+130

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.203701, 39.078455],
    title: '中国银行天津立达博兰支行'+"\n效率："+131

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津林苑道支行'+"\n效率："+132

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.162969, 39.116137],
    title: '中国银行天津馨名园支行'+"\n效率："+133

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.144837, 39.130181],
    title: '中国银行天津咸阳路支行'+"\n效率："+134

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.162969, 39.116137],
    title: '中国银行天津士英路支行'+"\n效率："+135

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.162969, 39.116137],
    title: '中国银行天津科贸街支行'+"\n效率："+136

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.162969, 39.116137],
    title: '中国银行天津中新大厦支行'+"\n效率："+137

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.229443, 39.164394],
    title: '中国银行天津黄河道支行'+"\n效率："+138

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.169858, 39.119132],
    title: '中国银行天津南丰路支行'+"\n效率："+139

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.187142, 39.137128],
    title: '中国银行天津南开支行'+"\n效率："+140

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.215373, 39.122316],
    title: '中国银行天津津玉大厦支行'+"\n效率："+141

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.403139, 39.155274],
    title: '中国银行天津海逸支行'+"\n效率："+142

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津嘉茂广场支行'+"\n效率："+143

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.314598, 39.093767],
    title: '中国银行天津广东路支行'+"\n效率："+144

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津爱国道支行'+"\n效率："+145

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津宾西路支行'+"\n效率："+146

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.230148, 39.104316],
    title: '中国银行天津南楼支行'+"\n效率："+147

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.229443, 39.164394],
    title: '中国银行天津滨湖路支行'+"\n效率："+148

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.217616, 39.086675],
    title: '中国银行天津友谊路支行'+"\n效率："+149

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.192932, 39.101047],
    title: '中国银行天津气象台路支行'+"\n效率："+150

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.263016, 39.064604],
    title: '中国银行天津枫林路支行'+"\n效率："+151

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.220847, 39.110825],
    title: '中国银行天津九龙路支行'+"\n效率："+152

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.244685, 39.09334],
    title: '中国银行天津大沽南路支行'+"\n效率："+153

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.232272, 39.057719],
    title: '中国银行天津水晶城支行'+"\n效率："+154

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.230476, 39.110587],
    title: '中国银行天津琼州道支行'+"\n效率："+155

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.225031, 39.100641],
    title: '中国银行天津利民道支行'+"\n效率："+156

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津文化中心支行'+"\n效率："+157

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津宾水道支行'+"\n效率："+158

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.272562, 39.069737],
    title: '中国银行天津曲江路支行'+"\n效率："+159

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津西康路支行'+"\n效率："+160

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.238405, 39.101726],
    title: '中国银行天津河西支行'+"\n效率："+161

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.215373, 39.122316],
    title: '中国银行天津国际大厦支行'+"\n效率："+162

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.187082, 39.120007],
    title: '中国银行天津鞍山道支行'+"\n效率："+163

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.215373, 39.122316],
    title: '中国银行天津诚基支行'+"\n效率："+164

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.192159, 39.117872],
    title: '中国银行天津万科支行'+"\n效率："+165

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津新华路支行'+"\n效率："+166

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津犀地支行'+"\n效率："+167

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.192236, 39.110566],
    title: '中国银行天津同安道支行'+"\n效率："+168

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.20513, 39.119825],
    title: '中国银行天津岳阳道支行'+"\n效率："+169

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.192086, 39.140794],
    title: '中国银行天津多伦道支行'+"\n效率："+170

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津福安支行'+"\n效率："+171

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.224968, 39.124625],
    title: '中国银行天津大光明支行'+"\n效率："+172

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津重庆道支行'+"\n效率："+173

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.192086, 39.140794],
    title: '中国银行天津保定道支行'+"\n效率："+174

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.215373, 39.122316],
    title: '中国银行天津锦中大厦支行'+"\n效率："+175

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.192086, 39.140794],
    title: '中国银行天津荣业大街支行'+"\n效率："+176

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.207117, 39.138017],
    title: '中国银行天津远洋广场支行'+"\n效率："+177

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.226982, 39.118992],
    title: '中国银行天津金皇大厦支行'+"\n效率："+178

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津吉利支行'+"\n效率："+179

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.403139, 39.155274],
    title: '中国银行天津和平支行'+"\n效率："+180

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.459664, 38.845103],
    title: '中国银行天津西苑支行'+"\n效率："+181

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津大港开发区支行'+"\n效率："+182

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.481853, 38.722362],
    title: '中国银行天津南苑支行'+"\n效率："+183

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.481853, 38.722362],
    title: '中国银行天津大港三号院支行'+"\n效率："+184

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.700839, 39.011105],
    title: '中国银行天津石化路支行'+"\n效率："+185

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津大港支行'+"\n效率："+186

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.214166, 39.215358],
    title: '中国银行天津渤龙湖支行'+"\n效率："+187

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.403139, 39.155274],
    title: '中国银行天津融和广场支行'+"\n效率："+188

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.700839, 39.011105],
    title: '中国银行天津保税区分行'+"\n效率："+189

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.668325, 39.033109],
    title: '中国银行天津河北路支行'+"\n效率："+190

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.705219, 39.019074],
    title: '中国银行天津春风路支行'+"\n效率："+191

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.229443, 39.164394],
    title: '中国银行天津东方名居支行'+"\n效率："+192

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.650505, 39.029094],
    title: '中国银行天津福建西路支行'+"\n效率："+193

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.708647, 39.026291],
    title: '中国银行天津市民广场支行'+"\n效率："+194

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.671928, 39.060506],
    title: '中国银行天津宝山道支行'+"\n效率："+195

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津散货交易中心支行'+"\n效率："+196

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.23654, 39.024736],
    title: '中国银行天津开发西区支行'+"\n效率："+197

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.658052, 39.046764],
    title: '中国银行天津广州道支行'+"\n效率："+198

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.707693, 39.036479],
    title: '中国银行天津芳林园支行'+"\n效率："+199

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.162969, 39.116137],
    title: '中国银行天津腾飞路支行'+"\n效率："+200

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.700839, 39.011105],
    title: '中国银行天津东疆保税港区支行'+"\n效率："+201

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津港务局大楼支行'+"\n效率："+202

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.71478, 38.961809],
    title: '中国银行天津石油新村支行'+"\n效率："+203

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.66875, 39.02222],
    title: '中国银行天津上海道支行'+"\n效率："+204

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津浙江路支行'+"\n效率："+205

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.65544, 39.025738],
    title: '中国银行天津永顺里支行'+"\n效率："+206

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.664354, 39.042014],
    title: '中国银行天津杭州道支行'+"\n效率："+207

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.700968, 39.011091],
    title: '中国银行天津新港支行'+"\n效率："+208

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.700839, 39.011105],
    title: '中国银行天津海关大楼支行'+"\n效率："+209

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.67668, 39.021204],
    title: '中国银行天津解放路支行'+"\n效率："+210

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.195724, 39.135848],
    title: '中国银行天津海洋支行'+"\n效率："+211

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.700839, 39.011105],
    title: '中国银行天津泰达大街支行'+"\n效率："+212

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.715151, 39.035477],
    title: '中国银行天津滨海分行'+"\n效率："+213

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.090702, 39.131944],
    title: '中国银行天津汇盈支行'+"\n效率："+214

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.838562, 39.335865],
    title: '中国银行天津宁河支行'+"\n效率："+215

  });
  markers.push(marker);

  marker= new AMap.Marker({
    position: [117.210753, 39.112372],
    title: '中国银行天津市分行'+"\n效率："+216

  });
  markers.push(marker);
  addCluster();



  // 添加点聚合
  function addCluster() {
    if (cluster) {
      cluster.setMap(null);
    }
    map.plugin(["AMap.MarkerClusterer"], function() {
      cluster = new AMap.MarkerClusterer(map, markers);
    });

  }

  var data0 = [
    {
      value: 123,
      color: "#E2EAE9",
      label: "和平区"

    },
    {
      value : 34,
      color : "#F7464A",
      label: "南开区"
    },
    {
      value : 563,
      color : "#D4CCC5",
      label: "河西区"
    },
    {
      value : 311,
      color : "#949FB1",
      label: "河东区"
    },
    {
      value : 344,
      color : "#4D5360",
      label: "河北区"
    },
    {
      value: 123,
      color: "#E2EAE9",
      label: "和平区"

    },
    {
      value : 35,
      color : "#F7464A",
      label: "红桥区"
    },
    {
      value : 83,
      color : "#D4CCC5",
      label: "东丽区"
    },
    {
      value : 23,
      color : "#949FB1",
      label: "西青区"
    },
    {
      value : 218,
      color : "#4D5360",
      label: "津南区"
    }
  ];



  var ch0 = new Chart(document.getElementById("ch0").getContext("2d")).Pie(data0);

  var data1 = {
    labels : ["业务量","存款","贷款","客户数对公","信用卡","客户数量私","借记卡","收入"],
    datasets : [
      {
        label: "东丽支行",
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : [1,0.93,0.38,0.63,0.47,0.37,0.56,0.41]
      }
    ]};
  var data2 = {
    labels : ["业务量","存款","贷款","客户数对公","信用卡","客户数量私","借记卡","收入"],
    datasets : [
      {
        label: "津南支行",
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : [0.81,1,0.44,0.51,0.71,0.42,0.67,0.44]
      }
    ]};
  var data3 = {
    labels : ["业务量","存款","贷款","客户数对公","信用卡","客户数量私","借记卡","收入"],
    datasets : [
      {
        label: "西青支行",
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : [0.84,0.89,0.31,0.72,0.72,0.30,0.52,0.34]
      }
    ]};
  var op = {
    //Boolean - Whether to show lines for each scale point
    scaleShowLine : true,

    //Boolean - Whether we show the angle lines out of the radar
    angleShowLineOut : true,

    //Boolean - Whether to show labels on the scale
    scaleShowLabels : false,

    // Boolean - Whether the scale should begin at zero
    scaleBeginAtZero : true,

    //String - Colour of the angle line
    angleLineColor : "rgba(0,0,0,.1)",

    //Number - Pixel width of the angle line
    angleLineWidth : 1,

    //String - Point label font declaration
    pointLabelFontFamily : "'Arial'",

    //String - Point label font weight
    pointLabelFontStyle : "normal",

    //Number - Point label font size in pixels
    pointLabelFontSize : 10,

    //String - Point label font colour
    pointLabelFontColor : "#666",

    //Boolean - Whether to show a dot for each point
    pointDot : true,

    //Number - Radius of each point dot in pixels
    pointDotRadius : 3,

    //Number - Pixel width of point dot stroke
    pointDotStrokeWidth : 1,

    //Number - amount extra to add to the radius to cater for hit detection outside the drawn point
    pointHitDetectionRadius : 20,

    //Boolean - Whether to show a stroke for datasets
    datasetStroke : true,

    //Number - Pixel width of dataset stroke
    datasetStrokeWidth : 2,

    //Boolean - Whether to fill the dataset with a colour
    datasetFill : true,

    //String - A legend template

  };
  //Get the context of the canvas element we want to
  var ch1 = new Chart(document.getElementById("ch1").getContext("2d")).Radar(data1,op);
  var ch2 = new Chart(document.getElementById("ch2").getContext("2d")).Radar(data2,op);
  var ch3 = new Chart(document.getElementById("ch3").getContext("2d")).Radar(data3,op);
</script>
