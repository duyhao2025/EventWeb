<%-- 
    Document   : cancel
    Created on : Jun 16, 2025, 4:31:51 AM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hủy đăng ký sự kiện</title>
    <style>
        table {
            width: 90%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #999;
            padding: 8px 12px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .btn-cancel {
            background-color: red;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h2 style="text-align: center;">Danh sách sự kiện bạn đã đăng ký</h2>

    <c:if test="${empty danhSachSuKien}">
        <p style="text-align: center;">Bạn chưa đăng ký sự kiện nào.</p>
    </c:if>

    <c:if test="${not empty danhSachSuKien}">
        <table>
            <tr>
                <th>Tiêu đề</th>
                <th>Thời gian</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>

            <c:forEach var="sk" items="${danhSachSuKien}">
                <tr>
                    <td>${sk.tieuDe}</td>
                    <td>${sk.ngayToChuc}</td>
                    <td>
                        <c:choose>
                            <c:when test="${sk.chuaDienRa}">Chưa diễn ra</c:when>
                            <c:otherwise>Đã diễn ra</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${sk.chuaDienRa}">
                            <form method="post" action="${pageContext.request.contextPath}/event/cancel">
                                <input type="hidden" name="id" value="${sk.maSuKien}" />
                                <button type="submit" class="btn-cancel">Hủy đăng ký</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</body>
</html>

