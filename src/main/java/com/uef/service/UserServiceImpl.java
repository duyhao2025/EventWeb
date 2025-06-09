/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.service;

import com.uef.model.User;
import com.uef.until.DBConnection;
import com.uef.until.HashUtil;

import java.sql.*;


import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    
    @Override
    public User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND mat_khau_ma_hoa = ?";
        try (
                Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, email);
            ps.setString(2, password);   // nếu đang dùng plain-text
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi đăng nhập", e);
        }
        return null;
    }

    @Override
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setMaNguoiDung(rs.getInt("ma_nguoi_dung"));
                    u.setHoTen(rs.getString("ho_ten"));
                    u.setEmail(rs.getString("email"));
                    u.setMatKhauMaHoa(rs.getString("mat_khau_ma_hoa"));
                    u.setSoDienThoai(rs.getString("so_dien_thoai"));
                    u.setXacThuc(rs.getBoolean("xac_thuc"));
                    u.setNgonNgu(rs.getString("ngon_ngu"));
                    u.setVaiTro(rs.getString("vai_tro"));
                    return u;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi truy vấn findByEmail", e);
        }
        return null;
    }

    @Override
    public boolean registerUser(String hoTen, String email, String password, String soDienThoai) {
        // 1. Kiểm tra email đã tồn tại
        if (findByEmail(email) != null) {
            throw new RuntimeException("Email đã tồn tại. Vui lòng chọn email khác.");
        }

        // 2. Mã hóa mật khẩu
        String hashed = HashUtil.sha256(password);  // dùng SHA-256 bạn đã có :contentReference[oaicite:1]{index=1}

        // 3. Chèn vào DB
        String sql = """
            INSERT INTO users
              (ho_ten, email, mat_khau_ma_hoa, so_dien_thoai, xac_thuc, ngon_ngu, vai_tro)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """;
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, hoTen);
            ps.setString(2, email);
            ps.setString(3, hashed);
            ps.setString(4, soDienThoai);
            ps.setBoolean(5, false);
            ps.setString(6, "vi");
            ps.setString(7, "nguoi_tham_gia");

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi chèn user mới", e);
        }
    }


    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setMaNguoiDung(rs.getInt("ma_nguoi_dung"));
        u.setHoTen(rs.getString("ho_ten"));
        u.setEmail(rs.getString("email"));
        u.setMatKhauMaHoa(rs.getString("mat_khau_ma_hoa"));
        u.setSoDienThoai(rs.getString("so_dien_thoai"));
        return u;
    }

   

   

}
