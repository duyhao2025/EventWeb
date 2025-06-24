<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết sự kiện</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f0f2f5;
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .event-detail-container {
            flex: 1;
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .event-detail-content {
            background: #fff;
            border-radius: 12px;
            max-width: 1100px;
            width: 100%;
            padding: 30px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
        }

        .event-detail-img {
            width: 100%;
            max-height: 66vh;
            object-fit: cover;
            border-radius: 12px;
            margin-bottom: 24px;
        }

        .event-content-flex {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: stretch;
            gap: 32px;
            flex-wrap: nowrap;
        }

        .btn-back {
            margin-top: 24px;
        }

        .map-wrapper {
            flex: 1;
            min-width: 300px;
            border-radius: 12px;
            overflow: hidden;
        }

        footer {
            background-color: #1c2230;
            color: #eaeaea;
            padding: 40px 0;
            font-size: 14px;
            z-index: 10;
            position: relative;
        }

        @media (max-width: 768px) {
            .event-content-flex {
                flex-direction: column;
            }

            .map-wrapper {
                width: 100% !important;
                height: 300px !important;
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>

<div class="event-detail-container" style="padding-top: 100px;">
    <div class="event-detail-content">

        <!-- Ảnh sự kiện -->
        <img src="${pageContext.request.contextPath}/uploads/${event.getHinhAnh()}" class="img-fluid event-detail-img" alt="Hình sự kiện">

        <!-- Nội dung + bản đồ -->
        <div class="event-content-flex">

            <!-- Cột trái: Thông tin -->
            <div style="flex: 2;">
                <h2><strong>${event.tieuDe}</strong></h2>
                <p><strong>Thể loại:</strong> ${event.tenDanhMuc}</p>
                <p><strong>Mô tả:</strong> ${event.moTa}</p>
                <p><strong>Bắt đầu:</strong> ${event.ngayGio}</p>
                <p><strong>Hạn đăng ký:</strong> ${event.hanDangKy}</p>
                <p><strong>Thời lượng:</strong> ${event.thoiLuongPhut} phút</p>
                <p><strong>Số người tối đa:</strong> ${event.soNguoiToiDa}</p>
                <p><strong>Địa chỉ:</strong> ${event.diaDiem}</p>
                <a href="${pageContext.request.contextPath}/demo" class="btn btn-secondary btn-back">← Quay lại</a>
            </div>

            <!-- Cột phải: Bản đồ -->
            <div class="map-wrapper">
                <iframe
                    width="100%"
                    height="100%"
                    frameborder="0"
                    style="border:0; min-height: 100%;"
                    allowfullscreen
                    referrerpolicy="no-referrer-when-downgrade"
                    src="https://www.google.com/maps/embed/v1/place?key=AIzaSyDxvgtArITjIRWjc7Ei5PGKyR8-na_9pV4&q=<c:out value='${event.diaDiem}'/>">
                </iframe>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</body>
</html>
