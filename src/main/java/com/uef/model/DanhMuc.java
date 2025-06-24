/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.model;

/**
 *
 * @author Admin
 */
public class DanhMuc {

    private Integer maDanhMuc;
    private String tenVi;
    private String tenEn;

    public DanhMuc() {
        // Default constructor
    }

    /**
     * Constructor with all fields
     */
    public DanhMuc(Integer maDanhMuc, String tenVi, String tenEn) {
        this.maDanhMuc = maDanhMuc;
        this.tenVi = tenVi;
        this.tenEn = tenEn;
    }

    // Getters and setters
    public Integer getMaDanhMuc() {
        return maDanhMuc;
    }

    public void setMaDanhMuc(Integer maDanhMuc) {
        this.maDanhMuc = maDanhMuc;
    }

    public String getTenVi() {
        return tenVi;
    }

    public void setTenVi(String tenVi) {
        this.tenVi = tenVi;
    }

    public String getTenEn() {
        return tenEn;
    }

    public void setTenEn(String tenEn) {
        this.tenEn = tenEn;
    }
}
