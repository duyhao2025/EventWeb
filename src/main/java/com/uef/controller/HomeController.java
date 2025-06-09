/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.controller;

import com.uef.model.User;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 *
 * @author PC
 */
@Controller
public class HomeController {

    @GetMapping({"/", "/demo"})
    public String showDemo(HttpSession session, Model model) {
        // Đẩy thông tin user (đã login) vào model để JSP có thể hiện avatar…
        User u = (User) session.getAttribute("currentUser");
        model.addAttribute("user", u);
        return "demo/index";    // ← trỏ tới /WEB-INF/views/demo/index.jsp
    }

}
