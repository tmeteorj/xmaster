/**
 * Created by NING on 2016/10/13.
 */
// 百度地图API功能

var show = function(data){

    var map = new BMap.Map('con');
    var point = new BMap.Point(data.longitude[0],data.latitude[0]);
    map.centerAndZoom(point, 11);
    function addMarker(point,laber){
        marker.addEventListener("click", function(){
            var infoWin = new BMap.InfoWindow(laber);
            this.openInfoWindow(infoWin);
        });

    }
    for(var i = 0;i < data.label.length; i++) {

        var marker = new BMap.Marker(new BMap.Point(data.longitude[i],data.latitude[i]));
        var la = data.label[i];
        (function(la){
            marker.addEventListener("click", function(){
                var infoWin = new BMap.InfoWindow(la);
                this.openInfoWindow(infoWin);
            });
        })(la);

        map.addOverlay(marker);

    }


}
