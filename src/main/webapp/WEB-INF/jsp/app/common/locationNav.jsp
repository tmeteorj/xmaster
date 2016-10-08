<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<style type="text/css">
    .panel{
        position: absolute;
        background-color: #fff;
        border: solid 1px silver;
        box-shadow: 3px 4px 3px 0px silver;
        right: 30px;
        top: 10px;
        padding: 5px 10px;
        font-size: 12px;
        border-radius: 4px
    }
</style>
<head>
    <title>Destroydrop &raquo; Javascripts &raquo; Tree</title>

    <link rel="StyleSheet" href="${pageContext.request.contextPath}/css/app/common/dtree.css" type="text/css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/app/common/dtree.js"></script>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main.css?v=1.0"/>
</head>

<body>
<div class="row-fluid">
    <div class="col-md-8">
        <div id="container" style="height: 800px"></div>
        <div class = 'panel'>选择切换省市：<select open id = 'subDistricts'></select></div>
    </div>
    <div class="col-md-4">
        <div class="dtree" id="myTree">
            <p><a href="javascript: d.openAll();">展开全部</a> | <a href="javascript: d.closeAll();">关闭全部</a></p>
        </div>
    </div>
</div>

<script src="http://webapi.amap.com/maps?v=1.3&key=7ea83963cea996848fd247e67ed8501f"></script>
<script type="text/javascript">

    d = new dTree('d');
    d.add(0,-1,'中国');
    <c:forEach items="${provinces}" var="province">
    d.add(${province.province_id},0,'${province.province_name}','javascript:');

    </c:forEach>

    <c:forEach items="${citys}" var="city">
    d.add(${city.city_id+provinces_size},${city.province_id},'${city.city_name}','javascript:');

    </c:forEach>

    <c:forEach items="${districts}" var="district">
    d.add(${district.district_id+provinces_size+citys_size},${district.city_id+provinces_size},'${district.district_name}','javascript:');

    </c:forEach>
    d.s=function(nodeId){
        add(this.aNodes[nodeId].name);
    }

    d.closeAll();
    document.getElementById("myTree").innerHTML += d;
    var map = new AMap.Map("container", {
        resizeEnable: true,
        center: [116.397428, 39.90923],//地图中心点
        zoom: 10 //地图显示的缩放级别
    });

    function add(name1) {
        //加载云图层插件
        AMap.service('AMap.DistrictSearch', function() {
            var opts = {
                subdistrict: 1,   //返回下一级行政区
                extensions: 'all',  //返回行政区边界坐标组等具体信息
                level: 'city'  //查询行政级别为 市
            };
            //alert(name1);
            //实例化DistrictSearch
            district = new AMap.DistrictSearch(opts);
            district.setLevel('district');
            //行政区查询
            district.search(name1,function(status, result){
                var subDistricts = result.districtList[0].districtList;
                var select = document.getElementById('subDistricts');
                select.innerHTML = '';
                for(var i = 0;i < subDistricts.length; i += 1){
                    var name = subDistricts[i].name;
                    var option = document.createElement('option');
                    option.value = option.innerHTML = name;
                    select.appendChild(option);
                }
                select.onchange = function(){map.setCity(this.value)};
                select.value = subDistricts[0].name;
                select.onchange();
            });
        });
    }
</script>
</body>
</html>