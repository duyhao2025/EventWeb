<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="container my-5" style="padding-top: 100px;">
    <h4>Sửa sự kiện</h4>
    <form action="${pageContext.request.contextPath}/events/edit"
          method="post"
          enctype="multipart/form-data">
        <!-- Bắt buộc phải có hidden id để @ModelAttribute bind -->
        <input type="hidden" name="maSuKien" value="${suKien.maSuKien}" />
        <div class="mb-3">
            <label for="imageFile" class="form-label">Hình ảnh sự kiện</label>
            <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*" required>
        </div>
        <!-- Ví dụ các input tương tự create.jsp -->
        <div class="mb-3">
            <label class="form-label">Tiêu đề</label>
            <input type="text" name="tieuDe" class="form-control"
                   value="${suKien.tieuDe}" required/>
        </div>
        <div class="mb-3">
            <label class="form-label">Mô Tả :</label>
            <input type="text" name="moTa" class="form-control"
                   value="${suKien.moTa}" required/>
        </div>
        <!-- Thể loại -->
        <div class="mb-3">
            <label class="form-label">Thể loại</label>
            <select name="maDanhMuc" class="form-select" required>
                <c:forEach var="dm" items="${danhMucList}">
                    <option value="${dm.maDanhMuc}"
                            ${dm.maDanhMuc == suKien.maDanhMuc ? 'selected' : ''}>
                        ${dm.tenVi}
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- Ngày giờ -->
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Ngày & Giờ bắt đầu</label>
                <input type="datetime-local" name="ngayGio" class="form-control"
                       value="${ngayGioString}" required/>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Hạn đăng ký</label>
                <input type="datetime-local" name="hanDangKy" class="form-control"
                       value="${hanDangKyString}" required/>
            </div>
        </div>

        <!-- Thời lượng & Số người tối đa -->
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Thời lượng (phút)</label>
                <input type="number" name="thoiLuongPhut" class="form-control" 
                       value="${suKien.thoiLuongPhut}" min="1" required/>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Số người tối đa</label>
                <input type="number" name="soNguoiToiDa" class="form-control" 
                       placeholder="Tối đa 2,147,483,647 người"
                       value="${suKien.soNguoiToiDa}" min="1" required/>
            </div>
        </div>

        <!-- Địa điểm -->
        <div class="mb-3">
            <label class="form-label">Địa điểm</label>
            <input type="text" name="diaDiem" class="form-control"
                   value="${suKien.diaDiem}" required/>
        </div>



        <!-- Nút -->
        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
        <a href="${pageContext.request.contextPath}/demo" class="btn btn-secondary">Hủy</a>
    </form>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
