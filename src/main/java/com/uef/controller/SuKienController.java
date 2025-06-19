/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.controller;

/**
 *
 * @author Admin
 */
import com.uef.model.DanhMuc;
import com.uef.model.SuKien;
import com.uef.model.User;
import com.uef.service.DanhMucService;
import com.uef.service.SuKienService;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/events")
public class SuKienController {

    @Autowired
    private SuKienService suKienService;
    private final DateTimeFormatter DT_FMT = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
    @Autowired
    private DanhMucService danhMucService;

    // Hiển thị form
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        List<DanhMuc> categories = danhMucService.getAll();
        // DanhMucServiceImpl phải đọc từ DanhMucDAO.findAll()
        model.addAttribute("categories", categories);
        return "event/create";
    }

    // Xử lý submit
    @PostMapping(
            value = "/create",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE
    )
    public String createEvent(
            @RequestParam("tieuDe") String tieuDe,
            @RequestParam(value = "moTa", required = false) String moTa,
            @RequestParam("maDanhMuc") Integer maDanhMuc,
            @RequestParam("ngayGio") String ngayGioStr,
            @RequestParam("hanDangKy") String hanDangKyStr,
            @RequestParam("thoiLuongPhut") Integer thoiLuongPhut,
            @RequestParam("soNguoiToiDa") Integer soNguoiToiDa,
            @RequestParam(value = "imageFile", required = false) MultipartFile file,
            HttpSession session
    ) {
        // 1) Build model
        SuKien sukien = new SuKien();
        sukien.setTieuDe(tieuDe);
        sukien.setMoTa(moTa);
        sukien.setMaDanhMuc(maDanhMuc);
        sukien.setNgayGio(LocalDateTime.parse(ngayGioStr, DT_FMT));
        sukien.setHanDangKy(LocalDateTime.parse(hanDangKyStr, DT_FMT));
        sukien.setThoiLuongPhut(thoiLuongPhut);
        sukien.setSoNguoiToiDa(soNguoiToiDa);

        // 2) Gán người tạo
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        sukien.setMaNguoiDung(user.getMaNguoiDung());
        sukien.setMaNguoiToChuc(user.getMaNguoiDung());

        // 3) Lưu file (nếu có)
        if (file != null && !file.isEmpty()) {
            String fileName = suKienService.saveImage(file);
            sukien.setHinhAnh(fileName);
        }

        // 4) Lưu vào DB
        try {
            suKienService.create(sukien, file);
        } catch (Exception ex) {
            throw new RuntimeException("Lỗi lưu sự kiện", ex);
        }

        return "redirect:/demo";
    }
}
