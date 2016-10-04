/**
 * Created by NING on 2016/10/4.
 */
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