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
import com.uef.service.UserService;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
            @RequestParam("diaDiem") String diaDiem,
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
        sukien.setDiaDiem(diaDiem);

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
    @Autowired
    private UserService userService;

// ==== FORM SỬA ====
    @GetMapping("edit/{id}")
    public String editForm(@PathVariable int id,
            Model model,
            HttpSession session,
            RedirectAttributes ra) {
        User current = (User) session.getAttribute("user");
        SuKien sk = suKienService.findById(id);
        User creator = userService.findById(sk.getMaNguoiToChuc());
        if (current == null || creator == null
                || !current.getEmail().equals(creator.getEmail())) {
            ra.addFlashAttribute("error", "Bạn không có quyền sửa sự kiện này.");
            return "redirect:/demo";
        }
        model.addAttribute("suKien", sk);
        model.addAttribute("danhMucList", danhMucService.getAll());
        return "event/edit";   // /WEB-INF/views/events/edit.jsp
    }

    @PostMapping("/edit")
    public String doEdit(
            @RequestParam("maSuKien") int maSuKien,
            @RequestParam("tieuDe") String tieuDe,
            @RequestParam(value = "moTa", required = false) String moTa,
            @RequestParam("maDanhMuc") Integer maDanhMuc,
            @RequestParam("ngayGio") String ngayGioStr,
            @RequestParam("hanDangKy") String hanDangKyStr,
            @RequestParam("thoiLuongPhut") Integer thoiLuongPhut,
            @RequestParam("soNguoiToiDa") Integer soNguoiToiDa,
            @RequestParam("diaDiem") String diaDiem,
            @RequestParam(value = "imageFile", required = false) MultipartFile file,
            HttpSession session,
            RedirectAttributes ra
    ) {
        // 1. Phân quyền
        User current = (User) session.getAttribute("user");
        SuKien exist = suKienService.findById(maSuKien);
        if (current == null || !current.getEmail().equals(exist.getCreatorEmail())) {
            ra.addFlashAttribute("error", "Bạn không có quyền sửa sự kiện này.");
            return "redirect:/demo";
        }

        // 2. Parse ngày giờ
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime ngayGio = LocalDateTime.parse(ngayGioStr, fmt);
        LocalDateTime hanDangKy = LocalDateTime.parse(hanDangKyStr, fmt);

        // 3. Build lại object
        SuKien sk = new SuKien();
        sk.setMaSuKien(maSuKien);
        sk.setTieuDe(tieuDe);
        sk.setMoTa(moTa);
        sk.setMaDanhMuc(maDanhMuc);
        sk.setNgayGio(ngayGio);
        sk.setHanDangKy(hanDangKy);
        sk.setThoiLuongPhut(thoiLuongPhut);
        sk.setSoNguoiToiDa(soNguoiToiDa);
        sk.setDiaDiem(diaDiem);
        // giữ nguyên creator/hình ảnh cũ
        sk.setHinhAnh(exist.getHinhAnh());
        sk.setMaNguoiToChuc(exist.getMaNguoiToChuc());

        // 4. Nếu user upload ảnh mới
        if (file != null && !file.isEmpty()) {
            String newName = suKienService.saveImage(file);
            sk.setHinhAnh(newName);
        }

        // 5. Gọi service
        suKienService.update(sk);
        ra.addFlashAttribute("message", "Cập nhật thành công!");
        return "redirect:/demo";
    }

    /**
     * Xóa sự kiện
     *
     * @param id
     * @param ra
     * @param session
     * @return
     */
    @PostMapping("delete/{id}")
    public String delete(@PathVariable int id,
            HttpSession session,
            RedirectAttributes ra) {
        User u = (User) session.getAttribute("user");
        SuKien sk = suKienService.findById(id);
        if (u != null && u.getEmail().equals(sk.getCreatorEmail())) {
            suKienService.deleteById(id);
            ra.addFlashAttribute("message", "Xóa thành công!");
        } else {
            ra.addFlashAttribute("error", "Bạn không có quyền xóa sự kiện này.");
        }
        return "redirect:/demo";
    }

    @GetMapping("/search")
    @ResponseBody
    public List<SuKien> searchSuKien(@RequestParam("keyword") String keyword) {
        return suKienService.searchByTitle(keyword);
    }

    @GetMapping("/my_events")
    public String myEvents(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        List<SuKien> suKienList = suKienService.getThongKeSuKienToChuc(user.getMaNguoiDung());
        model.addAttribute("suKienList", suKienList);
        return "event/myevents"; // kiểm tra view nằm đúng trong /WEB-INF/views/event/myevents.jsp
    }
}
