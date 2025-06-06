/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.dao;

import com.uef.model.User;
import com.uef.until.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author Admin
 */
public class UserDAO {
    // Câu lệnh SQL để tìm user theo email
    private static final String FIND_BY_EMAIL_SQL =
        "SELECT ma_nguoi_dung, ho_ten, email, mat_khau_ma_hoa, so_dien_thoai, " +
        "xac_thuc, ngon_ngu, vai_tro " +
        "FROM NguoiDung WHERE email = ?";

    // Câu lệnh SQL để chèn user mới
    private static final String INSERT_SQL =
        "INSERT INTO NguoiDung (ho_ten, email, mat_khau_ma_hoa, so_dien_thoai, xac_thuc, ngon_ngu, vai_tro) " +
        "VALUES (?, ?, ?, ?, 0, ?, ?)";

    /**
     * Tìm một User theo email. Nếu không tìm thấy, trả về null.
     *
     * @param email địa chỉ email cần tìm
     * @return User object hoặc null nếu không tồn tại
     * @throws SQLException nếu có lỗi truy vấn
     */
    public User findByEmail(String email) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_EMAIL_SQL)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Lấy dữ liệu từ ResultSet và khởi tạo User object
                    int id          = rs.getInt("ma_nguoi_dung");
                    String hoTen    = rs.getString("ho_ten");
                    String e        = rs.getString("email");
                    String hash     = rs.getString("mat_khau_ma_hoa");
                    String sdt      = rs.getString("so_dien_thoai");
                    boolean xacThuc = rs.getBoolean("xac_thuc");
                    String ngonNgu  = rs.getString("ngon_ngu");
                    String vaiTro   = rs.getString("vai_tro");

                    User user = new User();
                    user.setMaNguoiDung(id);
                    user.setHoTen(hoTen);
                    user.setEmail(e);
                    user.setMatKhauMaHoa(hash);
                    user.setSoDienThoai(sdt);
                    user.setXacThuc(xacThuc);
                    user.setNgonNgu(ngonNgu);
                    user.setVaiTro(vaiTro);
                    return user;
                }
            }
        }
        return null;
    }

    /**
     * Tạo (insert) một user mới vào bảng NguoiDung.
     *
     * @param user đối tượng User đã được set đầy đủ
     * @return true nếu insert thành công, false nếu không
     * @throws SQLException nếu có lỗi truy vấn
     */
    public boolean createUser(User user) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {

            ps.setString(1, user.getHoTen());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getMatKhauMaHoa());
            ps.setString(4, user.getSoDienThoai());
            ps.setString(5, user.getNgonNgu());
            ps.setString(6, user.getVaiTro());

            int rowAffected = ps.executeUpdate();
            return rowAffected > 0;
        }
    }

    // Bạn có thể bổ sung thêm các phương thức khác khi cần:
    // - updateUser(User user)
    // - deleteUser(int maNguoiDung)
    // - findAll(), findByRole(String vaiTro), ...
}
