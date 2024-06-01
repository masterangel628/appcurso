package com.venta.curso.Interface;

import com.venta.curso.Entity.UserEntity;

import java.util.Optional;

/**
 * @author Asus
 */
public interface PasswordResetTokenInterface {

    String validatePasswordResetToken(String theToken);

    Optional<UserEntity> findUserByPasswordResetToken(String theToken);

    void resetPassword(UserEntity theUser, String password);

    void createPasswordResetTokenForUser(UserEntity user, String passwordResetToken);
    
    void deletetoken(String id);
}
