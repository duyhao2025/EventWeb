<%@page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Event Management System</title>
        <!-- CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/argon-design-system.css?v=1.2.2">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

        <!-- JS -->
        <script src="${pageContext.request.contextPath}/assets/js/core/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/argon-design-system.min.js?v=1.2.2"></script>

        <!-- Fonts and icons -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/nucleo-icons.css">

        <!-- Bootstrap and Argon CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/argon-design-system.css?v=1.2.2">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

        <!-- Favicon -->
        <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" type="image/png">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">EventWeb</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/events">Sự kiện</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                    </ul>
                </div>
            </div>
        </nav>
