package com.uef.controller;

import com.uef.model.SuKien;
import com.uef.service.DanhMucService;
import com.uef.service.SuKienService;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/event")
public class SuKienController {

    @Autowired
    private SuKienService suKienService;

    @Autowired
    private DanhMucService danhMucService;

    // Trang chủ: Hiển thị newsfeed
    @GetMapping("/")
    public String index(Model model) {
        List<SuKien> danhSach = suKienService.layTatCaSuKien();
        model.addAttribute("suKiens", danhSach);
        return "index"; // index.jsp là newsfeed
    }

    // Trang quản trị (nếu cần)
    @GetMapping("/list")
    public String showEventList(Model model) {
        List<SuKien> danhSach = suKienService.layTatCaSuKien();
        model.addAttribute("dsSuKien", danhSach);
        return "event/list";
    }

    // Xử lý tạo bài viết/sự kiện từ form (modal)
    @PostMapping("/create")
    public String taoSuKien(@ModelAttribute SuKien suKien) {
        suKien.setNgayGio(LocalDateTime.now());
        suKien.setTrangThai("upcoming");

        // 1. Tạo sự kiện trước
        int maSuKien = suKienService.themSuKien(suKien);

        // 2. Xử lý thể loại (nhiều thể loại)
        String[] cacTheLoai = suKien.getDanhMuc().split(",");
        for (String ten : cacTheLoai) {
            ten = ten.trim();
            if (!ten.isEmpty()) {
                int maDanhMuc = danhMucService.getOrCreateDanhMuc(ten);
                suKienService.themDanhMucChoSuKien(maSuKien, maDanhMuc);
            }
        }

        // 3. Quay lại trang chủ (newsfeed chính là index)
        return "redirect:/";
    }
}
