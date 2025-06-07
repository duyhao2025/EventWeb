<%@page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo-16x16.png" />
        <title>Argon - Đăng ký</title>

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Major+Mono+Display" rel="stylesheet">
        <link href='https://cdn.jsdelivr.net/npm/boxicons@1.9.2/css/boxicons.min.css' rel='stylesheet'>

        <!-- Styles -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/components.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/auth.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/media.css" rel="stylesheet">
    </head>
    <body>
        <div class="row ht-100v flex-row-reverse no-gutters">
            <div class="col-md-6 d-flex justify-content-center align-items-center">
                <div class="signup-form">
                    <div class="auth-logo text-center mb-5">
                        <div class="row">
                            <div class="col-md-2">
                                <img src="${pageContext.request.contextPath}/assets/images/logo-64x64.png" class="logo-img" alt="Logo">
                            </div>
                            <div class="col-md-10">
                                <p>Argon Social Network</p>
                                <span>Design System</span>
                            </div>
                        </div>
                    </div>

                    <c:if test="${error != null && fn:trim(error) != ''}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <c:if test="${message != null && fn:trim(message) != ''}">
                        <div class="alert alert-success">${message}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post" class="pt-3">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" name="ho_ten" class="form-control" placeholder="Họ và tên" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <input type="text" class="form-control" placeholder="(Không cần điền)">
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <input type="email" name="email" class="form-control" placeholder="Email" required>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <input type="text" name="so_dien_thoai" class="form-control" placeholder="Số điện thoại" required>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="password" name="mat_khau" class="form-control" placeholder="Mật khẩu" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <input type="password" class="form-control" placeholder="Nhập lại mật khẩu">
                            </div>

                            <div class="col-md-12">
                                <p class="agree-privacy">Bằng cách nhấn Đăng ký, bạn đồng ý với chính sách bảo mật và điều khoản sử dụng.</p>
                            </div>
                            <div class="col-md-6">
                                <span class="go-login">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></span>
                            </div>
                            <div class="col-md-6 text-right">
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary sign-up">Đăng ký</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="col-md-6 auth-bg-image d-flex justify-content-center align-items-center">
                <div class="auth-left-content mt-5 mb-5 text-center">
                    <div class="weather-small text-white">
                        <p class="current-weather"><i class='bx bx-sun'></i> <span>14&deg;</span></p>
                        <p class="weather-city">Gyumri</p>
                    </div>
                    <div class="text-white mt-5 mb-5">
                        <h2 class="create-account mb-3">Tạo tài khoản</h2>
                        <p>Nhập thông tin cá nhân và bắt đầu hành trình với chúng tôi.</p>
                    </div>
                    <div class="auth-quick-links">
                        <a href="#" class="btn btn-outline-primary">Xem thêm template</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Core -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.3.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/popper/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>
