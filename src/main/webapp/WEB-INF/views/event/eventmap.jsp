<%-- 
    Document   : eventmap
    Created on : Jun 19, 2025, 1:33:28 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Bản đồ sự kiện</title>
</head>
<body>
<div class="map-container">
    <h2>Vị trí tổ chức sự kiện</h2>

    <c:if test="${not empty diaChi}">
        <c:set var="diaChiEncoded" value="${fn:replace(diaChi, ' ', '+')}" />
        <iframe
            width="100%" height="450" style="border:0; border-radius: 10px;"
            loading="lazy"
            allowfullscreen
            referrerpolicy="no-referrer-when-downgrade"
            src="https://www.google.com/maps/embed/v1/place?key=AIzaSyCPlOW0iM9rYKBc1mGAZ5QJIuvyARqDjp0&q=${diaChiEncoded}">
        </iframe>
    </c:if>

    <c:if test="${empty diaChi}">
        <p style="color: red;">Không có địa chỉ sự kiện để hiển thị bản đồ.</p>
    </c:if>

</div>
</body>
</html>


