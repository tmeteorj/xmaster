/**
 * Created by NING on 2016/10/10.
 */
$(function() {
    $("#form").validate({
        submitHandler : function(form) {
            ly.ajaxSubmit(form, {
                type : "post",
                dataType : "json",
                success : function(data) {

                    var tb = $("#loadhtml");
                    tb.html(CommnUtil.loadingImg());
                    tb.load(rootPath + '/visual/' + data + '/showconfig.shtml');

                }
            });
        }
    });
});