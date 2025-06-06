/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.model;

/**
 *
 * @author Admin
 */
public class User {

    // Các trường (fields) tương ứng với cột trong bảng NguoiDung
    private int maNguoiDung;
    private String hoTen;
    private String email;
    private String matKhauMaHoa; // mật khẩu đã băm (hash)
    private String soDienThoai;
    private boolean xacThuc;    // cột xac_thuc (BIT)
    private String ngonNgu;     // 'vi' hoặc 'en'
    private String vaiTro;      // 'nguoi_tham_gia' hoặc 'nguoi_to_chuc'

    public int getMaNguoiDung() {
        return maNguoiDung;
    }

    public void setMaNguoiDung(int maNguoiDung) {
        this.maNguoiDung = maNguoiDung;
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

    public String getMatKhauMaHoa() {
        return matKhauMaHoa;
    }

    public void setMatKhauMaHoa(String matKhauMaHoa) {
        this.matKhauMaHoa = matKhauMaHoa;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public boolean isXacThuc() {
        return xacThuc;
    }

    public void setXacThuc(boolean xacThuc) {
        this.xacThuc = xacThuc;
    }

    public String getNgonNgu() {
        return ngonNgu;
    }

    public void setNgonNgu(String ngonNgu) {
        this.ngonNgu = ngonNgu;
    }

    public String getVaiTro() {
        return vaiTro;
    }

    public void setVaiTro(String vaiTro) {
        this.vaiTro = vaiTro;
    }

    // Constructor không tham số (dùng khi cần khởi tạo rỗng rồi set từng trường)
    public User() {
    }

    // Constructor đầy đủ (nếu cần khởi tạo nhanh toàn bộ trường)
    public User(int maNguoiDung, String hoTen, String email, String matKhauMaHoa,
            String soDienThoai, boolean xacThuc, String ngonNgu, String vaiTro) {
        this.maNguoiDung = maNguoiDung;
        this.hoTen = hoTen;
        this.email = email;
        this.matKhauMaHoa = matKhauMaHoa;
        this.soDienThoai = soDienThoai;
        this.xacThuc = xacThuc;
        this.ngonNgu = ngonNgu;
        this.vaiTro = vaiTro;
    }

    @Override
    public String toString() {
        return "User{"
                + "maNguoiDung=" + maNguoiDung
                + ", hoTen='" + hoTen + '\''
                + ", email='" + email + '\''
                + ", soDienThoai='" + soDienThoai + '\''
                + ", xacThuc=" + xacThuc
                + ", ngonNgu='" + ngonNgu + '\''
                + ", vaiTro='" + vaiTro + '\''
                + '}';
    }
}
