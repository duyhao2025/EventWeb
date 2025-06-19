/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.uef.service;

import com.uef.model.SuKien;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Admin
 */
public interface SuKienService {
    List<SuKien> getAll();
    void create(SuKien sukien,MultipartFile file);
    String saveImage(MultipartFile file);
}
