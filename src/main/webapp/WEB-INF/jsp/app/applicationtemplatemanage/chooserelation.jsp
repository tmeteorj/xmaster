<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/11/29
  Time: 14:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<section class="panel panel-default">
  <div class="panel-body">
    <div class="form-group">
      <table class="table">
        <thead>
        <tr>
            <th class="">数据集</th>
            <th class="">描述</th>
            <th class=""> </th>
        </tr>
        </thead>
        <tbody>
          <c:forEach items="${ds}" var="daaa">
          <tr>
            <td class="">${daaa.title}</td>
            <td class="">${daaa.info}</td>
            <td class="" >
              <button id="fun${daaa.id}" class="btn btn-info btn-s-xs">选择</button>
            </td>
          </tr>
          <script>
            $("#fun${daaa.id}").click("click", function () {
              var cbox = "${daaa.id}";
              var cname = "${daaa.title}";

              var tb = $("#selecteddataset");
              var td = $("#selecteddatasetid");
              var tdc = td.html();
              var tds = tdc.split(",");
              for (var i=0;i<tds.length;i++)
              {
                if(tds[i].trim()==cbox){
                  layer.msg("已选过");
                  return;
                }
              }
              //console.log(cname);
              tb.append("<strong><u>"+cname+"</u></strong> ");
              td.append(cbox+",");
              var tb = $("#red");
              tb.html(CommnUtil.loadingImg());
              tb.load(rootPath + '/dataset/' + cbox + '/chooserelation.shtml');
            });
          </script>

          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</section>
