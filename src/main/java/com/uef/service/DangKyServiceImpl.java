/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.service;

import com.uef.model.SuKien;
import com.uef.until.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class DangKyServiceImpl implements DangKyService {

    //Xem lịch sử tham gia
    @Override
    public List<SuKien> getLichSuThamGia(int maNguoiDung) {
        List<SuKien> list = new ArrayList<>();
        String sql = "SELECT s.*, "
                + "CASE WHEN dg.danh_gia_id IS NOT NULL THEN 1 ELSE 0 END AS daDanhGia "
                + "FROM DangKy dk "
                + "JOIN SuKien s ON dk.ma_su_kien = s.ma_su_kien "
                + "LEFT JOIN DanhGia dg ON dg.ma_nguoi_dung = dk.ma_nguoi_dung AND dg.ma_su_kien = dk.ma_su_kien "
                + "WHERE dk.ma_nguoi_dung = ? ORDER BY s.ngay_gio DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, maNguoiDung);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                SuKien sk = new SuKien();
                sk.setMaSuKien(rs.getInt("ma_su_kien"));
                sk.setTieuDe(rs.getString("tieu_de"));
                Timestamp ts = rs.getTimestamp("ngay_gio");
                if (ts != null) {
                    sk.setNgayGio(ts.toLocalDateTime());
                }
                sk.setTrangThai(rs.getString("trang_thai"));
               
                list.add(sk);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void huyDangKy(int maNguoiDung, int maSuKien) {
        String sql = "DELETE FROM DangKy WHERE ma_nguoi_dung = ? AND ma_su_kien = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, maNguoiDung);
            stmt.setInt(2, maSuKien);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public SuKien getSuKienById(int maSuKien) {
        String sql = "SELECT * FROM SuKien WHERE ma_su_kien = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, maSuKien);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                SuKien sk = new SuKien();
                sk.setMaSuKien(rs.getInt("ma_su_kien"));
                sk.setTieuDe(rs.getString("tieu_de"));
                Timestamp ts = rs.getTimestamp("ngay_gio");
                if (ts != null) {
                    sk.setNgayGio(ts.toLocalDateTime());
                }
                sk.setTrangThai(rs.getString("trang_thai"));
                return sk;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
