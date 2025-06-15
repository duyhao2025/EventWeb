<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo sự kiện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Tạo sự kiện mới</h2>
    <form action="${pageContext.request.contextPath}/event/create" method="post">
        <div class="form-group">
            <label>Tiêu đề</label>
            <input type="text" name="tieuDe" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Địa điểm</label>
            <input type="text" name="diaDiem" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Thể loại</label>
            <input type="text" name="danhMuc" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Mô tả</label>
            <textarea name="moTa" class="form-control" rows="4"></textarea>
        </div>
        <div class="form-group">
            <label>Ngày giờ</label>
            <input type="datetime-local" name="ngayGio" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Trạng thái</label>
            <select name="trangThai" class="form-control">
                <option value="upcoming">Sắp diễn ra</option>
                <option value="ended">Đã kết thúc</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success">Tạo sự kiện</button>
    </form>
</div>

<script src="${pageContext.request.contextPath}/assets/js/core/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/core/bootstrap.bundle.min.js"></script>
</body>
</html>
