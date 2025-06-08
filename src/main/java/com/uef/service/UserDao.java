/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.uef.service;

import com.uef.model.User;

/**
 *
 * @author Admin
 */
public interface UserDao {
     int save(User user);                  // trả về số bản ghi insert
    User findByEmail(String email);
}
