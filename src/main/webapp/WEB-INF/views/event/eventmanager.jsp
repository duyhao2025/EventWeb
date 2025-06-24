<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Quản lý đăng ký sự kiện</title>
        <style>
            table {
                width: 90%;
                border-collapse: collapse;
                margin: 20px auto;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #f2f2f2;
            }
            h2 {
                text-align: center;
                margin-top: 30px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
        <div class="event-manager-container" style="padding-top: 100px;">
            <h2>Danh sách người đăng ký</h2>
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="nguoi" items="${danhSachDangKy}" varStatus="stt">
                        <tr>
                            <td>${stt.index + 1}</td>
                            <td>${nguoi.hoTen}</td>
                            <td>${nguoi.email}</td>
                            <td>${nguoi.soDienThoai}</td>
                            <td>${nguoi.trangThai}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </body>
</html>