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
    <a href="${pageContext.request.contextPath}/event/add" class="btn btn-primary mb-3">Thêm mới</a>
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Mô tả</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="event" items="${events}">
            <tr>
                <td>${event.id}</td>
                <td>${event.name}</td>
                <td>${event.description}</td>
                <td>${event.status}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/event/edit/${event.id}" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="${pageContext.request.contextPath}/event/delete/${event.id}" class="btn btn-danger btn-sm"
                       onclick="return confirm('Bạn chắc chắn muốn xoá?');">Xoá</a>
                    
                    <!-- Dropdown cập nhật trạng thái -->
                    <div class="btn-group">
                        <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                            Cập nhật trạng thái
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/event/updateStatus/${event.id}/Sắp diễn ra">Sắp diễn ra</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/event/updateStatus/${event.id}/Đang diễn ra">Đang diễn ra</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/event/updateStatus/${event.id}/Đã kết thúc">Đã kết thúc</a></li>
                        </ul>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS (dropdown support) -->
<!--script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
