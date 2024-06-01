package com.venta.curso.Event;

import com.venta.curso.Entity.UserEntity;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationListener;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import java.io.UnsupportedEncodingException;
import org.springframework.beans.factory.annotation.Value;

/**
 * @author Asus
 */
@Component
@RequiredArgsConstructor
public class RegistrationCompleteEventListener implements ApplicationListener<RegistrationCompleteEvent> {

    private final JavaMailSender mailSender;
    private UserEntity user;

    @Override
    public void onApplicationEvent(RegistrationCompleteEvent event) {
        user = event.getUser();
    }

    public void sendPasswordResetVerificationEmail(String url,String nombre,String cor) throws MessagingException, UnsupportedEncodingException {
        String subject = "Verificación de solicitud de restablecimiento de contraseña";
        String senderName = "Servicio de verificación de usuarios";
        String mailContent = "<p> Hola "+nombre+", </p>"
                + "<p><b>Recientemente solicitó restablecer su contraseña,</b>" + ""
                + "Por favor, siga el enlace a continuación para completar la acción.</p>"
                + "<a href=\"" + url + "\">Restablecer la contraseña</a>"
                + "<p>ISIPP-Instituto Sudamericano de Innovación de Políticas Públicas";
        emailMessage(subject, senderName, mailContent, mailSender, cor);
    }
    @Value("${spring.mail.username}")
    private String correm;

    private void emailMessage(String subject, String senderName,
            String mailContent, JavaMailSender mailSender,String cordes)
            throws MessagingException, UnsupportedEncodingException {
        MimeMessage message = mailSender.createMimeMessage();
        var messageHelper = new MimeMessageHelper(message);
        messageHelper.setFrom(correm, senderName);
        messageHelper.setTo(cordes);
        messageHelper.setSubject(subject);
        messageHelper.setText(mailContent, true);
        mailSender.send(message);
    }

}
