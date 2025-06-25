<!-- footer.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}" />
<fmt:setBundle basename="messages" />

<footer>
    <!-- footer.jsp -->
    <div style="background-color: #1c2230; color: #eaeaea; padding: 40px 0; font-size: 14px;">
        <div class="container">
            <div class="row text-left">
                <div class="col-md-3">
                    <h5 class="text-white mb-3"><fmt:message key="footer.aboutus"/></h5>
                    <p><a href="#" class="text-light"><fmt:message key="footer.introduce"/></a></p>
                    <p><a href="#" class="text-light"><fmt:message key="footer.pricing"/></a></p>
                    <p><a href="#" class="text-light"><fmt:message key="footer.ads"/></a></p>
                </div>
                <div class="col-md-3">
                    <h5 class="text-white mb-3"><fmt:message key="footer.support"/></h5>
                    <p><a href="#" class="text-light"><fmt:message key="footer.contact"/></a></p>
                    <p><a href="#" class="text-light"><fmt:message key="footer.helpcenter"/></a></p>
                    <p><a href="#" class="text-light"><fmt:message key="footer.terms"/></a></p>
                </div>
                <div class="col-md-3">
                    <h5 class="text-white mb-3"><fmt:message key="footer.information"/></h5>
                    <p><a href="#" class="text-light"><fmt:message key="footer.rules"/></a></p>
                    <p><a href="#" class="text-light"><fmt:message key="footer.dispute"/></a></p>
                    <p><a href="#" class="text-light"><fmt:message key="footer.privacy"/></a></p>
                </div>
            </div>
        </div>
    </div>
</div>
</footer>