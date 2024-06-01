package com.venta.curso.Util;

import jakarta.servlet.http.HttpServletRequest;

/**
 * @author Asus
 */

public class UrlUtil {
    public static String getApplicationUrl(HttpServletRequest request){
        String appUrl = request.getRequestURL().toString();
        return appUrl.replace(request.getServletPath(), "");

    }
}
