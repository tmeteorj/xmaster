/**
 * Created by NING on 2016/11/12.
 */
$("#cl").click("click", function () {// 绑定查询按扭
    var count = $("#count");
    console.log(count.text());
    for(var i = 0;i<count.text();i++){
        var tb = $("#loadhtml"+i);
        tb.load(rootPath + '/visual/' + $("#index"+i).text().trim() + '/showconfig.shtml');
    }
});
var beclick = $("#cl");
beclick.click();