<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@include file="/common/common.jspf" %>
    <script type="text/javascript" src="${ctx}/js/app/meetup/edit.js"></script>

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
      action="${ctx}/meetup/save.shtml">
    <input type="hidden" class="form-control"
           value="${meetup.id}" name="meetupFormMap.id" id="id">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">名称</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入组织名称" value="${meetup.name}"
                           name="meetupFormMap.name" id="name">
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">成员人数</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入成员人数" value="${meetup.num_member}"
                           name="meetupFormMap.num_member" id="num_member">
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">活动数</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入举办过的活动数" value="${meetup.num_past_meetups}"
                           name="meetupFormMap.num_past_meetups" id="num_past_meetups">
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">成立时间</label>

                <div class="col-sm-9">
                    <div class="input-group date form_date" data-date="" data-date-format="yyyy-MM-dd"
                         data-link-field="time_founded" data-link-format="yyyy-mm-dd">
                        <fmt:parseDate value="${meetup.time_founded}" var="time_founded"/>
                        <input class="form-control" size="16" type="text" value="<fmt:formatDate value="${time_founded}" pattern="yyyy-MM-dd"/>" readonly>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                    <input type="hidden" id="time_founded" name="meetupFormMap.time_founded" value="<c:out value="${meetup.time_founded}"/>"/><br/>
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">地址</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入地址" value="${meetup.place_name}"
                           name="meetupFormMap.place_name" id="place_name">
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">国家</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入国家" value="${meetup.country}"
                           name="meetupFormMap.country" id="country">
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">地区</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入地区" value="${meetup.region}"
                           name="meetupFormMap.region" id="region">
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">纬度</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入纬度" value="${meetup.latitude}"
                           name="meetupFormMap.latitude" id="latitude">
                </div>
            </div>

            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">经度</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control"
                           placeholder="请输入经度" value="${meetup.longitude}"
                           name="meetupFormMap.longitude" id="longitude">
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