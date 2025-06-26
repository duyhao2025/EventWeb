/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.controller;

/**
 *
 * @author Admin
 */
import com.uef.model.User;
import com.uef.service.YeuThichService;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/yeu-thich")
public class YeuThichController {

    @Autowired
    private YeuThichService yeuThichService;

    @PostMapping("/them")
    public String themYeuThich(@RequestParam("suKienId") int suKienId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Bạn cần đăng nhập để sử dụng chức năng này.");
            return "redirect:/login";
        }

        yeuThichService.themYeuThich(user.getMaNguoiDung(), suKienId);
        return "redirect:/events/detail/" + suKienId;
    }

    @PostMapping("/xoa")
    public String xoaYeuThich(@RequestParam("suKienId") int suKienId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Bạn cần đăng nhập.");
            return "redirect:/login";
        }

        yeuThichService.anYeuThich(user.getMaNguoiDung(), suKienId);
        redirectAttributes.addFlashAttribute("msg", "Đã bỏ yêu thích sự kiện.");
        return "redirect:/user/profile";
    }

    @PostMapping("/bo")
    public String boYeuThich(@RequestParam("suKienId") int suKienId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Bạn cần đăng nhập để sử dụng chức năng này.");
            return "redirect:/login";
        }

        yeuThichService.boYeuThich(user.getMaNguoiDung(), suKienId);
        return "redirect:/events/detail/" + suKienId;
    }
}
