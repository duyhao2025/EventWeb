/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author Admin
 */
public class SuKien {

    private int maSuKien;
    private String tieuDe;
    private LocalDateTime ngayGio;
    private String trangThai;
    private boolean daDanhGia;
    private boolean chuaDienRa;

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
    
    public boolean isChuaDienRa() {
    return chuaDienRa;
    }

    public void setChuaDienRa(boolean chuaDienRa) {
    this.chuaDienRa = chuaDienRa;
    }
    
    public LocalDate getNgayToChuc() {
    return this.ngayGio != null ? this.ngayGio.toLocalDate() : null;
    }
    
    
}


