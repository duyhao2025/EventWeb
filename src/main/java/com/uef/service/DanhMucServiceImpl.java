/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.service;

import com.uef.dao.DanhMucDAO;
import com.uef.model.DanhMuc;

import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author Admin
 */
@Service
public class DanhMucServiceImpl implements DanhMucService {

    @Autowired
    private DanhMucDAO danhMucDAO;

    @Override
    public List<DanhMuc> getAll() {
        try {
            List<DanhMuc> list = danhMucDAO.findAll();
            // DEBUG: in ra console xem lấy được bao nhiêu
            System.out.println(">>> Đọc DanhMuc từ DB, count = " + list.size());
            return list;
        } catch (Exception e) {
            throw new RuntimeException("Lỗi đọc danh mục", e);
        }
    }
}
