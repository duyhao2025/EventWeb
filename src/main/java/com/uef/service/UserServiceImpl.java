    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
     */
    package com.uef.service;

    import com.uef.model.User;
    import com.uef.until.HashUtil;
    import java.util.ArrayList;
    import java.util.List;
    import org.springframework.stereotype.Service;

    /**
     *
     * @author PC
     */
    @Service
    public class UserServiceImpl implements UserService {

        private static final List<User> userList = new ArrayList<>();

        @Override
        public User findByEmail(String email) {
            for (User user : userList) {
                if (user.getEmail().equalsIgnoreCase(email)) {
                    return user;
                }
            }
            return null;
        }

        /**
         *
         * @param hoTen
         * @param email
         * @param password
         * @param soDienThoai
         * @return
         */
        @Override
        public boolean registerUser(String hoTen, String email, String password, String soDienThoai) {
            // Kiểm tra trùng email
            if (findByEmail(email) != null) {
                throw new RuntimeException("Email đã tồn tại. Vui lòng chọn email khác.");
            }

            User user = new User();
            user.setHoTen(hoTen);
            user.setEmail(email);
            user.setSoDienThoai(soDienThoai);
            user.setMatKhauMaHoa(HashUtil.sha256(password));
            user.setVaiTro("nguoi_tham_gia");
            user.setXacThuc(false);
            user.setNgonNgu("vi");

            userList.add(user);
            return true;
        }

        @Override
        public void eventRegisterUser(String hoTen, String email, String password, String soDienThoai) {
        if (findByEmail(email) != null) {
            throw new RuntimeException("Email đã tồn tại. Vui lòng chọn email khác.");
        }

        User user = new User();
        user.setHoTen(hoTen);
        user.setEmail(email);
        user.setMatKhauMaHoa(HashUtil.sha256(password));
        user.setVaiTro("");
        user.setXacThuc(false);
        user.setNgonNgu("vi");

        userList.add(user);
        }

    @Override
    public void save(User user) {
        userList.add(user);
    }

    @Override
    public List<User> getAllUsers() {
        return userList;
    }

    @Override
    public int countRegisteredUsers() {
        return userList.size();
    }

    @Override
    public void saveEventRegistration(String email, String fullName, String phone, String code) {
        System.out.println("Đăng ký mới: " + fullName + " | " + email + " | " + phone + " | Mã: " + code);
    }
    }
