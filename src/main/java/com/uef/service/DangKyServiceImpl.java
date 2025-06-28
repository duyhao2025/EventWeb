/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.service;

import com.uef.dao.DangKyDAO;
import com.uef.model.DangKy;
import com.uef.model.SuKien;
import com.uef.until.DBConnection;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Admin
 */
@Service
public class DangKyServiceImpl implements DangKyService {

    private final DangKyDAO dangKyDAO;

    @Autowired
    public DangKyServiceImpl(DangKyDAO dangKyDAO) {
        this.dangKyDAO = dangKyDAO;
    }

    @Override
    public List<SuKien> getLichSuThamGia(int maNguoiDung) {
        String sql = """
            SELECT 
              s.ma_su_kien,
              s.tieu_de,
              d.ten_vi        AS tenDanhMuc,
              s.ngay_gio,
              s.han_dang_ky,
              dk.trang_thai
            FROM DangKy dk
            JOIN SuKien s ON dk.ma_su_kien = s.ma_su_kien
            LEFT JOIN DanhMuc d ON s.ma_danh_muc = d.ma_danh_muc
            WHERE dk.ma_nguoi_dung = ?
            ORDER BY s.ngay_gio DESC
        """;

        List<SuKien> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maNguoiDung);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SuKien sk = new SuKien();
                    sk.setMaSuKien(rs.getInt("ma_su_kien"));
                    sk.setTieuDe(rs.getString("tieu_de"));
                    sk.setTenDanhMuc(rs.getString("tenDanhMuc"));
                    sk.setNgayGio(rs.getTimestamp("ngay_gio").toLocalDateTime());
                    sk.setHanDangKy(rs.getTimestamp("han_dang_ky").toLocalDateTime());
                    sk.setTrangThai(rs.getString("trang_thai"));
                    list.add(sk);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy lịch sử tham gia", e);
        }
        return list;
    }

    @Override
    public void huyDangKy(int maNguoiDung, int maSuKien) {
        List<DangKy> regs = dangKyDAO.findByUserId(maNguoiDung);
        for (DangKy dk : regs) {
            if (dk.getMaSuKien() == maSuKien) {
                capNhatTrangThai(dk.getMaDangKy(), "Đã hủy");
                return;
            }
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

    @Override
    public void dangKySuKien(DangKy dangKy) {
        if (dangKyDAO.existsByEmailAndSuKien(dangKy.getEmail(), dangKy.getMaSuKien())) {
            throw new RuntimeException("Email này đã đăng ký sự kiện rồi.");
        }
        dangKyDAO.save(dangKy);
    }

    @Override
    public List<DangKy> layDanhSachDangKyTheoSuKien(int maSuKien) {
        return dangKyDAO.findBySuKienId(maSuKien);
    }

    @Override
    public List<DangKy> getRegistrationsByUser(int maNguoiDung) {
        return dangKyDAO.findByUserId(maNguoiDung);
    }

    @Override
    public void capNhatTrangThai(int maDangKy, String trangThai) {
        try {
            dangKyDAO.updateTrangThai(maDangKy, trangThai);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi cập nhật trạng thái", e);
        }
    }
}
