package com.uef.service;

import com.uef.model.SuKien;
import java.util.List;

public interface SuKienService {
    int themSuKien(SuKien suKien);
    List<SuKien> layTatCaSuKien();
    List<SuKien> timKiemSuKien(String tuKhoa, String diaDiem);
    void themDanhMucChoSuKien(int maSuKien, int maDanhMuc);
}
