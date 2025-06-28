/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.uef.dao;

import com.uef.model.DangKy;
import java.util.List;

/**
 *
 * @author Admin
 */
public interface DangKyDAO {

    void save(DangKy dangKy);

    List<DangKy> findBySuKienId(int suKienId);

    List<DangKy> findByUserId(int maNguoiDung);

    void updateTrangThai(int maDangKy, String trangThai);

    boolean existsByEmailAndSuKien(String email, int maSuKien);
}
