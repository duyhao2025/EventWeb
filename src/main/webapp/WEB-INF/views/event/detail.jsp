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
                max-width: 800px;
                width: 100%;
                padding: 30px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            }

            .event-detail-img {
                width: 100%;
                max-height: 480px;
                object-fit: cover;
                border-radius: 12px;
            }

            .btn-back {
                margin-top: 24px;
            }

            .btn-hover:hover {
                transform: scale(1.05);
                transition: all 0.2s ease-in-out;
            }

            footer {
                background-color: #1c2230;
                color: #eaeaea;
                padding: 40px 0;
                font-size: 14px;
                z-index: 10;
                position: relative;
            }

            form {
                display: inline-block;
                margin-right: 10px;
            }
        </style>
    </head>
    <body>

        <div class="event-detail-container" style="padding-top: 100px;">
            <div class="event-detail-content">
                <img src="${pageContext.request.contextPath}/uploads/${event.hinhAnh}" class="img-fluid event-detail-img mb-4" alt="Hình sự kiện">
                <h2><strong>${event.tieuDe}</strong></h2>
                <p><strong>Thể loại:</strong> ${event.tenDanhMuc}</p>
                <p><strong>Mô tả:</strong> ${event.moTa}</p>
                <p><strong>Bắt đầu:</strong> ${event.ngayGio}</p>
                <p><strong>Hạn đăng ký:</strong> ${event.hanDangKy}</p>
                <p><strong>Thời lượng:</strong> ${event.thoiLuongPhut} phút</p>
                <p><strong>Số người tối đa:</strong> ${event.soNguoiToiDa}</p>
                <p><strong>Địa chỉ:</strong> ${event.diaDiem}</p>

                <c:if test="${not empty user}">
                    <c:choose>
                        <c:when test="${daYeuThich}">
                            <form action="${pageContext.request.contextPath}/yeu-thich/bo" method="post">
                                <input type="hidden" name="suKienId" value="${event.maSuKien}" />
                                <button type="submit" class="btn btn-outline-secondary hover-btn">💔 Bỏ yêu thích</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form action="${pageContext.request.contextPath}/yeu-thich/them" method="post">
                                <input type="hidden" name="suKienId" value="${event.maSuKien}" />
                                <button type="submit" class="btn btn-outline-danger hover-btn">❤️ Yêu thích</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </c:if>

                <a href="${pageContext.request.contextPath}/demo" class="btn btn-secondary btn-back btn-hover">← Quay lại</a>
            </div>
        </div>

        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </body>
</html>
