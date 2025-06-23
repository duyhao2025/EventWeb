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
    public List<SuKien> getAll() throws Exception {
        String sql = """
        SELECT 
          s.*,
          d.ten_vi     AS tenDanhMuc,
          u.email      AS creatorEmail
        FROM SuKien s
        LEFT JOIN DanhMuc d
          ON s.ma_danh_muc = d.ma_danh_muc
        LEFT JOIN users u
          ON s.ma_nguoi_to_chuc = u.ma_nguoi_dung
        ORDER BY s.ngay_gio DESC
        """;

        List<SuKien> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SuKien e = new SuKien();
                e.setMaSuKien(rs.getInt("ma_su_kien"));
                e.setTieuDe(rs.getString("tieu_de"));
                e.setMoTa(rs.getString("mo_ta"));
                e.setHinhAnh(rs.getString("hinh_anh"));

                Timestamp tsNgayGio = rs.getTimestamp("ngay_gio");
                e.setNgayGio(tsNgayGio != null ? tsNgayGio.toLocalDateTime() : null);

                Timestamp tsHanDangKy = rs.getTimestamp("han_dang_ky");
                e.setHanDangKy(tsHanDangKy != null ? tsHanDangKy.toLocalDateTime() : null);

                e.setThoiLuongPhut(rs.getInt("thoi_luong_phut"));
                e.setSoNguoiToiDa(rs.getInt("so_nguoi_toi_da"));
                e.setDiaDiem(rs.getString("dia_diem"));
                e.setMaDanhMuc(rs.getInt("ma_danh_muc"));

                // map tên danh mục
                e.setTenDanhMuc(rs.getString("tenDanhMuc"));
                // map email creator
                e.setCreatorEmail(rs.getString("creatorEmail"));
                // map organizer id (nếu cần)
                e.setMaNguoiToChuc(rs.getInt("ma_nguoi_to_chuc"));

                list.add(e);
            }
        }
        return list;
    }

    @Override
    public SuKien findById(int id) {
        String sql = """
            SELECT 
              s.*,
              d.ten_vi     AS tenDanhMuc,
              u.email      AS creatorEmail
            FROM SuKien s
            LEFT JOIN DanhMuc d ON s.ma_danh_muc = d.ma_danh_muc
            LEFT JOIN users u ON s.ma_nguoi_to_chuc = u.ma_nguoi_dung
            WHERE s.ma_su_kien = ?
            """;
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi findById SuKien", e);
        }
        return null;
    }

    @Override
    public void update(SuKien sk) {
        String sql = """
            UPDATE SuKien SET
              tieu_de=?, mo_ta=?, ngay_gio=?, han_dang_ky=?,
              thoi_luong_phut=?, so_nguoi_toi_da=?, dia_diem=?, ma_danh_muc=?
            WHERE ma_su_kien=?
            """;
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, sk.getTieuDe());
            ps.setString(2, sk.getMoTa());
            ps.setTimestamp(3, Timestamp.valueOf(sk.getNgayGio()));
            ps.setTimestamp(4, Timestamp.valueOf(sk.getHanDangKy()));
            ps.setInt(5, sk.getThoiLuongPhut());
            ps.setInt(6, sk.getSoNguoiToiDa());
            ps.setString(7, sk.getDiaDiem());
            ps.setInt(8, sk.getMaDanhMuc());
            ps.setInt(9, sk.getMaSuKien());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi update SuKien", e);
        }
    }

    @Override
    public void deleteById(int id) {
        String sql = "DELETE FROM SuKien WHERE ma_su_kien = ?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi deleteById SuKien", e);
        }
    }

    private SuKien mapRow(ResultSet rs) throws SQLException {
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
        e.setTenDanhMuc(rs.getString("tenDanhMuc"));        // từ DanhMuc
        e.setMaNguoiToChuc(rs.getInt("ma_nguoi_to_chuc"));
        e.setCreatorEmail(rs.getString("creatorEmail"));    // từ users
        return e;
    }

    @Override
    public List<SuKien> searchByTitle(String keyword) {
        List<SuKien> list = new ArrayList<>();
        String sql = """
        SELECT s.*, d.ten_vi AS tenDanhMuc, u.email AS creatorEmail
        FROM SuKien s
        JOIN DanhMuc d ON s.ma_danh_muc = d.ma_danh_muc
        LEFT JOIN users u ON s.ma_nguoi_to_chuc = u.ma_nguoi_dung
        WHERE s.tieu_de LIKE ?
        ORDER BY s.ngay_gio DESC
    """;

        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SuKien e = mapRow(rs);
                    list.add(e);
                }
            }

        } catch (Exception e) {
            throw new RuntimeException("Lỗi tìm kiếm tiêu đề sự kiện", e);
        }

        return list;
    }

    @Override
    public List<SuKien> getThongKeSuKienToChuc(int maNguoiToChuc) {
        List<SuKien> list = new ArrayList<>();
        String sql = 
    "SELECT s.ma_su_kien, s.tieu_de, " +
    "COUNT(DISTINCT d.ma_dang_ky) AS so_luong_tham_gia, " +
    "AVG(CAST(g.diem AS FLOAT)) AS sao_trung_binh " +
    "FROM SuKien s " +
    "LEFT JOIN DangKy d ON d.ma_su_kien = s.ma_su_kien " +
    "LEFT JOIN DanhGia g ON g.ma_su_kien = s.ma_su_kien " +
    "WHERE s.ma_nguoi_to_chuc = ? " +
    "GROUP BY s.ma_su_kien, s.tieu_de";

        try (Connection conn = DBConnection.getConnection(); 
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maNguoiToChuc);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SuKien e = new SuKien();
                e.setMaSuKien(rs.getInt("ma_su_kien"));
                e.setTieuDe(rs.getString("tieu_de"));
                e.setSoLuongThamGia(rs.getInt("so_luong_tham_gia"));
                e.setSaoTrungBinh(rs.getDouble("sao_trung_binh"));
                list.add(e);
            }

        } catch (Exception e) {
            throw new RuntimeException("Lỗi thống kê sự kiện", e);
        }
        return list;
    }
}
