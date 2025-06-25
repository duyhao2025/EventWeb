<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông tin cá nhân & Lịch sử sự kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f3f5f8;
            margin: 0;
        }

        .container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 0 24px;
        }

        .tabs {
            display: flex;
            margin-bottom: 20px;
        }

        .tab {
            flex: 1;
            text-align: center;
            padding: 12px;
            cursor: pointer;
            background-color: #3498db;
            color: white;
            font-weight: bold;
            border-radius: 8px 8px 0 0;
            margin-right: 2px;
        }

        .tab.active {
            background-color: white;
            color: #333;
            border-bottom: 2px solid white;
        }

        .tab-content {
            display: none;
            background: white;
            padding: 30px;
            border-radius: 0 0 12px 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }

        .tab-content.active {
            display: block;
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

        .event-card {
            border: 1px solid #ddd;
            padding: 16px;
            border-radius: 10px;
            margin-bottom: 16px;
            display: flex;
            align-items: flex-start;
            background-color: #fff;
        }

        .event-image {
            width: 120px;
            height: 80px;
            object-fit: cover;
            border-radius: 6px;
            margin-right: 20px;
        }

        .event-info {
            flex-grow: 1;
        }

        .event-info h4 {
            margin: 0 0 6px;
        }

        .event-info p {
            margin: 4px 0;
            font-size: 14px;
        }

        .event-info a {
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
        }

        .msg {
            text-align: center;
            color: green;
            margin-bottom: 16px;
        }

        .btn-back {
            display: block;
            margin-top: 30px;
            text-align: right;
        }
    </style>
</head>
<body>
<div class="container" style="padding-top: 100px;">
    <div class="tabs">
        <div class="tab active" onclick="showTab(0)">Thông tin cá nhân</div>
        <div class="tab" onclick="showTab(1)">Lịch sử tham gia sự kiện</div>
        <div class="tab" onclick="showTab(2)">Sự kiện yêu thích của bạn</div>
    </div>

    <!-- Tab 1 -->
    <div class="tab-content active">
        <h2>Thông tin cá nhân</h2>
        <c:if test="${not empty msg}">
            <div class="msg">${msg}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/user/profile" method="post" id="profileForm">
            <label>Họ tên</label>
            <input type="text" name="hoTen" value="${user.hoTen}" readonly />

            <label>Email</label>
            <input type="email" name="email" value="${user.email}" readonly />

            <label>Số điện thoại</label>
            <input type="text" name="soDienThoai" value="${user.soDienThoai}" readonly />

            <label>Ngôn ngữ</label>
            <select name="ngonNgu" disabled>
                <option value="vi" ${user.ngonNgu == 'vi' ? 'selected' : ''}>Tiếng Việt</option>
                <option value="en" ${user.ngonNgu == 'en' ? 'selected' : ''}>English</option>
            </select>

            <button type="button" id="editBtn">Sửa thông tin cá nhân</button>
            <button type="submit" id="saveBtn" style="display:none; margin-top: 12px;">Cập nhật</button>
        </form>
    </div>

    <!-- Tab 2 -->
    <div class="tab-content">
        <h2>Lịch sử tham gia sự kiện</h2>
        <c:forEach var="e" items="${events}">
            <div class="event-card">
                <div class="event-info">
                    <h4>${e.tieuDe}</h4>
                    <p>Ngày tổ chức: ${e.ngayGio}</p>
                    <p>Trạng thái: ${e.trangThai}</p>
                    <c:if test="${e.trangThai == 'finished' && !e.daDanhGia}">
                        <a href="${pageContext.request.contextPath}/event/evaluate?suKienId=${e.maSuKien}">Đánh giá sự kiện</a>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Tab 3 -->
    <div class="tab-content">
        <h2>Sự kiện yêu thích của bạn</h2>

        <c:if test="${empty yeuThichList}">
            <p>Bạn chưa yêu thích sự kiện nào.</p>
        </c:if>

        <c:forEach var="event" items="${yeuThichList}">
            <div class="event-card">
                <img class="event-image" src="${pageContext.request.contextPath}/uploads/${event.hinhAnh}" alt="Hình sự kiện" />
                <div class="event-info">
                    <h4>${event.tieuDe}</h4>
                    <p>${event.moTa}</p>
                    <p>Thời gian: ${event.ngayGio}</p>
                    <p>Địa điểm: ${event.diaDiem}</p>
                    <a href="${pageContext.request.contextPath}/events/detail/${event.maSuKien}">Xem chi tiết</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    function showTab(index) {
        const tabs = document.querySelectorAll(".tab");
        const contents = document.querySelectorAll(".tab-content");
        tabs.forEach((tab, i) => {
            tab.classList.toggle("active", i === index);
            contents[i].classList.toggle("active", i === index);
        });
    }

    document.getElementById("editBtn").addEventListener("click", function () {
        document.querySelectorAll("input, select").forEach(el => el.removeAttribute("readonly"));
        document.querySelector("select").removeAttribute("disabled");
        document.getElementById("saveBtn").style.display = "block";
        this.style.display = "none";
    });
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
