<%--
  Created by IntelliJ IDEA.
  User: NING
  Date: 2016/9/28
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style type="text/css"/>
<form name="myform" method="post" action="" class="form-horizontal">
  <table cellpadding="2" cellspacing="1" class="table">
    <caption>添加数据集</caption>
    <tr>
      <th><font color="red">*</font>  <strong>ID</strong></th>
      <td><input type="text" name="id" size="30" value="" readonly="true"/></td>
    </tr>
    <tr>
      <th><font color="red">*</font>  <strong>数据集名称</strong></th>
      <td><input type="text" name="title" size="30" value=""/></td>
    </tr>
    <tr>
      <th><strong>数据描述</strong></th>
      <td><input type="text" name="info" size="30" value=""/></td>
    </tr>
    <tr>
      <th><strong>数据库连接地址</strong></th>
      <td><input type="text" name="datasetUrl" value="" size="10"/>
      </td>
    </tr>
    <tr>
      <th><strong>数据库名称</strong></th>
      <td><input type="text" name="dataname" value="" size="10"/>
      </td>
    </tr>
    <tr>
      <th><strong>用户名</strong></th>
      <td><input type="text" name="username" value="" size="10"/>
      </td>
    </tr>
    <tr>
      <th><strong>密码</strong></th>
      <td><input type="text" name="psw" value="" size="10"/>
      </td>
    </tr>
    <tr>
      <th><strong>数据来源机构</strong></th>
      <td><input type="text" name="src" value="" size="10"/>
      </td>
    </tr>
    <tr>
      <th><strong>当前角色</strong></th>
      <td><input type="text" name="publisher" value="" size="10"/>
      </td>
    </tr>
    <tr>
      <th><strong>数据大小</strong></th>
      <td><input type="text" name="size" value="" size="10"/>
      </td>
    </tr>
    <tr>
      <th><strong>发布时间</strong></th>
      <td><input type="text" name="publishTime" value="" size="10"/>
      </td>
    </tr>
    <tbody><tr>
      <th></th>
      <td><input type="submit" name="next" value=" 添加 " class="button_style">&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" name="reset" value=" 重置 " class="button_style"></td>
    </tr>
    </tbody></table>
</form>
