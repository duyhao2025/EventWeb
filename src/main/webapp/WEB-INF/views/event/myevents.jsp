<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
<html>
    <head>
        <title>Sự kiện bạn tổ chức</title>
        <link rel="stylesheet" href="../assets/css/bootstrap/bootstrap.min.css"/>
    </head>
    <body>
        <div class="container mt-4">
            <h2>Sự kiện bạn tổ chức</h2>
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
                                    <a href="${pageContext.request.contextPath}/events/edit/${event.maSuKien}"
                                       class="btn btn-warning btn-sm">Sửa sự kiện </a>
                                    <form action="${pageContext.request.contextPath}/events/delete/${event.maSuKien}"
                                          method="post" style="display:inline;"
                                          onsubmit="return confirm('Xác nhận xóa sự kiện?');">
                                        <button type="submit" class="btn btn-danger btn-sm">Xóa sự kiện</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>