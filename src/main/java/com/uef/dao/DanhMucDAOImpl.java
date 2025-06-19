/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.dao;

import com.uef.model.DanhMuc;
import com.uef.until.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Admin
 */
@Repository
public class DanhMucDAOImpl implements DanhMucDAO {
  @Override
  public List<DanhMuc> findAll() throws Exception {
    List<DanhMuc> list = new ArrayList<>();
    String sql = "SELECT ma_danh_muc, ten_vi, ten_en FROM DanhMuc";
    try (Connection c = DBConnection.getConnection();
         PreparedStatement ps = c.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
      while (rs.next()) {
        DanhMuc dm = new DanhMuc();
        dm.setMaDanhMuc(rs.getInt("ma_danh_muc"));
        dm.setTenVi(rs.getString("ten_vi"));
        dm.setTenEn(rs.getString("ten_en"));
        list.add(dm);
      }
    }
    return list;
  }
}
