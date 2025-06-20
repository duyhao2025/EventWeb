<%-- 
    Document   : create
    Created on : Jun 17, 2025, 12:40:39 AM
    Author     : Admin
--%>

<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container my-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Tạo sự kiện mới</h4>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/events/create"
                  method="post"
                  enctype="multipart/form-data">
                <div class="row">
                    <!-- Cột trái -->
                    <div class="col-lg-6">

                        <div class="mb-3">
                            <label for="title" class="form-label">Tên sự kiện</label>
                            <input type="text" class="form-control" id="tieuDe" name="tieuDe" placeholder="Nhập tên sự kiện" required>
                        </div>
                        <div class="mb-3">
                            <label for="maDanhMuc" class="form-label">Thể loại</label>
                            <select id="maDanhMuc" name="maDanhMuc" class="form-select" required>
                                <option value="" disabled selected>-- Chọn thể loại --</option>
                                <option value="1">Hội thảo</option>           <!-- Conference -->
                                <option value="2">Workshop</option>            <!-- Workshop -->
                                <option value="3">Cuộc thi</option>            <!-- Competition -->
                                <option value="4">Triển lãm</option>           <!-- Exhibition -->
                                <option value="5">Hội thảo trực tuyến</option> <!-- Webinar -->
                                <option value="6">Buổi giao lưu</option>       <!-- Networking Event -->
                                <option value="7">Buổi hòa nhạc</option>       <!-- Concert -->
                                <option value="8">Khóa học ngắn hạn</option>   <!-- Short Course -->
                            </select>

                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả</label>
                            <textarea id="moTa" name="moTa" class="form-control" rows="4"
                                      placeholder="Mô tả ngắn về sự kiện" maxlength="1000"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="location" class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" id="diaDiem" name="diaDiem"
                                   placeholder="Ví dụ: 123 Đường ABC, Quận X" required>
                        </div>
                    </div>

                    <!-- Cột phải -->
                    <div class="col-lg-6">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="startDate" class="form-label">Ngày &amp; Giờ bắt đầu</label>
                                <input type="datetime-local" id="ngayGio" name="ngayGio" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label for="endRegister" class="form-label">Hạn đăng ký</label>
                                <input type="datetime-local" id="hanDangKy" name="hanDangKy" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label for="duration" class="form-label">Thời lượng (phút)</label>
                                <input type="number" id="thoiLuongPhut" name="thoiLuongPhut" class="form-control" min="1" required>
                            </div>
                            <div class="col-md-6">
                                <label for="organizerEmail" class="form-label">Email tổ chức</label>
                                <input type="email" id="organizerEmail" name="organizerEmail"
                                       class="form-control" 
                                       value="${sessionScope.user.email}"
                                       readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="maxParticipants" class="form-label">Số người tối đa</label>
                                <input type="number" id="soNguoiToiDa" name="soNguoiToiDa"
                                       placeholder="Tối đa 2,147,483,647 người"
                                       class="form-control" min="1" required>
                            </div>
                            <div class="col-12 text-end mt-4">
                                <button type="submit" class="btn btn-success me-2">Tạo sự kiện</button>
                                <a href="${pageContext.request.contextPath}/demo" class="btn btn-outline-secondary">Hủy</a>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
