/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.uef.model.SuKien;
import com.uef.until.DBConnection;
import org.springframework.stereotype.Repository;

/**
 *
 * @author PC
 */
@Repository
public class YeuThichDAOImpl implements YeuThichDAO {

    @Override
    public void themYeuThich(int maNguoiDung, int maSuKien) {
        String checkSql = "SELECT da_an FROM YeuThich WHERE ma_nguoi_dung = ? AND ma_su_kien = ?";
        String insertSql = "INSERT INTO YeuThich (ma_nguoi_dung, ma_su_kien, da_an) VALUES (?, ?, 0)";
        String updateSql = "UPDATE YeuThich SET da_an = 0 WHERE ma_nguoi_dung = ? AND ma_su_kien = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setInt(1, maNguoiDung);
            checkStmt.setInt(2, maSuKien);

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    // Bản ghi đã tồn tại, cập nhật lại da_an = 0
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, maNguoiDung);
                        updateStmt.setInt(2, maSuKien);
                        updateStmt.executeUpdate();
                    }
                } else {
                    // Chưa từng yêu thích → insert mới
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setInt(1, maNguoiDung);
                        insertStmt.setInt(2, maSuKien);
                        insertStmt.executeUpdate();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean daYeuThich(int maNguoiDung, int maSuKien) {
        String sql = "SELECT COUNT(*) FROM YeuThich WHERE ma_nguoi_dung = ? AND ma_su_kien = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, maNguoiDung);
            stmt.setInt(2, maSuKien);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void anYeuThich(int maNguoiDung, int maSuKien) {
        String sql = "UPDATE YeuThich SET da_an = 1 WHERE ma_nguoi_dung = ? AND ma_su_kien = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, maNguoiDung);
            stmt.setInt(2, maSuKien);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Chỉ dùng trong trường hợp đặc biệt – KHÔNG dùng trong luồng logic thông
     * thường. Đã thay thế bằng phương thức anYeuThich().
     */
    @Override
    public void xoaYeuThich(int maNguoiDung, int maSuKien) {
        String sql = "DELETE FROM YeuThich WHERE ma_nguoi_dung = ? AND ma_su_kien = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, maNguoiDung);
            stmt.setInt(2, maSuKien);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<SuKien> layDanhSachYeuThich(int maNguoiDung) {
        List<SuKien> list = new ArrayList<>();
        String sql = """
    SELECT s.*
    FROM SuKien s
    JOIN YeuThich y ON s.ma_su_kien = y.ma_su_kien
    WHERE y.ma_nguoi_dung = ? AND y.da_an = 0
""";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, maNguoiDung);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    SuKien sk = new SuKien();
                    sk.setMaSuKien(rs.getInt("ma_su_kien"));
                    sk.setTieuDe(rs.getString("tieu_de"));
                    sk.setMoTa(rs.getString("mo_ta"));
                    sk.setHinhAnh(rs.getString("hinh_anh"));
                    sk.setNgayGio(rs.getTimestamp("ngay_gio").toLocalDateTime());
                    sk.setThoiLuongPhut(rs.getInt("thoi_luong_phut"));
                    sk.setDiaDiem(rs.getString("dia_diem"));
                    sk.setViDo(rs.getDouble("vi_do"));
                    sk.setKinhDo(rs.getDouble("kinh_do"));
                    sk.setSoNguoiToiDa(rs.getInt("so_nguoi_toi_da"));
                    sk.setHanDangKy(rs.getTimestamp("han_dang_ky").toLocalDateTime());
                    sk.setGiaVe(rs.getBigDecimal("gia_ve"));
                    sk.setMaDanhMuc(rs.getInt("ma_danh_muc"));
                    sk.setMaNguoiToChuc(rs.getInt("ma_nguoi_to_chuc"));
                    sk.setTrangThai(rs.getString("trang_thai"));
                    sk.setThongTinNganHang(rs.getString("thong_tin_ngan_hang"));

                    list.add(sk);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public boolean daYeuThichHienTai(int maNguoiDung, int maSuKien) {
        String sql = "SELECT COUNT(*) FROM YeuThich WHERE ma_nguoi_dung = ? AND ma_su_kien = ? AND da_an = 0";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, maNguoiDung);
            stmt.setInt(2, maSuKien);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void hienLai(int maNguoiDung, int maSuKien) {
        String sql = "UPDATE YeuThich SET da_an = 0 WHERE ma_nguoi_dung = ? AND ma_su_kien = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, maNguoiDung);
            stmt.setInt(2, maSuKien);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
