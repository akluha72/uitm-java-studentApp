<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<sql:setDataSource var="myDatasource"
                   driver="org.apache.derby.jdbc.ClientDriver"
                   url="jdbc:derby://localhost:1527/StudentDB"
                   user="app" password="app"/>

<sql:query var="ids" dataSource="${myDatasource}">
    SELECT ID FROM STUDENT
</sql:query>

<c:set var="id" value="${param.id}" />

<form action="delete.jsp" method="post">
    ID:
    <select name="id">
        <option value="select">--Select--</option>
        <c:forEach var="row" items="${ids.rows}">
            <option value="${row.ID}">${row.ID}</option>
        </c:forEach>
    </select><br>
    <input type="submit" value="Delete">
</form>

<c:if test="${id != null && id != 'select'}">
    <sql:update dataSource="${myDatasource}">
        DELETE FROM STUDENT WHERE ID = ?
        <sql:param value="${id}" />
    </sql:update>
</c:if>
