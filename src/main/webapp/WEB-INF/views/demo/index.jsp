<%@page import="com.uef.model.User"%>
<%@page import="com.uef.model.SuKien"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo-16x16.png" />

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Major+Mono+Display" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/boxicons.min.css" rel="stylesheet">

        <!-- Styles -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/components.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/media.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/chat.css" rel="stylesheet">

        <!-- Video.js (CDN) -->
        <link href="https://vjs.zencdn.net/7.4.1/video-js.css" rel="stylesheet">
        <script src="https://vjs.zencdn.net/ie8/1.1.2/videojs-ie8.min.js" type="text/javascript"></script>

        <!-- Local JS -->
        <script src="${pageContext.request.contextPath}/assets/js/load.js" type="text/javascript"></script>
        <title>Trang chủ sự kiện</title>
        <style>
            #categoryFilter {
                border-top-left-radius: 4px;
                border-bottom-left-radius: 4px;
                border-right: 1px solid #ccc;
                background: #f9f9f9;
                font-weight: 500;
            }
            .search-suggestions {
                position: absolute;
                background: #fff;
                border: 1px solid #ccc;
                max-height: 250px;
                width: 100%;
                overflow-y: auto;
                z-index: 9999;
                top: 45px; /* tùy chỉnh để khớp với thanh search của bạn */
                border-radius: 4px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }

            .search-suggestions div {
                padding: 8px 12px;
                cursor: pointer;
            }

            .search-suggestions div:hover {
                background-color: #f0f0f0;
            }
            .event-detail-panel {
                position: fixed;
                top: 80px;
                right: 40px;
                width: 340px;
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                z-index: 999;
                transition: all 0.3s ease;
            }
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
            }

            .feed-wrapper {
                max-width: 720px;
                margin: 0 auto;
                padding: 40px 20px;
            }

            .event-card {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                margin-bottom: 24px;
                display: flex;
                overflow: hidden;
            }

            .event-image {
                width: 240px;
                height: 180px;
                object-fit: cover;
            }

            .event-info {
                flex: 1;
                padding: 20px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .event-title {
                font-size: 20px;
                font-weight: 600;
                color: #333;
                margin: 0 0 8px;
            }

            .event-description {
                font-size: 14px;
                color: #555;
                margin-bottom: 12px;
            }

            .event-dates {
                font-size: 13px;
                color: #888;
                margin-bottom: 8px;
            }

            .event-action {
                text-align: right;
            }
            .btn-detail {
                background-color: #e0e0e0;   /* xám nhạt */
                color: #000;                 /* chữ đen */
                padding: 10px 16px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 500;
                margin-right: 10px; /* ~0.1cm khoảng cách giữa 2 nút */
                display: inline-block;
            }

            .btn-detail:hover {
                background-color: #d5d5d5;
            }
            .btn-register {
                background-color: #007bff;
                color: white;
                padding: 10px 16px;
                border: none;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 500;
                transition: background 0.2s ease;
            }

            .btn-register:hover {
                background-color: #0056b3;
            }
        </style>
    </head>

    <body class="newsfeed">
        <div class="container-fluid" id="wrapper">
            <div class="row newsfeed-size">
                <div class="col-md-12 newsfeed-right-side">

                    <nav class="navbar navbar-expand-lg shadow-sm sticky-top bg-white">
                        <div class="container-fluid">
                            <div class="d-flex w-100 align-items-center">
                                <!-- Logo -->
                                <a class="navbar-brand me-3" href="${pageContext.request.contextPath}/demo">
                                    <img src="${pageContext.request.contextPath}/assets/images/logo-64x64.png"
                                         width="40" alt="Logo">
                                </a>

                                <!-- Dropdown Danh mục -->
                                <form action="${pageContext.request.contextPath}/events/filter" method="get" class="me-3">
                                    <select id="categoryFilter" class="form-select" style="width: 150px;">
                                        <option value="">Danh mục</option>
                                        <option value="Hội thảo">Hội thảo</option>
                                        <option value="Workshop">Workshop</option>
                                        <option value="Cuộc thi">Cuộc thi</option>
                                        <option value="Triển lãm">Triển lãm</option>
                                        <option value="Hội thảo trực tuyến">Hội thảo trực tuyến</option>
                                        <option value="Buổi giao lưu">Buổi giao lưu</option>
                                        <option value="Buổi hòa nhạc">Buổi hòa nhạc</option>
                                        <option value="Khóa học ngắn hạn">Khóa học ngắn hạn</option>
                                    </select>
                                </form>
                                <!-- Search + Pencil -->
                                <form action="${pageContext.request.contextPath}/events/list"
                                      method="get"
                                      class="d-flex flex-grow-1 me-3">
                                    <div class="input-group">
                                        <input type="text"
                                               id="searchBox"
                                               name="keyword"
                                               class="form-control rounded-pill ps-4"
                                               placeholder="Tìm kiếm sự kiện…">
                                        <button class="btn btn-outline-secondary rounded-pill ms-2"
                                                type="submit"
                                                style="width: 44px; height: 44px;">
                                            <i class="bx bx-search fs-4"></i>
                                        </button>
                                        <!-- Pencil icon to create -->
                                        <a href="${pageContext.request.contextPath}/events/create"
                                           class="btn btn-link ms-2"
                                           style="width: 44px; height: 44px; display:flex; align-items:center; justify-content:center;">
                                            <i class="bx bx-pencil" style="font-size:2rem; line-height:1;"></i>
                                        </a>
                                    </div>
                                </form>

                                <!-- Right-side Icons -->
                                <div class="d-flex align-items-center">

                                    <a href="#" class="nav-link ps-3">
                                        <img src="${pageContext.request.contextPath}/assets/images/users/user-4.jpg"
                                             class="rounded-circle"
                                             width="36"
                                             style="object-fit: cover;"
                                             alt="User">
                                    </a>
                                    <li class="nav-item s-nav nav-icon dropdown">
                                        <a href="settings.html" data-toggle="dropdown" data-placement="bottom" data-title="Settings" class="nav-link settings-link rm-drop-mobile drop-w-tooltip" id="settings-dropdown"><img src="assets/images/icons/navbar/settings.png" class="nav-settings" alt="navbar icon"></a>
                                        <div class="dropdown-menu dropdown-menu-right settings-dropdown shadow-sm" aria-labelledby="settings-dropdown">
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                                                <img src="assets/images/icons/settings/account.png" alt="Navbar icon"> Thông tin cá nhân</a>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/settings-password">
                                                <img src="assets/images/icons/settings/contact.png" alt="Navbar icon"> Đổi mật khẩu
                                            </a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                                <img src="assets/images/icons/navbar/logout.png" alt="Navbar icon"> Đăng xuất
                                            </a>
                                            <a class="dropdown-item" href="#">
                                                <img src="assets/images/icons/navbar/gear-1.png" alt="Navbar icon"> Settings</a>
                                        </div>
                                    </li>
                                </div>
                            </div>
                        </div>
                    </nav>


                    <button type="button" class="btn nav-link" id="menu-toggle"><img src="assets/images/icons/theme/navs.png" alt="Navbar navs"></button>

                </div>

                <div class="row newsfeed-right-side-content mt-3">
                    <div class="col-md-3 newsfeed-left-side sticky-top shadow-sm" id="sidebar-wrapper">
                        <div class="card newsfeed-user-card h-100">
                            <ul class="list-group list-group-flush newsfeed-left-sidebar">
                                <li class="list-group-item">
                                    <h6>Home</h6>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center sd-active">
                                    <a href="index.html" class="sidebar-item"><img src="assets/images/icons/left-sidebar/newsfeed.png" alt="newsfeed"> Trang chính</a>
                                    <a href="#" class="newsfeedListicon"><i class='bx bx-dots-horizontal-rounded'></i></a>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <a href="${pageContext.request.contextPath}/events/my_events" class="sidebar-item">
                                        <img src="assets/images/icons/left-sidebar/event.png" alt="event"> Sự kiện bạn tổ chức
                                    </a>
                                    <span class="badge badge-primary badge-pill">3</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <a href="saved.html" class="sidebar-item"><img src="assets/images/icons/left-sidebar/saved.png" alt="saved"> Lưu sự kiện</a>
                                    <span class="badge badge-primary badge-pill">8</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div    class="col-md-6 second-section" id="page-content-wrapper">
                        <div class="feed-wrapper">

                            <%
                                List<SuKien> list = (List<SuKien>) request.getAttribute("suKienList");
                                if (list != null) {
                                    for (SuKien event : list) {
                            %>
                            <div class="event-card" data-title="<%= event.getTieuDe()%>" data-category="<%= event.getTenDanhMuc()%>">


                                <div class="event-info">
                                    <div>
                                        <h3 class="event-title">Tên sự kiện: <%= event.getTieuDe()%></h3>
                                        <h3 class="event-title">Thể loại: <%= event.getTenDanhMuc()%></h3>
                                        <div class="event-description">
                                            <strong>Email tổ chức:</strong> <%= event.getCreatorEmail()%>
                                        </div>

                                        <div class="event-dates">
                                            Bắt đầu: <%= event.getNgayGio()%> <br/>
                                            Hạn đăng ký: <%= event.getHanDangKy()%>
                                        </div> 
                                    </div>
                                    <div class="event-action">
                                        <%
                                            // Lấy user từ session
                                            User u = (User) session.getAttribute("user");
                                            // So sánh email
                                            if (u != null && u.getEmail().equals(event.getCreatorEmail())) {
                                        %>
                                        <a href="<%=request.getContextPath()%>/events/edit/<%=event.getMaSuKien()%>"
                                           class="btn btn-warning btn-sm me-2">Sửa</a>
                                        <form action="<%=request.getContextPath()%>/events/delete/<%=event.getMaSuKien()%>"
                                              method="post" style="display:inline;"
                                              onsubmit="return confirm('Xác nhận xóa sự kiện?');">
                                            <button type="submit" class="btn btn-danger btn-sm me-2">Xóa</button>
                                        </form>
                                        <%
                                            }
                                        %>
                                        <button class="btn-detail" onclick="toggleDetail('<%= event.getMaSuKien()%>')">Chi tiết</button>
                                        <a href="${pageContext.request.contextPath}/eventregister" class="btn-register">
                                            Đăng ký tham gia
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- PHẦN CHI TIẾT -->
                            <div class="event-detail-panel" id="detail-<%= event.getMaSuKien()%>" style="display:none;">

                                <h3><strong>Tên sự kiện:</strong> <%= event.getTieuDe()%></h3>
                                <p><strong>Thể loại:</strong> <%= event.getTenDanhMuc()%></p>
                                <p><strong>Mô tả:</strong> <%= event.getMoTa()%></p>
                                <p><strong>Bắt đầu:</strong> <%= event.getNgayGio()%></p>
                                <p><strong>Hạn đăng ký:</strong> <%= event.getHanDangKy()%></p>
                                <p><strong>Thời lượng:</strong> <%= event.getThoiLuongPhut()%> phút</p>
                                <p><strong>Số người tối đa:</strong> <%= event.getSoNguoiToiDa()%></p>
                                <p><strong>Địa chỉ:</strong> <%= event.getDiaDiem()%></p>
                                <%
                                    String diaChi = event.getDiaDiem();
                                    String diaChiEncoded = "";
                                    try {
                                        diaChiEncoded = java.net.URLEncoder.encode(diaChi, "UTF-8");
                                    } catch (Exception e) {
                                        diaChiEncoded = "";
                                    }
                                %>

                                <div style="width: 100%; height: 180px; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); margin-top: 10px;">
                                    <iframe
                                        width="100%"
                                        height="100%"
                                        frameborder="0"
                                        style="border:0"
                                        allowfullscreen
                                        src="https://www.google.com/maps/embed/v1/place?key=AIzaSyDxvgtArITjIRWjc7Ei5PGKyR8-na_9pV4&q=<%= diaChiEncoded %>">
                                    </iframe>
                                </div>



                                
                            </div>
                            <%
                                } // end for
                            } else {
                            %>
                            <p style="color:red;">Không có sự kiện nào để hiển thị.</p>
                            <%
                                } // end if
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <!-- Core -->
        <script src="assets/js/jquery/jquery-3.3.1.min.js"></script>
        <script src="assets/js/popper/popper.min.js"></script>
        <script src="assets/js/bootstrap/bootstrap.min.js"></script>
        <!-- Optional -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
        <script>
                                            const CONTEXT_PATH = "${pageContext.request.contextPath}";
        </script>
        <script type="text/javascript">
            $("#menu-toggle").click(function (e) {
                e.preventDefault();
                $("#wrapper").toggleClass("toggled");
            });

        </script>
        <script src="assets/js/app.js"></script>
        <script src="assets/js/components/components.js"></script>
        <script>
            function toggleDetail(id) {
                // Ẩn tất cả các chi tiết
                document.querySelectorAll(".event-detail-panel").forEach(el => {
                    if (el.id !== "detail-" + id) {
                        el.style.display = "none";
                    }
                });

                // Toggle panel được chọn
                const panel = document.getElementById("detail-" + id);
                if (panel.style.display === "none" || panel.style.display === "") {
                    panel.style.display = "block";
                } else {
                    panel.style.display = "none";
                }
            }
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const searchBox = document.getElementById("searchBox");
                const suggestionBox = document.getElementById("suggestions");

                if (searchBox) {
                    searchBox.addEventListener("input", function () {
                        const keyword = this.value.trim();

                        if (keyword.length < 2) {
                            suggestionBox.innerHTML = "";
                            return;
                        }

                        fetch(`${window.location.origin}${pageContext.request.contextPath}/events/search?keyword=` + encodeURIComponent(keyword))
                                .then(response => response.json())
                                .then(data => {
                                    let html = "";
                                    data.forEach(event => {
                                        html += `<div onclick="location.href='${pageContext.request.contextPath}/events/detail/${event.maSuKien}'">
                                    <strong>${event.tieuDe}</strong> - ${event.tenDanhMuc}
                                 </div>`;
                                    });
                                    suggestionBox.innerHTML = html;
                                });
                    });
                }
            });
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const searchBox = document.getElementById("searchBox");

                if (searchBox) {
                    searchBox.addEventListener("input", function () {
                        const keyword = this.value.trim().toLowerCase();

                        document.querySelectorAll(".event-card").forEach(card => {
                            const title = card.getAttribute("data-title").toLowerCase();
                            if (title.includes(keyword)) {
                                card.style.display = "flex"; // hoặc "block" nếu bạn dùng layout khác
                            } else {
                                card.style.display = "none";
                            }
                        });
                    });
                }
            });
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const categoryFilter = document.getElementById("categoryFilter");

                if (categoryFilter) {
                    categoryFilter.addEventListener("change", function () {
                        const selectedCategory = this.value.toLowerCase();

                        document.querySelectorAll(".event-card").forEach(card => {
                            const category = card.getAttribute("data-category").toLowerCase();

                            if (!selectedCategory || category === selectedCategory) {
                                card.style.display = "flex";  // hoặc "block" nếu dùng layout khác
                            } else {
                                card.style.display = "none";
                            }
                        });
                    });
                }
            });
        </script>

        <footer>
            <!-- footer.jsp -->
            <div style="background-color: #1c2230; color: #eaeaea; padding: 40px 0; font-size: 14px;">
                <div class="container">
                    <div class="row text-left">
                        <div class="col-md-3">
                            <h5 class="text-white mb-3">Về chúng tôi</h5>
                            <p><a href="#" class="text-light">Giới thiệu</a></p>
                            <p><a href="#" class="text-light">Bảng giá dịch vụ</a></p>
                            <p><a href="#" class="text-light">Liên hệ quảng cáo</a></p>
                        </div>
                        <div class="col-md-3">
                            <h5 class="text-white mb-3">Trợ giúp</h5>
                            <p><a href="#" class="text-light">Liên hệ</a></p>
                            <p><a href="#" class="text-light">Trung tâm trợ giúp</a></p>
                            <p><a href="#" class="text-light">Quy định và Điều khoản</a></p>
                        </div>
                        <div class="col-md-3">
                            <h5 class="text-white mb-3">Thông tin</h5>
                            <p><a href="#" class="text-light">Quy chế hoạt động</a></p>
                            <p><a href="#" class="text-light">Cơ chế giải quyết tranh chấp</a></p>
                            <p><a href="#" class="text-light">Chính sách bảo mật thông tin</a></p>
                        </div>

                    </div>
                </div>
            </div>
        </footer>
    </body>

</html>
