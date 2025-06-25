<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
<html>
    <head>
        <title>Sự kiện của bạn</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.min.css"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>

            .card .d-flex.gap-2 .btn {
                display: inline-flex;          /* để icon và text canh giữa */
                align-items: center;
                transition: transform .1s ease;
            }
            .card .d-flex.gap-2 .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 2px 6px rgba(0,0,0,0.15);
            }
            .tab-pane {
                padding-top: 20px;
            }
            .nav-tabs .nav-link {
                background-color: #3399ff;   /* xanh dương biển đậm hơn */
                color: white;                /* chữ trắng */
                font-weight: 600;            /* đậm hơn */
                border: 1px solid #dee2e6;
                margin-right: 4px;
            }

            .nav-tabs .nav-link.active {
                background-color: #ffffff;   /* tab đang chọn là trắng */
                color: #0d6efd;              /* chữ xanh dương */
                font-weight: 700;
                border-bottom: 2px solid #0d6efd;
            }
            .myevents .d-flex.gap-2 .btn {
                margin-right: 8px;           /* tăng khoảng cách */
            }
            .myevents .d-flex.gap-2 .btn:last-child {
                margin-right: 0;             /* nút cuối không cần margin */
            }

            /* 2. Hiệu ứng hover nhẹ cho tab control */
            .myevents .nav-tabs .nav-link {
                transition: background .2s ease, color .2s ease;
            }
            .myevents .nav-tabs .nav-link:hover:not(.active) {
                background-color: rgba(51, 153, 255, 0.2);
                color: #3399ff;
            }
            .myevents .nav-tabs .nav-link.active {
                background-color: #fff !important;
                color: #0d6efd !important;
                border-bottom: 3px solid #0d6efd;
            }

            /* 3. Padding cho card để nội dung không sát lề */
            .myevents .card-body {
                padding: 1.25rem;            /* 20px */
            }

            /* 4. Thêm slight lift hover cho toàn bộ card */
            .myevents .card:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            }
            .myevents .card {
                transition: transform .2s ease, box-shadow .2s ease;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4 myevents"  style="padding-top: 100px;">
            <ul class="nav nav-tabs" id="eventTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="list-tab" data-bs-toggle="tab" data-bs-target="#event-list" type="button" role="tab">Sự kiện bạn tổ chức</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="create-tab" data-bs-toggle="tab" data-bs-target="#event-create" type="button" role="tab">Tạo sự kiện của bạn</button>
                </li>
            </ul>

            <div class="tab-content mt-3" id="eventTabsContent">
                <!-- Tab 1: Danh sách sự kiện -->
                <div class="tab-pane fade show active" id="event-list" role="tabpanel" aria-labelledby="list-tab">
                    <h4 class="mb-3">Sự kiện bạn tổ chức</h4>
                    <c:if test="${empty suKienList}">
                        <div class="alert alert-info">Bạn chưa tổ chức sự kiện nào.</div>
                    </c:if>
                    <div class="row">
                        <c:forEach var="event" items="${suKienList}">
                            <div class="col-md-6 mb-3">
                                <div class="card h-100">
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${event.tieuDe}</h5>

                                        <div class="mt-auto">
                                            <div class="d-flex gap-2">
                                                <!-- Quản lý -->
                                                <a href="${pageContext.request.contextPath}/events/manager?suKienId=${event.maSuKien}"
                                                   class="btn btn-outline-primary btn-sm">
                                                    <i class="bx bx-cog me-1"></i>Quản lý
                                                </a>

                                                <!-- Sửa -->
                                                <a href="${pageContext.request.contextPath}/events/edit/${event.maSuKien}"
                                                   class="btn btn-primary btn-sm">
                                                    <i class="bx bx-edit-alt me-1"></i>Sửa
                                                </a>

                                                <!-- Xóa -->
                                                <form action="${pageContext.request.contextPath}/events/delete/${event.maSuKien}"
                                                      method="post" class="d-inline" onsubmit="return confirm('Xác nhận xóa sự kiện này?');">
                                                    <button type="submit" class="btn btn-danger btn-sm">
                                                        <i class="bx bx-trash me-1"></i>Xóa
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Tab 2: Form tạo sự kiện -->
                <div class="tab-pane fade" id="event-create" role="tabpanel" aria-labelledby="create-tab">

                    <jsp:include page="/WEB-INF/views/event/create.jsp"/>
                    <%-- Hoặc bạn có thể paste thẳng form ở đây nếu không có file riêng --%>
                </div>
            </div>
        </div>
    </body>
</html>
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
