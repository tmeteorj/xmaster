<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/10/11
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="http://webapi.amap.com/maps?v=1.3&key=7ea83963cea996848fd247e67ed8501f"></script>
<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&ak=vYqY1p0N8melwlfnLqBwlVmy&services=&t=20160928173929"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/echarts3/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/diy/${js}"></script>

<label class="control-label">${info}</label>
</br>${type}
<div>
  <div id="con${configid}" style="height:400px;width: 100%"></div>
</div>
<div style="display: none">
  <p id = "configid">${configid}</p>

  <button id="beclick">创建</button>

</div>
<script>
//    var configid = $("#configid");
//    var tdc = configid.html();
//    $.ajax({
//        type: 'GET',
//        url: '/visual/' + tdc.trim() + '/getconfigdata.shtml',
//        datatype: 'json',
//        async: true,
//        success: function (data) {
//            show(JSON.parse(data));
//        },
//        error:function(data){
//            alert('error!');
//        }
//    });

    var data = ${data};
    show(data,"con${configid}");
</script>