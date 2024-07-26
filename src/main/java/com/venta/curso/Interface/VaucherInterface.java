package com.venta.curso.Interface;

import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface VaucherInterface {

    public void save(String nom, String fkidmat);
    public List<Map<String, Object>> getVaucher(String fkidmat);
}
