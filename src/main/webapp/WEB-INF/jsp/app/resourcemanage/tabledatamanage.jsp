<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@include file="/common/common.jspf" %>

    <style type="text/css">
        .col-sm-3 {
            width: 15%;
            float: left;
        }

        .col-sm-9 {
            width: 85%;
            float: left;
        }
    </style>
</head>
<body>
<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${ctx}/table/<c:out value="${tableName}"/>/save.shtml">
    <input type="hidden" class="form-control"
           value="${tabledata.id}" name="<c:out value="${tableName}"/>.id" id="id">
    <section class="panel panel-default">
        <div class="panel-body">
            <c:forEach items="${tableList}" var="table">
                <c:choose>
                    <c:when test="${table.columnName eq 'id'}"></c:when>
                    <c:when test="${table.columnName eq 'meta_created'}"></c:when>
                    <c:when test="${table.columnName eq 'meta_updated'}"></c:when>
                    <c:when test="${table.columnName eq 'deleted_mark'}"></c:when>
                    <c:when test="${table.dataType == 'datetime' || table.dataType == 'timestamp'}">
                        <div class="line line-dashed line-lg pull-in"></div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label"><c:out value="${table.columnComment}"/></label>

                            <div class="col-sm-9"><c:set value="${table.columnName}" var="columnName"/>
                                <div class="input-group date form_date" data-date="" data-date-format="yyyy-MM-dd"
                                     data-link-field="<c:out value="${table.columnName}"/>" data-link-format="yyyy-mm-dd">
                                    <c:set value="${tabledata.get(columnName)}" var="tabledataTime"/>
                                    <fmt:parseDate value="${tabledataTime}" var="time_founded"/>
                                    <input class="form-control" size="16" type="text" value="<fmt:formatDate value="${tabledataTime}" pattern="yyyy-MM-dd"/>" readonly>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                </div>
                                <input type="hidden" id="<c:out value="${table.columnName}"/>" name="<c:out value="${table.tableName}"/>.<c:out value="${table.columnName}"/>" value="<c:out value="${tabledata.get(columnName)}"/>"/><br/>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="line line-dashed line-lg pull-in"></div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label"><c:out value="${table.columnComment}"/></label>

                            <div class="col-sm-9"><c:set value="${table.columnName}" var="columnName"/>
                                <input type="text" class="form-control"
                                       placeholder="请输入<c:out value="${table.columnComment}"/>" value="<c:out value="${tabledata.get(columnName)}"/>"
                                       id="<c:out value="${table.columnName}"/>" name="<c:out value="${table.tableName}"/>.<c:out value="${table.columnName}"/>"/>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

        </div>
        <footer class="panel-footer text-right bg-light lter">
            <button type="submit" class="btn btn-success btn-s-xs">保存</button>
        </footer>
    </section>
</form>
<script type="text/javascript">
    onloadurl();
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
<script type="application/javascript">
    //单独验证某一个input  class="checkpass"
    jQuery.validator.addMethod("checkacc", function(value, element) {
        return this.optional(element)
                || ((value.length <= 30) && (value.length >= 3));
    }, "账号由3至30位字符组合构成");

    $(function() {
        $("form").validate({
            submitHandler : function(form) {
                ly.ajaxSubmit(form, {
                    type : "post",
                    dataType : "json",
                    success : function(data) {
                        if (data == "success") {
                            layer.confirm('操作成功！是否关闭窗口？', function(index) {
                                parent.grid.loadData();
                                parent.layer.close(parent.pageii);
                                return false;
                            });
                        } else {
                            layer.msg('操作失败！', 3);
                        }
                    }
                });
            },
            errorPlacement : function(error, element) {// 自定义提示错误位置
                $(".l_err").css('display', 'block');
                // element.css('border','3px solid #FFCCCC');
                $(".l_err").html(error.html());
            },
            success : function(label) {// 验证通过后
                $(".l_err").css('display', 'none');
            }
        });
    });
</script>
</body>
</html>