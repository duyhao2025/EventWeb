<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thông tin cá nhân</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap');

            * {
                box-sizing: border-box;
            }
            body {
                font-family: 'Inter', 'Segoe UI', sans-serif;
                background: #eef2f7;
                margin: 0;
                padding: 0;
            }
            .wrapper {
                max-width: 600px;
                margin: 60px auto;
                background: #ffffff;
                padding: 40px 48px;
                border-radius: 16px;
                box-shadow: 0 12px 28px rgba(0, 0, 0, 0.06);
            }
            h2 {
                margin-top: 0;
                font-size: 24px;
                font-weight: 600;
                color: #1a202c;
                margin-bottom: 32px;
                text-align: center;
            }
            label {
                font-weight: 500;
                color: #2d3748;
                display: block;
                margin-bottom: 6px;
            }
            input[type="text"],
            input[type="email"],
            select {
                width: 100%;
                padding: 12px 14px;
                margin-bottom: 20px;
                border: 1px solid #cbd5e0;
                border-radius: 8px;
                font-size: 15px;
            }
            .button-group {
                display: flex;
                justify-content: space-between;
                gap: 12px;
            }
            button,
            .btn-link {
                padding: 12px 20px;
                font-size: 15px;
                font-weight: 600;
                border-radius: 8px;
                border: none;
                cursor: pointer;
                transition: all 0.25s ease;
            }
            button {
                background-color: #38a169;
                color: white;
            }
            button:hover {
                background-color: #2f855a;
            }
            .btn-link {
                background-color: #3182ce;
                color: white;
                text-decoration: none;
                display: inline-block;
                text-align: center;
            }
            .btn-link:hover {
                background-color: #2b6cb0;
            }
            .msg {
                text-align: center;
                color: #2f855a;
                margin-bottom: 20px;
                font-weight: 500;
            }
        </style>
    </head>
    <body>

        <div class="wrapper">
            <h2>Thông tin cá nhân</h2>

            <c:if test="${not empty msg}">
                <div class="msg">${msg}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/user/profile" method="post">
                <label for="hoTen">Họ tên</label>
                <input type="text" id="hoTen" name="hoTen" value="${user.hoTen}" required />

                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="${user.email}" required />

                <label for="soDienThoai">Số điện thoại</label>
                <input type="text" id="soDienThoai" name="soDienThoai" value="${user.soDienThoai}" />

                <div class="button-group">
                    <button type="submit">Cập nhật</button>
                    <a href="${pageContext.request.contextPath}/demo" class="btn-link">Quay về trang chủ</a>
                </div>
            </form>
        </div>

    </body>
</html>
