/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.uef.dao;

import com.uef.model.DanhMuc;
import java.util.List;

/**
 *
 * @author Admin
 */
public interface DanhMucDAO {

    List<DanhMuc> findAll() throws Exception;
}
