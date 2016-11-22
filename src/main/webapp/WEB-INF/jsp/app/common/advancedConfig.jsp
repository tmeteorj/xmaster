<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@include file="/common/common.jspf" %>
</head>
<body>
<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
<form id="form" name="form" class="form-horizontal" method="post"
      action="">
    <input type="hidden" class="form-control"
           value="" name="">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">数据集</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control" value="生物黑客" readonly>
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">起始时间</label>

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

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">截止时间</label>

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

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">国家</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入国家" value=""
                           name="">
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">州省</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入州省" value=""
                           name="">
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">郡市</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入郡市" value=""
                           name="">
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">区县</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入区县" value=""
                           name="">
                </div>
            </div>


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
</body>
</html>