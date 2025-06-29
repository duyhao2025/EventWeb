<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <meta charset="UTF-8">
        <title>Thông tin cá nhân & Lịch sử sự kiện</title>
        <style>
            footer a {
                color: #eaeaea;
                text-decoration: none;
            }

            footer a:hover {
                color: #ffffff;
                text-decoration: underline;
            }

            footer h5 {
                font-weight: bold;
                margin-bottom: 16px;
            }
            footer ul {
                padding-left: 0;
            }

            footer li {
                margin-bottom: 6px;
            }
            body {
                font-family: 'Segoe UI', sans-serif;
                background: #f3f5f8;
                margin: 0;
            }
            .container {
                display: flex;
                gap: 24px;
                max-width: 1200px;
                margin: 50px auto;
                padding: 0 24px;
            }
            .profile-section, .history-section {
                background: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.06);
            }
            .profile-section {
                flex: 1;
            }
            .history-section {
                flex: 2;
            }
            h2 {
                margin-top: 0;
                font-size: 22px;
                border-bottom: 1px solid #ddd;
                padding-bottom: 12px;
            }
            label {
                font-weight: 500;
                margin-bottom: 6px;
                display: block;
            }
            input, select {
                width: 100%;
                padding: 10px 12px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 8px;
            }
            button {
                width: 100%;
                padding: 12px;
                background-color: #38a169;
                color: white;
                font-weight: bold;
                border: none;
                border-radius: 8px;
                cursor: pointer;
            }
            button:hover {
                background-color: #2f855a;
            }
            .event-card {
                border: 1px solid #ddd;
                padding: 16px;
                border-radius: 10px;
                margin-bottom: 16px;
            }
            .event-card h4 {
                margin: 0 0 8px;
            }
            .event-card p {
                margin: 4px 0;
                font-size: 14px;
            }
            .event-card a {
                color: #3182ce;
                text-decoration: none;
                font-weight: 500;
            }
            .msg {
                text-align: center;
                color: green;
                margin-bottom: 16px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Profile Form -->
            <div class="profile-section">
                <h2>Thông tin cá nhân</h2>

                <c:if test="${not empty msg}">
                    <div class="msg">${msg}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/user/profile" method="post">
                    <label>Họ tên</label>
                    <input type="text" name="hoTen" value="${user.hoTen}" required />

                    <label>Email</label>
                    <input type="email" name="email" value="${user.email}" required />

                    <label>Số điện thoại</label>
                    <input type="text" name="soDienThoai" value="${user.soDienThoai}" />

                    <label>Ngôn ngữ</label>
                    <select name="ngonNgu">
                        <option value="vi" ${user.ngonNgu == 'vi' ? 'selected' : ''}>Tiếng Việt</option>
                        <option value="en" ${user.ngonNgu == 'en' ? 'selected' : ''}>English</option>
                    </select>

                    <button type="submit">Cập nhật</button>
                </form>
            </div>

            <!-- Event History -->
            <div class="history-section">
                <h2>Lịch sử tham gia sự kiện</h2>

                <c:forEach var="e" items="${events}">
                    <div class="event-card">
                        <h4>${e.tieuDe}</h4>
                        <p>Ngày tổ chức: ${e.ngayGio}</p>
                        <p>Trạng thái: ${e.trangThai}</p>
                        <c:if test="${e.trangThai == 'finished' && !e.daDanhGia}">
                            <a href="${pageContext.request.contextPath}/event/evaluate?suKienId=${e.maSuKien}">Đánh giá sự kiện</a>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
        <footer>
            <!-- footer.jsp -->
            <div style="background-color: #1c2230; color: #eaeaea; padding: 40px 0; font-size: 14px;">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-3 ">
                            <h5 class="text-white">Về chúng tôi</h5>
                            <ul class="list-unstyled">
                                <li><a href="#">Giới thiệu</a></li>
                                <li><a href="#">Bảng giá dịch vụ</a></li>
                                <li><a href="#">Liên hệ quảng cáo</a></li>
                            </ul>
                        </div>
                        <div class="col-md-3 ">
                            <h5 class="text-white">Trợ giúp</h5>
                            <ul class="list-unstyled">
                                <li><a href="#">Liên hệ</a></li>
                                <li><a href="#">Trung tâm trợ giúp</a></li>
                                <li><a href="#">Quy định và Điều khoản</a></li>
                            </ul>
                        </div>
                        <div class="col-md-3 ">
                            <h5 class="text-white">Thông tin</h5>
                            <ul class="list-unstyled">
                                <li><a href="#">Quy chế hoạt động</a></li>
                                <li><a href="#">Cơ chế giải quyết tranh chấp</a></li>
                                <li><a href="#">Chính sách bảo mật thông tin</a></li>
                            </ul>
                        </div>

                    </div>
                </div>
            </div>
        </footer>
    </body>
</html>