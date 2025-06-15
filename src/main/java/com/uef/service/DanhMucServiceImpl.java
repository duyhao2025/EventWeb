package com.uef.service;

import com.uef.service.DanhMucService;
import com.uef.until.DBConnection;

import java.sql.*;
import org.springframework.stereotype.Service;

@Service
public class DanhMucServiceImpl implements DanhMucService {

    @Override
    public int getOrCreateDanhMuc(String tenDanhMuc) {
        int maDanhMuc = -1;
        String tenXuLy = tenDanhMuc.trim().toLowerCase();

        String sqlSelect = "SELECT ma_danh_muc FROM DanhMuc WHERE LOWER(ten_vi) = ?";
        String sqlInsert = "INSERT INTO DanhMuc (ten_vi) OUTPUT INSERTED.ma_danh_muc VALUES (?)";

        try (Connection conn = DBConnection.getConnection()) {

            // Bước 1: kiểm tra đã có chưa
            try (PreparedStatement stmt = conn.prepareStatement(sqlSelect)) {
                stmt.setString(1, tenXuLy);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt("ma_danh_muc"); // danh mục đã tồn tại
                }
            }

            // Bước 2: nếu chưa có thì insert mới
            try (PreparedStatement stmt = conn.prepareStatement(sqlInsert)) {
                stmt.setString(1, tenDanhMuc); // giữ nguyên định dạng chữ gốc
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    maDanhMuc = rs.getInt("ma_danh_muc");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return maDanhMuc;
    }
}
