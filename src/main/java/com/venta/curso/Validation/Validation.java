package com.venta.curso.Validation;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Asus
 */
public class Validation {

    public String getfec(String fectim) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime localDateTime = LocalDateTime.parse(fectim, formatter);
        LocalDateTime localDateTim = LocalDateTime.of(localDateTime.getYear(),
                localDateTime.getMonthValue(), localDateTime.getDayOfMonth(), localDateTime.getHour(),
                localDateTime.getMinute(), localDateTime.getSecond());
        ZoneId zoneId = ZoneId.of("America/Lima");
        ZonedDateTime zonedDateTime = localDateTim.atZone(zoneId);
        DateTimeFormatter formatte = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ssXXX");
        return zonedDateTime.format(formatte);
    }

    public String factnumero(String num, int cant) {
        cant = cant - num.length();
        int i = 1;
        String resp = "";
        while (i <= cant) {
            resp = resp + "0";
            i++;
        }
        resp = resp + num;
        return resp;
    }

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
