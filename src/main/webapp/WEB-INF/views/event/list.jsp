<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách Sự kiện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-3">Danh sách Sự kiện</h2>
    <a href="${pageContext.request.contextPath}/event/form" class="btn btn-primary mb-3">+ Tạo sự kiện mới</a>

    <c:if test="${empty events}">
        <div class="alert alert-warning">Không có sự kiện nào!</div>
    </c:if>

    <c:if test="${not empty events}">
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tiêu đề</th>
                    <th>Địa điểm</th>
                    <th>Ngày giờ</th>
                    <th>Thể loại</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="event" items="${events}">
                <tr>
                    <td>${event.maSuKien}</td>
                    <td>${event.tieuDe}</td>
                    <td>${event.diaDiem}</td>
                    <td><fmt:formatDate value="${event.ngayGio}" pattern="dd-MM-yyyy HH:mm" /></td>
                    <td>${event.danhMuc}</td>
                    <td>${event.trangThai}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/event/edit/${event.maSuKien}" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="${pageContext.request.contextPath}/event/delete/${event.maSuKien}" class="btn btn-danger btn-sm"
                           onclick="return confirm('Bạn chắc chắn muốn xoá?');">Xoá</a>

                        <div class="btn-group mt-1">
                            <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-bs-toggle="dropdown">
                                Cập nhật trạng thái
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/event/updateStatus/${event.maSuKien}/Sắp diễn ra">Sắp diễn ra</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/event/updateStatus/${event.maSuKien}/Đang diễn ra">Đang diễn ra</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/event/updateStatus/${event.maSuKien}/Đã kết thúc">Đã kết thúc</a></li>
                            </ul>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
