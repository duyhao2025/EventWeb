<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa Sự kiện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>Chỉnh sửa Sự kiện</h2>
    <form action="${pageContext.request.contextPath}/event/update" method="post">
        <input type="hidden" name="id" value="${event.id}">
        <div class="mb-3">
            <label for="name" class="form-label">Tên Sự kiện</label>
            <input type="text" id="name" name="name" class="form-control" value="${event.name}" required>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Mô tả</label>
            <textarea id="description" name="description" class="form-control" rows="3">${event.description}</textarea>
        </div>
        <div class="mb-3">
            <label for="status" class="form-label">Trạng thái</label>
            <select id="status" name="status" class="form-select">
                <option value="Sắp diễn ra" <c:if test="${event.status eq 'Sắp diễn ra'}">selected</c:if>>Sắp diễn ra</option>
                <option value="Đang diễn ra" <c:if test="${event.status eq 'Đang diễn ra'}">selected</c:if>>Đang diễn ra</option>
                <option value="Đã kết thúc" <c:if test="${event.status eq 'Đã kết thúc'}">selected</c:if>>Đã kết thúc</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/event/list" class="btn btn-secondary">Quay lại</a>
    </form>
</div>
</body>
</html>