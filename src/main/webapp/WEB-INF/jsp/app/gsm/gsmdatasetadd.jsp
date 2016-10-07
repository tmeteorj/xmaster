<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@include file="/common/common.jspf" %>
	<script type="text/javascript" src="${ctx}/js/app/gsm/gsmdatasetadd.js"></script>

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
<form id="form" name="form" enctype="multipart/form-data" class="form-horizontal" method="post"
	  action="${ctx}/gsmdataset/adddataset.shtml">
	<input type="hidden" class="form-control"
		   value="${sessionScope.userSessionId}" name="upload_user_id" id="upload_user_id">
	<input type="hidden" class="form-control"
		   value="${sessionScope.userSessionAccountName}" name="upload_username" id="upload_username">
	<section class="panel panel-default">
		<div class="panel-body">
			<div class="form-group">
				<label class="col-sm-3 control-label">数据集描述</label>
				<div class="col-sm-9">
					<input type="text" class="form-control"
						   placeholder="请输入数据集描述"
						   name="description" id="description">
				</div>
			</div>

			<div class="line line-dashed line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label">文件路径</label>

				<div class="col-sm-9">
					<input type="file" name="file" class="form-control"  placeholder="请选择数据集文件" id="file">
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