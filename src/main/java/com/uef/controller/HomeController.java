/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.controller;

import com.uef.model.SuKien;
import com.uef.model.User;
import com.uef.service.SuKienService;
import com.uef.service.YeuThichService;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


/**
 *
 * @author PC
 */
@Controller
public class HomeController {

    @Autowired
    private SuKienService suKienService;
    @Autowired
    private YeuThichService yeuThichService;

    @GetMapping({"/","/demo"})
    public String showDemo(HttpSession session, Model model) {
        // Không còn kiểm tra session → ai cũng vào được demo
        User u = (User) session.getAttribute("user");
        model.addAttribute("user", u);

        List<SuKien> event = suKienService.getAll();
        model.addAttribute("suKienList", event);
        if (u != null) {
            List<SuKien> dsYeuThich = yeuThichService.layDanhSachYeuThich(u.getMaNguoiDung());
            List<Integer> idYeuThich = dsYeuThich.stream().map(SuKien::getMaSuKien).toList();
            model.addAttribute("idYeuThichList", idYeuThich);
        }
        return "demo/index";
    }

}
