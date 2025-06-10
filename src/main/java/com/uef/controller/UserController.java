package com.uef.controller;

import com.uef.model.User;
import com.uef.service.UserService;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
public class UserController {

    @Autowired
    private UserService userService;

    // GET: Hiển thị form đăng nhập
    @GetMapping("/login")
    public String showLoginForm(@RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "registered", required = false) String registered,
            Model model) {
        if (error != null) {
            model.addAttribute("error", error);
        }
        if (registered != null) {
            model.addAttribute("message", "Đăng ký thành công. Bạn có thể đăng nhập.");
        }
        return "user/login";
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
                return "redirect:/demo";
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

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/eventregister")
    public String showEventRegistrationForm() {
        return "event/eventregister";
    }

    // Xử lý form đăng ký tham gia sự kiện
    @PostMapping("/eventregister")
    public String processEventRegistration(@RequestParam("hoTen") String hoTen,
            @RequestParam("email") String email,
            @RequestParam("soDienThoai") String soDienThoai,
            Model model,
            HttpServletRequest request) {

        try {
            String code = "CONF" + System.currentTimeMillis();

            userService.saveEventRegistration(email, hoTen, soDienThoai, code);
            userService.eventRegisterUser(hoTen, email, "macdinh", "nguoi_tham_gia");

            LocalDate expirationDate = LocalDate.now().plusDays(7);
            String ngayHetHan = expirationDate.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));

            String qrContent = String.format("Họ tên: %s\nEmail: %s\nSĐT: %s\nMã: %s\nHết hạn: %s",
                    hoTen, email, soDienThoai, code, ngayHetHan);

            String qrImagePath = QRCodeGenerator.generateQRCodeImage(qrContent, request);

            model.addAttribute("code", code);
            model.addAttribute("ngayHetHan", ngayHetHan);
            model.addAttribute("qrImagePath", qrImagePath);

            return "event/success";

        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi xử lý đăng ký: " + e.getMessage());
            return "event/eventregister";
        }
    }
}
