package com.venta.curso.Repository;

import com.venta.curso.Entity.PasswordResetTokenEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author Asus
 */
public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetTokenEntity, Long> {

    Optional<PasswordResetTokenEntity> findByToken(String theToken);

    @Modifying
    @Transactional
    @Query(value = "delete from password_reset_tokens where user_id=:id", nativeQuery = true)
    void deletetoken(@Param("id") String id);
}
