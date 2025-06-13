/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author PC
 */
@Controller
public class HomeController {

     @GetMapping({"/","/login"})
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

}
