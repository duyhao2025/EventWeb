package com.uef.controller;

import com.uef.model.SuKien;
import com.uef.model.User;
import com.uef.service.DangKyService;
import com.uef.service.DangKyServiceImpl;
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
    private UserService userService;

    // GET: Hiển thị form đăng nhập
    @GetMapping("/demo")
    public String showDemo(HttpSession session, Model model) {
        // Đẩy thông tin user (đã login) vào model để JSP có thể hiện avatar…
        User u = (User) session.getAttribute("currentUser");
        model.addAttribute("user", u);
        return "demo/index";    // ← trỏ tới /WEB-INF/views/demo/index.jsp
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
            
            if (!email.toLowerCase().endsWith("@gmail.com")) {
            model.addAttribute("error", "Sai định dạng email Gmail");
            return "event/eventregister";
            }
            
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

    private DangKyService dangKyService = new DangKyServiceImpl();

    @GetMapping("/user/profile")
    public String showProfile(HttpSession session, Model model) {
        User loggedUser = (User) session.getAttribute("user");
        if (loggedUser == null) {
            return "redirect:/login";
        }

        User user = userService.findById(loggedUser.getMaNguoiDung());
        model.addAttribute("user", user);

        List<SuKien> history = dangKyService.getTatCaSuKien(user.getMaNguoiDung());
        model.addAttribute("events", history);
        model.addAttribute("danhSachSuKien", history);
        model.addAttribute("today", LocalDate.now());

        return "event/eventcancel";
    }

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
    
    
        @GetMapping("/event/list")
        public String showEventListPage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

         List<SuKien> danhSachSuKien = dangKyService.getTatCaSuKien();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
        for (SuKien sk : danhSachSuKien) {
        if (sk.getNgayToChuc() != null) {
            sk.setChuaDienRa(sk.getNgayToChuc().isAfter(LocalDate.now()));
        } else {
            sk.setChuaDienRa(false); 
        }
    }

        model.addAttribute("danhSachSuKien", danhSachSuKien);
        model.addAttribute("today", LocalDate.now());

        return "event/eventlist";
}

        @PostMapping("/event/list")
        public String cancelRegistration(@RequestParam("id") int maSuKien,
                                         HttpSession session,
                                         RedirectAttributes redirectAttributes) {
            User user = (User) session.getAttribute("user");
            if (user == null) return "redirect:/login";

            SuKien sk = dangKyService.getSuKienById(maSuKien);
            if (sk == null) {
                redirectAttributes.addFlashAttribute("error", "Sự kiện không tồn tại.");
                return "redirect:/event/list";
            }

            LocalDate today = LocalDate.now();
            if (sk.getNgayToChuc().isAfter(today)) {
                dangKyService.huyDangKy(user.getMaNguoiDung(), maSuKien);
                redirectAttributes.addFlashAttribute("msg", "Hủy đăng ký thành công.");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể hủy vì sự kiện đã diễn ra hoặc đang diễn ra.");
            }

            return "redirect:/event/list";
        }
        @GetMapping("/event/map")
            public String showEventMapPage(@RequestParam("id") int maSuKien, Model model) {
            SuKien sk = dangKyService.getSuKienById(maSuKien);
            if (sk == null) {
                model.addAttribute("error", "Không tìm thấy sự kiện");
                return "redirect:/eventregister";
            }
            model.addAttribute("diaChi", sk.getDiaChi());
            return "event/eventmap";
        }
}
