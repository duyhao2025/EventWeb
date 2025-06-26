/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.dao;

/**
 *
 * @author Admin
 */
import com.uef.model.DangKy;
import com.uef.until.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class DangKyDAOImpl implements DangKyDAO {

    private final JdbcTemplate jdbcTemplate;

    public DangKyDAOImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<DangKy> findByUserId(int maNguoiDung) {
        String sql = "SELECT * FROM DangKy WHERE ma_nguoi_dung = ?";
        return jdbcTemplate.query(sql, new Object[]{maNguoiDung}, (rs, rowNum) -> {
            DangKy dk = new DangKy();
            dk.setMaDangKy(rs.getInt("ma_dang_ky"));
            dk.setMaSuKien(rs.getInt("ma_su_kien"));
            dk.setMaNguoiDung(rs.getInt("ma_nguoi_dung"));
            dk.setHoTen(rs.getString("ho_ten"));
            dk.setEmail(rs.getString("email"));
            dk.setSoDienThoai(rs.getString("so_dien_thoai"));
            dk.setTrangThai(rs.getString("trang_thai"));
            return dk;
        });
    }

    @Override
    public void save(DangKy dangKy) {
        String sql = """
        INSERT INTO DangKy 
          (ho_ten, email, so_dien_thoai, ma_su_kien, ma_nguoi_dung, trang_thai) 
        VALUES (?, ?, ?, ?, ?, ?)
    """;
        jdbcTemplate.update(sql,
                dangKy.getHoTen(),
                dangKy.getEmail(),
                dangKy.getSoDienThoai(),
                dangKy.getMaSuKien(),
                dangKy.getMaNguoiDung(), // <-- thêm dòng này
                dangKy.getTrangThai());
    }

    @Override
    public List<DangKy> findBySuKienId(int suKienId) {
        String sql = "SELECT * FROM DangKy WHERE ma_su_kien = ?";
        return jdbcTemplate.query(sql, new Object[]{suKienId}, new RowMapper<DangKy>() {
            public DangKy mapRow(ResultSet rs, int rowNum) throws SQLException {
                DangKy dk = new DangKy();
                dk.setMaDangKy(rs.getInt("ma_dang_ky"));
                dk.setHoTen(rs.getString("ho_ten"));
                dk.setEmail(rs.getString("email"));
                dk.setSoDienThoai(rs.getString("so_dien_thoai"));
                dk.setTrangThai(rs.getString("trang_thai"));
                dk.setMaSuKien(rs.getInt("ma_su_kien"));
                return dk;
            }
        });
    }

    @Override
    public void updateTrangThai(int maNguoiDung, int maSuKien, String trangThai) throws Exception {
        String sql = "UPDATE DangKy SET trang_thai = ? WHERE ma_nguoi_dung = ? AND ma_su_kien = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, trangThai);
            ps.setInt(2, maNguoiDung);
            ps.setInt(3, maSuKien);
            ps.executeUpdate();
        }
    }
}
