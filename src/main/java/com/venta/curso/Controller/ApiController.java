package com.venta.curso.Controller;

import com.venta.curso.Service.ApiService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author Asus
 */
@RestController
public class ApiController {

    @Autowired
    private ApiService apiService;

    @PostMapping("/send-json")
    public String sendJson() {
        return apiService.sendJson(getBody());
    }
    

    public String getBody() {
        JSONObject objetoCabecera = new JSONObject();
        objetoCabecera.put("tipo_Operacion", "0101");
        objetoCabecera.put("tipo_Doc", "01");
        objetoCabecera.put("serie", "F015");
        objetoCabecera.put("correlativo", "2");
        objetoCabecera.put("tipo_Moneda", "PEN");
        objetoCabecera.put("fecha_Emision", "2024-07-26T00:00:00-05:00");

        objetoCabecera.put("empresa_Ruc", "20607086215");

        objetoCabecera.put("cliente_Tipo_Doc", "6");
        objetoCabecera.put("cliente_Num_Doc", "20552103816");
        objetoCabecera.put("cliente_Razon_Social", "AGROLIGHT PERU S.A.C.");
        objetoCabecera.put("cliente_Direccion", "PJ. JORGE BASADRE NRO. 158, LIMA - LIMA - SANTA ANITA");

        objetoCabecera.put("monto_Oper_Gravadas", "100");
        objetoCabecera.put("monto_Igv", "18");
        objetoCabecera.put("total_Impuestos", "18");
        objetoCabecera.put("valor_Venta", "100");
        objetoCabecera.put("sub_Total", "118");
        objetoCabecera.put("monto_Imp_Venta", "118");

        objetoCabecera.put("monto_Oper_Exoneradas", "0");

        objetoCabecera.put("estado_Documento", "0");
        objetoCabecera.put("manual", false);
        objetoCabecera.put("id_Base_Dato", "152659");

        JSONArray lista = new JSONArray();
        JSONObject detalle_linea_1 = new JSONObject();

        detalle_linea_1.put("unidad", "NIU");
        detalle_linea_1.put("cantidad", "1");
        detalle_linea_1.put("cod_Producto", "CDFG");
        detalle_linea_1.put("descripcion", "PRODUCTO 1");
        detalle_linea_1.put("monto_Valor_Unitario", "100");
        detalle_linea_1.put("monto_Base_Igv", "100");
        detalle_linea_1.put("porcentaje_Igv", "18");
        detalle_linea_1.put("igv", "18");
        detalle_linea_1.put("tip_Afe_Igv", "10");
        detalle_linea_1.put("total_Impuestos", "18");
        detalle_linea_1.put("monto_Precio_Unitario", "118");
        detalle_linea_1.put("monto_Valor_Venta", "100");
        detalle_linea_1.put("factor_Icbper", "0");

        lista.add(detalle_linea_1);

        objetoCabecera.put("detalle", lista);

        JSONArray listafor = new JSONArray();
        JSONObject formpag = new JSONObject();
        formpag.put("tipo", "Contado");
        formpag.put("monto", 118);
        formpag.put("cuota", 0);
        formpag.put("fecha_Pago", "2024-02-02T00:00:00-05:00");

        listafor.add(formpag);
        objetoCabecera.put("forma_pago", listafor);

        JSONArray listaleg = new JSONArray();
        JSONObject leg = new JSONObject();
        leg.put("legend_Code", "1000");
        leg.put("legend_Value", "SON CIENTO DIECIOCHO CON 00/100 SOLES");
        listaleg.add(leg);
        objetoCabecera.put("legend", listaleg);

        return objetoCabecera.toString();

    }
}
