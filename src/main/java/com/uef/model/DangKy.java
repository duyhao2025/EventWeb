/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.model;

import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class DangKy {

    private int maDangKy;
    private String hoTen;
    private String email;
    private String soDienThoai;
    private int maNguoiDung;
    private int maSuKien;
    private Timestamp ngayDangKy;
    private String trangThai;
    private String maQr;
    private boolean daCheckin;

    public int getMaDangKy() {
        return maDangKy;
    }

    public void setMaDangKy(int maDangKy) {
        this.maDangKy = maDangKy;
    }

    public int getMaNguoiDung() {
        return maNguoiDung;
    }

    public void setMaNguoiDung(int maNguoiDung) {
        this.maNguoiDung = maNguoiDung;
    }

    public Timestamp getNgayDangKy() {
        return ngayDangKy;
    }

    public void setNgayDangKy(Timestamp ngayDangKy) {
        this.ngayDangKy = ngayDangKy;
    }

    public String getMaQr() {
        return maQr;
    }

    public void setMaQr(String maQr) {
        this.maQr = maQr;
    }

    public boolean isDaCheckin() {
        return daCheckin;
    }

    public void setDaCheckin(boolean daCheckin) {
        this.daCheckin = daCheckin;
    }

    public Timestamp getThoiGianCheckin() {
        return thoiGianCheckin;
    }

    public void setThoiGianCheckin(Timestamp thoiGianCheckin) {
        this.thoiGianCheckin = thoiGianCheckin;
    }

    public boolean isDaHuy() {
        return daHuy;
    }

    public void setDaHuy(boolean daHuy) {
        this.daHuy = daHuy;
    }
    private Timestamp thoiGianCheckin;
    private boolean daHuy;

    public DangKy() {
    }

    public DangKy(int maSuKien, String hoTen, String email, String soDienThoai, String trangThai) {
        this.maSuKien = maSuKien;
        this.hoTen = hoTen;
        this.email = email;
        this.soDienThoai = soDienThoai;
        this.trangThai = trangThai;
    }

   

    public int getMaSuKien() {
        return maSuKien;
    }

    public void setMaSuKien(int maSuKien) {
        this.maSuKien = maSuKien;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
}
