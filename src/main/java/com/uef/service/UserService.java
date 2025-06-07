/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.service;

import com.uef.model.User;

/**
 *
 * @author PC
 */
public interface UserService {
    User findByEmail(String email);
    boolean registerUser(String hoTen, String email, String password, String soDienThoai);
}