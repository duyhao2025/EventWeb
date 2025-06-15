<%@page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en" class="no-js">


    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo-16x16.png" />

        <title>Argon - Social Network</title>

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

    </head>

    <body class="newsfeed">
        <div class="container-fluid" id="wrapper">
            <div class="row newsfeed-size">
                <div class="col-md-12 newsfeed-right-side">

                    <nav id="navbar-main" class="navbar navbar-expand-lg shadow-sm sticky-top">
                        <div class="w-100 justify-content-md-center">
                            <ul class="nav navbar-nav enable-mobile px-2">
                                <li class="nav-item">
                                    <button type="button" class="btn nav-link p-0"><img src="assets/images/icons/theme/post-image.png" class="f-nav-icon" alt="Quick make post"></button>
                                </li>
                                <li class="nav-item w-100 py-2">
                                    <form class="d-inline form-inline w-100 px-4">
                                        <div class="input-group">
                                            <input type="text" id="searchBox" class="form-control search-input" placeholder="Tìm kiếm sự kiện " aria-label="Search" aria-describedby="search-addon">
                                            <div id="suggestions" class="search-suggestions"></div>
                                            <div class="input-group-append">
                                                <button class="btn search-button" type="button"><i class='bx bx-search'></i></button>
                                            </div>
                                        </div>
                                    </form>
                                </li>
                                <li class="nav-item">
                                    <a href="messages.html" class="nav-link nav-icon nav-links message-drop drop-w-tooltip" data-placement="bottom" data-title="Messages">
                                        <img src="assets/images/icons/navbar/message.png" class="message-dropdown f-nav-icon" alt="navbar icon">
                                    </a>
                                </li>
                            </ul>
                            <ul class="navbar-nav mr-5 flex-row" id="main_menu">
                                <a class="navbar-brand nav-item mr-lg-5" href="index.html"><img src="assets/images/logo-64x64.png" width="40" height="40" class="mr-3" alt="Logo"></a>
                                <!-- Collect the nav links, forms, and other content for toggling -->
                                <div class="input-group-prepend">
                                    <select class="form-control" id="categoryFilter" style="margin-top:15px;">
                                        <option value="">Danh mục</option>
                                        <option value="Thể thao">Thể thao</option>
                                        <option value="Nhạc hội">Nhạc hội</option>
                                        <option value="Off Fan">Off Fan</option>
                                    </select>
                                </div>
                                <form class="w-30 mx-2 my-auto d-inline form-inline mr-5 dropdown search-form">
                                    <div class="input-group" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="searchDropdown">
                                        <input type="text" class="form-control search-input w-75" placeholder="Tìm kiếm sự kiện" aria-label="Search" aria-describedby="search-addon">
                                        <div class="input-group-append">
                                            <button class="btn search-button" type="button"><i class='bx bx-search'></i></button>
                                        </div>
                                    </div>
                                    <ul class="dropdown-menu notify-drop nav-drop shadow-sm" aria-labelledby="searchDropdown">
                                        <div class="notify-drop-title">
                                            <div class="row">
                                                <div class="col-md-6 col-sm-6 col-xs-6 fs-8">Search Results <span class="badge badge-pill badge-primary ml-2">29</span></div>
                                            </div>
                                        </div>
                                        <!-- end notify title -->
                                        <!-- notify content -->

                                        <div class="notify-drop-footer text-center">
                                            <a href="#">See More</a>
                                        </div>
                                    </ul>
                                </form>
                                <li class="nav-item s-nav dropdown d-mobile">
                                    <a href="#" class="nav-link nav-icon nav-links drop-w-tooltip" data-toggle="dropdown" data-placement="bottom" data-title="Create" role="button" aria-haspopup="true" aria-expanded="false">
                                        <img src="assets/images/icons/navbar/create.png" alt="navbar icon">
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right nav-dropdown-menu">
                                        <a href="#" class="dropdown-item" aria-describedby="createGroup">
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <i class='bx bx-group post-option-icon'></i>
                                                </div>
                                                <div class="col-md-10">
                                                    <span class="fs-9">Group</span>
                                                    <small id="createGroup" class="form-text text-muted">Find people with shared interests</small>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="dropdown-item" aria-describedby="createEvent">
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <i class='bx bx-calendar post-option-icon'></i>
                                                </div>
                                                <div class="col-md-10">
                                                    <span class="fs-9">Event</span>
                                                    <small id="createEvent" class="form-text text-muted">bring people together with a public or private event</small>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </li>
                                <li class="nav-item s-nav dropdown message-drop-li">
                                    <a href="#" class="nav-link nav-links message-drop drop-w-tooltip" data-toggle="dropdown" data-placement="bottom" data-title="Messages" role="button" aria-haspopup="true" aria-expanded="false">
                                        <img src="assets/images/icons/navbar/message.png" class="message-dropdown" alt="navbar icon"> <span class="badge badge-pill badge-primary">1</span>
                                    </a>
                                    <ul class="dropdown-menu notify-drop dropdown-menu-right nav-drop shadow-sm">
                                        <div class="notify-drop-title">
                                            <div class="row">
                                                <div class="col-md-6 col-sm-6 col-xs-6 fs-8">Messages | <a href="#">Requests</a></div>
                                                <div class="col-md-6 col-sm-6 col-xs-6 text-right">
                                                    <a href="#" class="notify-right-icon">
                                                        Mark All as Read
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- end notify title -->
                                        <!-- notify content -->
                                        <div class="drop-content">
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-6.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <a href="#" class="notification-user">Susan P. Jarvis</a>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        <i class='bx bx-check'></i> This party is going to have a DJ, food, and drinks.
                                                    </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-5.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <a href="#" class="notification-user">Ruth D. Greene</a>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        Great, I’ll see you tomorrow!.
                                                    </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-7.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <a href="#" class="notification-user">Kimberly R. Hatfield</a>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        yeah, I will be there.
                                                    </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-8.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <a href="#" class="notification-user">Joe S. Feeney</a>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        I would really like to bring my friend Jake, if...
                                                    </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-9.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <a href="#" class="notification-user">William S. Willmon</a>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        Sure, what can I help you with?
                                                    </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-10.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <a href="#" class="notification-user">Sean S. Smith</a>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        Which of those two is best?
                                                    </p>
                                                </div>
                                            </li>
                                        </div>
                                        <div class="notify-drop-footer text-center">
                                            <a href="#">See More</a>
                                        </div>
                                    </ul>
                                </li>
                                <li class="nav-item s-nav dropdown notification">
                                    <a href="#" class="nav-link nav-links rm-drop-mobile drop-w-tooltip" data-toggle="dropdown" data-placement="bottom" data-title="Notifications" role="button" aria-haspopup="true" aria-expanded="false">
                                        <img src="assets/images/icons/navbar/notification.png" class="notification-bell" alt="navbar icon"> <span class="badge badge-pill badge-primary">3</span>
                                    </a>
                                    <ul class="dropdown-menu notify-drop dropdown-menu-right nav-drop shadow-sm">
                                        <div class="notify-drop-title">
                                            <div class="row">
                                                <div class="col-md-6 col-sm-6 col-xs-6 fs-8">Notifications <span class="badge badge-pill badge-primary ml-2">3</span></div>
                                                <div class="col-md-6 col-sm-6 col-xs-6 text-right">
                                                    <a href="#" class="notify-right-icon">
                                                        Mark All as Read
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- end notify title -->
                                        <!-- notify content -->
                                        <div class="drop-content">
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-10.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <a href="#" class="notification-user">Sean</a> <span class="notification-type">replied to your comment on a post in </span><a href="#" class="notification-for">PHP</a>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        <span class="badge badge-pill badge-primary"><i class='bx bxs-group'></i></span> 3h
                                                    </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-7.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <a href="#" class="notification-user">Kimberly</a> <span class="notification-type">likes your comment "I would really... </span>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        <span class="badge badge-pill badge-primary"><i class='bx bxs-like'></i></span> 7h
                                                    </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-8.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <span class="notification-type">10 people saw your story before it disappeared. See who saw it.</span>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        <span class="badge badge-pill badge-primary"><i class='bx bx-images'></i></span> 23h
                                                    </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-11.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <a href="#" class="notification-user">Michelle</a> <span class="notification-type">posted in </span><a href="#" class="notification-for">Argon Social Design System</a>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        <span class="badge badge-pill badge-primary"><i class='bx bxs-quote-right'></i></span> 1d
                                                    </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-5.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <a href="#" class="notification-user">Karen</a> <span class="notification-type">likes your comment "Sure, here... </span>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        <span class="badge badge-pill badge-primary"><i class='bx bxs-like'></i></span> 2d
                                                    </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="col-md-2 col-sm-2 col-xs-2">
                                                    <div class="notify-img">
                                                        <img src="assets/images/users/user-12.png" alt="notification user image">
                                                    </div>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10">
                                                    <a href="#" class="notification-user">Irwin</a> <span class="notification-type">posted in </span><a href="#" class="notification-for">Themeforest</a>
                                                    <a href="#" class="notify-right-icon">
                                                        <i class='bx bx-radio-circle-marked'></i>
                                                    </a>
                                                    <p class="time">
                                                        <span class="badge badge-pill badge-primary"><i class='bx bxs-quote-right'></i></span> 3d
                                                    </p>
                                                </div>
                                            </li>
                                        </div>
                                        <div class="notify-drop-footer text-center">
                                            <a href="#">See More</a>
                                        </div>
                                    </ul>
                                </li>
                                
                                
                                </li>
                                <li class="nav-item s-nav">
                                    <a href="profile.jsp" class="nav-link nav-links">
                                        <div class="menu-user-image">
                                            <img src="assets/images/users/user-4.jpg" class="menu-user-img ml-1" alt="Menu Image">
                                        </div>
                                    </a>
                                </li>
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
                                <button type="button" class="btn nav-link" id="menu-toggle"><img src="assets/images/icons/theme/navs.png" alt="Navbar navs"></button>
                            </ul>

                        </div>

                    </nav>
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
                                        <a href="messages.html" class="sidebar-item"><img src="assets/images/icons/left-sidebar/message.png" alt="message"> Tin nhắn</a>
                                        <span class="badge badge-primary badge-pill">2</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <a href="groups.html" class="sidebar-item"><img src="assets/images/icons/left-sidebar/group.png" alt="group"> Nhóm của bạn</a>
                                        <span class="badge badge-primary badge-pill">17</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <a href="events.html" class="sidebar-item"><img src="assets/images/icons/left-sidebar/event.png" alt="event"> Sự kiện bạn tổ chức</a>
                                        <span class="badge badge-primary badge-pill">3</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <a href="saved.html" class="sidebar-item"><img src="assets/images/icons/left-sidebar/saved.png" alt="saved"> Lưu sự kiện</a>
                                        <span class="badge badge-primary badge-pill">8</span>
                                    </li>


                                </ul>
                            </div>
                        </div>
                        <div class="col-md-6 second-section" id="page-content-wrapper">



                            <!-- Posts -->
                            <meta charset="UTF-8">
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

                                <div class="feed-wrapper">
                                    <c:forEach var="event" items="${suKienList}">
                                        <div class="event-card" data-title="${event.tieuDe}" data-category="${event.tenDanhMuc}">
                                            <img class="event-image" src="${pageContext.request.contextPath}/assets/img/${event.hinhAnh}" alt="Hình sự kiện" />

                                            <div class="event-info">
                                                <div>
                                                    <h3 class="event-title">Tên sự kiện: ${event.tieuDe}</h3>
                                                    <h3 class="event-title">Thể loại: ${event.maDanhMuc}</h3>
                                                    <div class="event-description">
                                                        Mô tả sự kiện:
                                                        <c:choose>
                                                            <c:when test="${fn:length(event.moTa) > 20}">
                                                                ${fn:substring(event.moTa, 0, 20)}...
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${event.moTa}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="event-dates">
                                                        Bắt đầu: ${event.ngayGio} <br/>
                                                        Hạn đăng ký: ${event.hanDangKy}
                                                    </div> 
                                                </div>
                                                <div class="event-action">
                                                    <button class="btn-detail" onclick="toggleDetail('${event.maSuKien}')">Chi tiết</button>
                                                    <a href="${pageContext.request.contextPath}/eventregister" class="btn-register">
                                                        Đăng ký tham gia
                                                    </a>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- PHẦN CHI TIẾT ĐI KÈM MỖI SỰ KIỆN -->
                                        <div class="event-detail-panel" id="detail-${event.maSuKien}" style="display:none;">
                                            <img src="${pageContext.request.contextPath}/assets/img/${event.hinhAnh}" width="100%" />
                                            <h3><strong>Tên sự kiện:</strong>${event.tieuDe}</h3>
                                            <p><strong>Mô tả:</strong>${event.moTa}</p>
                                            <p><strong>Bắt đầu:</strong> ${event.ngayGio}</p>
                                            <p><strong>Hạn đăng ký:</strong> ${event.hanDangKy}</p>
                                            <p><strong>Thời lượng:</strong> ${event.thoiLuongPhut} phút</p>
                                            <p><strong>Số người tối đa:</strong> ${event.soNguoiToiDa}</p>
                                        </div>
                                    </c:forEach>
                                </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modals -->
            <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" id="postModal" aria-labelledby="postModal" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-body post-body">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-7 post-content">
                                        <img src="https://scontent.fevn1-2.fna.fbcdn.net/v/t1.0-9/56161887_588993861570433_2896723195090436096_n.jpg?_nc_cat=103&_nc_eui2=AeFI0UuTq3uUF_TLEbnZwM-qSRtgOu0HE2JPwW6b4hIki73-2OWYhc7L1MPsYl9cYy-w122CCak-Fxj0TE1a-kjsd-KXzh5QsuvxbW_mg9qqtg&_nc_ht=scontent.fevn1-2.fna&oh=ea44bffa38f368f98f0553c5cef8e455&oe=5D050B05" alt="post-image">
                                    </div>
                                    <div class="col-md-5 pr-3">
                                        <div class="media text-muted pr-3 pt-3">
                                            <img src="assets/images/users/user-1.jpg" alt="user image" class="mr-3 post-modal-user-img">
                                            <div class="media-body">
                                                <div class="d-flex justify-content-between align-items-center w-100 post-modal-top-user fs-9">
                                                    <a href="#" class="text-gray-dark">John Michael</a>
                                                    <div class="dropdown">
                                                        <a href="#" class="postMoreSettings" role="button" data-toggle="dropdown" id="postOptions" aria-haspopup="true" aria-expanded="false">
                                                            <i class='bx bx-dots-horizontal-rounded'></i>
                                                        </a>
                                                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left postDropdownMenu">
                                                            <a href="#" class="dropdown-item" aria-describedby="savePost">
                                                                <div class="row">
                                                                    <div class="col-md-2">
                                                                        <i class='bx bx-bookmark-plus postOptionIcon'></i>
                                                                    </div>
                                                                    <div class="col-md-10">
                                                                        <span class="postOptionTitle">Save post</span>
                                                                        <small id="savePost" class="form-text text-muted">Add this to your saved items</small>
                                                                    </div>
                                                                </div>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <span class="d-block fs-8">3 hours ago <i class='bx bx-globe ml-3'></i></span>
                                            </div>
                                        </div>
                                        <div class="mt-3 post-modal-caption fs-9">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quis voluptatem veritatis harum, tenetur, quibusdam voluptatum, incidunt saepe minus maiores ea atque sequi illo veniam sint quaerat corporis totam et. Culpa?</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Chat Popup -->
            <!--
                <div class="chat-popup shadow" id="hide-in-mobile">
                    <div class="row chat-window col-xs-5 col-md-3">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="top-bar shadow-sm d-flex align-items-center">
                                    <div class="col-md-6 col-xs-6">
                                        <a href="profile.html">
                                            <img src="assets/images/users/user-2.jpg" class="mr-2 chatbox-user-img" alt="Chat user image">
                                            <span class="panel-title">Karen Minas</span>
                                        </a>
                                    </div>
                                    <div class="col-md-6 col-xs-6 d-flex align-items-center justify-content-between">
                                        <a href="#">
                                            <img src="assets/images/icons/messenger/video-call.png" class="chatbox-call" alt="Chatbox contact types">
                                        </a>
                                        <a href="#" data-toggle="modal" data-target="#callModal">
                                            <img src="assets/images/icons/messenger/call.png" class="chatbox-call" alt="Chatbox contact types">
                                        </a>
                                        <a href="javascript:void(0)"><i id="minimize-chat-window" class="bx bx-minus icon_minim"></i></a>
                                        <a href="javascript:void(0)" id="close-chatbox"><i class="bx bx-x"></i></a>
                                    </div>
                                </div>
                                <div id="messagebody" class="msg_container_base">
                                    <div class="row msg_container base_sent">
                                        <div class="col-md-10 col-xs-10">
                                            <div class="messages message-reply bg-primary shadow-sm">
                                                <p>Are you going to the party on Saturday?</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row msg_container base_receive">
                                        <div class="col-md-10 col-xs-10">
                                            <div class="messages message-receive shadow-sm">
                                                <p>I was thinking about it. Are you?</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row msg_container base_receive">
                                        <div class="col-xs-10 col-md-10">
                                            <div class="messages message-receive shadow-sm">
                                                <p>Really? Well, what time does it start?</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row msg_container base_sent">
                                        <div class="col-xs-10 col-md-10">
                                            <div class="messages message-reply bg-primary shadow-sm">
                                                <p>It starts at 8:00 pm, and I really think you should go.</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row msg_container base_receive">
                                        <div class="col-xs-10 col-md-10">
                                            <div class="messages message-receive shadow-sm">
                                                <p>Well, who else is going to be there?</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row msg_container base_sent">
                                        <div class="col-md-10 col-xs-10">
                                            <div class="messages message-reply bg-primary shadow-sm">
                                                <p>Everybody from school.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer chat-inputs">
                                    <div class="col-md-12 message-box">
                                        <input type="text" class="w-100 search-input type-message" placeholder="Type a message..." />
                                        <div class="chat-tools">
                                            <a href="#" class="chatbox-tools">
                                                <img src="assets/images/icons/theme/post-image.png" class="chatbox-tools-img" alt="Chatbox tool">
                                            </a>
                                            <a href="#" class="chatbox-tools">
                                                <img src="assets/images/icons/messenger/gif.png" class="chatbox-tools-img" alt="Chatbox tool">
                                            </a>
                                            <a href="#" class="chatbox-tools">
                                                <img src="assets/images/icons/messenger/smile.png" class="chatbox-tools-img" alt="Chatbox tool">
                                            </a>
                                            <a href="#" class="chatbox-tools">
                                                <img src="assets/images/icons/messenger/console.png" class="chatbox-tools-img" alt="Chatbox tool">
                                            </a>
                                            <a href="#" class="chatbox-tools">
                                                <img src="assets/images/icons/messenger/attach-file.png" class="chatbox-tools-img" alt="Chatbox tool">
                                            </a>
                                            <a href="#" class="chatbox-tools">
                                                <img src="assets/images/icons/messenger/photo-camera.png" class="chatbox-tools-img" alt="Chatbox tool">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            -->
            <!-- END Chat Popup -->

            <!-- Call modal -->
            <div id="callModal" class="modal fade call-modal" tabindex="-1" role="dialog" aria-labelledby="callModalLabel" aria-hidden="true">
                <div class="modal-dialog call-modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header align-items-center">
                            <div class="call-status">
                                <h1 id="callModalLabel" class="modal-title mr-3">Connected</h1>
                                <span class="online-status bg-success"></span>
                            </div>
                            <div class="modal-options d-flex align-items-center">
                                <button type="button" class="btn btn-quick-link" id="minimize-call-window">
                                    <i class='bx bx-minus'></i>
                                </button>
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="row h-100">
                                <div class="col-md-12 d-flex align-items-center justify-content-center">
                                    <div class="call-user text-center">
                                        <div class="call-user-img-anim">
                                            <img src="assets/images/users/user-1.jpg" class="call-user-img" alt="Call user image">
                                        </div>
                                        <p class="call-user-name">Name Surename</p>
                                        <p class="text-muted call-time">05:28</p>
                                    </div>
                                </div>
                                <div class="col-md-4 offset-md-4 d-flex align-items-center justify-content-between call-btn-list">
                                    <a href="#" class="btn call-btn" data-toggle="tooltip" data-placement="top" data-title="Disable microphone"><i class='bx bxs-microphone'></i></a>
                                    <a href="#" class="btn call-btn" data-toggle="tooltip" data-placement="top" data-title="Enable camera"><i class='bx bxs-video-off'></i></a>
                                    <a href="#" class="btn call-btn drop-call" data-toggle="tooltip" data-placement="top" data-title="End call" data-dismiss="modal" aria-label="Close"><i class='bx bxs-phone'></i></a>
                                    <a href="#" class="btn call-btn" data-toggle="tooltip" data-placement="top" data-title="Share Screen"><i class='bx bx-laptop'></i></a>
                                    <a href="#" class="btn call-btn" data-toggle="tooltip" data-placement="top" data-title="Dark mode"><i class='bx bx-moon'></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END call modal -->

            <!-- Core -->
            <script src="assets/js/jquery/jquery-3.3.1.min.js"></script>
            <script src="assets/js/popper/popper.min.js"></script>
            <script src="assets/js/bootstrap/bootstrap.min.js"></script>
            <!-- Optional -->
            <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
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
                    const searchBox = document.getElementById("searchBox");
                    const suggestionBox = document.getElementById("suggestions");

                    // Danh sách tiêu đề sự kiện lấy từ server bằng JSP
                    const eventTitles = [
                        <c:forEach var="event" items="${suKienList}" varStatus="loop">
                                                   "${event.tieuDe}"<c:if test="${!loop.last}">,</c:if>
                                    </c:forEach>
                    ];

                    searchBox.addEventListener("input", function () {
                        const keyword = this.value.trim().toLowerCase();
                        suggestionBox.innerHTML = "";

                        if (keyword === "") {
                            suggestionBox.style.display = "none";
                            return;
                        }

                        const matched = eventTitles.filter(title => title.toLowerCase().includes(keyword));

                        if (matched.length > 0) {
                            matched.forEach(title => {
                                const div = document.createElement("div");
                                div.textContent = title;
                                div.onclick = () => {
                                    searchBox.value = title;
                                    suggestionBox.innerHTML = "";
                                    suggestionBox.style.display = "none";
                                };
                                suggestionBox.appendChild(div);
                            });
                            suggestionBox.style.display = "block";
                        } else {
                            suggestionBox.style.display = "none";
                        }
                    });

                    // Ẩn gợi ý khi click ra ngoài
                    document.addEventListener("click", function (e) {
                        if (!suggestionBox.contains(e.target) && e.target !== searchBox) {
                            suggestionBox.style.display = "none";
                        }
                    });
                });
                                               </script>
                                                </body>

                                                </html>
