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
}
