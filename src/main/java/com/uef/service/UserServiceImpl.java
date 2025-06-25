/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.service;

import com.uef.model.User;
import com.uef.until.DBConnection;
import com.uef.until.HashUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    private static final List<User> userList = new ArrayList<>();

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

    @Override
    public User checkLogin(String email, String pass) {
        String sql = "SELECT * FROM users WHERE email = ? AND mat_khau_ma_hoa = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{email, pass},
                    new BeanPropertyRowMapper<>(User.class));
        } catch (EmptyResultDataAccessException e) {
            return null; // Không tìm thấy user → trả null
        }
    }

    @Override
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE ma_nguoi_dung=?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper<>(User.class));
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

    @Override
    public void eventRegisterUser(String hoTen, String email, String password, String soDienThoai) {
        email = email.trim().toLowerCase();
        User existing = findByEmail(email);
        if (existing != null) {
            System.out.println("User đã tồn tại, không cần thêm.");
            return; // hoặc update thông tin nếu muốn
        }

        User user = new User();
        user.setHoTen(hoTen);
        user.setEmail(email);
        user.setMatKhauMaHoa(HashUtil.sha256(password));
        user.setVaiTro("");
        user.setXacThuc(false);
        user.setNgonNgu("vi");

        userList.add(user);
    }

    @Override
    public void save(User user) {
        userList.add(user);
    }

    @Override
    public List<User> getAllUsers() {
        return userList;
    }

    @Override
    public int countRegisteredUsers() {
        return userList.size();
    }

    @Override
    public void saveEventRegistration(String email, String fullName, String phone, String code) {
        System.out.println("Đăng ký mới: " + fullName + " | " + email + " | " + phone + " | Mã: " + code);
    }

    @Override
    public void updateUser(User user) {
        String sql = "UPDATE users SET ho_ten=?, email=?, so_dien_thoai=?, ngon_ngu=? WHERE ma_nguoi_dung=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getHoTen());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getSoDienThoai());
            stmt.setString(4, user.getNgonNgu());
            stmt.setInt(5, user.getMaNguoiDung());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE ma_nguoi_dung=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User u = new User();
                u.setMaNguoiDung(rs.getInt("ma_nguoi_dung"));
                u.setHoTen(rs.getString("ho_ten"));
                u.setEmail(rs.getString("email"));
                u.setSoDienThoai(rs.getString("so_dien_thoai"));
                u.setNgonNgu(rs.getString("ngon_ngu"));
                return u;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateLanguage(int maNguoiDung, String lang) {
        String sql = "UPDATE NgonNguDaiDien SET ngon_ngu = ? WHERE ma_nguoi_dung = ?";
        jdbcTemplate.update(sql, lang, maNguoiDung);
    }

}
