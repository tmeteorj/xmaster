<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/11/29
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/Chart.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/swiper2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/app/applicationtemplatemanage/script.js"></script>


<link href="${pageContext.request.contextPath}/css/app/sstyle.css" rel="stylesheet" type="text/css">
<div class="index_swipers swiper-container">
  <div class="swiper-wrapper">
    <div id="up_down_mod" class="swiper-slide up_down swiper-slide-visible swiper-slide-active">
      <div class="swiper-slide_in">
        <div class="up_text">
          <div>
            <h3 style="opacity: 1; top: 0px;">地图ATM展示</h3>
            <p style="opacity: 1; top: 0px;">本行ATM取款机分布，及每个取款机效率</p>
          </div>
        </div>
        <div><canvas id="ch0" width="400" height="400"/></div>

      </div>
    </div>
    <div id="up_down_mod" class="swiper-slide up_down swiper-slide-visible">
      <div class="swiper-slide_in">
        <div class="up_text">
          <div>
            <h3 style="opacity: 1; top: 0px;">地图ATM展示</h3>
            <p style="opacity: 1; top: 0px;">本行ATM取款机分布，及每个取款机效率</p>
          </div>
        </div>
        <div><canvas id="ch1" width="400" height="400"/></div>

      </div>
    </div>
    <div class="pagination index_p"></div>
  </div>
</div>

</body>

<script>
  var data0 = [
    {
      value: 123,
      color: "#E2EAE9",
      label: "和平区"

    },
    {
      value : 34,
      color : "#F7464A",
      label: "南开区"
    },
    {
      value : 563,
      color : "#D4CCC5",
      label: "河西区"
    },
    {
      value : 311,
      color : "#949FB1",
      label: "河东区"
    },
    {
      value : 344,
      color : "#4D5360",
      label: "河北区"
    },
    {
      value: 123,
      color: "#E2EAE9",
      label: "和平区"

    },
    {
      value : 35,
      color : "#F7464A",
      label: "红桥区"
    },
    {
      value : 83,
      color : "#D4CCC5",
      label: "东丽区"
    },
    {
      value : 23,
      color : "#949FB1",
      label: "西青区"
    },
    {
      value : 218,
      color : "#4D5360",
      label: "津南区"
    }
  ];



  var ch0 = new Chart(document.getElementById("ch0").getContext("2d")).Pie(data0);
  var ch1 = new Chart(document.getElementById("ch1").getContext("2d")).Pie(data0);
</script><script>$(document).ready(function() {
  $("div.full,.index_swipers").css('height', window.innerHeight + 'px')

  $(window).resize(function() {
    $("div.full,.index_swipers").css('height', window.innerHeight + 'px');

    $(".index_swipers .swiper-slide").css('width', window.innerWidth + 'px');
  });
  var index_swipers = new Swiper('.index_swipers', {
    pagination: '.index_p',
    paginationClickable: true,
    mode: 'vertical',
    speed: 1000,
    cssWidthAndHeight: 'width',

    mousewheelControl: true,
    onSlideChangeStart: function(swiper) {
      $.news_open();
    },
    onSlideChangeEnd: function(swiper) {
      if ($('.swiper-slide-active').hasClass('lastslide')) {
        index_swipers.disableMousewheelControl();

      }
    },

    onFirstInit: function(swiper) {
      $.news_open()
    }
  });

  $(window).scroll(function() {
    if ($(window).scrollTop() == 0) {

      index_swipers.enableMousewheelControl();

    }
  });

});</script>