/**
 * Created by NING on 2016/10/12.
 */
var show = function(data,divid){

    var map = new AMap.Map(divid, {
        resizeEnable: true,
        zoom:9,
        center: [data.longitude[0],data.latitude[0]]

    });
    for(var i = 0;i < data.label.length; i++) {
        new AMap.Marker({
            position: [data.longitude[i],data.latitude[i]],
            title: data.label[i],
            map: map
        });
    }

}