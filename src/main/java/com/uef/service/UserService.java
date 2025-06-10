/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.service;

import com.uef.model.User;
import java.util.List;

/**
 *
 * @author PC
 */
public interface UserService {

    User findByEmail(String email);

    boolean registerUser(String hoTen, String email, String password, String soDienThoai);

    User login(String email, String password);

    void eventRegisterUser(String hoTen, String email, String matKhau, String vaiTro);

    void save(User user);

    List<User> getAllUsers();

    int countRegisteredUsers();

    void saveEventRegistration(String email, String fullName, String phone, String code);
}
