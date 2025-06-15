package com.uef.until;

import java.io.File;
import java.io.IOException;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.HttpServletRequest;

public class EmailUtil {
    private static final String FROM_EMAIL = "zackerman261120@gmail.com";
    private static final String PASSWORD = "vmwu feox povx qmxx";

    private static Session createSession() {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        return Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });
    }

    private static String buildQrEmailBody(String hoTen, String code, String ngayHetHan, String cidOrUrl, boolean isInline) {
        String imgSrc = isInline ? "cid:" + cidOrUrl : cidOrUrl;
        return String.format("""
            <p>Chào %s,</p>
            <p>Bạn đã đăng ký tham gia sự kiện thành công.</p>
            <p><strong>Mã xác nhận:</strong> %s<br/>
            <strong>Hết hạn:</strong> %s</p>
            <p><img src=\"%s\" width=\"250\"/></p>
            <p>Trân trọng,<br/>UEF Event System</p>
        """, hoTen, code, ngayHetHan, imgSrc);
    }

    public static void send(String to, String subject, String htmlBody) throws MessagingException {
        Session session = createSession();
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM_EMAIL));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setContent(htmlBody, "text/html; charset=utf-8");
        Transport.send(message);
    }

    public static void sendEmailWithEmbeddedImage(String to, String subject, String hoTen, String code, String ngayHetHan, String qrImagePath) throws MessagingException, IOException {
        Session session = createSession();
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM_EMAIL));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);

        MimeMultipart multipart = new MimeMultipart("related");

        // HTML part
        BodyPart messageBodyPart = new MimeBodyPart();
        String cid = "qrImage001";
        String htmlText = buildQrEmailBody(hoTen, code, ngayHetHan, cid, true);
        messageBodyPart.setContent(htmlText, "text/html; charset=utf-8");
        multipart.addBodyPart(messageBodyPart);

        // Image part
        MimeBodyPart imagePart = new MimeBodyPart();
        FileDataSource fds = new FileDataSource(new File(qrImagePath));
        imagePart.setDataHandler(new DataHandler(fds));
        imagePart.setHeader("Content-ID", "<" + cid + ">");
        imagePart.setDisposition(MimeBodyPart.INLINE);
        multipart.addBodyPart(imagePart);

        message.setContent(multipart);
        Transport.send(message);
    }

    public static String generateQrEmailBody(String hoTen, String code, String ngayHetHan, String qrImagePath, HttpServletRequest request) {
        String qrUrl = request.getScheme() + "://" +
                       request.getServerName() + ":" +
                       request.getServerPort() +
                       request.getContextPath() + "/" + qrImagePath;
        return buildQrEmailBody(hoTen, code, ngayHetHan, qrUrl, false);
    }
}
