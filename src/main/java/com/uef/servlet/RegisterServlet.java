package com.uef.servlet;

import com.uef.until.DBConnection;
import com.uef.until.HashUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    private static final String INSERT_USER_SQL =
        "INSERT INTO NguoiDung (ho_ten, email, mat_khau_ma_hoa, so_dien_thoai, xac_thuc, ngon_ngu, vai_tro) " +
        "VALUES (?, ?, ?, ?, 0, 'vi', 'nguoi_tham_gia')";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String hoTen = request.getParameter("ho_ten");
        String email = request.getParameter("email");
        String matKhau = request.getParameter("mat_khau");
        String soDienThoai = request.getParameter("so_dien_thoai");

        String hashedPassword = HashUtil.sha256(matKhau);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_USER_SQL)) {

            ps.setString(1, hoTen);
            ps.setString(2, email);
            ps.setString(3, hashedPassword);
            ps.setString(4, soDienThoai);

            int row = ps.executeUpdate();
            if (row > 0) {
                // Nếu đăng ký thành công → redirect ngay về login.html?registered=success
                response.sendRedirect(request.getContextPath() + "/login.html?registered=success");
                return;
            } else {
                // Nếu không insert được, chuyển về register.html cùng thông báo lỗi
                String msg = URLEncoder.encode("Đăng ký không thành công. Vui lòng thử lại.", StandardCharsets.UTF_8);
                response.sendRedirect(request.getContextPath() + "/register.html?error=" + msg);
                return;
            }
        } catch (SQLException e) {
            String msg;
            String lower = e.getMessage().toLowerCase();
            if (lower.contains("unique") || lower.contains("duplicate")) {
                msg = URLEncoder.encode("Email đã tồn tại. Vui lòng chọn email khác.", StandardCharsets.UTF_8);
            } else {
                msg = URLEncoder.encode("Lỗi hệ thống: " + e.getMessage(), StandardCharsets.UTF_8);
            }
            response.sendRedirect(request.getContextPath() + "/register.html?error=" + msg);
        }
    }
}
