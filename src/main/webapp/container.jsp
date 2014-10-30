<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<!doctype html>
<html>
    <head>
        <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/">
        <link rel="stylesheet" href="style.css">
    </head>
<body>
    <div class="menu">
        <img src="images/dockerlogo.png" height="64">
        <ul>
            <li><a href="imagelist/">Images</a><br></li>
            <li class="selected"><a href="containerlist/">Container</a><br></li>
        </ul>
    </div>
    <table>
         <tr>
            <th align="left"></th>
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
            <td><a href="deletecontainer/${container.id}"><img src="images/bomb.png" height="16"></a></td>
            <td>${fn:substring(container.id,0,8)}</td>
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
