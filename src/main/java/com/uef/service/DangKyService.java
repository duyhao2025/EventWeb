/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.uef.service;

import com.uef.model.DangKy;
import com.uef.model.SuKien;
import java.util.List;

/**
 *
 * @author Admin
 */
public interface DangKyService {

    void huyDangKy(int maNguoiDung, int maSuKien);

    SuKien getSuKienById(int maSuKien);

    public List<SuKien> getLichSuThamGia(int maNguoiDung);

    void dangKySuKien(DangKy dangKy);

    List<DangKy> layDanhSachDangKyTheoSuKien(int maSuKien);
}
