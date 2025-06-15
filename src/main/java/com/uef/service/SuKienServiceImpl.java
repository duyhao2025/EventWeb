package com.uef.service;

import com.uef.model.SuKien;
import com.uef.until.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class SuKienServiceImpl implements SuKienService {

    @Override
    public int themSuKien(SuKien suKien) {
        String sql = "INSERT INTO SuKien (tieu_de, mo_ta, dia_diem, ma_nguoi_dung, ngay_gio, trang_thai) "
                + "OUTPUT INSERTED.ma_su_kien "
                + "VALUES (?, ?, ?, ?, GETDATE(), 'upcoming')";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, suKien.getTieuDe());
            stmt.setString(2, suKien.getMoTa());
            stmt.setString(3, suKien.getDiaDiem());
            stmt.setInt(4, suKien.getMaNguoiDung());

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("ma_su_kien");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    @Override
    public List<SuKien> layTatCaSuKien() {
        List<SuKien> ds = new ArrayList<>();
        String sql = "SELECT * FROM SuKien ORDER BY ngay_gio DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                SuKien sk = new SuKien();
                sk.setMaSuKien(rs.getInt("ma_su_kien"));
                sk.setTieuDe(rs.getString("tieu_de"));
                sk.setMoTa(rs.getString("mo_ta"));
                sk.setDiaDiem(rs.getString("dia_diem"));
                sk.setTrangThai(rs.getString("trang_thai"));
                Timestamp timestamp = rs.getTimestamp("ngay_gio");
                if (timestamp != null) {
                    sk.setNgayGio(timestamp.toLocalDateTime());
                }
                ds.add(sk);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return ds;
    }

    @Override
    public List<SuKien> timKiemSuKien(String tuKhoa, String diaDiem) {
        List<SuKien> ds = new ArrayList<>();
        String sql = "SELECT * FROM SuKien WHERE LOWER(tieu_de) LIKE ? AND LOWER(dia_diem) LIKE ? ORDER BY ngay_gio DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + tuKhoa.toLowerCase() + "%");
            stmt.setString(2, "%" + diaDiem.toLowerCase() + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    SuKien sk = new SuKien();
                    sk.setMaSuKien(rs.getInt("ma_su_kien"));
                    sk.setTieuDe(rs.getString("tieu_de"));
                    sk.setMoTa(rs.getString("mo_ta"));
                    sk.setDiaDiem(rs.getString("dia_diem"));
                    sk.setTrangThai(rs.getString("trang_thai"));
                    Timestamp timestamp = rs.getTimestamp("ngay_gio");
                    if (timestamp != null) {
                        sk.setNgayGio(timestamp.toLocalDateTime());
                    }
                    ds.add(sk);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return ds;
    }

    @Override
    public void themDanhMucChoSuKien(int maSuKien, int maDanhMuc) {
        String sql = "INSERT INTO SuKien_DanhMuc (ma_su_kien, ma_danh_muc) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, maSuKien);
            stmt.setInt(2, maDanhMuc);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
