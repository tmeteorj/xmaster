<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/crime/fzryxxlist.js"></script>

<div class="m-b-md">
    <form class="form-inline" role="form" id="searchForm"
          name="searchForm">
        <div class="form-group">
            <label class="control-label">
                <span class="h4 font-thin v-middle">身份证号:</span></label> <input
                class="input-medium ui-autocomplete-input" id="gmsfhm"
                name="fzryxxFormMap.gmsfhm" style="width: 150px">
        </div>
        <div class="form-group">
            <label class="control-label">
                <span class="h4 font-thin v-middle">姓名:</span></label> <input
                class="input-medium ui-autocomplete-input" id="xm"
                name="fzryxxFormMap.xm" style="width: 80px">
        </div>
        <div class="form-group">
            <label class="control-label"> <span
                    class="h4 font-thin v-middle">性别:</span></label>
            <select style="width:40px;height:30px; display:inline" id="type" name="fzryxxFormMap.xb">
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
        </div>
        <div class="form-group">
            <label class="control-label"> <span
                    class="h4 font-thin v-middle">文化程度:</span></label>
            <select style="width:80px;height:30px; display:inline" id="whcd" name="fzryxxFormMap.whcd">
                <option value="无">无</option>
                "小学","初中","高中","职业高中","大专","本科","硕士","博士","博士后"
                <option value="小学">小学</option>
                <option value="初中">初中</option>
                <option value="高中">高中</option>
                <option value="职业高中">职业高中</option>
                <option value="大专">大专</option>
                <option value="本科">本科</option>
                <option value="硕士">硕士</option>
                <option value="博士">博士</option>
                <option value="博士后">博士后</option>
            </select>
        </div>
        <div class="form-group">
            <label class="control-label"> <span
                    class="h4 font-thin v-middle">案件类别:</span></label>
            <select style="width:120px;height:30px; display:inline" id="ajlb" name="fzryxxFormMap.aklb">
                <option value="盗窃">盗窃</option>
                <option value="抢劫">抢劫</option>
                <option value="杀人">杀人</option>
                <option value="诈骗">诈骗</option>
                <option value="寻性滋事">寻性滋事</option>
                <option value="聚众斗殴">聚众斗殴</option>
                <option value="强奸">强奸</option>
                <option value="放火">放火</option>
            </select>
        </div>
        <div class="form-group">
            <label class="control-label"> <span
                    class="h4 font-thin v-middle">处理结果:</span></label>
            <select style="width:120px;height:30px; display:inline" id="cljg" name="fzryxxFormMap.cljg">
                <option value="刑拘">刑拘</option>
                <option value="罚款">罚款</option>
                <option value="死刑">死刑</option>
                <option value="批评教育">批评教育</option>
            </select>
        </div>
        <a href="javascript:void(0)" class="btn btn-info" id="search">查询</a>
    </form>
</div>

<header class="panel-heading">
    <div class="doc-buttons">
        <c:forEach items="${res}" var="key">
            ${key.description}
        </c:forEach>
    </div>
</header>

<div class="table-responsive">
    <div id="paging" class="pagclass"></div>
</div>