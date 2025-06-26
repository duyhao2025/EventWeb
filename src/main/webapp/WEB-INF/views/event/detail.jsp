<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.uef.model.SuKien"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
<%
    // Lấy object SuKien mà Controller đã đặt vào attribute "event"
    SuKien event = (SuKien) request.getAttribute("event");
    String diaChiEncoded = "";

    if (event != null && event.getDiaDiem() != null && !event.getDiaDiem().isEmpty()) {
        try {
            diaChiEncoded = URLEncoder.encode(event.getDiaDiem(), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            // Nếu có lỗi encode, chỉ để chuỗi rỗng
            diaChiEncoded = "";
        }
    }
%>
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
                max-width: 80%;
                width: 100%;
                padding: 30px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            }

            .event-detail-img {
                width: 100%;
                max-height: 66vh;
                object-fit: cover;
                border-radius: 12px;
            }

            .btn-back {
                margin-top: 24px;
            }

            footer {
                background-color: #1c2230;
                color: #eaeaea;
                padding: 40px 0;
                font-size: 14px;
                z-index: 10;
                position: relative;
            }
        </style>
    </head>
    <body>

        <div class="event-detail-container" style="padding-top: 100px;">
            <div class="event-detail-content">
                <h2><strong>${event.tieuDe}</strong></h2>
                <img src="${pageContext.request.contextPath}/uploads/${event.hinhAnh}"
                     class="img-fluid event-detail-img" alt="Hình sự kiện"/>
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
                <!-- Nhúng Google Map dựa trên địa chỉ đã encode -->
                <div style="width:100%; height:500px; border-radius:10px; overflow:hidden; box-shadow:0 2px 5px rgba(0,0,0,0.1); margin-top:10px;">
                    <iframe
                        width="100%" height="100%" frameborder="0" style="border:0"
                        allowfullscreen
                        src="https://www.google.com/maps/embed/v1/place?key=AIzaSyDxvgtArITjIRWjc7Ei5PGKyR8-na_9pV4
                        &q=<%= diaChiEncoded%>">
                    </iframe>
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </body>
</html>
