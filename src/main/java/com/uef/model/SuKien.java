/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.model;

import java.time.LocalDateTime;

/**
 *
 * @author Admin
 */
public class SuKien {

    private String diaDiem;
    private String moTa;
    private String danhMuc;
    private int maNguoiDung;
    private int maSuKien;
    private String tieuDe;
    private LocalDateTime ngayGio;
    private String trangThai;
    private boolean daDanhGia;

    public SuKien() {
    }

    public SuKien(String diaDiem, String moTa, String danhMuc, int maNguoiDung, int maSuKien, String tieuDe, LocalDateTime ngayGio, String trangThai, boolean daDanhGia) {
        this.diaDiem = diaDiem;
        this.moTa = moTa;
        this.danhMuc = danhMuc;
        this.maNguoiDung = maNguoiDung;
        this.maSuKien = maSuKien;
        this.tieuDe = tieuDe;
        this.ngayGio = ngayGio;
        this.trangThai = trangThai;
        this.daDanhGia = daDanhGia;
    }

    public String getDiaDiem() {
        return diaDiem;
    }

    public void setDiaDiem(String diaDiem) {
        this.diaDiem = diaDiem;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public String getDanhMuc() {
        return danhMuc;
    }

    public void setDanhMuc(String danhMuc) {
        this.danhMuc = danhMuc;
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

    public String getTieuDe() {
        return tieuDe;
    }

    public void setTieuDe(String tieuDe) {
        this.tieuDe = tieuDe;
    }

    public LocalDateTime getNgayGio() {
        return ngayGio;
    }

    public void setNgayGio(LocalDateTime ngayGio) {
        this.ngayGio = ngayGio;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public boolean isDaDanhGia() {
        return daDanhGia;
    }

    public void setDaDanhGia(boolean daDanhGia) {
        this.daDanhGia = daDanhGia;
    }

    @Override
    public String toString() {
        return "SuKien{" + "diaDiem=" + diaDiem + ", moTa=" + moTa + ", danhMuc=" + danhMuc + ", maNguoiDung=" + maNguoiDung + ", maSuKien=" + maSuKien + ", tieuDe=" + tieuDe + ", ngayGio=" + ngayGio + ", trangThai=" + trangThai + ", daDanhGia=" + daDanhGia + '}';
    }
    
}
