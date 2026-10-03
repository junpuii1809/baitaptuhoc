-- =============================================================================
-- HỌ VÀ TÊN SINH VIÊN : QUAN KHOA CÁT TƯỜNG
-- MÃ SỐ SINH VIÊN (MSSV): 2531540215
-- MÔN HỌC              : CƠ SỞ DỮ LIỆU
-- ĐỀ TÀI CSDL          : TIỆM ĐỒ ĂN VẶT CAY CHUA TRUNG QUỐC (CAY CAY QUÁN)
-- TƯƠNG THÍCH          : MySQL / MariaDB / XAMPP
-- =============================================================================

DROP DATABASE IF EXISTS csdl_tiem_an_vat;
CREATE DATABASE IF NOT EXISTS csdl_tiem_an_vat CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE csdl_tiem_an_vat;

-- =============================================================================
-- 1. BẢNG DANH MỤC / LOẠI HÀNG
-- =============================================================================
DROP TABLE IF EXISTS DanhMuc;
CREATE TABLE DanhMuc (
    MaDM VARCHAR(10) PRIMARY KEY,
    TenDM VARCHAR(100) NOT NULL,
    MoTa TEXT,
    NgayTao DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- 2. BẢNG NHÀ CUNG CẤP NỘI ĐỊA TRUNG QUỐC
-- =============================================================================
DROP TABLE IF EXISTS NhaCungCap;
CREATE TABLE NhaCungCap (
    MaNCC VARCHAR(10) PRIMARY KEY,
    TenNCC VARCHAR(150) NOT NULL,
    XuatXu VARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(20),
    Email VARCHAR(100),
    DiaChi VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- 3. BẢNG MẶT HÀNG / SẢN PHẨM ĂN VẶT
-- =============================================================================
DROP TABLE IF EXISTS SanPham;
CREATE TABLE SanPham (
    MaSP VARCHAR(20) PRIMARY KEY,
    TenSP VARCHAR(150) NOT NULL,
    MaDM VARCHAR(10) NOT NULL,
    MaNCC VARCHAR(10) NOT NULL,
    QuyCach VARCHAR(50),
    MucDoCay INT DEFAULT 1 COMMENT '0: Khong cay, 1: Cay nhe, 2: Cay vua, 3: Cay te Tu Xuyen, 4: Sieu cay',
    DonGiaBan DECIMAL(10,2) NOT NULL,
    DonGiaNhap DECIMAL(10,2) NOT NULL,
    SoLuongTon INT DEFAULT 0,
    HinhAnh VARCHAR(255),
    HanSuDung VARCHAR(50),
    DieuKienBaoQuan VARCHAR(150),
    TrangThai TINYINT(1) DEFAULT 1 COMMENT '1: Con hang, 0: Het hang',
    NgayTao DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_sp_dm FOREIGN KEY (MaDM) REFERENCES DanhMuc(MaDM) ON UPDATE CASCADE,
    CONSTRAINT fk_sp_ncc FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- 4. BẢNG KHÁCH HÀNG
-- =============================================================================
DROP TABLE IF EXISTS KhachHang;
CREATE TABLE KhachHang (
    MaKH VARCHAR(10) PRIMARY KEY,
    HoTen VARCHAR(100) NOT NULL,
    TenDangNhap VARCHAR(50) UNIQUE,
    MatKhau VARCHAR(255),
    SoDienThoai VARCHAR(15) NOT NULL,
    Email VARCHAR(100),
    DiaChiDefault VARCHAR(255),
    DiemTichLuy INT DEFAULT 0,
    NgayTao DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- 5. BẢNG NHÂN VIÊN
-- =============================================================================
DROP TABLE IF EXISTS NhanVien;
CREATE TABLE NhanVien (
    MaNV VARCHAR(10) PRIMARY KEY,
    HoTen VARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(15) NOT NULL,
    ChucVu VARCHAR(50) NOT NULL,
    CaLamViec VARCHAR(30),
    NgayVaoLam DATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- 6. BẢNG ĐƠN HÀNG
-- =============================================================================
DROP TABLE IF EXISTS DonHang;
CREATE TABLE DonHang (
    MaDH VARCHAR(20) PRIMARY KEY,
    MaKH VARCHAR(10) NOT NULL,
    MaNV_XuLy VARCHAR(10),
    NgayDat DATETIME DEFAULT CURRENT_TIMESTAMP,
    KhungGioGiao VARCHAR(50),
    NguoiNhan VARCHAR(100) NOT NULL,
    SoDienThoaiNhan VARCHAR(15) NOT NULL,
    DiaChiGiao VARCHAR(255) NOT NULL,
    PhuongThucThanhToan VARCHAR(50) DEFAULT 'COD' COMMENT 'COD, QR_BANK, MOMO, ZALOPAY',
    TrangThaiThanhToan VARCHAR(30) DEFAULT 'ChuaThanhToan',
    TongTienHang DECIMAL(10,2) NOT NULL,
    PhiVanChuyen DECIMAL(10,2) DEFAULT 0,
    GiamGia DECIMAL(10,2) DEFAULT 0,
    TongThanhToan DECIMAL(10,2) NOT NULL,
    TrangThaiDonHang VARCHAR(50) DEFAULT 'MoiNhan' COMMENT 'MoiNhan, DangDongGoi, DangGiao, DaGiao, HuyDon',
    GhiChu TEXT,
    CONSTRAINT fk_dh_kh FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH) ON UPDATE CASCADE,
    CONSTRAINT fk_dh_nv FOREIGN KEY (MaNV_XuLy) REFERENCES NhanVien(MaNV) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- 7. BẢNG CHI TIẾT ĐƠN HÀNG
-- =============================================================================
DROP TABLE IF EXISTS ChiTietDonHang;
CREATE TABLE ChiTietDonHang (
    MaCTDH INT AUTO_INCREMENT PRIMARY KEY,
    MaDH VARCHAR(20) NOT NULL,
    MaSP VARCHAR(20) NOT NULL,
    SoLuong INT NOT NULL CHECK (SoLuong > 0),
    MucDoCayYeuCau VARCHAR(30) DEFAULT 'MacDinh',
    DonGia DECIMAL(10,2) NOT NULL,
    ThanhTien DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_ctdh_dh FOREIGN KEY (MaDH) REFERENCES DonHang(MaDH) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ctdh_sp FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- 8. BẢNG HÓA ĐƠN
-- =============================================================================
DROP TABLE IF EXISTS HoaDon;
CREATE TABLE HoaDon (
    SoHD VARCHAR(20) PRIMARY KEY,
    MaDH VARCHAR(20) NOT NULL UNIQUE,
    NgayLap DATETIME DEFAULT CURRENT_TIMESTAMP,
    TongTien DECIMAL(10,2) NOT NULL,
    HinhThucTT VARCHAR(50),
    MaSoThueTiem VARCHAR(20) DEFAULT '0318252026',
    CONSTRAINT fk_hd_dh FOREIGN KEY (MaDH) REFERENCES DonHang(MaDH) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- 9. BẢNG ĐÁNH GIÁ MÓN ĂN
-- =============================================================================
DROP TABLE IF EXISTS DanhGia;
CREATE TABLE DanhGia (
    MaDG INT AUTO_INCREMENT PRIMARY KEY,
    MaKH VARCHAR(10) NOT NULL,
    MaSP VARCHAR(20) NOT NULL,
    SoSao INT CHECK (SoSao BETWEEN 1 AND 5),
    MucDoCayThucTe VARCHAR(30),
    BinhLuan TEXT,
    NgayDanhGia DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_dg_kh FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH) ON UPDATE CASCADE,
    CONSTRAINT fk_dg_sp FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- DỮ LIỆU MẪU (INSERT SAMPLE DATA CHUẨN MENU TIỆM ĂN VẶT CAY CHUA)
-- =============================================================================

-- 1. Danh mục
INSERT INTO DanhMuc (MaDM, TenDM, MoTa) VALUES
('DM_NUOC', 'Món Nước Chua Cay', 'Các món bún, miến chua cay ăn liền và set tự sôi chuẩn vị Trùng Khánh, Liễu Châu'),
('DM_CAY', 'Đồ Ăn Vặt Cay Tê', 'Món ăn vặt tẩm ướp cay tê hoa tiêu Tứ Xuyên và thảo mộc nội địa thơm lừng'),
('DM_UONG', 'Đồ Uống Giải Cay', 'Các loại thức uống mát lạnh thanh nhiệt, giải cay tức thì'),
('DM_COMBO', 'Set Combo Tiết Kiệm', 'Các gói kết hợp các món cay chua hot trend cho cá nhân và nhóm bạn');

-- 2. Nhà cung cấp nội địa
INSERT INTO NhaCungCap (MaNCC, TenNCC, XuatXu, SoDienThoai, DiaChi) VALUES
('NCC_WL', 'Tập đoàn Thực phẩm Weilong (Vệ Long)', 'Hà Nam, Trung Quốc', '0901234567', 'Khu Công Nghiệp Tháp Hà, Hà Nam, TQ'),
('NCC_LZ', 'Xưởng Đặc sản Liễu Châu (Lý Tử Thất)', 'Quảng Tây, Trung Quốc', '0908765432', 'Thành phố Liễu Châu, Quảng Tây, TQ'),
('NCC_TK', 'Xưởng Miến Truyền Thống Trùng Khánh', 'Trùng Khánh, Trung Quốc', '0912348899', 'Khu Du lịch Cửu Long Pha, Trùng Khánh, TQ'),
('NCC_VH', 'Cơ sở Chế biến Cổ Vịt Cay Chu Đen', 'Vũ Hán, Hồ Bắc, Trung Quốc', '0933221144', 'Quận Vũ Xương, TP. Vũ Hán, TQ');

-- 3. Mặt hàng / Sản phẩm (khớp 100% hình ảnh và menu trong web_an_vat)
INSERT INTO SanPham (MaSP, TenSP, MaDM, MaNCC, QuyCach, MucDoCay, DonGiaBan, DonGiaNhap, SoLuongTon, HinhAnh, HanSuDung, DieuKienBaoQuan) VALUES
('TK-MC-01', 'Miến Chua Cay Trùng Khánh', 'DM_NUOC', 'NCC_TK', 'Hộp 142g', 3, 35000, 20000, 150, 'images/mienchua.jpg', '10 tháng', 'Nhiệt độ phòng khô ráo'),
('LZ-BO-01', 'Bún Ốc Liễu Châu (Luosifen)', 'DM_NUOC', 'NCC_LZ', 'Gói 335g', 4, 42000, 25000, 120, 'images/bunoc.jpg', '9 tháng', 'Nhiệt độ phòng khô ráo'),
('WL-CG-01', 'Chân Gà Cay Rút Xương', 'DM_CAY', 'NCC_WL', 'Túi hút chân không 100g', 3, 38000, 22000, 200, 'images/changa.jpg', '6 tháng', 'Ngăn mát hoặc nơi râm mát'),
('TX-DH-01', 'Đậu Hũ Sốt Cay Tứ Xuyên', 'DM_CAY', 'NCC_WL', 'Hộp sốt 200g', 2, 25000, 14000, 90, 'images/dauhu.jpg', '6 tháng', 'Nhiệt độ phòng thoáng mát'),
('VH-CV-01', 'Cổ Vịt Cay Vũ Hán', 'DM_CAY', 'NCC_VH', 'Hút chân không 150g', 4, 35000, 21000, 180, 'images/covit.jpg', '6 tháng', 'Nơi thoáng mát, tránh nắng'),
('WL-QC-01', 'Que Cay Tứ Xuyên (Vệ Long)', 'DM_CAY', 'NCC_WL', 'Gói dải dài 65g', 2, 15000, 8000, 300, 'images/quecay.jpg', '6 tháng', 'Nhiệt độ phòng'),
('DU-TS-01', 'Trà Sữa Trân Châu Đen', 'DM_UONG', 'NCC_WL', 'Ly 500ml', 0, 25000, 10000, 100, 'images/douong.jpg', 'Trong ngày', 'Bảo quản lạnh 4-8 độ C'),
('DU-TC-01', 'Trà Chanh Giã Tay Quảng Đông', 'DM_UONG', 'NCC_WL', 'Ly 700ml', 0, 20000, 7000, 100, 'images/drink.jpg', 'Trong ngày', 'Uống với đá lạnh'),
('CB-TK-01', 'Combo Trùng Khánh Cay Tê', 'DM_COMBO', 'NCC_TK', 'Set 3 món', 3, 85000, 49000, 50, 'images/hero.jpg', 'Theo từng món', 'Bảo quản theo từng món'),
('CB-TT-02', 'Combo Thử Thách Cực Cay', 'DM_COMBO', 'NCC_VH', 'Set 4 món siêu cay', 4, 119000, 68000, 40, 'images/ingredients.jpg', 'Theo từng món', 'Bảo quản theo từng món');

-- 4. Khách hàng
INSERT INTO KhachHang (MaKH, HoTen, TenDangNhap, MatKhau, SoDienThoai, Email, DiaChiDefault, DiemTichLuy) VALUES
('KH001', 'Nguyễn Thị Minh Thư', 'minhthu99', '123456', '0918112233', 'thu.nguyen@gmail.com', 'Số 45 Ngõ 12 Đội Cấn, Ba Đình, Hà Nội', 120),
('KH002', 'Trần Hoàng Long', 'longtran', '123456', '0987445566', 'long.tran@gmail.com', 'Tòa S2.05 Vinhomes Smart City, Nam Từ Liêm, Hà Nội', 85),
('KH003', 'Lê Khánh Linh', 'linhlinh', '123456', '0905332211', 'linh.le@gmail.com', 'Ký túc xá Đại học Quốc Gia, Cầu Giấy, Hà Nội', 210);

-- 5. Nhân viên
INSERT INTO NhanVien (MaNV, HoTen, SoDienThoai, ChucVu, CaLamViec, NgayVaoLam) VALUES
('NV01', 'Quan Khoa Cát Tường', '0988776655', 'Quản lý cửa hàng', 'Toàn thời gian', '2026-01-10'),
('NV02', 'Bùi Tuấn Tú', '0977665544', 'Nhân viên đóng gói & kho', 'Ca chiều (13h-21h)', '2026-02-15'),
('NV03', 'Hoàng Xuân Gia Bảo', '0966554433', 'Nhân viên thu ngân & trực web', 'Ca sáng (7h-15h)', '2026-03-01');

-- 6. Đơn hàng
INSERT INTO DonHang (MaDH, MaKH, MaNV_XuLy, NgayDat, KhungGioGiao, NguoiNhan, SoDienThoaiNhan, DiaChiGiao, PhuongThucThanhToan, TrangThaiThanhToan, TongTienHang, PhiVanChuyen, GiamGia, TongThanhToan, TrangThaiDonHang, GhiChu) VALUES
('DH20261001-01', 'KH001', 'NV02', '2026-10-01 10:30:00', '11h30 - 12h00', 'Nguyễn Thị Minh Thư', '0918112233', 'Số 45 Ngõ 12 Đội Cấn, Ba Đình, Hà Nội', 'MOMO', 'DaThanhToan', 98000, 15000, 10000, 103000, 'DaGiao', 'Giao đồ ăn cay tê nhiều ớt chưng'),
('DH20261002-02', 'KH003', 'NV03', '2026-10-02 15:45:00', '17h00 - 17h30', 'Lê Khánh Linh', '0905332211', 'Ký túc xá Đại học Quốc Gia, Cầu Giấy, Hà Nội', 'COD', 'ChuaThanhToan', 119000, 20000, 0, 139000, 'DangGiao', 'Xin thêm đũa ăn liền và thìa nhựa');

-- 7. Chi tiết đơn hàng
INSERT INTO ChiTietDonHang (MaDH, MaSP, SoLuong, MucDoCayYeuCau, DonGia, ThanhTien) VALUES
('DH20261001-01', 'TK-MC-01', 1, 'Cay tê nhiều', 35000, 35000),
('DH20261001-01', 'WL-CG-01', 1, 'Cay vừa', 38000, 38000),
('DH20261001-01', 'DU-TS-01', 1, 'Không cay - 50% đường', 25000, 25000),
('DH20261002-02', 'CB-TT-02', 1, 'Siêu cay cấp độ 4', 119000, 119000);

-- 8. Hóa đơn
INSERT INTO HoaDon (SoHD, MaDH, NgayLap, TongTien, HinhThucTT) VALUES
('HD20261001-01', 'DH20261001-01', '2026-10-01 11:45:00', 103000, 'MOMO Ví điện tử');

-- 9. Đánh giá
INSERT INTO DanhGia (MaKH, MaSP, SoSao, MucDoCayThucTe, BinhLuan) VALUES
('KH001', 'TK-MC-01', 5, 'Cay tê vừa miệng', 'Miến dai ngon, nước sốt chua cay Trùng Khánh đậm đà đúng chuẩn vị nội địa, sẽ ủng hộ tiếp!'),
('KH001', 'WL-CG-01', 5, 'Cay đậm vị', 'Chân gà rút xương ngâm ớt xiêm xanh giòn sần sật, ăn rất cuốn hút.');
