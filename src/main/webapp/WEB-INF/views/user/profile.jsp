<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Thông tin cá nhân</title>
        <!-- include CSS/JS argon/bootstrap -->
    </head>
    <body>
        <div class="container mt-4">
            <h2>Thông tin cá nhân</h2>
            <ul class="nav nav-tabs" id="profileTabs">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#tabPersonal">Cá nhân</a>
                </li>
                <li class="nav-item" 
            <c:if test="${user.vaiTro != 'nguoi_to_chuc'}">style="display:none"</c:if>>
            <a class="nav-link" data-toggle="tab" href="#tabOrganizer">Ng??i t? ch?c</a>
            </li>
        </ul>

        <div class="tab-content mt-3">
            <!-- Tab Cá nhân -->
            <div id="tabPersonal" class="tab-pane fade show active">
                <form action="${pageContext.request.contextPath}/profile/updatePersonal" method="post">
                    <div class="form-group">
                        <label>Tên</label>
                        <input name="hoTen" class="form-control" value="${user.hoTen}" />
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input name="email" class="form-control" value="${user.email}" />
                    </div>
                    <div class="form-group">
                        <label>S? ?i?n tho?i</label>
                        <input class="form-control" value="${user.soDienThoai}" readonly />
                    </div>
                    <button class="btn btn-primary">L?u thay ??i</button>
                </form>

                <h5 class="mt-4">Các s? ki?n ?ã tham gia</h5>
                <ul class="list-group">
                    <c:forEach var="e" items="${joinedEvents}">
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/event/${e.maSuKien}">${e.tieuDe}</a>
                            <span class="text-muted">(<fmt:formatDate value="${e.ngayGio}" pattern="dd/MM/yyyy HH:mm"/>)</span>
                        </li>
                    </c:forEach>
                    <c:if test="${empty joinedEvents}">
                        <li class="list-group-item text-muted">B?n ch?a tham gia s? ki?n nào.</li>
                    </c:if>
                </ul>
            </div>

            <!-- Tab Ng??i t? ch?c -->
            <div id="tabOrganizer" class="tab-pane fade">
                <div class="form-group">
                    <label>Tên t? ch?c</label>
                    <input class="form-control" value="${user.hoTen}" readonly />
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input class="form-control" value="${user.email}" readonly />
                </div>
                <div class="form-group">
                    <label>S?T liên l?c</label>
                    <input class="form-control" 
                           value="${fn:replace(user.soDienThoai,'^0','+84')}" readonly />
                </div>
                <div class="form-group">
                    <label>?ánh giá trung bình</label>
                    <p><strong>${avgRating}</strong> ?</p>
                </div>
                <h5 class="mt-4">Các s? ki?n ?ã t? ch?c</h5>
                <ul class="list-group">
                    <c:forEach var="e" items="${organizedEvents}">
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/event/${e.maSuKien}">${e.tieuDe}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${empty organizedEvents}">
                        <li class="list-group-item text-muted">Ch?a t? ch?c s? ki?n nào.</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
    <script>
        // kích ho?t Bootstrap tabs n?u c?n
        $('#profileTabs a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
    </script>
</body>
</html>