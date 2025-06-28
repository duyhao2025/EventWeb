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
        return jdbcTemplate.query(sql, new Object[]{maNguoiDung}, rowMapper());
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
        return jdbcTemplate.query(sql, new Object[]{suKienId}, rowMapper());
    }

    @Override
    public void updateTrangThai(int maDangKy, String trangThai) {
        String sql = "UPDATE DangKy SET trang_thai = ? WHERE ma_dang_ky = ?";
        jdbcTemplate.update(sql, trangThai, maDangKy);
    }

    private RowMapper<DangKy> rowMapper() {
        return (ResultSet rs, int rowNum) -> {
            DangKy dk = new DangKy();
            dk.setMaDangKy(rs.getInt("ma_dang_ky"));
            dk.setMaNguoiDung(rs.getInt("ma_nguoi_dung"));
            dk.setMaSuKien(rs.getInt("ma_su_kien"));
            dk.setHoTen(rs.getString("ho_ten"));
            dk.setEmail(rs.getString("email"));
            dk.setSoDienThoai(rs.getString("so_dien_thoai"));
            dk.setTrangThai(rs.getString("trang_thai"));
            return dk;
        };
    }

    @Override
    public boolean existsByEmailAndSuKien(String email, int maSuKien) {
        String sql = "SELECT COUNT(*) FROM DangKy WHERE email = ? AND ma_su_kien = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email, maSuKien);
        return count != null && count > 0;
    }
}
