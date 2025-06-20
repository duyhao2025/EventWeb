<%-- 
    Document   : cancel
    Created on : Jun 16, 2025, 4:31:51 AM
    Author     : Admin
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sự kiện đã đăng ký</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
</head>
<body>
    <h2>Danh sách sự kiện đã đăng ký</h2>

    <c:if test="${not empty msg}">
        <p style="color: green;">${msg}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>

    <table border="1" cellpadding="10" cellspacing="0">
    <thead>
        <tr>
            <th>Tiêu đề</th>
            <th>Địa chỉ</th>
            <th>Ngày giờ</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
            <th>Bản đồ</th> <!-- NEW -->
        </tr>
    </thead>
    <tbody>
        <c:forEach var="sk" items="${danhSachSuKien}">
            <tr>
                <td>${sk.tieuDe}</td>
                <td>${sk.diaChi}</td>
                <td>${sk.ngayGioHienThi}</td>
                <td>
                    <c:choose>
                        <c:when test="${sk.chuaDienRa}">Chưa diễn ra</c:when>
                        <c:otherwise>Đã diễn ra</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${sk.chuaDienRa}">
                        <form method="post" action="${pageContext.request.contextPath}/event/list">
                            <input type="hidden" name="id" value="${sk.maSuKien}" />
                            <button type="submit">Hủy đăng ký</button>
                        </form>
                    </c:if>
                </td>
                <td>
                    <form method="get" action="${pageContext.request.contextPath}/event/map">
                        <input type="hidden" name="id" value="${sk.maSuKien}" />
                        <button type="submit">Xem bản đồ</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</body>
</html>




