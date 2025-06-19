CREATE DATABASE WEB_EVENT
GO

USE WEB_EVENT;
GO

CREATE TABLE users  (
    ma_nguoi_dung INT PRIMARY KEY IDENTITY(1,1),
    ho_ten NVARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mat_khau_ma_hoa VARCHAR(255) NOT NULL,
    so_dien_thoai VARCHAR(20),
    xac_thuc BIT DEFAULT 0,
    ngon_ngu VARCHAR(5) DEFAULT 'vi',
    vai_tro NVARCHAR(20) CHECK (vai_tro IN ('nguoi_tham_gia', 'nguoi_to_chuc')) DEFAULT 'nguoi_tham_gia'
);


CREATE TABLE DanhMuc (
    ma_danh_muc INT PRIMARY KEY IDENTITY(1,1),
    ten_vi NVARCHAR(100) COLLATE Vietnamese_CI_AS,
    ten_en NVARCHAR(100)
);


CREATE TABLE SuKien (
    ma_su_kien INT PRIMARY KEY IDENTITY(1,1),
	ma_nguoi_dung INT,
    tieu_de NVARCHAR(200) NOT NULL,
    mo_ta NVARCHAR(MAX),
    hinh_anh VARCHAR(255),
    ngay_gio DATETIME NOT NULL,
    thoi_luong_phut INT,
    dia_diem NVARCHAR(255),
    vi_do FLOAT,
    kinh_do FLOAT,
    so_nguoi_toi_da INT,
    han_dang_ky DATETIME,
    gia_ve DECIMAL(10,2),
    ma_danh_muc INT,
    ma_nguoi_to_chuc INT,
    trang_thai VARCHAR(50) DEFAULT 'upcoming',
    thong_tin_ngan_hang VARCHAR(255),
    FOREIGN KEY (ma_danh_muc) REFERENCES DanhMuc(ma_danh_muc),
    FOREIGN KEY (ma_nguoi_dung) REFERENCES users(ma_nguoi_dung)
);


CREATE TABLE DangKy (
    ma_dang_ky INT PRIMARY KEY IDENTITY(1,1),
    ma_nguoi_dung INT,
    ma_su_kien INT,
    ngay_dang_ky DATETIME DEFAULT GETDATE(),
    ma_qr VARCHAR(255),
    da_checkin BIT DEFAULT 0,
    thoi_gian_checkin DATETIME,
    da_huy BIT DEFAULT 0,
    FOREIGN KEY (ma_nguoi_dung) REFERENCES users (ma_nguoi_dung),
    FOREIGN KEY (ma_su_kien) REFERENCES SuKien(ma_su_kien)
);


CREATE TABLE DanhGia (
	danh_gia_id INT PRIMARY KEY IDENTITY(1,1),
	ma_nguoi_dung INT,
	ma_su_kien INT,
    nguoi_dung_id INT,
    su_kien_id INT,
    diem INT CHECK (diem BETWEEN 1 AND 5),
    nhan_xet NVARCHAR(MAX),
    ngay_danh_gia DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ma_nguoi_dung) REFERENCES users(ma_nguoi_dung),
    FOREIGN KEY (ma_su_kien) REFERENCES SuKien(ma_su_kien)
);


CREATE TABLE YeuCauToChuc (
    ma_yeu_cau INT PRIMARY KEY IDENTITY(1,1),
    
	ma_nguoi_dung INT,
    ngay_yeu_cau DATETIME DEFAULT GETDATE(),
    trang_thai VARCHAR(50) DEFAULT 'pending',
    ghi_chu NVARCHAR(255),
    FOREIGN KEY (ma_nguoi_dung) REFERENCES [users](ma_nguoi_dung)
);

CREATE TABLE DiaDiemToChuc (
    ma_su_kien INT PRIMARY KEY,
    dia_chi NVARCHAR(MAX),
    FOREIGN KEY (ma_su_kien) REFERENCES SuKien(ma_su_kien)
);

CREATE TABLE NgonNguDaiDien (
    ma_nguoi_dung INT PRIMARY KEY,
    ngon_ngu NVARCHAR(10) CHECK (ngon_ngu IN ('vi', 'en')) DEFAULT 'vi',
    FOREIGN KEY (ma_nguoi_dung) REFERENCES users(ma_nguoi_dung)

);
INSERT INTO DanhMuc(ten_vi, ten_en) VALUES
  (N'Hội thảo',            'Conference'),
  (N'Workshop',            'Workshop'),
  (N'Cuộc thi',            'Competition'),
  (N'Triển lãm',           'Exhibition'),
  (N'Hội thảo trực tuyến',  'Webinar'),
  (N'Buổi giao lưu',       'Networking Event'),
  (N'Buổi hòa nhạc',       'Concert'),
  (N'Khóa học ngắn hạn',    'Short Course');
