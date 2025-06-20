/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author Admin
 */
public class SuKien {

    private Integer maSuKien;
    private Integer maNguoiDung;
    private String tieuDe;
    private String moTa;
    private String hinhAnh;
    private LocalDateTime ngayGio;
    private Integer thoiLuongPhut;
    private String diaDiem;
    private Double viDo;
    private Double kinhDo;
    private Integer soNguoiToiDa;
    private LocalDateTime hanDangKy;
    private BigDecimal giaVe;
    private Integer maDanhMuc;
    private Integer maNguoiToChuc;
    private String trangThai;
    private String thongTinNganHang;
    private String tenDanhMuc;
    private String creatorEmail;
    private Integer soLuongThamGia;
    private Double saoTrungBinh;
    private boolean daDanhGia;
    private boolean chuaDienRa;
    private String ngayGioHienThi;
    private LocalDate ngayToChuc;

    public String getNgayGioHienThi() {
        return ngayGioHienThi;
    }

    public void setNgayGioHienThi(String ngayGioHienThi) {
        this.ngayGioHienThi = ngayGioHienThi;
    }

    public LocalDate getNgayToChuc() {
        return ngayToChuc;
    }

    public void setNgayToChuc(LocalDate ngayToChuc) {
        this.ngayToChuc = ngayToChuc;
    }

    public boolean isDaDanhGia() {
        return daDanhGia;
    }

    public void setDaDanhGia(boolean daDanhGia) {
        this.daDanhGia = daDanhGia;
    }

    public boolean isChuaDienRa() {
        return chuaDienRa;
    }

    public void setChuaDienRa(boolean chuaDienRa) {
        this.chuaDienRa = chuaDienRa;
    }

    public Integer getSoLuongThamGia() {
        return soLuongThamGia;
    }

    public void setSoLuongThamGia(Integer soLuongThamGia) {
        this.soLuongThamGia = soLuongThamGia;
    }

    public Double getSaoTrungBinh() {
        return saoTrungBinh;
    }

    public void setSaoTrungBinh(Double saoTrungBinh) {
        this.saoTrungBinh = saoTrungBinh;
    }

    public String getCreatorEmail() {
        return creatorEmail;
    }

    public void setCreatorEmail(String creatorEmail) {
        this.creatorEmail = creatorEmail;
    }

    public String getTenDanhMuc() {
        return tenDanhMuc;
    }

    public void setTenDanhMuc(String tenDanhMuc) {
        this.tenDanhMuc = tenDanhMuc;
    }

    public Integer getMaSuKien() {
        return maSuKien;
    }

    public void setMaSuKien(Integer maSuKien) {
        this.maSuKien = maSuKien;
    }

    public Integer getMaNguoiDung() {
        return maNguoiDung;
    }

    public void setMaNguoiDung(Integer maNguoiDung) {
        this.maNguoiDung = maNguoiDung;
    }

    public String getTieuDe() {
        return tieuDe;
    }

    public void setTieuDe(String tieuDe) {
        this.tieuDe = tieuDe;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

    public LocalDateTime getNgayGio() {
        return ngayGio;
    }

    public void setNgayGio(LocalDateTime ngayGio) {
        this.ngayGio = ngayGio;
    }

    public Integer getThoiLuongPhut() {
        return thoiLuongPhut;
    }

    public void setThoiLuongPhut(Integer thoiLuongPhut) {
        this.thoiLuongPhut = thoiLuongPhut;
    }

    public String getDiaDiem() {
        return diaDiem;
    }

    public void setDiaDiem(String diaDiem) {
        this.diaDiem = diaDiem;
    }

    public Double getViDo() {
        return viDo;
    }

    public void setViDo(Double viDo) {
        this.viDo = viDo;
    }

    public Double getKinhDo() {
        return kinhDo;
    }

    public void setKinhDo(Double kinhDo) {
        this.kinhDo = kinhDo;
    }

    public Integer getSoNguoiToiDa() {
        return soNguoiToiDa;
    }

    public void setSoNguoiToiDa(Integer soNguoiToiDa) {
        this.soNguoiToiDa = soNguoiToiDa;
    }

    public LocalDateTime getHanDangKy() {
        return hanDangKy;
    }

    public void setHanDangKy(LocalDateTime hanDangKy) {
        this.hanDangKy = hanDangKy;
    }

    public BigDecimal getGiaVe() {
        return giaVe;
    }

    public void setGiaVe(BigDecimal giaVe) {
        this.giaVe = giaVe;
    }

    public Integer getMaDanhMuc() {
        return maDanhMuc;
    }

    public void setMaDanhMuc(Integer maDanhMuc) {
        this.maDanhMuc = maDanhMuc;
    }

    public Integer getMaNguoiToChuc() {
        return maNguoiToChuc;
    }

    public void setMaNguoiToChuc(Integer maNguoiToChuc) {
        this.maNguoiToChuc = maNguoiToChuc;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getThongTinNganHang() {
        return thongTinNganHang;
    }

    public void setThongTinNganHang(String thongTinNganHang) {
        this.thongTinNganHang = thongTinNganHang;
    }

    public SuKien() {
        // Default constructor
    }

}
