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
            <li class="selected"><a href="imagelist/">Images</a><br></li>
            <li><a href="containerlist/">Container</a><br></li>
        </ul>
    </div>
    <table>
         <tr>
            <th align="left"></th>
            <th align="left">Id</th>
            <th align="left">ParentId</th>
            <th align="left">Repository Tags</th>
            <th align="right">Size</th>
            <th align="right">Virtual Size</th>
            <th align="left">Created</th>
            <th align="left"></th>
         </tr>
    <c:forEach items="${data}" var="image">
        <tr>
            <td><a href="startcontainer/${image.id}"><img src="images/play.png" height="16"></a></td>
            <td>${fn:substring(image.id,0,8)}</td>
            <td></td>
            <td>
                <c:forEach items="${image.repoTags}" var="tag">
                    ${tag}<br>
                </c:forEach>
            </td>
            <td align="right">${image.size}</td>
            <td align="right">${image.virtualSize}</td>
            <td>${image.created}</td>
            <td><a href="deleteimage/${image.id}"><img src="images/delete.png" height="16"></a></td>
        </tr>
    </c:forEach>
    </table>
</body>
</html>
