<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/visualuiconfigoperator.js"></script>
<label class="control-label">选择算子</label>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${ctx}/visual/saveoperator.shtml">
    <div class="panel-body">
        <div class="form-group">
            <label class="col-sm-3 control-label">算子配置信息的描述</label>

            <div class="col-sm-9">
                <input type="text" class="form-control"
                       placeholder="请描述这个算子配置信息" value=""
                       name="operatorConfigFromMap.info" id="info">
            </div>
        </div>



        <div class="line line-dashed line-lg pull-in"></div>
        <div class="form-group">
            <label class="col-sm-3 control-label">所使用算法</label>

            <div class="col-sm-9">
                <input type="text" class="form-control" value="${operatorid}" readOnly="true"
                       name="operatorConfigFromMap.operatorid" id="operatorid">
            </div>
        </div>


        <label class="control-label">请配置算子输入</label>
        <c:forEach var="operatorInputFromMap" items="${operatorInputFromMaps}">
            <c:choose>
                <c:when test="${operatorInputFromMap.ismetadata > 0}">
                    <div class="line line-dashed line-lg pull-in"></div>
                    <div class="form-group">

                        <div class="col-sm-3">
                            <label class="control-label">${operatorInputFromMap.name}</label>
                            </br>${operatorInputFromMap.discription}
                        </div>
                        <div class="col-sm-9">
                            <select id="${operatorInputFromMap.id}" name="${operatorInputFromMap.id}"  class="form-control">
                                <c:forEach var="metadata" items="${metadatas}">
                                    <option value="${metadata.id}">${metadata.meta}:${metadata.remark}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>



                </c:when>

                <c:otherwise>
                    <div class="line line-dashed line-lg pull-in"></div>
                    <div class="form-group">

                        <div class="col-sm-3">
                            <label class="control-label">${operatorInputFromMap.name}</label>
                            </br>${operatorInputFromMap.discription}
                        </div>
                        <div class="col-sm-9">
                            <input type="text" class="form-control"
                                   placeholder="" value=""
                                   name="${operatorInputFromMap.id}" id="${operatorInputFromMap.id}">
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </div>
    <footer class="panel-footer text-right bg-light lter">
        <button type="submit" class="btn btn-success btn-s-xs" id="createconfig">完成</button>
    </footer>
</form>

<div>

    <p id="datasetids" style="display: none">
        ${datasetids}
    </p>
    <p id="typeid" style="display: none">
        ${typeid}
    </p>

</div>