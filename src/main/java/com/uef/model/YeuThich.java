/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.model;

import java.sql.Timestamp;

/**
 *
 * @author PC
 */
public class YeuThich {

    private int maNguoiDung;
    private int maSuKien;
    private Timestamp ngayYeuThich;


    public YeuThich() {
    }

    public YeuThich(int maNguoiDung, int maSuKien, Timestamp ngayYeuThich) {
        this.maNguoiDung = maNguoiDung;
        this.maSuKien = maSuKien;
        this.ngayYeuThich = ngayYeuThich;
    }

    public int getMaNguoiDung() {
        return maNguoiDung;
    }

    public void setMaNguoiDung(int maNguoiDung) {
        this.maNguoiDung = maNguoiDung;
    }

    public int getMaSuKien() {
        return maSuKien;
    }

    public void setMaSuKien(int maSuKien) {
        this.maSuKien = maSuKien;
    }

    public Timestamp getNgayYeuThich() {
        return ngayYeuThich;
    }

    public void setNgayYeuThich(Timestamp ngayYeuThich) {
        this.ngayYeuThich = ngayYeuThich;
    }


    
}
