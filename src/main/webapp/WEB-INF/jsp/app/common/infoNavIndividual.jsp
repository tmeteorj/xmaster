<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/11/21
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet"	href="${pageContext.servletContext.contextPath }/css/cikonss.css">
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
                  <%@include file="retrievalDatasetConfig.jsp" %>
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
              <fieldset>
                <div id="legend" class="">
                  <legend class="">人轨迹</legend>
                </div>
                <div id = "miaoshu">

                </div>
              </fieldset>
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
                     视频监控
                    </h4>
                  </div>
                  <div class="panel-body" style="display: block;"  id = "jk">
                    <%--<video width="320" height="240"  autoplay loop >--%>
                      <%--<source src="${pageContext.servletContext.contextPath }/images/jk.mp4" type="video/mp4">--%>
                    <%--</video>--%>
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
              <%@ include file="restrictionConfig.jsp" %>
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
  var timeid;
  var amap;
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
      var dbName = $("select[name='tableName'] option:selected").attr("dbName");
      $("#databaseName").val(dbName);
    });

  });
  function bindingDetailBtn(columns, currentData) {
    $("[dataId]").each(function () {
      $(this).bind("click", function () {

        var vhtml = "<div class=\"panel-body\" style=\"display: block;\"  id = \"jk\">"+
        "<video width=\"320\" height=\"240\"  autoplay loop >"+
        "<source src=\"${pageContext.servletContext.contextPath }/images/jk.mp4\" type=\"video/mp4\">"+
        "</video>"+
        "</div>"
        $("#jk").html(vhtml);
       // document.getElementById("jk").style.display="block";
        var dataId = $(this).attr("dataId");
        var index = $(this).attr("index");
        $.ajax({
          type: 'GET',
          url: '/common/<c:out value="${tableName}"/>/' + dataId + '/detail1.shtml',
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
            $.ajax({
              type: 'GET',
              url:  '/common/<c:out value="${tableName}"/>/' + dataId + '/getTrace.shtml',
              datatype: 'json',
              async: false,
              error: function () {

              },
              success: function (trace) {
                trace = JSON.parse(trace);

                var miaoshu = $("#miaoshu");
                var html = "";
                for(var o=0; o<trace.length; o++){
                  //console.log(trace[o][0]);

                  html += "<div class=\"form-group\">"+
                          "      <div class=\"col-sm-2\">"+

                          "      <p style=\"float: right\">"+trace[o][0]+"</p>"+
                          "        </div>"+
                          "       <div class=\"col-sm-10\">"+
                          "       <span class=\"icon icon-mid\"><span class=\"icon-file\"></span></span>"+
                          "       <p>"+trace[o][1]+"</p>"+
                          "       </div>"+
                          "       </div>"
                }
                miaoshu.html(html);
                $.ajax({
                  type: 'GET',
                  url: '/common/<c:out value="${tableName}"/>/' + dataId + '/getGps.shtml',
                  datatype: 'json',
                  async: false,
                  error: function () {

                  },
                  success: function (gpsData) {
                    init();
                    var arrayObj = getsubJson(gpsData,0,100);
                    gpsData = JSON.parse(gpsData);
                    console.log(gpsData);
                    var polyline = new AMap.Polyline({
                      path:gpsData,          //设置线覆盖物路径
                      strokeColor: "#33CC33", //线颜色
                      strokeOpacity: 1,       //线透明度
                      strokeWeight: 5,        //线宽
                      strokeStyle: "solid",   //线样式
                      strokeDasharray: [10, 5] //补充线样式
                    });
                    polyline.setMap(amap);

                  }
                });
                window.clearInterval(timeid);
                timeid = window.setInterval(showalert, 3000);
                function showalert()
                {
                  $.ajax({
                    type: 'GET',
                    url: '/common/getOneGps.shtml',
                    datatype: 'json',
                    async: false,
                    error: function () {

                    },
                    success: function (detailedData) {
                      detailedData = JSON.parse(detailedData);
                      console.log(detailedData);
                      var polyline = new AMap.Polyline({
                        path:detailedData,          //设置线覆盖物路径
                        strokeColor: "#33CC33", //线颜色
                        strokeOpacity: 1,       //线透明度
                        strokeWeight: 5,        //线宽
                        strokeStyle: "solid",   //线样式
                        strokeDasharray: [10, 5] //补充线样式
                      });
                      polyline.setMap(amap);
                      amap.setZoomAndCenter(19, detailedData[1]);
                    }
                  });
                }
              }
            });
          }
        });

      });
    });
  }

  function getsubJson(json,s,e){
    var arrayObj = new Array();
    for(var o=s;o<e-1;o++){
      var obj = {};
      var tmp = json[o];
      for(var key in tmp){
        obj[key] = tmp[key];
      }
      arrayObj.push(obj);
    }
    return arrayObj;
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
<script src="http://webapi.amap.com/maps?v=1.3&key=d811dda1aae5e80c64f364d199c05d9b&callback=init"></script>
<script> // gaode map
function init() {
  var map = new AMap.Map('map', {
//            center: [117.000923, 36.675807],
    center: [117.20, 39.13],
    zoom: 12
  });
  amap =map;
  map.plugin(['AMap.ToolBar', 'AMap.Scale', 'AMap.OverView'], function () {
    map.addControl(new AMap.ToolBar());
    map.addControl(new AMap.Scale());
    map.addControl(new AMap.OverView({isOpen: true}));
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

