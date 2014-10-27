<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <h1>List of local Docker Images</h1>
    <div class="menu">
        <ul>
            <li class="selected"><a href="../imagelist/">Images</a><br></li>
            <li><a href="../containerlist/">Container</a><br></li>
        </ul>
    </div>
    <table>
         <tr>
            <th align="left">Id</th>
            <th align="left">ParentId</th>
            <th align="left">Repository Tags</th>
            <th align="right">Size</th>
            <th align="right">Virtual Size</th>
            <th align="left">Created</th>
         </tr>
    <c:forEach items="${data}" var="image">
        <tr>
            <td><a href="../startcontainer/${image.id}">${image.id}</a></td>
            <td></td>
            <td>
                <c:forEach items="${image.repoTags}" var="tag">
                    ${tag}<br>
                </c:forEach>
            </td>
            <td align="right">${image.size}</td>
            <td align="right">${image.virtualSize}</td>
            <td>${image.created}</td>
        </tr>
    </c:forEach>
    </table>
</body>
</html>
