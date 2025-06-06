package com.uef.servlet;

import com.uef.model.User;
import com.uef.dao.UserDAO;       // chỗ này phải khớp với nơi bạn đặt UserDAO.java
import com.uef.until.HashUtil;    // sửa import cho đúng package

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String matKhau = request.getParameter("mat_khau");

        try {
            User user = userDAO.findByEmail(email);
            if (user != null) {
                String hashedInput = HashUtil.sha256(matKhau);
                if (hashedInput.equalsIgnoreCase(user.getMatKhauMaHoa())) {
                     // Lưu user vào session
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                      // Redirect về trang chủ (index.html)
                    response.sendRedirect(request.getContextPath() + "/index.html");
                    return;
                } else {
                    String msg = URLEncoder.encode("Sai email hoặc mật khẩu.", StandardCharsets.UTF_8);
                    response.sendRedirect(request.getContextPath() + "/login.html?error=" + msg);
                    return;
                }
            } else {
                String msg = URLEncoder.encode("Sai email hoặc mật khẩu.", StandardCharsets.UTF_8);
                response.sendRedirect(request.getContextPath() + "/login.html?error=" + msg);
                return;
            }
        } catch (SQLException e) {
            String msg = URLEncoder.encode("Lỗi hệ thống: " + e.getMessage(), StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/login.html?error=" + msg);
        }
    }
}
