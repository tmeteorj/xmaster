<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<select id="tableName" name="tableName" class="form-control">
    <option value="bd_normal_action" dbname="xmaster" <c:if test="${tableName eq 'bd_normal_action'}">selected</c:if>>
        行为
    </option>
    <option value="bd_normal_people" dbname="xmaster" <c:if test="${tableName eq 'bd_normal_people'}">selected</c:if>>
        人口
    </option>
    <option value="bd_normal_org" dbname="xmaster" <c:if test="${tableName eq 'bd_normal_org'}">selected</c:if>>
        组织
    </option>
    <option value="bd_normal_plane" dbname="xmaster" <c:if test="${tableName eq 'bd_normal_plane'}">selected</c:if>>
        地块
    </option>
    <option value="bd_normal_event" dbname="xmaster" <c:if test="${tableName eq 'bd_normal_event'}">selected</c:if>>
        事件
    </option>
</select>