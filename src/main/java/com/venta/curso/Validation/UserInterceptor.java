package com.venta.curso.Validation;

import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Interface.UserInterface;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Asus
 */
@Component
@RequiredArgsConstructor
public class UserInterceptor implements HandlerInterceptor {

    private final UserInterface userInterface;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {
        if (modelAndView != null) {
            UserEntity user = userInterface.getinfouser();
            if (user != null) {
                modelAndView.addObject("nom", user.getPersona().getNomper());
                modelAndView.addObject("ape", user.getPersona().getApeper());
                modelAndView.addObject("username", user.getUsername());
            }
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
    }

}
