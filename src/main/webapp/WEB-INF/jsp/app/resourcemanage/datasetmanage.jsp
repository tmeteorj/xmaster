<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/9/28
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style type="text/css"/>
<form action="" method="post">
  <div class="button_box">
    <input name="addinfo" type="submit" value="添加数据集" class="button_style">
    <input type="hidden" name="lastindex" value="5" />
  </div>
</form>
<table align="center" cellpadding="0" cellspacing="1" class="table_list">
  <caption>数据集列表</caption>
  <tbody><tr>
    <th width="5%">ID</th>
    <th width="8%">数据名称</th>
    <th width="12%">数据描述</th>
    <th width="10%">数据库连接地址</th>
    <th width="8%">数据库名称</th>
    <th width="7%">用户名</th>
    <th width="6%">密码</th>
    <th width="8%">数据来源机构</th>
    <th width="7%">当前角色</th>
    <th width="6%">数据大小</th>
    <th width="9%">发布时间</th>
    <th >操作</th>
  </tr>

  <tr>
    <td class="align_c">1</td>
    <td class="align_c">data1</td>
    <td class="align_c">银行</td>
    <td class="align_c">127.0.0.1:3306</td>
    <td class="align_c">jxc</td>
    <td class="align_c">root</td>
    <td class="align_c">123</td>
    <td class="align_c">银行</td>
    <td class="align_c"></td>
    <td class="align_c"></td>
    <td class="align_c">2016-06-25 07:57:40</td>
    <td class="align_c"><a  href="">查看 </a>        <a href="">修改</a>　<a href="" onclick="return confirm('确定删除“data1”数据集？');">删除</a></td>
  </tr>
  <tr>
    <td class="align_c">2</td>
    <td class="align_c">data21</td>
    <td class="align_c"></td>
    <td class="align_c">127.0.0.1:3306</td>
    <td class="align_c">jxc</td>
    <td class="align_c">root</td>
    <td class="align_c">123</td>
    <td class="align_c"></td>
    <td class="align_c"></td>
    <td class="align_c"></td>
    <td class="align_c">2016-07-01 01:54:24</td>
    <td class="align_c"><a  href="">查看 </a>        <a href="">修改</a>　<a href="" onclick="return confirm('确定删除“data1”数据集？');">删除</a></td>
  </tr>
  <tr>
    <td class="align_c">3</td>
    <td class="align_c">data22</td>
    <td class="align_c"></td>
    <td class="align_c">127.0.0.1:3306</td>
    <td class="align_c">jxc</td>
    <td class="align_c">root</td>
    <td class="align_c">123</td>
    <td class="align_c"></td>
    <td class="align_c"></td>
    <td class="align_c"></td>
    <td class="align_c">2016-07-01 21:04:58</td>
    <td class="align_c"><a  href="">查看 </a>        <a href="">修改</a>　<a href="" onclick="return confirm('确定删除“data1”数据集？');">删除</a></td>
  </tr>
  <tr>
    <td class="align_c">4</td>
    <td class="align_c">data31</td>
    <td class="align_c"></td>
    <td class="align_c">127.0.0.1:3306</td>
    <td class="align_c">jxc</td>
    <td class="align_c">root</td>
    <td class="align_c">123</td>
    <td class="align_c"></td>
    <td class="align_c"></td>
    <td class="align_c"></td>
    <td class="align_c">2016-07-28 21:05:01</td>
    <td class="align_c"><a  href="">查看 </a>        <a href="">修改</a>　<a href="" onclick="return confirm('确定删除“data1”数据集？');">删除</a></td>
  </tr>
  <tr>
    <td class="align_c">14</td>
    <td class="align_c">data32</td>
    <td class="align_c"></td>
    <td class="align_c">127.0.0.1:3306</td>
    <td class="align_c">jxc</td>
    <td class="align_c">root</td>
    <td class="align_c">123</td>
    <td class="align_c"></td>
    <td class="align_c"></td>
    <td class="align_c"></td>
    <td class="align_c">2016-07-29 11:02:04</td>
    <td class="align_c"><a  href="">查看 </a>        <a href="">修改</a>　<a href="" onclick="return confirm('确定删除“data1”数据集？');">删除</a></td>
  </tr>
  </tbody></table>
<form action="" method="post">
  <div class="button_box">
    <input name="addinfo" type="submit" value="添加数据集" class="button_style">
  </div>
</form>

<!--从这里开始修改-->
<div id="pages">
  总数：<b>5</b>
  <a href="">首页</a><a href="">上一页</a><a href="">下一页</a><a href="0">尾页</a>
  页次：<b><font color="red">1</font>/1</b>
  <input type="text" name="page" id="page" size="2" onkeydown="" class="input_blur">
  <input type="button" value="GO" class="gotopage button_style" onclick=""></div>
