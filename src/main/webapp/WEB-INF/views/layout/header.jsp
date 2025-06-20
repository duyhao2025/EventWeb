<%@page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">
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
    <body>
        <!-- Navbar -->
        <!-- Logo -->
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
                        <select id="categoryFilter" class="form-select me-3" style="width: 150px;">
                            <option value="">Danh mục</option>
                            <option value="1">Hội thảo</option>
                            <option value="2">Workshop</option>
                            <option value="3">Cuộc thi</option>
                            <option value="4">Triển lãm</option>
                            <option value="5">Hội thảo trực tuyến</option>
                            <option value="6">Buổi giao lưu</option>
                            <option value="7">Buổi hòa nhạc</option>
                            <option value="8">Khóa học ngắn hạn</option>

                        </select>

                        <!-- Search + Pencil -->
                        <form action="${pageContext.request.contextPath}/events/list"
                              method="get"
                              class="d-flex flex-grow-1 me-3">
                            <div class="input-group">
                                <input type="text"
                                       name="keyword"
                                       class="form-control rounded-pill ps-4"
                                       placeholder="Tìm kiếm sự kiện…"
                                       style="height: 44px; font-size: 1rem;"
                                       value="${keyword != null ? keyword : ''}">
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
                                <a href="settings.html" data-toggle="dropdown" data-placement="bottom" data-title="Settings" class="nav-link settings-link rm-drop-mobile drop-w-tooltip" id="settings-dropdown">
                                    <img src="${pageContext.request.contextPath}/assets/images/icons/navbar/settings.png" class="nav-settings" alt="navbar icon"></a>
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
        </div>
        <script type="text/javascript">
            $("#menu-toggle").click(function (e) {
                e.preventDefault();
                $("#wrapper").toggleClass("toggled");
            });

        </script>
    </body>