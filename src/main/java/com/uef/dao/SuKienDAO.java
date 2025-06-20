/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.uef.dao;

import com.uef.model.SuKien;
import java.util.List;

/**
 *
 * @author Admin
 */
public interface SuKienDAO {

    List<SuKien> getAll() throws Exception;

    void insert(SuKien e) throws Exception;

    SuKien findById(int id) throws Exception;

    void update(SuKien sk) throws Exception;

    void deleteById(int id) throws Exception;

    List<SuKien> searchByTitle(String keyword);

    List<SuKien> getThongKeSuKienToChuc(int maNguoiToChuc); 
}
