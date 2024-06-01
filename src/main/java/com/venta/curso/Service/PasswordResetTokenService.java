package com.venta.curso.Service;

import com.venta.curso.Entity.PasswordResetTokenEntity;
import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Interface.PasswordResetTokenInterface;
import com.venta.curso.Repository.PasswordResetTokenRepository;
import com.venta.curso.Repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Optional;

/**
 * @author Asus
 */

@Service
@RequiredArgsConstructor
public class PasswordResetTokenService implements PasswordResetTokenInterface {
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;


    @Override
    public String validatePasswordResetToken(String theToken) {
        Optional<PasswordResetTokenEntity> passwordResetToken = passwordResetTokenRepository.findByToken(theToken);
        if (passwordResetToken.isEmpty()){
            return "invalid";
        }
        Calendar calendar = Calendar.getInstance();
        if ((passwordResetToken.get().getExpirationTime().getTime()-calendar.getTime().getTime())<= 0){
            return "expired";
        }
        return "valid";
    }

    @Override
    public Optional<UserEntity> findUserByPasswordResetToken(String theToken) {
        return Optional.ofNullable(passwordResetTokenRepository.findByToken(theToken).get().getUser());
    }

    @Override
    public void resetPassword(UserEntity theUser, String newPassword) {
        theUser.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(theUser);
    }
    @Override
    public void createPasswordResetTokenForUser(UserEntity user, String passwordResetToken) {
        PasswordResetTokenEntity resetToken = new PasswordResetTokenEntity(passwordResetToken, user);
        passwordResetTokenRepository.save(resetToken);
    }

    @Override
    public void deletetoken(String id) {
        passwordResetTokenRepository.deletetoken(id); 
    }
}
