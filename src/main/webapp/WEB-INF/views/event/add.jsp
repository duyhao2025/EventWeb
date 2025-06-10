<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm Sự kiện</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-4">
            <h2>Thêm Sự kiện</h2>
            <form action="${pageContext.request.contextPath}/event/save" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Tên Sự kiện</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả</label>
                    <textarea id="description" name="description" class="form-control" rows="3"></textarea>
                </div>
                <div class="mb-3">
                    <label for="status" class="form-label">Trạng thái</label>
                    <select id="status" name="status" class="form-select">
                        <option value="Sắp diễn ra">Sắp diễn ra</option>
                        <option value="Đang diễn ra">Đang diễn ra</option>
                        <option value="Đã kết thúc">Đã kết thúc</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-success">Lưu</button>
                <a href="${pageContext.request.contextPath}/event/list" class="btn btn-secondary">Quay lại</a>
            </form>
        </div>
    </body>
</html>