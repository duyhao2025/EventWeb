/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uef.until;



import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;

public class QRCodeGenerator {

    public static String generateQRCodeImage(String text, HttpServletRequest request) {
        try {
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            java.util.Map<com.google.zxing.EncodeHintType, Object> hints = new java.util.HashMap<>();
            hints.put(com.google.zxing.EncodeHintType.CHARACTER_SET, "UTF-8");
            BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, 300, 300, hints);

            String fileName = "qr-" + System.currentTimeMillis() + ".png";
            String uploadDir = request.getServletContext().getRealPath("/qr-codes");
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            Path path = FileSystems.getDefault().getPath(uploadDir, fileName);
            MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

            return "qr-codes/" + fileName;
        } catch (WriterException | IOException e) {
            throw new RuntimeException("Lỗi tạo mã QR", e);
        }
    }
}
