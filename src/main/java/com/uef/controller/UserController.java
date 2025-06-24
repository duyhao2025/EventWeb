package com.uef.controller;

import com.uef.model.DangKy;
import com.uef.model.SuKien;
import com.uef.model.User;
import com.uef.service.DangKyService;
import com.uef.service.DangKyServiceImpl;
import com.uef.service.SuKienService;
import com.uef.service.UserService;
import com.uef.until.EmailUtil;
import com.uef.until.HashUtil;
import com.uef.until.QRCodeGenerator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
public class UserController {

    @Autowired
    private DangKyService dangKyService;
    @Autowired
    private UserService userService;
    @Autowired
    private SuKienService suKienService;

    // GET: Hiển thị form đăng nhập
    @GetMapping("/demo")
    public String showDemo(HttpSession session, Model model) {
        // Không còn kiểm tra session → ai cũng vào được demo
        User u = (User) session.getAttribute("user");
        model.addAttribute("user", u);

        List<SuKien> event = suKienService.getAll();
        model.addAttribute("suKienList", event);

        return "demo/index";
    }

    // POST: Xử lý đăng nhập
    @PostMapping("/login")
    public String processLogin(@RequestParam("email") String email,
            @RequestParam("mat_khau") String password,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        User user = userService.findByEmail(email);
        if (user != null) {
            String hashedInput = HashUtil.sha256(password);
            if (hashedInput.equalsIgnoreCase(user.getMatKhauMaHoa())) {
                session.setAttribute("user", user);
                return "redirect:/demo";  // hoặc "/" tùy yêu cầu
            }
        }
        String msg = URLEncoder.encode("Sai email hoặc mật khẩu.", StandardCharsets.UTF_8);
        return "redirect:/login?error=" + msg;
    }

    // GET: Hiển thị form đăng ký
    @GetMapping("/register")
    public String showRegisterForm(@RequestParam(value = "error", required = false) String error,
            Model model) {
        if (error != null) {
            model.addAttribute("error", error);
        }
        return "user/register";
    }

    // POST: Xử lý đăng ký
    @PostMapping("/register")
    public String processRegister(@RequestParam("ho_ten") String hoTen,
            @RequestParam("email") String email,
            @RequestParam("mat_khau") String password,
            @RequestParam("so_dien_thoai") String phone,
            RedirectAttributes redirectAttributes) {
        try {
            boolean success = userService.registerUser(hoTen, email, password, phone);
            if (success) {
                return "redirect:/login?registered=success";
            } else {
                String msg = URLEncoder.encode("Đăng ký không thành công. Vui lòng thử lại.", StandardCharsets.UTF_8);
                return "redirect:/register?error=" + msg;
            }
        } catch (RuntimeException e) {
            String msg = URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8);
            return "redirect:/register?error=" + msg;
        }
    }

    // GET: API trả về tên người dùng hiện tại (cho AJAX)
    @GetMapping("/get-username")
    public void getUsername(HttpSession session, HttpServletResponse response) throws IOException {
        String name = "";
        User user = (User) session.getAttribute("user");
        if (user != null) {
            name = user.getHoTen();
        }
        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(name);
        out.flush();
    }
// Đăng xuất

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
// Đăng ký tham gia sự kiện

    @GetMapping("/eventregister")
    public String showEventRegistrationForm(HttpServletRequest request, Model model) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("email", user.getEmail());
        return "event/eventregister";
    }

    @PostMapping("/eventregister")
    public String processEventRegistration(@RequestParam("hoTen") String hoTen,
            @RequestParam("email") String email,
            @RequestParam("soDienThoai") String soDienThoai,
            @RequestParam("suKienId") int suKienId,
            Model model,
            HttpServletRequest request) {

        try {
            if (!email.toLowerCase().endsWith("@gmail.com")) {
                model.addAttribute("error", "Sai định dạng email Gmail");
                return "event/eventregister";
            }
            // lưu vào bảng DangKy
            DangKy dk = new DangKy();
            dk.setMaSuKien(suKienId);
            dk.setHoTen(hoTen);
            dk.setEmail(email);
            dk.setSoDienThoai(soDienThoai);
            dk.setTrangThai("Đã đăng ký");
            dangKyService.dangKySuKien(dk);

            String code = "CONF" + System.currentTimeMillis();

            userService.saveEventRegistration(email, hoTen, soDienThoai, code);
            userService.eventRegisterUser(hoTen, email, "macdinh", "nguoi_tham_gia");

            LocalDate expirationDate = LocalDate.now().plusDays(7);
            String ngayHetHan = expirationDate.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));

            String qrContent = String.format("Họ tên: %s\nEmail: %s\nSĐT: %s\nMã: %s\nHết hạn: %s",
                    hoTen, email, soDienThoai, code, ngayHetHan);

            String qrImagePath = QRCodeGenerator.generateQRCodeImage(qrContent, request);

            try {
                String realPath = request.getServletContext().getRealPath("/") + qrImagePath;
                EmailUtil.sendEmailWithEmbeddedImage(
                        email,
                        "Xác nhận đăng ký sự kiện",
                        hoTen,
                        code,
                        ngayHetHan,
                        realPath
                );
            } catch (Exception e) {
                e.printStackTrace();
                model.addAttribute("warning", "Đăng ký thành công nhưng không gửi được email xác nhận.");
            }

            model.addAttribute("code", code);
            model.addAttribute("ngayHetHan", ngayHetHan);
            model.addAttribute("qrImagePath", qrImagePath);

            return "event/success";

        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi xử lý đăng ký: " + e.getMessage());
            return "event/eventregister";
        }
    }

    @GetMapping("/events/manager")
    public String hienThiQuanLyDangKy(@RequestParam("suKienId") int suKienId, Model model) {
        List<DangKy> danhSach = dangKyService.layDanhSachDangKyTheoSuKien(suKienId);
        model.addAttribute("danhSachDangKy", danhSach);
        return "event/eventmanager";
    }


    @GetMapping("/user/profile")
    public String showProfile(HttpSession session, Model model) {
        User loggedUser = (User) session.getAttribute("user");
        if (loggedUser == null) {
            return "redirect:/login";
        }

        User user = userService.findById(loggedUser.getMaNguoiDung());
        model.addAttribute("user", user);

        List<SuKien> history = dangKyService.getLichSuThamGia(user.getMaNguoiDung());
        model.addAttribute("events", history);

        return "user/profile";
    }
//Thông tin cá nhân và Xem lịch sử sự kiện

    @PostMapping("/user/profile")
    public String updateProfile(@ModelAttribute("user") User user,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/login";
        }

        user.setMaNguoiDung(sessionUser.getMaNguoiDung());
        userService.updateUser(user);
        session.setAttribute("user", userService.findById(user.getMaNguoiDung()));
        redirectAttributes.addFlashAttribute("msg", "Cập nhật thành công!");
        return "redirect:/user/profile";
    }

}
