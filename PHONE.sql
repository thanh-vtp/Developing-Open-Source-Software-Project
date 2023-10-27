CREATE DATABASE PHONE;

USE PHONE;


------------------------------------------
----LOAINHANVIEN
CREATE TABLE LOAINHANVIEN
(
    MALOAINV varchar(20) not null,
    TENLOAINV nvarchar(40),
    constraint pk_lnv primary key(MALOAINV)
)

----------------------------------------
--NHANVIEN
CREATE TABLE NHANVIEN
(
    MANV varchar(20) not null,
    HOTEN nvarchar(40),
    GIOITINH nvarchar(20),
    DIACHI nvarchar(40),
    SODT varchar(20),
    NGAYSINH varchar(50),
    MALOAINV varchar(20),
    constraint pk_nv primary key(MANV)
)
GO
-- Khoa ngoai cho bang NHANVIEN
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NHANVIEN_MALOAITV FOREIGN KEY(MALOAINV) REFERENCES LOAINHANVIEN(MALOAINV)


------------------------------------------
--LOAITHANHVIEN
CREATE TABLE LOAITHANHVIEN
(
    MALOAITV varchar(20) not null,
    TENLOAITV nvarchar(40),
    constraint pk_ltv primary key(MALOAITV)
)

----------------------------------------
--THANHVIEN
CREATE TABLE THANHVIEN
(
    MATV varchar(20) not null,
    HOTEN nvarchar(40),
    GIOITINH nvarchar(20),
    SODT varchar(20),
    EMAIL nvarchar(40),
    MALOAITV varchar(20),
    username nvarchar(40),
    password nvarchar(50),
    NGAYSINH varchar(50),
    constraint pk_tv primary key(MATV)
)
GO
-- Khoa ngoai cho bang THANHVIEN
ALTER TABLE THANHVIEN ADD CONSTRAINT FK_THANHVIEN_MALOAITV FOREIGN KEY(MALOAITV) REFERENCES LOAITHANHVIEN(MALOAITV)

----------------------------------------
--VOUCHER
CREATE TABLE VOUCHER
(
    MAVOUCHER varchar(20) not null,
    TENVOUCHER nvarchar(40),
    NOIDUNG nvarchar(100),
    NGAYBD date,
    NGAYKT date,
    GIAMGIA int,
    GHICHU nvarchar(100),
    ANHDAIDIEN image,
    constraint pk_voucher primary key(MAVOUCHER)
)


----------------------------------------
--QUOCGIA
CREATE TABLE QUOCGIA
(
    MAQUOCGIA varchar(20) not null,
    TENQUOCGIA nvarchar(40),
    constraint pk_qg primary key(MAQUOCGIA)
)

CREATE TABLE LOAITHANHTOAN
(
    MALOAITT VARCHAR(20) NOT NULL,
    HINHTHUCTT NVARCHAR(20),
    CONSTRAINT PK_MA_LOAI_TT PRIMARY KEY(MALOAITT)
)

CREATE TABLE THANHTOAN
(
    MATT VARCHAR(20) NOT NULL,
    MALOAITT VARCHAR(20),
    MAVOUCHER varchar(20),
    CONSTRAINT PK_TT PRIMARY KEY(MATT)
)
ALTER TABLE THANHTOAN ADD CONSTRAINT FK_THANHTOAN_MALOAITT FOREIGN KEY(MALOAITT) REFERENCES LOAITHANHTOAN(MALOAITT)
GO
ALTER TABLE THANHTOAN ADD CONSTRAINT FK_THANHTOAN_MAVOUCHER FOREIGN KEY(MAVOUCHER) REFERENCES VOUCHER(MAVOUCHER)
GO


----------------------------------------
--BINHLUAN
CREATE TABLE BINHLUAN
(
    MABINHLUAN varchar(20) not null,
    MATHANHVIEN varchar(20),
    MASP varchar(20),
    NOIDUNG nvarchar(200),
    constraint PK_BL primary key(MABINHLUAN)
)


CREATE TABLE HANGSANXUAT
(
    MAHANGSX VARCHAR(20) NOT NULL,
    TENHANGSX VARCHAR(20),
    CONSTRAINT PK_MAHANGSX PRIMARY KEY(MAHANGSX)
)

----------------------------------------
--PHIENBAN
CREATE TABLE PHIENBAN
(
    MAPHIENBAN VARCHAR(20) NOT NULL,
    PHIENBAN NVARCHAR(20),
    CONSTRAINT PK_PHIENBAN PRIMARY KEY(MAPHIENBAN)
)
----------------------------------------
--MAUSP
CREATE TABLE MAUSAC
(
    MAMAUSAC VARCHAR(20) NOT NULL,
    TENMAUSAC NVARCHAR(20),
    CONSTRAINT PK_MAUSAC PRIMARY KEY(MAMAUSAC)
)

CREATE TABLE LOAICAUHINH
(
    MALOAICAUHINH VARCHAR(20) NOT NULL,
    MAPHIENBAN VARCHAR(20),
    MAMAUSAC VARCHAR(20),
    TENLOAICAUHINH NVARCHAR(20),
    CONSTRAINT PK_LOAICAUHINH PRIMARY KEY(MALOAICAUHINH)
)
ALTER TABLE LOAICAUHINH ADD CONSTRAINT FK_LOAICAUHINH_MAPHIENBAN FOREIGN KEY(MAPHIENBAN) REFERENCES PHIENBAN(MAPHIENBAN)
GO
ALTER TABLE LOAICAUHINH ADD CONSTRAINT FK_LOAICAUHINH_MAMAUSAC FOREIGN KEY(MAMAUSAC) REFERENCES MAUSAC(MAMAUSAC)


CREATE TABLE SOLUONGSANPHAM
(
    MASOLUONG VARCHAR(20) NOT NULL,
    SOLUONG SMALLINT,
    MALOAICAUHINH VARCHAR(20),
    TENSOLUONG NVARCHAR(20),

    CONSTRAINT PK_MASOLUONG PRIMARY KEY(MASOLUONG)
)
ALTER TABLE SOLUONGSANPHAM ADD CONSTRAINT FK_SOLUONGSANPHAM_MALOAICAUHINH FOREIGN KEY(MALOAICAUHINH) REFERENCES LOAICAUHINH(MALOAICAUHINH)


----------------------------------------
--SANPHAM
CREATE TABLE SANPHAM
(
    MASP VARCHAR(20) NOT NULL,
    TENSP NVARCHAR(20),
    ANHDAIDIEN NVARCHAR(100),
    MACAUHINH VARCHAR(20),
    MAMAUSAC VARCHAR(20),
    MOTA NVARCHAR(200),
    MASOLUONG VARCHAR(20),
    MAHANGSX VARCHAR(20),
    MAQUOCGIA VARCHAR(20),
    GIASP VARCHAR(20),
    MABINHLUAN VARCHAR(20),
    DANHGIA SMALLINT,
    CONSTRAINT PK_SANPHAM PRIMARY KEY(MASP)
)
--Khoa ngoai cho bang SANPHAM
ALTER TABLE SANPHAM ADD CONSTRAINT FK_SANPHAM_MABINHLUAN FOREIGN KEY(MABINHLUAN) REFERENCES BINHLUAN(MABINHLUAN)
GO
ALTER TABLE SANPHAM ADD CONSTRAINT FK_SANPHAM_MAQUOCGIA FOREIGN KEY(MAQUOCGIA)  REFERENCES QUOCGIA(MAQUOCGIA)
GO
ALTER TABLE SANPHAM ADD CONSTRAINT FK_SANPHAM_MAHANGSX FOREIGN KEY(MAHANGSX) REFERENCES HANGSANXUAT(MAHANGSX)
GO
ALTER TABLE SANPHAM ADD CONSTRAINT FK_SANPHAM_MASOLUONG FOREIGN KEY (MASOLUONG) REFERENCES SOLUONGSANPHAM(MASOLUONG)

CREATE TABLE CHITIETHD
(
    MACTHD varchar(20) not null,
    MANV varchar(20),
    MATV varchar(20),
    MASP varchar(20),
    SLSP INT,
    DONGIASP INT,
    MAVOUCHER varchar(20),
    constraint PK_MACTHD primary key(MACTHD)
)
-- Khoa ngoai cho bang THANHTOAN
ALTER TABLE CHITIETHD ADD CONSTRAINT FK_CHITIETHD_MANV FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV)
GO
ALTER TABLE CHITIETHD ADD CONSTRAINT FK_CHITIETHD_MATV FOREIGN KEY(MATV) REFERENCES THANHVIEN(MATV)
GO
ALTER TABLE CHITIETHD ADD CONSTRAINT FK_CHITIETHD_MASP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)
GO
ALTER TABLE CHITIETHD ADD CONSTRAINT FK_CHITIETHD_MAVOUCHER FOREIGN KEY(MAVOUCHER) REFERENCES VOUCHER(MAVOUCHER)
GO
ALTER TABLE CHITIETHD ADD CONSTRAINT CK_SLSP CHECK (SLSP > 0)
GO
ALTER TABLE CHITIETHD ADD CONSTRAINT CK_DONGIASP CHECK (DONGIASP > 0)

----------------------------------------
--HOADON
CREATE TABLE HOADON
(
    MAHD varchar(20) not null,
    TONGSL INT,
    TONGDG INT,
    MACTHD VARCHAR(20),
    constraint PK_HD primary key(MAHD)
)
GO
-- Khoa ngoai cho bang HOADON
ALTER TABLE HOADON ADD CONSTRAINT FK_HOADON_MACTHD FOREIGN KEY(MACTHD) REFERENCES CHITIETHD(MACTHD)
GO
ALTER TABLE HOADON ADD CONSTRAINT TONGSL CHECK (TONGSL > 0)
GO
ALTER TABLE HOADON ADD CONSTRAINT TONGDG CHECK (TONGDG > 0)

----------------------------------------
--BANNER
CREATE TABLE BANNER
(
    ID varchar(20) not null,
    LINK nvarchar(100),
    MASP varchar(20),
    constraint pk_banner primary key(ID)
)

GO
-- Khoa ngoai cho bang BANNER
ALTER TABLE BANNER ADD CONSTRAINT FK_BANNER_MASP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)

------------------------------------------------------------------------------------------------------------------------------
DROP DATABASE PHONE
----------------------------------------
--KHO
-- CREATE TABLE KHO
-- (
--     MAKHO INT IDENTITY(1,1) NOT NULL,
--     MASP VARCHAR(20) NOT NULL,
--     MARAM VARCHAR(20),
--     MAROM VARCHAR(20),
--     MAMAUSAC VARCHAR(20),
--     SOLUONGTRONGKHO SMALLINT,
--     MATINHTRANGHANG varchar(20),
--     CONSTRAINT PR_MA_KHO PRIMARY KEY(MAKHO)
-- )
-- --Khoa ngoai cho bang KHO
-- ALTER TABLE KHO ADD CONSTRAINT FK_MASP_KHO FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
-- GO
-- ALTER TABLE KHO ADD CONSTRAINT FK_MARAM_KHO FOREIGN KEY (MARAM) REFERENCES RAM(MARAM)
-- GO
-- ALTER TABLE KHO ADD CONSTRAINT FK_MAROM_KHO FOREIGN KEY (MAROM) REFERENCES ROM(MAROM)
-- GO
-- ALTER TABLE KHO ADD CONSTRAINT FK_MAMAUSAC_KHO FOREIGN KEY (MAMAUSAC) REFERENCES MAUSAC(MAMAUSAC)
-- GO
-- ALTER TABLE KHO ADD CONSTRAINT FK_TINHTRANG_KHO FOREIGN KEY(MATINHTRANGHANG) REFERENCES TINHTRANGHANGHOA(MATINHTRANGHANG)
-- GO
-- ALTER TABLE KHO ADD CONSTRAINT CK_SOLUONGTRONGKHO CHECK (SOLUONGTRONGKHO >= 0)



-- DROP DATABASE PHONE

-- DROP TABLE SANPHAM

-- DROP TABLE HANGSANXUAT

-- DROP TABLE HOADON


--***************************************************************************--


--Thêm dữ liệu vào các bảng
--QUOCGIA
-- INSERT INTO QUOCGIA
--     (MAQUOCGIA, TENQUOCGIA)
-- VALUES
--     ('CN', 'China'),
--     ('US', 'United States'),
--     ('VN', 'Vietnam'),
--     ('JP', 'Japan'),
--     ('IN', 'India'),
--     ('KOR', 'Korea');

-- ----------------------------------------
-- --HANGSANXUAT
-- INSERT INTO HANGSANXUAT
--     (MAHANGSX, TENHANGSX)
-- VALUES
--     ('apple', 'Apple'),
--     ('xiaomi', 'Xiaomi'),
--     ('samsung', 'Samsung'),
--     ('oppo', 'OPPO'),
--     ('vivo', 'Vivo'),
--     ('asus', 'Asus');

-- ----------------------------------------
-- --TINHTRANGHANGHOA
-- INSERT INTO TINHTRANGHANGHOA
--     (MATINHTRANGHANG, TENTINHTRANGHANG)
-- VALUES
--     ('TT001', N'Hàng còn'),
--     ('TT002', N'Hết hàng');

-- ----------------------------------------
-- --RAMSP
-- INSERT INTO RAM
--     (MARAM, KICHCO)
-- VALUES
--     ('RAM001', '4GB'),
--     ('RAM002', '6GB'),
--     ('RAM003', '8GB'),
--     ('RAM004', '12GB'),
--     ('RAM005', '16GB');

-- ----------------------------------------
-- --ROMSP
-- INSERT INTO ROM
--     (MAROM, KICHCO)
-- VALUES
--     ('ROM001', '32GB'),
--     ('ROM002', '64GB'),
--     ('ROM003', '128GB'),
--     ('ROM004', '256GB'),
--     ('ROM005', '512GB'),
--     ('ROM006', '1TB');

-- ----------------------------------------
-- --MAUSP
-- INSERT INTO MAUSAC
--     (MAMAUSAC, TENMAUSAC)
-- VALUES
--     ('M001', N'Màu Xanh'),
--     ('M002', N'Màu Đỏ'),
--     ('M003', N'Màu Tím'),
--     ('M004', N'Màu Hồng'),
--     ('M005', N'Màu Vàng'),
--     ('M006', N'Màu Trắng');

-- ----------------------------------------
-- --HEDIEUHANH
-- INSERT INTO HEDIEUHANH
--     (MAHDH, TENHDH)
-- VALUES
--     ('HDH1', 'Android'),
--     ('HDH2', 'IOS');

-- ----------------------------------------
-- --BINHLUAN
-- INSERT INTO BINHLUAN
--     (MABINHLUAN, MATHANHVIEN, MASP, NOIDUNG)
-- VALUES
--     ('BL1', 'KH01', 'SP1', N'Bình luận 1'),
--     ('BL2', 'KH01', 'SP2', N'Bình luận 2'),
--     ('BL3', 'KH01', 'SP3', N'Bình luận 3'),
--     ('BL4', 'KH01', 'SP4', N'Bình luận 4'),
--     ('BL5', 'KH01', 'SP5', N'Bình luận 5'),
--     ('BL6', 'KH01', 'SP6', N'Bình luận 6'),
--     ('BL7', 'KH01', 'SP7', N'Bình luận 7'),
--     ('BL8', 'KH01', 'SP8', N'Bình luận 8'),
--     ('BL9', 'KH01', 'SP9', N'Bình luận 9'),
--     ('BL10', 'KH01', 'SP10', N'Bình luận 10');

------------------------------------------
-- --SANPHAM
-- INSERT INTO SANPHAM
--     (MASP, TENSP, ANHDAIDIEN, MARAM, MAROM, MAHDH, MAMAUSAC, MOTA, SOLUONG, MAHANGSX, MAQUOCGIA, GIASP, MABINHLUAN, DANHGIA)
-- VALUES
--     ('SP1', N'Sản phẩm 1', 'anh1.jpg', 'RAM001', 'ROM001', 'HDH1', 'M001', N'Mô tả sản phẩm 1', 10, 'apple', 'US', '1000', 'BL1', 4),
--     ('SP2', N'Sản phẩm 2', 'anh2.jpg', 'RAM002', 'ROM002', 'HDH2', 'M002', N'Mô tả sản phẩm 2', 20, 'xiaomi', 'CN', '800', 'BL2', 4),
--     ('SP3', N'Sản phẩm 3', 'anh3.jpg', 'RAM003', 'ROM003', 'HDH1', 'M003', N'Mô tả sản phẩm 3', 15, 'samsung', 'KOR', '900', 'BL3', 5),
--     ('SP4', N'Sản phẩm 4', 'anh4.jpg', 'RAM001', 'ROM004', 'HDH2', 'M004', N'Mô tả sản phẩm 4', 5, 'oppo', 'CN', '700', 'BL4', 4),
--     ('SP5', N'Sản phẩm 5', 'anh5.jpg', 'RAM002', 'ROM003', 'HDH1', 'M005', N'Mô tả sản phẩm 5', 30, 'xiaomi', 'CN', '950', 'BL5', 4),
--     ('SP6', N'Sản phẩm 6', 'anh6.jpg', 'RAM002', 'ROM002', 'HDH2', 'M006', N'Mô tả sản phẩm 6', 8, 'asus', 'CN', '750', 'BL6', 3),
--     ('SP7', N'Sản phẩm 7', 'anh7.jpg', 'RAM004', 'ROM004', 'HDH1', 'M001', N'Mô tả sản phẩm 7', 12, 'samsung', 'KOR', '1200', 'BL7', 5),
--     ('SP8', N'Sản phẩm 8', 'anh8.jpg', 'RAM003', 'ROM003', 'HDH2', 'M002', N'Mô tả sản phẩm 8', 18, 'oppo', 'CN', '850', 'BL8', 4),
--     ('SP9', N'Sản phẩm 9', 'anh9.jpg', 'RAM002', 'ROM004', 'HDH1', 'M003', N'Mô tả sản phẩm 9', 25, 'xiaomi', 'CN', '1000', 'BL9', 4),
--     ('SP10', N'Sản phẩm 10', 'anh10.jpg', 'RAM003', 'ROM003', 'HDH2', 'M004', N'Mô tả sản phẩm 10', 15, 'apple', 'US', '1100', 'BL10', 4);


-- INSERT INTO KHO
--     (MASP, MARAM, MAROM, MAMAUSAC, SOLUONGTRONGKHO, MATINHTRANGHANG)
-- VALUES
--     ('SP1', 'RAM001', 'ROM001', 'M001', 50, 'TT001'),
--     ('SP2', 'RAM002', 'ROM002', 'M002', 30, 'TT001'),
--     ('SP3', 'RAM003', 'ROM003', 'M003', 10, 'TT001'),
--     ('SP4', 'RAM001', 'ROM004', 'M004', 15, 'TT001'),
--     ('SP5', 'RAM002', 'ROM003', 'M005', 40, 'TT001'),
--     ('SP6', 'RAM002', 'ROM002', 'M006', 20, 'TT001'),
--     ('SP7', 'RAM004', 'ROM004', 'M001', 5, 'TT002'),
--     ('SP8', 'RAM003', 'ROM003', 'M002', 25, 'TT001'),
--     ('SP9', 'RAM002', 'ROM004', 'M003', 35, 'TT001'),
--     ('SP10', 'RAM003', 'ROM003', 'M004', 8, 'TT002');



-- ----------------------------------------
-- --LOAINHANVIEN
-- INSERT INTO LOAITHANHVIEN
--     (MALOAITV, TENLOAITV)
-- VALUES
--     ('BASIC', 'Basic Membership'),
--     ('PREMIUM', 'Premium Membership'),
--     ('VIP', 'VIP Membership');


-- INSERT INTO THANHVIEN
--     (MATV, HOTEN, GIOITINH, SODT, EMAIL, MALOAITV, MAQUOCGIA, USERNAME, PASSWORD, NGAYSINH)
-- VALUES
--     ('TV1', N'Nguyễn Văn A', N'Nam', '0123456789', 'nguyenvana@email.com', 'BASIC', 'VN', 'user1', 'password1', '2000-01-01'),
--     ('TV2', N'Trần Thị B', N'Nữ', '0987654321', 'tranthib@email.com', 'PREMIUM', 'VN', 'user2', 'password2', '1995-02-15'),
--     ('TV3', N'Lê Văn C', N'Nam', '0123456789', 'levanc@email.com', 'VIP', 'VN', 'user3', 'password3', '1990-03-20'),
--     ('TV4', N'Phạm Thị D', N'Nữ', '0987654321', 'phamthid@email.com', 'BASIC', 'VN', 'user4', 'password4', '1985-04-25'),
--     ('TV5', N'Hoàng Văn E', N'Nam', '0123456789', 'hoangvane@email.com', 'PREMIUM', 'VN', 'user5', 'password5', '1980-05-30'),
--     ('TV6', N'Nguyễn Thị F', N'Nữ', '0987654321', 'nguyenthif@email.com', 'VIP', 'VN', 'user6', 'password6', '1975-06-05'),
--     ('TV7', N'Trần Văn G', N'Nam', '0123456789', 'tranvang@email.com', 'BASIC', 'VN', 'user7', 'password7', '1970-07-10'),
--     ('TV8', N'Lê Thị H', N'Nữ', '0987654321', 'lethih@email.com', 'PREMIUM', 'VN', 'user8', 'password8', '1965-08-15'),
--     ('TV9', N'Phạm Văn I', N'Nam', '0123456789', 'phamvani@email.com', 'VIP', 'VN', 'user9', 'password9', '1960-09-20'),
--     ('TV10', N'Hoàng Thị K', N'Nữ', '0987654321', 'hoangthik@email.com', 'BASIC', 'VN', 'user10', 'password10', '1955-10-25');


-- INSERT INTO LOAINHANVIEN
--     (MALOAINV, TENLOAINV)
-- VALUES('BH', N'BÁN HÀNG'),
--     ('BV', N'BẢO VỆ');


-- INSERT INTO NHANVIEN
--     (MANV, HOTEN, GIOITINH, DIACHI, SODT, MALOAINV)
-- VALUES('NV01', N'Nguyễn Tuyết Trinh', N'Nữ', N'Nha Trang - Khánh Hòa', '0000000000', 'BH'),
--     ('NV02', N'Đặng Viết Hùng', N'Nam', N'Phú Yên', '1111111111', 'BV')

-- ----------------------------------------
-- --VOUCHER
-- -- Thêm voucher giảm giá cho Oppo
-- INSERT INTO VOUCHER
--     (MAVOUCHER, TENVOUCHER, NOIDUNG, NGAYBD, NGAYKT, GIAMGIA, GHICHU, ANHDAIDIEN)
-- VALUES
--     ('VOUCHEROPPO1', N'SALE 10%', N'Giảm 10% cho sản phẩm Oppo cho mọi đơn hàng.', '2023-10-26', '2023-12-31', 10, N'Áp dụng cho tất cả sản phẩm Oppo.', NULL),
--     ('VOUCHEROPPO2', N'FREE SHIP', N'Miễn phí vận chuyển cho sản phẩm Oppo cho đơn hàng trên 1 triệu.', '2023-10-26', '2023-12-31', 0, N'Áp dụng cho đơn hàng trên 1 triệu.', NULL);

-- -- Thêm voucher giảm giá cho Xiaomi
-- INSERT INTO VOUCHER
--     (MAVOUCHER, TENVOUCHER, NOIDUNG, NGAYBD, NGAYKT, GIAMGIA, GHICHU, ANHDAIDIEN)
-- VALUES
--     ('VOUCHERXIAOMI1', N'SALE 15%', N'Giảm 15% cho sản phẩm Xiaomi cho đơn hàng trên 2 triệu.', '2023-10-26', '2023-12-31', 15, N'Áp dụng cho đơn hàng trên 2 triệu.', NULL);

-- -- Thêm voucher giảm giá cho Apple
-- INSERT INTO VOUCHER
--     (MAVOUCHER, TENVOUCHER, NOIDUNG, NGAYBD, NGAYKT, GIAMGIA, GHICHU, ANHDAIDIEN)
-- VALUES
--     ('VOUCHERAPPLE1', N'SALE 5%', N'Giảm 5% cho sản phẩm Apple cho đơn hàng trên 3 triệu.', '2023-10-26', '2023-12-31', 5, N'Áp dụng cho đơn hàng trên 3 triệu.', NULL);


-- INSERT INTO THANHTOAN
--     (MATT, MANV, MATV, MASP, SLSP, MAVOUCHER, TENLOAINV, DONGIA)
-- VALUES('MTT01', 'NV01', 'TV1', 'SP1', 1, 'VOUCHERAPPLE1', N'BÁN HÀNG', 24000000),
--     ('MTT02', 'NV01', 'TV2', 'SP4', 1, 'VOUCHEROPPO2', N'BÁN HÀNG', 12000000),
--     ('MTT03', 'NV01', 'TV3', 'SP2', 1, 'VOUCHERXIAOMI1', N'BÁN HÀNG', 7000000),
--     ('MTT04', 'NV01', 'TV1', 'SP4', 1, 'VOUCHEROPPO1', N'BÁN HÀNG', 10000000);

-- ----------------------------------------
-- --HOADON
-- INSERT INTO HOADON
--     (MAHOADON, MATT)
-- VALUES('MHD001', 'MTT01'),
--     ('MHD002', 'MTT02'),
--     ('MHD003', 'MTT03'),
--     ('MHD004', 'MTT04');

-- ----------------------------------------
-- --BANNER
-- INSERT INTO BANNER
--     (ID, LINK, MASP)
-- VALUES('BN001', NULL, 'SP1'),
--     ('BN002', NULL, 'SP2'),
--     ('BN003', NULL, 'SP3'),
--     ('BN004', NULL, 'SP4'),
--     ('BN005', NULL, 'SP5'),
--     ('BN006', NULL, 'SP6'),
--     ('BN007', NULL, 'SP7'),
--     ('BN008', NULL, 'SP8'),
--     ('BN009', NULL, 'SP9'),
--     ('BN010', NULL, 'SP10');

-- SELECT * FROM LOAINHANVIEN
-- SELECT * FROM LOAITHANHVIEN
-- SELECT * FROM NHANVIEN
-- SELECT * FROM THANHVIEN
-- SELECT * FROM QUOCGIA
-- SELECT * FROM BINHLUAN
-- SELECT * FROM HANGSANXUAT
-- SELECT * FROM TINHTRANGHANGHOA
-- SELECT * FROM VOUCHER
-- SELECT * FROM RAM
-- SELECT * FROM ROM
-- SELECT * FROM MAUSAC
-- SELECT * FROM HEDIEUHANH
-- SELECT * FROM SANPHAM
-- SELECT * FROM KHO
-- SELECT * FROM THANHTOAN
-- SELECT * FROM HOADON
-- SELECT * FROM BANNER