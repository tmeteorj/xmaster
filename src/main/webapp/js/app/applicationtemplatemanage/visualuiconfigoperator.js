/**
 * Created by NING on 2016/10/18.
 */
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


                    var td1 = $("#datasetids");
                    var tdc1 = td1.html();
                    var td2 = $("#typeid");
                    var tdc2 = td2.html();
                    var tb = $("#loadhtml");
                    tb.html(CommnUtil.loadingImg());
                    tb.load(rootPath + '/visual/' + tdc1.trim() + '/' + tdc2.trim() + '/' + data + '/config.shtml');

                }
            });
        }
    });
});