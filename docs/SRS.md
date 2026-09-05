# Tài liệu Đặc tả Hệ thống — [Tên dự án]

**Phiên bản:** 1.0
**Ngày:** [dd/mm/yyyy]
**Người soạn thảo:** [Tên]
**Trạng thái:** Draft / Review / Approved

---

## 1. Giới thiệu

### 1.1 Mục đích
Mô tả ngắn gọn tài liệu này dùng để làm gì, dành cho ai đọc (dev, QA, PM, stakeholder...).

### 1.2 Phạm vi
- Hệ thống làm gì (in scope)
- Hệ thống KHÔNG làm gì (out of scope)

### 1.3 Định nghĩa & thuật ngữ
| Thuật ngữ | Giải thích |
|---|---|
| ... | ... |

### 1.4 Tài liệu tham khảo
- Link thiết kế, tài liệu liên quan, benchmark...

---

## 2. Mô tả tổng quan

### 2.1 Bối cảnh / Vấn đề cần giải quyết
Vì sao dự án này tồn tại, pain point hiện tại là gì.

### 2.2 Đối tượng người dùng
| Vai trò | Mô tả | Nhu cầu chính |
|---|---|---|
| Người dùng cuối | ... | ... |
| Admin | ... | ... |

### 2.3 Giả định & ràng buộc
- Giả định: (vd: người dùng có kết nối internet ổn định)
- Ràng buộc: (vd: phải tương thích iOS 14+, ngân sách, deadline)

---

## 3. Yêu cầu chức năng (Functional Requirements)

### 3.1 [Tên module/tính năng — vd: Quản lý tài khoản]

**Mô tả:** Tóm tắt tính năng làm gì.

**Yêu cầu chi tiết:**
1. Hệ thống phải cho phép người dùng đăng ký bằng email/mật khẩu.
2. Hệ thống phải gửi email xác thực sau khi đăng ký.
3. Mật khẩu phải có tối thiểu 8 ký tự, gồm chữ và số.

**Use case:**
| Actor | Trường hợp sử dụng | Kết quả mong đợi |
|---|---|---|
| Người dùng | Đăng ký với email đã tồn tại | Hệ thống báo lỗi, không tạo tài khoản mới |

> Lặp lại mục 3.x cho từng module: 3.2, 3.3...

---

## 4. Yêu cầu phi chức năng (Non-functional Requirements)

| Loại | Yêu cầu |
|---|---|
| Hiệu năng | Thời gian tải trang < 2s với 95% requests |
| Bảo mật | Mật khẩu mã hóa bcrypt, dữ liệu truyền qua HTTPS |
| Khả năng mở rộng | Hỗ trợ tối thiểu 10,000 user đồng thời |
| Khả dụng | Uptime 99.5% |
| Tương thích | Chrome, Safari, Firefox bản mới nhất; iOS 14+, Android 10+ |
| Khả năng bảo trì | Code tuân theo coding convention của team, có unit test coverage ≥ 70% |

---

## 5. Luồng nghiệp vụ chính (Business Process)

Mô tả bằng lời hoặc lưu đồ (flowchart) các luồng quan trọng.

**Ví dụ: Luồng đặt hàng**
1. Người dùng chọn sản phẩm → thêm vào giỏ hàng
2. Người dùng vào giỏ hàng → xác nhận thông tin giao hàng
3. Hệ thống tính phí vận chuyển + tổng tiền
4. Người dùng chọn phương thức thanh toán → xác nhận
5. Hệ thống tạo đơn hàng, gửi email xác nhận

---

## 6. Mô hình dữ liệu (Data Model)

### 6.1 Các thực thể chính
| Thực thể | Mô tả | Thuộc tính chính |
|---|---|---|
| User | Tài khoản người dùng | id, email, password, status |
| Order | Đơn hàng | id, user_id, total, status |

### 6.2 Mối quan hệ
- User (1) — (n) Order

---

## 7. Giao diện hệ thống (System Interfaces)

### 7.1 Giao diện người dùng (UI)
Danh sách màn hình chính (tham chiếu mockup/wireframe nếu có).

### 7.2 Giao diện API / Tích hợp bên thứ ba
| Hệ thống tích hợp | Mục đích | Ghi chú |
|---|---|---|
| Payment gateway (vd: Stripe) | Xử lý thanh toán | ... |
| Email service | Gửi email thông báo | ... |

---

## 8. Yêu cầu về dữ liệu & bảo mật

- Chính sách lưu trữ dữ liệu (retention policy)
- Phân quyền truy cập dữ liệu theo vai trò
- Tuân thủ quy định (GDPR, PCI-DSS... nếu áp dụng)

---

## 9. Tiêu chí nghiệm thu (Acceptance Criteria)

| # | Tiêu chí | Cách kiểm tra |
|---|---|---|
| 1 | Người dùng đăng ký thành công nhận được email trong vòng 1 phút | Test thủ công / automation |
| 2 | ... | ... |

---

## 10. Rủi ro & vấn đề mở

| Rủi ro | Mức độ ảnh hưởng | Phương án giảm thiểu |
|---|---|---|
| ... | Cao/Trung bình/Thấp | ... |

**Câu hỏi/vấn đề chưa chốt:**
- [ ] ...

---

## 11. Phụ lục
- Lịch sử thay đổi tài liệu
- Người phê duyệt

| Phiên bản | Ngày | Người sửa | Nội dung thay đổi |
|---|---|---|---|
| 1.0 | | | Khởi tạo |