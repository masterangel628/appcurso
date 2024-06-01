package com.venta.curso.Event;

import com.venta.curso.Entity.UserEntity;
import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;

/**
 * @author Asus
 */

@Getter
@Setter
public class RegistrationCompleteEvent extends ApplicationEvent {
    private  UserEntity user;
    private String confirmationUrl;
    public RegistrationCompleteEvent(UserEntity user, String confirmationUrl) {
        super(user);
        this.user = user;
        this.confirmationUrl = confirmationUrl;
    }
}
