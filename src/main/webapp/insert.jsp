<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<sql:setDataSource var="myDatasource"
                   driver="org.apache.derby.jdbc.ClientDataSource"
                   url="jdbc:derby://localhost:1527/StudentDB"
                   user="app" password="app"/>

<c:set var="id" value="${param.id}" />
<c:set var="name" value="${param.name}" />
<c:set var="branch" value="${param.branch}" />

<form action="Insert.jsp" method="post">
    ID: <input type="text" name="id"><br>
    Name: <input type="text" name="name"><br>
    Branch: <input type="text" name="branch"><br>
    <input type="submit" value="Insert">
</form>

<c:if test="${not empty id && not empty name && not empty branch}">
    <sql:update dataSource="${myDatasource}">
        INSERT INTO STUDENT (ID, NAME, BRANCH) VALUES (?, ?, ?)
        <sql:param value="${id}" />
        <sql:param value="${name}" />
        <sql:param value="${branch}" />
    </sql:update>
</c:if>

<h3>Student Records:</h3>
<sql:query var="result" dataSource="${myDatasource}">
    SELECT * FROM STUDENT
</sql:query>

<table border="1">
    <tr><th>ID</th><th>Name</th><th>Branch</th></tr>
    <c:forEach var="row" items="${result.rows}">
        <tr>
            <td>${row.ID}</td>
            <td>${row.NAME}</td>
            <td>${row.BRANCH}</td>
        </tr>
    </c:forEach>
</table>
