/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.dao;

/**
 *
 * @author Admin
 */
import com.uef.model.SuKien;
import com.uef.until.DBConnection;
import org.springframework.stereotype.Repository;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class SuKienDAOImpl implements SuKienDAO {

    @Override
    public void insert(SuKien e) throws Exception {
        String sql = "INSERT INTO SuKien( ma_nguoi_dung, tieu_de, mo_ta, hinh_anh, ngay_gio, thoi_luong_phut, dia_diem, so_nguoi_toi_da, han_dang_ky, gia_ve, ma_danh_muc, ma_nguoi_to_chuc ) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, e.getMaNguoiDung());
            ps.setString(2, e.getTieuDe());
            ps.setString(3, e.getMoTa());
            ps.setString(4, e.getHinhAnh());
            ps.setTimestamp(5, Timestamp.valueOf(e.getNgayGio()));
            ps.setInt(6, e.getThoiLuongPhut());
            ps.setString(7, e.getDiaDiem());
            ps.setInt(8, e.getSoNguoiToiDa());
            ps.setTimestamp(9, Timestamp.valueOf(e.getHanDangKy()));
            ps.setBigDecimal(10, e.getGiaVe());
            ps.setInt(11, e.getMaDanhMuc());
            ps.setInt(12, e.getMaNguoiToChuc());
            ps.executeUpdate();
        }
    }


        @Override
        public List<SuKien> findAll() throws Exception {
            List<SuKien> list = new ArrayList<>();
            String sql = "SELECT ma_su_kien, tieu_de, mo_ta, hinh_anh, ngay_gio, han_dang_ky, "
                    + "thoi_luong_phut, so_nguoi_toi_da, dia_diem, ma_danh_muc, ma_nguoi_to_chuc "
                    + "FROM SuKien ORDER BY ngay_gio DESC";
            try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SuKien e = new SuKien();
                    e.setMaSuKien(rs.getInt("ma_su_kien"));
                    e.setTieuDe(rs.getString("tieu_de"));
                    e.setMoTa(rs.getString("mo_ta"));
                    e.setHinhAnh(rs.getString("hinh_anh"));
                    e.setNgayGio(rs.getTimestamp("ngay_gio").toLocalDateTime());
                    e.setHanDangKy(rs.getTimestamp("han_dang_ky").toLocalDateTime());
                    e.setThoiLuongPhut(rs.getInt("thoi_luong_phut"));
                    e.setSoNguoiToiDa(rs.getInt("so_nguoi_toi_da"));
                    e.setDiaDiem(rs.getString("dia_diem"));
                    e.setMaDanhMuc(rs.getInt("ma_danh_muc"));
                    e.setMaNguoiToChuc(rs.getInt("ma_nguoi_to_chuc"));
                    list.add(e);
                }
            }
            return list;
        }
    }

