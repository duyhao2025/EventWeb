<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Quản lý đăng ký sự kiện</title>
        <style>
            table {
                width: 90%;
                border-collapse: collapse;
                margin: 20px auto;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #f2f2f2;
            }
            h2 {
                text-align: center;
                margin-top: 30px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
        <div class="event-manager-container" style="padding-top: 100px;">
            <h2>Danh sách người đăng ký</h2>
            <div class="mb-3">
                <input id="searchPhone"
                       type="text"
                       class="form-control"
                       placeholder="🔍 Tìm theo số điện thoại..."
                       onkeyup="filterByPhone()" />
            </div>
            <table id="regTable" class="table table-striped">
                <thead>
                    <tr>
                        <th>STT</th><th>Tên</th><th>Email</th><th>Số điện thoại</th><th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dk" items="${danhSachDangKy}" varStatus="st">
                        <tr>
                            <td>${st.index + 1}</td>
                            <td>${dk.hoTen}</td>
                            <td>${dk.email}</td>
                            <td class="col-phone">${dk.soDienThoai}</td>
                            <td>
                                <select class="form-select form-select-sm status-select" 
                                        data-madangky="${dk.maDangKy}">
                                    <option value="Đã đăng ký" ${dk.trangThai=='Đã đăng ký' ? 'selected':''}>Đã đăng ký</option>
                                    <option value="Đã tham gia" ${dk.trangThai=='Đã tham gia' ? 'selected':''}>Đã tham gia</option>
                                    <option value="Đã hủy"     ${dk.trangThai=='Đã hủy'     ? 'selected':''}>Đã hủy</option>
                                </select>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <script>
            function filterByPhone() {
                const term = document
                        .getElementById('searchPhone')
                        .value
                        .toLowerCase()
                        .trim();
                document.querySelectorAll('#regTable tbody tr').forEach(tr => {
                    const phone = tr.querySelector('.col-phone').textContent.toLowerCase();
                    tr.style.display = phone.includes(term) ? '' : 'none';
                });
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                    $(function () {
                        // khi dropdown thay đổi
                        $('#regTable').on('change', '.status-select', function () {
                            const sel = $(this);
                            const maDangKy = sel.data('madangky');
                            const trangThai = sel.val();
                            $.ajax({
                                url: '${pageContext.request.contextPath}/events/manager/updateStatus',
                                type: 'POST',
                                data: {maDangKy, trangThai},
                                success: function (resp) {
                                    if (!resp.success) {
                                        alert('Cập nhật trạng thái thất bại, thử lại');
                                    }
                                    // nếu muốn: sel.prop('disabled', !resp.success);
                                },
                                error: function () {
                                    alert('Có lỗi khi gọi server, thử lại');
                                }
                            });
                        });
                    });
        </script>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </body>
</html>