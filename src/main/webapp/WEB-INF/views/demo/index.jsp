<%@page import="com.uef.model.User"%>
<%@page import="com.uef.model.SuKien"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
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
            .event-detail-panel {
                opacity: 0;
                transform: translateX(50px);
                transition: all 0.3s ease-in-out;
            }

            .event-detail-panel.show {
                opacity: 1;
                transform: translateX(0);
            }
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
                padding: 40px 20px;
                width: 100%;
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
            .close-detail-btn {
                position: absolute;
                top: 10px;
                right: 12px;
                background: transparent;
                border: none;
                font-size: 24px;
                font-weight: bold;
                color: #555;
                cursor: pointer;
                transition: color 0.2s;
            }

            .close-detail-btn:hover {
                color: #d00;
            }
        </style>
    </head>

    <body class="newsfeed">
        <div class="container-fluid" id="wrapper">
            <div class="container" style="padding-top: 100px;">
                <form action="${pageContext.request.contextPath}/events/list" method="get">
                    <div class="input-group">
                        <input type="text"
                               id="searchBox"
                               name="keyword"
                               class="form-control rounded-start-pill ps-4"
                               placeholder="Tìm kiếm sự kiện...">
                        <button class="btn btn-outline-secondary rounded-end-pill"
                                type="submit"
                                style="width: 44px; height: 44px; font-size: 20px;">
                            <i class="bx bx-search"></i>
                        </button>
                    </div>
                </form>
            </div>
            <div class="d-flex justify-content-center mt-4">
                <div class="feed-wrapper w-100" style="max-width: 80%;">


                    <%
                        List<SuKien> list = (List<SuKien>) request.getAttribute("suKienList");
                        if (list != null) {
                            for (SuKien event : list) {
                    %>
                    <div class="event-card" data-title="<%= event.getTieuDe()%>" data-category="<%= event.getTenDanhMuc()%>">
                        <img class="event-image" src="${pageContext.request.contextPath}/uploads/${event.hinhAnh}" alt="Hình sự kiện" />

                        <div class="event-info">
                            <div>
                                <h3 class="event-title"> <%= event.getTieuDe()%></h3>
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

                                <%
                                    }
                                %>
                                <a href="${pageContext.request.contextPath}/events/detail/<%= event.getMaSuKien()%>" class="btn-detail">Chi tiết</a>
                                <a href="${pageContext.request.contextPath}/eventregister?suKienId=<%= event.getMaSuKien()%>">Đăng ký tham gia</a>


                            </div>
                        </div>
                    </div>

                    <!-- PHẦN CHI TIẾT -->

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
                        el.classList.remove("show"); // Xóa hiệu ứng cũ nếu có
                    }
                });

                const panel = document.getElementById("detail-" + id);

                // Nếu đang ẩn thì hiển thị với hiệu ứng
                if (panel.style.display === "none" || panel.style.display === "") {
                    panel.style.display = "block";

                    // Cho phép CSS kích hoạt hiệu ứng sau một chút (delay nhỏ để trigger transition)
                    setTimeout(() => {
                        panel.classList.add("show");
                    }, 10);
                } else {
                    // Ẩn đi với hiệu ứng ngược
                    panel.classList.remove("show");

                    // Sau khi hiệu ứng ẩn chạy xong, tắt hẳn display
                    setTimeout(() => {
                        panel.style.display = "none";
                    }, 300); // Thời gian trùng với transition 0.3s
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
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const settingsIcon = document.querySelector('#settings-dropdown');
                const dropdown = document.querySelector('.settings-dropdown');

                if (settingsIcon && dropdown) {
                    settingsIcon.addEventListener('click', function (e) {
                        e.preventDefault();

                        // Toggle dropdown
                        dropdown.classList.toggle('show');

                        // Nếu hiển thị -> chạy animation từng item
                        if (dropdown.classList.contains('show')) {
                            const items = dropdown.querySelectorAll('.dropdown-item');
                            items.forEach((item, index) => {
                                item.style.animationDelay = `${index * 100}ms`;
                            });
                        } else {
                            // Xóa delay khi ẩn
                            dropdown.querySelectorAll('.dropdown-item').forEach(item => {
                                item.style.animation = 'none';
                                item.offsetHeight; // trigger reflow
                                item.style.animation = '';
                            });
                        }
                    });
                }
            });
        </script>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </body>

</html>
