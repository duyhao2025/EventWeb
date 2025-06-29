/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.service;

/**
 *
 * @author Admin
 */
import com.uef.dao.SuKienDAO;
import com.uef.model.SuKien;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class SuKienServiceImpl implements SuKienService {

    @Autowired
    private SuKienDAO suKienDAO;
    private List<SuKien> store = new ArrayList<>();
    private final Path uploadDir = Paths.get("uploads");

    public SuKienServiceImpl() throws Exception {
        Files.createDirectories(uploadDir);
    }

    @Override
    public List<SuKien> getAll() {
        try {
            List<SuKien> events = suKienDAO.getAll();
            return events;
        } catch (Exception e) {
            throw new RuntimeException("Lỗi đọc sự kiện", e);
        }

    }

    @Override
    public void create(SuKien sukien, MultipartFile file) {
        // 1) lưu ảnh
        if (file != null && !file.isEmpty()) {
            String fn = saveImage(file);
            sukien.setHinhAnh(fn);
        }
        // 2) lưu Sukien vào DB
        try {
            suKienDAO.insert(sukien);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi lưu sự kiện", e);
        }
    }

    @Override
    public String saveImage(MultipartFile file) {
        try {
            String fn = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            Path target = uploadDir.resolve(fn);
            Files.copy(file.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
            return fn;
        } catch (Exception e) {
            throw new RuntimeException("Không lưu được ảnh", e);
        }
    }

    @Override
    public SuKien findById(int id) {
        try {
            return suKienDAO.findById(id);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi tìm sự kiện", e);
        }
    }

    @Override
    public void update(SuKien sk) {
        try {
            suKienDAO.update(sk);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi cập nhật sự kiện", e);
        }
    }

    @Override
    public void deleteById(int id) {
        try {
            suKienDAO.deleteById(id);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi xóa sự kiện", e);
        }
    }

    @Override
    public List<SuKien> searchByTitle(String keyword) {
        return suKienDAO.searchByTitle(keyword);
    }

    @Override
    public List<SuKien> getThongKeSuKienToChuc(int maNguoiToChuc) {
        return suKienDAO.getThongKeSuKienToChuc(maNguoiToChuc);
    }
}
