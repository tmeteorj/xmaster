<%@ page import="cn.edu.tju.bigdata.util.ConstMap" %>
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
<form id="form" name="form" class="form-horizontal">
    <input type="hidden" class="form-control"
           value="" name="">
    <section class="panel panel-default">
        <div class="panel-body">

            <div class="form-group">
                <label class="col-sm-3 control-label">国家</label>
                <div class="col-sm-9">
                    <select class="form-control">
                        <option selected>中国</option>
                    </select>
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">省市</label>
                <div class="col-sm-9">
                    <select class="form-control">
                        <option selected>天津</option>
                    </select>
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">数据集</label>
                <div class="col-sm-9">
                    <select class="form-control">
                        <option selected>天津中心城区块</option>
                    </select>
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">年份</label>

                <div class="col-sm-9">
                    <select class="form-control" id="sel_year">
                        <option value="2015">2015年</option>
                    </select>
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">月份</label>
                <div class="col-sm-9">
                    <select class="form-control" id="sel_month">
                        <option value="1">1月</option>
                        <option value="2">2月</option>
                        <option value="3">3月</option>
                        <option value="4">4月</option>
                        <option value="5">5月</option>
                        <option value="6">6月</option>
                        <option value="7">7月</option>
                        <option value="8">8月</option>
                        <option value="9">9月</option>
                        <option value="10">10月</option>
                        <option value="11">11月</option>
                        <option value="12">12月</option>
                    </select>
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">属性</label>
                <div class="col-sm-9">
                    <div class="col-sm-9">
                        <select class="form-control" id="sel_attr">
                            <%
                                for (String[] items : ConstMap.attrMap) {
                                    out.println(String.format("<option value=\"%s\">%s</option>", items[0], items[1]));
                                }
                            %>
                        </select>
                    </div>
                </div>
            </div>


        </div>
        <footer class="panel-footer text-right bg-light lter">
            <button id="btn_save" type="submit" class="btn btn-success btn-s-xs">保存</button>
        </footer>
    </section>
</form>
<script>
    $(function () {
        $("#btn_save").click(function () {
            var year = $("#sel_year").val();
            var month = $("#sel_month").val();
            var attr = $("#sel_attr").val();
            $.ajax({
                type: "POST",
                url: "/plane/" + year + "/" + month + "/" + attr + "/session-set.shtml",
                success: function (response) {

                },
                error: function () {
                    alert("Error");
                }
            });
        })
</script>
</body>
</html>