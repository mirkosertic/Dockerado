<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
</head>
<body>
    <h1>List of local Docker Container</h1>
    <a href="../imagelist/">Images</a><br>
    <table>
         <tr>
            <th align="left">Id</th>
            <th align="left">Created</th>
            <th align="left">Command</th>
            <th align="left">Image</th>
            <th align="left">Names</th>
            <th align="left">Ports</th>
            <th align="left">Status</th>
         </tr>
    <c:forEach items="${data}" var="container">
        <tr>
            <td><a href="../deletecontainer/${container.id}">${container.id}</a></td>
            <td>${container.created}</td>
            <td>${container.command}</td>
            <td>${container.image}</td>
            <td>
                <c:forEach items="${container.names}" var="name">
                    ${name}&nbsp;
                </c:forEach>
            </td>
            <td>
                <c:forEach items="${container.ports}" var="port">
                    ${port.ip}:${port.publicPort}(${port.type}) -&gt; ${port.privatePort}<br>
                </c:forEach>
            </td>
            <td>${container.status}</td>
        </tr>
    </c:forEach>
    </table>
</body>
</html>
