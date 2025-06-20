<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="java.util.List"%>
<%@page import="com.uef.model.SuKien"%>
<%@page import="com.uef.model.User"%>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="container my-5">
    <h2 class="mb-4 text-center">📊 Sự kiện bạn tổ chức</h2>

    <%
        List<SuKien> events = (List<SuKien>) request.getAttribute("myEvents");
        if (events != null && !events.isEmpty()) {
            for (SuKien event : events) {
    %>
    <div class="card shadow-sm mb-4 border-0">
        <div class="row g-0">
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title text-primary"><%=event.getTieuDe()%></h5>
                    <p class="card-text mb-1"><strong>Thể loại:</strong> <%=event.getTenDanhMuc()%></p>
                    <p class="card-text mb-1"><strong>Ngày tổ chức:</strong> <%=event.getNgayGio()%></p>
                    <p class="card-text mb-1"><strong>Địa điểm:</strong> <%=event.getDiaDiem()%></p>
                    <p class="card-text mb-1">
                        👥 <strong>Người tham gia:</strong> <%=event.getSoLuongThamGia()%> người
                    </p>
                    <p class="card-text mb-3">
                        ⭐ <strong>Đánh giá trung bình:</strong>
                        <span class="text-warning"><%=String.format("%.1f", event.getSaoTrungBinh())%></span> / 5.0
                    </p>
                    <a href="<%=request.getContextPath()%>/events/detail/<%=event.getMaSuKien()%>" class="btn btn-outline-primary">Xem chi tiết</a>
                </div>
            </div>
        </div>
    </div>
    <%
        }
    } else {
    %>
    <div class="alert alert-info text-center">Bạn chưa tổ chức sự kiện nào.</div>
    <%
        }
    %>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>