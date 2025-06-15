
<%-- 
    Document   : success
    Created on : Jun 8, 2025, 4:40:19 PM
    Author     : Admin
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Đăng ký thành công</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                background: url('https://topanh.com/wp-content/uploads/2024/01/background-dep-ppt-scaled-1-2048x1080.jpg') no-repeat center center fixed;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .success-box {
                background: #ffffff;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                text-align: center;
            }

            .success-box h2 {
                color: #4CAF50;
                font-size: 24px;
                margin-bottom: 20px;
            }

            .success-box p {
                font-size: 16px;
                margin: 10px 0;
            }

            .success-box img {
                margin-top: 20px;
                border: 2px solid #ccc;
                padding: 5px;
                border-radius: 6px;
            }
        </style>
    </head>
    <body>
        <div class="success-box">
            <h2>🎉 Bạn đã đăng ký thành công!</h2>
            <p>Mã xác nhận: <strong>${code}</strong></p>
            <p>Ngày hết hạn: <strong>${ngayHetHan}</strong></p>
            <p><img src="${pageContext.request.contextPath}/${qrImagePath}" alt="QR Code" width="250"/></p>
        </div>
    </body>
</html>

