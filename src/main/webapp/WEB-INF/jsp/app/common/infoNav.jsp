<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">
  #network {
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
              <form id="searchForm" class="navbar-form navbar-left" role="search">
                <div class="form-group">
                  <input id="keyword" name="keyword" value="<c:out value="${keyword}"/>"
                         type="text" class="form-control" placeholder="请输入关键字"/>
                </div>
                <select id="tableName" name="tableName" class="form-control">
                  <c:forEach var="mapOfTableName" items="${tableNameList}">
                    <option value="<c:out value="${mapOfTableName.get('tableName')}"/>"
                            <c:if test="${tableName eq mapOfTableName.get('tableName')}">selected</c:if>>
                      <c:out
                              value="${mapOfTableName.get('tableComment')}"/></option>
                  </c:forEach>
                </select>
                <button id="search" type="button" class="btn btn-success">
                  检索
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!--搜索栏-->
      <div class="row"><!--地图栏-->
        <div class="col-md-12">
          <div id="network"></div>
        </div>
      </div>
      <!--关系图-->
      <div class="row"><!--列表栏-->
        <div class="col-md-12">
          <div id="bechange" class="table-responsive">
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
                导航
              </h3>
            </div>
            <div class="panel-body"><!--body-->
              <div class="panel-group">
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      时间导航
                    </h4>
                  </div>
                  <div class="panel-body">
                    <li><a href="#">年</a></li>
                    <li><a href="#">月</a></li>
                    <li><a href="#">日</a></li>
                    <li><a href="#">周次</a></li>
                  </div>
                </div>
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      空间导航
                    </h4>
                  </div>
                  <div class="panel-body">
                    <li><a href="#">国家</a></li>
                    <li><a href="#">州省</a></li>
                    <li><a href="#">郡市</a></li>
                    <li><a href="#">区县</a></li>
                  </div>
                </div>
                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      关系导航
                    </h4>
                  </div>
                  <div class="panel-body">
                    <li><a href="#">同乘坐一辆车</a></li>
                    <li><a href="#">同住一个地方</a></li>
                    <li><a href="#">同发表一篇文章</a></li>
                    <li><a href="#">其他关联关系</a></li>
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
              </h3>
            </div>
            <div class="panel-body">
              <div class="form-group">
                <label class="col-sm-3 control-label">数据集</label>

                <div class="col-sm-9">
                  <select class="form-control">
                    <option>请选择数据集</option>
                    <option>生物黑客活动</option>
                    <option selected>生物黑客组织</option>
                    <option>生物黑客成员</option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">起始</label>

                <div class="col-sm-9">
                  <div class="input-group date form_date" data-date="" data-date-format="yyyy-MM-dd"
                       data-link-field="" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" value="2009-12-10" readonly>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                  </div>
                  <input type="hidden" value=""/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">截止</label>

                <div class="col-sm-9">
                  <div class="input-group date form_date" data-date="" data-date-format="yyyy-MM-dd"
                       data-link-field="" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" value="2016-01-01" readonly>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                  </div>
                  <input type="hidden" value=""/>
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

<script src="${pageContext.request.contextPath}/echarts3/echarts.min.js" type="text/javascript"></script>
<script>
    var myChart = echarts.init(document.getElementById('network'));

    $(function(){
        myChart.showLoading();

        $.ajax({
            type: 'get',
            url: '/common/getGraph.shtml',
            datatype: 'json',
            error: function () {
            },
            success: function (myGraph) {
                myChart.hideLoading();
                myGraph = JSON.parse(myGraph);
                myGraph = JSON.parse(myGraph);
                option = {
                    tooltip: {
                        trigger: 'item'
                    },

                    animation: false,
                    legend: {
                        data: ['地块', '事件', '机构','人', '行为']
                    },
                    series : [
                        {
                            type: 'graph',
                            layout: 'force',
                            animation: false,
                            data: myGraph.nodes,
                            links: myGraph.links,
                            categories: myGraph.categories,
                            draggable: true,
                            roam: true,
                            label: {
                                normal: {
                                    position: 'right',
                                    formatter: '{b}'
                                }
                            },
                            force: {
                                edgeLength: 5,
                                repulsion: 20
                            }
                        }
                    ]
                };
                myChart.setOption(option);
            }
        });

        myChart.on('click', function (param){

            var tb = $("#bechange");
            tb.load(rootPath + '/common/' + param.data.dataset + '/selectData.shtml');
            //alert( '/common/'+param.value+'/' + 3 + '/getGraphbyid.shtml');
            $.ajax({
                type: 'GET',
                url: '/common/'+ param.data.dataset+'/'+ param.value+'/' + 4 + '/getGraphbyid.shtml',
                datatype: 'json',
                async: false,
                error: function () {
                },
                success: function (myGraph) {
                    myChart.hideLoading();
                    myGraph = JSON.parse(myGraph);
                    myGraph = JSON.parse(myGraph);
                    option = {
                        tooltip: {
                            trigger: 'item'
                        },

                        animation: false,
                        legend: {
                            data: ['地块', '事件', '机构','人', '行为','当前选择']
                        },
                        series : [
                            {
                                type: 'graph',
                                layout: 'force',
                                animation: false,
                                data: myGraph.nodes,
                                links: myGraph.links,
                                categories: myGraph.categories,
                                draggable: true,
                                roam: true,
                                label: {
                                    normal: {
                                        position: 'right',
                                        formatter: '{b}'
                                    }
                                },
                                force: {
                                    edgeLength: 5,
                                    repulsion: 20
                                }
                            }
                        ]
                    };
                    myChart.setOption(option);
                }
            });

            $.ajax({
                type: 'GET',
                url: '/common/'+param.data.dataset+'/' + param.value + '/detail1.shtml',
                datatype: 'json',
                async: false,
                error: function () {
                },
                success: function (detailedData) {
                    var detailedInfo = $("#detailedInfo");
                    detailedInfo.html("");
                    detailedData = JSON.parse(detailedData);
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
            });

        });
    });


</script>
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
      jsonUrl: rootPath + '/common/<c:out value="${tableName}"/>/findByPage/1.shtml?keyword=' + keyword,
      checkbox: false
    });

    $("#search").click(function () {
      var tableName = $("#tableName").val();
      var keyword = $("#keyword").val();
      var tb = $("#loadhtml");
      tb.html(CommnUtil.loadingImg());
      tb.load(rootPath + "/common/<c:out value="${accountName}"/>/infoRetrieval.shtml?tableName=" + tableName + '&keyword=' + keyword);
    });

    $("#tableName").change(function () {
      $("#keyword").val("");
    });

    $("[dataId]").each(function () {
      $(this).bind("click", function () {
        var dataId = $(this).attr("dataId");
        console.info(dataId);
        $.ajax({
          type: 'GET',
          url: '/common/<c:out value="${tableName}"/>/' + dataId + '/detail.shtml',
          datatype: 'json',
          async: false,
          error: function () {
          },
          success: function (detailedData) {
            var detailedInfo = $("#detailedInfo");
            detailedInfo.html("");
            detailedData = JSON.parse(detailedData);
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
        });
      });
    });
  });

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

