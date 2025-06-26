/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.uef.service;

import com.uef.model.SuKien;
import java.util.List;

/**
 *
 * @author PC
 */
public interface YeuThichService {

    void themYeuThich(int maNguoiDung, int maSuKien);

    boolean daYeuThich(int maNguoiDung, int maSuKien);

    List<SuKien> layDanhSachYeuThich(int maNguoiDung);

    void xoaYeuThich(int maNguoiDung, int maSuKien);

    void anYeuThich(int maNguoiDung, int maSuKien);

    void boYeuThich(int maNguoiDung, int maSuKien);

    boolean daYeuThichHienTai(int maNguoiDung, int maSuKien);
}
