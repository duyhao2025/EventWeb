/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.model;

/**
 *
 * @author Admin
 */
import java.time.LocalDateTime;

public class HistoryItem {

    private int maSuKien;
    private String tieuDe;
    private String tenDanhMuc;
    private LocalDateTime ngayGio;
    private LocalDateTime hanDangKy;

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

    public String getTenDanhMuc() {
        return tenDanhMuc;
    }

    public void setTenDanhMuc(String tenDanhMuc) {
        this.tenDanhMuc = tenDanhMuc;
    }

    public LocalDateTime getNgayGio() {
        return ngayGio;
    }

    public void setNgayGio(LocalDateTime ngayGio) {
        this.ngayGio = ngayGio;
    }

    public LocalDateTime getHanDangKy() {
        return hanDangKy;
    }

    public void setHanDangKy(LocalDateTime hanDangKy) {
        this.hanDangKy = hanDangKy;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    private String trangThai; // ví dụ: "Đã đăng ký", "Đã hủy", …

    public HistoryItem(int maSuKien, String tieuDe, String tenDanhMuc,
            LocalDateTime ngayGio, LocalDateTime hanDangKy, String trangThai) {
        this.maSuKien = maSuKien;
        this.tieuDe = tieuDe;
        this.tenDanhMuc = tenDanhMuc;
        this.ngayGio = ngayGio;
        this.hanDangKy = hanDangKy;
        this.trangThai = trangThai;
    }
    // getters và setters...
}
