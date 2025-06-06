# SWP391-BE
https://docs.google.com/document/d/1T3EYg2VZFC7tm7bPtop-myZqG6gd1xtwCkkbvFYU6Tw/edit?tab=t.0
📄 DANH SÁCH API DỰ ÁN


🔐 1. Authentication (Xác thực)


Phương thức	Endpoint	Chức năng

POST	/auth/login	Đăng nhập

POST	/auth/register	Đăng ký tài khoản

POST	/auth/forgot	Quên mật khẩu

POST	/auth/logout	Đăng xuất


👤 2. User Profile & Role

Phương thức	Endpoint	Chức năng

GET	/user/profile	Lấy thông tin tài khoản hiện tại

PUT	/user/profile	Cập nhật thông tin cá nhân

GET	/user/roles	Lấy danh sách vai trò người dùng

GET	/user/list	Danh sách tất cả user (admin/manager)

PUT	/user/{id}/role	Cập nhật vai trò người dùng


🧍 3. Patients (Bệnh nhân)

Phương thức	Endpoint	Chức năng

GET	/patients	Lấy danh sách bệnh nhân

GET	/patients/{id}	Chi tiết bệnh nhân

POST	/patients	Thêm bệnh nhân

PUT	/patients/{id}	Cập nhật bệnh nhân

DELETE	/patients/{id}	Xóa bệnh nhân


📝 4. Medical Records (Hồ sơ y tế)

Phương thức	Endpoint	Chức năng

GET	/medical-records	Lấy danh sách hồ sơ y tế

GET	/medical-records/{id}	Chi tiết hồ sơ

GET	/patients/{id}/medical-records	Hồ sơ theo bệnh nhân

POST	/medical-records	Tạo hồ sơ y tế

PUT	/medical-records/{id}	Cập nhật hồ sơ

DELETE	/medical-records/{id}	Xóa hồ sơ


📅 5. Appointments (Lịch hẹn khám)

Phương thức	Endpoint	Chức năng

POST	/appointments	Đặt lịch khám/tư vấn

GET	/appointments	Danh sách lịch hẹn

GET	/appointments/{id}	Chi tiết lịch hẹn

GET	/patients/{id}/appointments	Lịch theo bệnh nhân

PUT	/appointments/{id}/status	Cập nhật trạng thái (xác nhận/hủy)



💊 6. Treatments & Protocols (Phác đồ điều trị)

Phương thức	Endpoint	Chức năng

GET	/treatments	Danh sách điều trị

GET	/treatments/{id}	Chi tiết điều trị

GET	/patients/{id}/treatments	Điều trị theo bệnh nhân

POST	/treatments	Tạo điều trị mới

PUT	/treatments/{id}	Cập nhật thông tin điều trị

DELETE	/treatments/{id}	Xóa điều trị


📦 7. Medications (Thuốc)

Phương thức	Endpoint	Chức năng

GET	/medications	Danh sách thuốc

GET	/medications/{id}	Chi tiết thuốc

POST	/medications	Thêm thuốc mới

PUT	/medications/{id}	Cập nhật thuốc

DELETE	/medications/{id}	Xóa thuốc


📋 8. Prescriptions (Đơn thuốc)

Phương thức	Endpoint	Chức năng

GET	/prescriptions	Danh sách đơn thuốc

GET	/prescriptions/{id}	Chi tiết đơn thuốc

POST	/prescriptions	Tạo đơn thuốc mới

PUT	/prescriptions/{id}	Cập nhật đơn thuốc

DELETE	/prescriptions/{id}	Xóa đơn thuốc


📊 9. Dashboard / Báo cáo

Phương thức	Endpoint	Chức năng

GET	/dashboard/stats	Thống kê tổng quan hệ thống

GET	/reports?from&to	Báo cáo theo khoảng thời gian


🏥 10. Hệ thống & Tài nguyên

Phương thức	Endpoint	Chức năng

GET	/resources	Danh sách tài liệu giáo dục

GET	/blogs	Danh sách bài viết, tin tức

GET	/doctors	Danh sách bác sĩ
