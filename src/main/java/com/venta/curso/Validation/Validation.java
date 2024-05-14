package com.venta.curso.Validation;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Asus
 */
public class Validation {

    public boolean correo(String correo) {
        String regex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(correo);
        return matcher.matches();
    }

    public boolean vacio(String cadena) {
        boolean band = false;
        if (cadena.trim().length() != 0) {
            band = true;
        }
        return band;
    }

    public boolean logitud(String cadena, int len) {
        String regex = "^.{" + len + "}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(cadena);
        return matcher.matches();
    }

    public boolean soloenteros(String num) {
        String regex = "^\\d+$";// ^[1-9]\\d*$
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(num);
        return matcher.matches();
    }

    public boolean solodecimalentero(String num) {
        String regex = "^\\d+(?:\\.\\d{1,2})?$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(num);
        return matcher.matches();
    }

    public boolean sololetras(String cadena) {
        String regex = "^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\\s]+$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(cadena);
        return matcher.matches();
    }

}
