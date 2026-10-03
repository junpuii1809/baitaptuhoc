# Tiệm Ăn Vặt Cay Cay - Đồ Ăn Vặt Cay Chua Trung Quốc (Cay Cay Quán)

* **Họ và tên sinh viên:** Quan Khoa Cát Tường  
* **Mã số sinh viên (MSSV):** 2531540215  
* **Học phần:** Lập trình Web & Cơ sở dữ liệu  
* **Chủ đề:** Website Giới thiệu & Kinh doanh Tiệm Đồ Ăn Vặt Cay Chua Trung Quốc  

---

## 1. Cấu trúc thư mục dự án (Chuẩn 08 trang HTML & CSDL)

```
web_an_vat/
│
├── index.html          # Trang 1: Trang chủ - Banner Hero, Top món cay hot, Dịch vụ nổi bật, Cẩm nang
├── about.html          # Trang 2: Giới thiệu - Câu chuyện tiệm, cam kết nguồn hàng nội địa date mới
├── products.html       # Trang 3: Thực đơn - Món nước chua cay, đồ ăn vặt cay tê, đồ uống, combo
├── menu.html           # (Đồng bộ với products.html giúp điều hướng mượt mà)
├── services.html       # Trang 4: Dịch vụ - Ship hỏa tốc 30P, setup tiệc ăn vặt, phân phối sỉ lẻ, Spicy Challenge
├── gallery.html        # Trang 5: Hình ảnh - Bộ sưu tập hình ảnh món ngon, không gian tiệm và feedback
├── blog.html           # Trang 6: Cẩm nang - Bài viết ẩm thực Trung Hoa, review độ cay, mẹo giải cay
├── details.html        # Trang 7: Chi tiết món - Chi tiết Bún ốc Liễu Châu / Miến chua cay, chọn cấp độ cay, topping
├── contact.html        # Trang 8: Liên hệ & Đặt ship - Thông tin hotline, bản đồ, form đặt hàng trực tuyến
│
├── css/
│   └── style.css       # File CSS hoàn chỉnh: Flexbox, CSS Grid, Media Queries responsive đa thiết bị
│
├── images/             # Toàn bộ hình ảnh thực tế chất lượng cao (đường dẫn tương đối)
│   ├── hero.jpg        # Banner đồ ăn cay
│   ├── mienchua.jpg    # Miến chua cay Trùng Khánh
│   ├── bunoc.jpg       # Bún ốc Liễu Châu (Luosifen)
│   ├── changa.jpg      # Chân gà cay rút xương
│   ├── dauhu.jpg       # Đậu hũ sốt cay Tứ Xuyên
│   ├── covit.jpg       # Cổ vịt cay Vũ Hán
│   ├── quecay.jpg      # Que cay Tứ Xuyên (Vệ Long)
│   ├── douong.jpg      # Trà sữa trân châu đen
│   ├── drink.jpg       # Trà chanh giã tay Quảng Đông
│   ├── ingredients.jpg # Khay nguyên liệu đóng gói date mới
│   ├── shop.jpg        # Không gian tiệm Cay Cay Quán
│   ├── chef.jpg        # Đội ngũ đầu bếp tâm huyết
│   └── nem.jpg         # Nem chua giòn rụm
│
├── csdl/               # Thư mục Cơ sở dữ liệu cho dự án
│   ├── csdl_tiem_an_vat_cay_chua.sql     # Script SQL tạo database, bảng, khóa ngoại, dữ liệu mẫu
│   └── BaiTap_TiemDoAnVatCayChuaTrungQuoc_QuanKhoaCatTuong_2531540215.docx  # Báo cáo phân tích CSDL chuẩn LMS
│
├── csdl_tiem_an_vat.sql                   # File SQL dự phòng tại thư mục gốc
├── Mo_Giao_Dien_Web.bat                   # File kích hoạt mở nhanh giao diện website
├── link.txt                               # Thông tin bài nộp và link triển khai GitHub Pages
└── README.md                              # Báo cáo và hướng dẫn cấu trúc dự án
```

---

## 2. Các điểm nổi bật đáp ứng 100% yêu cầu đề bài

* **Đúng 08 trang HTML chuẩn Semantic**: Sử dụng các thẻ chuẩn HTML5 (`<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<footer>`).
* **Hệ thống Components đầy đủ**:
  - `Header` & `Navigation`: Thanh menu đồng bộ giữa cả 8 trang, có hiệu ứng `active` trang hiện tại và hover đẹp mắt.
  - `Banner/Hero`: Khu vực giới thiệu nổi bật với tiêu đề, mô tả và các nút kêu gọi hành động (CTA).
  - `Section`: Phân chia bố cục nội dung khoa học, mạch lạc.
  - `Grid`: Trình bày danh sách món ăn, dịch vụ, bài viết và thư viện ảnh bằng CSS Grid linh hoạt.
  - `Card`: Thẻ hiển thị sản phẩm, blog, dịch vụ có hình ảnh, tiêu đề, mức giá, tag và nút tương tác.
  - `Button/Link`: Hệ thống nút bấm bo tròn hiện đại, hiệu ứng hover đổi màu mượt mà.
  - `Footer`: Chân trang ghi rõ thông tin liên hệ, bản quyền sinh viên và trích dẫn nguồn hình ảnh từ Unsplash.
* **Responsive 100% (Desktop, Tablet, Mobile)**:
  - Tự động co giãn bố cục, thay đổi số cột của Grid/Card khi chuyển đổi màn hình (1 cột trên mobile, 2-3 cột trên tablet, 3-4 cột trên desktop).
  - Thanh Navigation tự động sắp xếp gọn gàng, chữ và khoảng cách điều chỉnh tỉ lệ cân đối.
  - Hình ảnh không bị méo, không tràn viền, tuyệt đối không xuất hiện thanh cuộn ngang ngoài ý muốn.
* **Không lỗi ảnh/link**: Toàn bộ liên kết và hình ảnh sử dụng đường dẫn tương đối nội bộ chuẩn xác.
* **Tích hợp Cơ sở dữ liệu đầy đủ**: Kèm theo file script `.sql` hoàn chỉnh và file văn bản `.docx` phân tích mô hình dữ liệu của tiệm ăn vặt theo bài giảng.
