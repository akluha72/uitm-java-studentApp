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
<c:set var="name" value="${param.name}" />
<c:set var="branch" value="${param.branch}" />

<form action="update.jsp" method="post">
    ID:
    <select name="id">
        <option value="select">--Select--</option>
        <c:forEach var="row" items="${ids.rows}">
            <option value="${row.ID}">${row.ID}</option>
        </c:forEach>
    </select><br>
    Name: <input type="text" name="name"><br>
    Branch: <input type="text" name="branch"><br>
    <input type="submit" value="Update">
</form>

<c:if test="${id != 'select' && not empty name && not empty branch}">
    <sql:update dataSource="${myDatasource}">
        UPDATE STUDENT SET NAME = ?, BRANCH = ? WHERE ID = ?
        <sql:param value="${name}" />
        <sql:param value="${branch}" />
        <sql:param value="${id}" />
    </sql:update>
</c:if>
