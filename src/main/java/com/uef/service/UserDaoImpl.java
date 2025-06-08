/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.service;

import com.uef.model.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Admin
 */@Repository
public class UserDaoImpl implements UserDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<User> mapper = new RowMapper<User>() {
        @Override
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User u = new User();
            u.setMaNguoiDung(rs.getInt("ma_nguoi_dung"));
            u.setHoTen(rs.getString("ho_ten"));
            u.setEmail(rs.getString("email"));
            u.setMatKhauMaHoa(rs.getString("mat_khau_ma_hoa"));
            u.setSoDienThoai(rs.getString("so_dien_thoai"));
            return u;
        }
    };

    @Override
    public int save(User user) {
        String sql = "INSERT INTO user (ho_ten, email, mat_khau_ma_hoa, so_dien_thoai) VALUES (?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
            user.getHoTen(),
            user.getEmail(),
            user.getMatKhauMaHoa(),
            user.getSoDienThoai()
        );
    }

    @Override
    public User findByEmail(String email) {
        String sql = "SELECT * FROM user WHERE email = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{email}, mapper);
    }
}
