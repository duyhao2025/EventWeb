<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Trang chủ sự kiện</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo-16x16.png"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/boxicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
            }
            .navbar {
                background-color: #fff;
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
                padding: 12px 24px;
            }
            .navbar-brand img {
                width: 40px;
                height: 40px;
                object-fit: contain;
            }
            #categoryFilter {
                border-radius: 6px;
                padding: 6px 12px;
                border: 1px solid #ccc;
                font-weight: 500;
                background-color: #f9f9f9;
            }
            .input-group .form-control {
                border-radius: 6px 0 0 6px;
                height: 40px;
            }
            .input-group .btn {
                border-radius: 0 6px 6px 0;
            }
            .search-wrapper {
                flex: 1;
                max-width: 380px;
                margin-left: 20px;
            }
            .nav-profile img {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                object-fit: cover;
            }
            .settings-icon {
                width: 28px;
                height: 28px;
                margin-left: 16px;
                cursor: pointer;
                object-fit: contain;
            }
            .dropdown-menu a {
                font-size: 14px;
            }

            .btn-hover {
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }

            .btn-hover:hover {
                transform: scale(1.07);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }

            #categoryFilter:hover {
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                transform: scale(1.03);
                transition: 0.2s ease;
            }

        </style>
    </head>
    <body>
        <div id="main-header" style="position: fixed; top: 0; left: 0; width: 100%; background: white; z-index: 999; box-shadow: 0 2px 6px rgba(0,0,0,0.1); padding: 10px 20px;">
            <div class="col-md-12 newsfeed-right-side">
                <nav class="navbar navbar-expand-lg shadow-sm sticky-top bg-white">
                    <div class="container-fluid d-flex justify-content-end align-items-center"
                         style="position: fixed; top: 0; left: 0; right: 0; z-index: 1000; background: white; box-shadow: 0 2px 6px rgba(0,0,0,0.05); padding: 10px 20px;">
                        <!-- Dùng gap-40 để giãn nút 1cm -->
                        <div class="d-flex align-items-center flex-row-reverse" style="gap: 40px;">

                            <!-- Avatar -->
                            <a href="#" class="nav-link">
                                <img src="${pageContext.request.contextPath}/assets/images/users/user-4.jpg"
                                     class="rounded-circle"
                                     width="36"
                                     height="36"
                                     style="object-fit: cover;"
                                     alt="User">
                            </a>

                            <!-- Đăng xuất -->
                            <a class="btn btn-outline-primary btn-hover"
                               href="${pageContext.request.contextPath}/logout">
                                Đăng xuất
                            </a>

                            <!-- Trang chủ -->
                            <a class="btn btn-outline-primary btn-hover"
                               href="${pageContext.request.contextPath}/demo">
                                Trang chủ
                            </a>

                            <!-- Thông tin cá nhân -->
                            <a class="btn btn-outline-primary btn-hover"
                               href="${pageContext.request.contextPath}/user/profile">
                                Thông tin cá nhân
                            </a>

                            <!-- Trung tâm quản lý sự kiện -->
                            <a class="btn btn-outline-primary btn-hover"
                               href="${pageContext.request.contextPath}/events/my_events">
                                Trung tâm quản lý sự kiện
                            </a>

                            <!-- Danh mục -->
                            <form action="${pageContext.request.contextPath}/events/filter" method="get">
                                <select id="categoryFilter"
                                        name="category"
                                        class="form-select shadow-sm"
                                        style="height: 44px; width: 180px; border-radius: 24px;">
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

                        </div>
                    </div>
                </nav>
            </div>
        </div>



        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
        <script type="text/javascript">
            $("#menu-toggle").click(function (e) {
                e.preventDefault();
                $("#wrapper").toggleClass("toggled");
            });

        </script>
    </body>
</html>
