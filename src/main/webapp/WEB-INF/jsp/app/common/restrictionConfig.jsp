<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
                    <c:forEach var="mapOfTableName" items="${tableNameList}">
                        <c:if test="${tableName eq mapOfTableName.tableName}">
                            <c:set var="tableComment" value="${mapOfTableName.tableComment}"/>
                        </c:if>
                    </c:forEach>
                    <input type="text" class="form-control" value="<c:out value="${tableComment}"/>" readonly>
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
