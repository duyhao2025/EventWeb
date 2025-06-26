/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.service;

/**
 *
 * @author Admin
 */
import com.uef.dao.YeuThichDAO;
import com.uef.model.SuKien;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author PC
 */
@Service
public class YeuThichServiceImpl implements YeuThichService {

    @Autowired
    private YeuThichDAO yeuThichDAO;

    @Override
    public void themYeuThich(int maNguoiDung, int maSuKien) {
        boolean daTonTai = yeuThichDAO.daYeuThich(maNguoiDung, maSuKien);
        if (daTonTai) {
            // đã từng yêu thích (nhưng có thể đã bị ẩn)
            yeuThichDAO.hienLai(maNguoiDung, maSuKien);  // cập nhật da_an = 0
        } else {
            // chưa từng yêu thích
            yeuThichDAO.themYeuThich(maNguoiDung, maSuKien);
        }
    }

    @Override
    public boolean daYeuThich(int maNguoiDung, int maSuKien) {
        return yeuThichDAO.daYeuThich(maNguoiDung, maSuKien);
    }

    @Override
    public List<SuKien> layDanhSachYeuThich(int maNguoiDung) {
        return yeuThichDAO.layDanhSachYeuThich(maNguoiDung);
    }

    @Override
    public void xoaYeuThich(int maNguoiDung, int maSuKien) {
        yeuThichDAO.xoaYeuThich(maNguoiDung, maSuKien);
    }

    @Override
    public void anYeuThich(int maNguoiDung, int maSuKien) {
        yeuThichDAO.anYeuThich(maNguoiDung, maSuKien);
    }

    @Override
    public boolean daYeuThichHienTai(int maNguoiDung, int maSuKien) {
        return yeuThichDAO.daYeuThichHienTai(maNguoiDung, maSuKien);
    }

    @Override
    public void boYeuThich(int maNguoiDung, int maSuKien) {
        yeuThichDAO.anYeuThich(maNguoiDung, maSuKien);  // soft delete: da_an = 1
    }
}
