// File: src/main/java/com/uef/servlet/GetUsernameServlet.java
package com.uef.servlet;

import com.uef.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet này khi được gọi sẽ lấy tên người dùng (hoTen) từ session.
 * Nếu chưa đăng nhập (session không có "user"), trả về chuỗi rỗng.
 */
@WebServlet(name="GetUsernameServlet", urlPatterns="/get-username")
public class GetUsernameServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String name = "";

        if (session != null) {
            User u = (User) session.getAttribute("user");
            if (u != null) {
                name = u.getHoTen();  // Lấy họ tên đã lưu trong User object
            }
        }

        // Chúng ta sẽ trả về plain-text (hoặc JSON tuỳ ý).
        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(name);  // Nếu name = "" nghĩa chưa đăng nhập.
        out.flush();
    }
}
