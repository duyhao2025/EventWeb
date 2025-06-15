
<%-- 
    Document   : eventregister
    Created on : Jun 8, 2025, 4:40:08 PM
    Author     : Admin
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Đăng ký tham gia sự kiện</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                background: url('https://anhdephd.vn/wp-content/uploads/2022/05/background-dep.jpg') no-repeat center center fixed;
                background-size: cover;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }

            .form-container {
                background: #ffffffee;
                padding: 40px 35px;
                border-radius: 12px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
                width: 100%;
                max-width: 420px;
                box-sizing: border-box;
            }

            .form-container h2 {
                text-align: center;
                margin-bottom: 25px;
                font-size: 24px;
                color: #111;
            }

            .form-container input[type="text"],
            .form-container input[type="email"] {
                width: 100%;
                padding: 12px 15px;
                margin-bottom: 18px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 15px;
                box-sizing: border-box;
                transition: 0.3s ease;
            }

            .form-container input[type="text"]:focus,
            .form-container input[type="email"]:focus {
                border-color: #e91e63;
                outline: none;
            }

            .form-container input[type="submit"] {
                width: 100%;
                padding: 13px;
                background-color: #e91e63;
                border: none;
                color: white;
                font-weight: bold;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .form-container input[type="submit"]:hover {
                background-color: #d81b60;
            }

            .message {
                text-align: center;
                color: red;
                margin-bottom: 15px;
            }

            .warning {
                text-align: center;
                color: orange;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Đăng ký tham gia sự kiện</h2>

            <c:if test="${not empty error}">
                <div class="message">${error}</div>
            </c:if>
            <c:if test="${not empty warning}">
                <div class="warning">${warning}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/eventregister" method="post">
                <input type="text" name="hoTen" placeholder="Họ tên" required />
                <input type="email" name="email" placeholder="Email" required />
                <input type="text" name="soDienThoai" placeholder="Số điện thoại" required />
                <input type="submit" value="Đăng ký" />
            </form>
        </div>
    </body>
</html>

