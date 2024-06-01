package com.venta.curso.Controller;

import com.venta.curso.Entity.DistritoEntity;
import com.venta.curso.Entity.PersonaEntity;
import com.venta.curso.Interface.DocenteInterface;
import com.venta.curso.Interface.PersonaInterface;
import com.venta.curso.Validation.Validation;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Asus
 */
@Controller
@RequiredArgsConstructor
public class DocenteController {

    private final DocenteInterface docenteinter;
    private final PersonaInterface personainter;

    Validation val = new Validation();

    @GetMapping("/docente")
    public String Docente() {
        return "docente";
    }

    @GetMapping("docente/mdocente")
    @ResponseBody
    public List getDocente() {
        return docenteinter.getDocente();
    }

    @PostMapping("docente/guardar")
    @ResponseBody
    public Map Guardar(@RequestParam(name = "ape") String ape, @RequestParam(name = "nom") String nom,
            @RequestParam(name = "dni") String dni, @RequestParam(name = "dir") String dir,
            @RequestParam(name = "cel") String cel, @RequestParam(name = "cor") String cor,
            @RequestParam(name = "dep") String dep, @RequestParam(name = "prov") String prov,
            @RequestParam(name = "dist") String dist) {

        Map validacion = new HashMap();

        if (!val.vacio(dni)) {
            validacion.put("dni", "El campo DNI es obligatorio");
        } else {
            if (!val.soloenteros(dni)) {
                validacion.put("dni", "El campo DNI debe tener numérico");
            } else {
                if (!val.logitud(dni, 8)) {
                    validacion.put("dni", "El campo DNI debe tener 8 caractéres");
                } else {
                    if (personainter.existepersona(dni) == 1) {
                        PersonaEntity d = personainter.getpersona(dni);
                        if (docenteinter.existedocente(String.valueOf(d.getIdpersona())) == 1) {
                            validacion.put("dni", "Ya existe un docente con este DNI");
                        }
                    }
                }
            }
        }
        if (!val.vacio(cel)) {
            validacion.put("cel", "El campo Celular es obligatorio");
        } else {
            if (!val.soloenteros(cel)) {
                validacion.put("cel", "El campo Celular debe tener numérico");
            } else {
                if (!val.logitud(cel, 9)) {
                    validacion.put("cel", "El campo Celular debe tener 9 caractéres");
                }
            }
        }

        if (!val.vacio(cor)) {
            validacion.put("cor", "El campo Correo es obligatorio");
        } else {
            if (!val.correo(cor)) {
                validacion.put("cor", "El campo Correo no es correcto");
            }else{
                if (personainter.existecorreo(cor) == 1) {
                    validacion.put("cor", "El Correo ya existe");
                }
            }
        }

        if (!val.vacio(ape)) {
            validacion.put("ape", "El campo Apellido es obligatorio");
        } else {
            if (!val.sololetras(ape)) {
                validacion.put("ape", "El campo Apellido no debe ser numérico");
            }
        }

        if (!val.vacio(nom)) {
            validacion.put("nom", "El campo Nombre es obligatorio");
        } else {
            if (!val.sololetras(nom)) {
                validacion.put("nom", "El campo Nombre no debe ser numérico");
            }
        }
        if (dep.equalsIgnoreCase("0")) {
            validacion.put("dep", "Seleccione un departamento");
        }
        if (prov.equalsIgnoreCase("0")) {
            validacion.put("prov", "Seleccione una provincia");
        }
        if (dist.equalsIgnoreCase("0")) {
            validacion.put("dist", "Seleccione un distrito");
        }

        if (validacion.isEmpty()) {
            if (personainter.existepersona(dni) == 1) {
                PersonaEntity d = personainter.getpersona(dni);
                docenteinter.guardardoc(String.valueOf(d.getIdpersona()), "Activo");
            } else {
                DistritoEntity DistritoEntity = new DistritoEntity();
                DistritoEntity.setIddistrito(dist);
                PersonaEntity PersonaEntity = new PersonaEntity();
                PersonaEntity.setApeper(ape);
                PersonaEntity.setNomper(nom);
                PersonaEntity.setDniper(dni);
                PersonaEntity.setCelper(cel);
                PersonaEntity.setDirper(dir);
                PersonaEntity.setCorreoper(cor);
                PersonaEntity.setDistrito(DistritoEntity);
                personainter.guardarpersona(PersonaEntity);
                PersonaEntity d = personainter.getpersona(dni);
                docenteinter.guardardoc(String.valueOf(d.getIdpersona()), "Activo");
            }

            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @PostMapping("docente/editar")
    @ResponseBody
    public Map Editar(@RequestParam(name = "idper") String idper, @RequestParam(name = "ape") String ape, @RequestParam(name = "nom") String nom,
            @RequestParam(name = "dni") String dni, @RequestParam(name = "dir") String dir,
            @RequestParam(name = "cel") String cel, @RequestParam(name = "cor") String cor,
            @RequestParam(name = "dep") String dep, @RequestParam(name = "prov") String prov,
            @RequestParam(name = "dist") String dist) {

        Map validacion = new HashMap();

        if (!val.vacio(dni)) {
            validacion.put("dni", "El campo DNI es obligatorio");
        } else {
            if (!val.soloenteros(dni)) {
                validacion.put("dni", "El campo DNI debe tener numérico");
            } else {
                if (!val.logitud(dni, 8)) {
                    validacion.put("dni", "El campo DNI debe tener 8 caractéres");
                } else {
                    if (personainter.existepersonaedit(dni, Integer.parseInt(idper)) == 1) {
                        validacion.put("dni", "Ya existe un persona con este DNI");
                    }
                }
            }
        }

        if (!val.vacio(ape)) {
            validacion.put("ape", "El campo Apellido es obligatorio");
        } else {
            if (!val.sololetras(ape)) {
                validacion.put("ape", "El campo Apellido no debe ser numérico");
            }
        }

        if (!val.vacio(nom)) {
            validacion.put("nom", "El campo Nombre es obligatorio");
        } else {
            if (!val.sololetras(nom)) {
                validacion.put("nom", "El campo Nombre no debe ser numérico");
            }
        }
        if (dep.equalsIgnoreCase("0")) {
            validacion.put("dep", "Seleccione un departamento");
        }
        if (prov.equalsIgnoreCase("0")) {
            validacion.put("prov", "Seleccione una provincia");
        }
        if (dist.equalsIgnoreCase("0")) {
            validacion.put("dist", "Seleccione un distrito");
        }
        if (!val.vacio(cel)) {
            validacion.put("cel", "El campo Celular es obligatorio");
        } else {
            if (!val.soloenteros(cel)) {
                validacion.put("cel", "El campo Celular debe tener numérico");
            } else {
                if (!val.logitud(cel, 9)) {
                    validacion.put("cel", "El campo Celular debe tener 9 caractéres");
                }
            }
        }

        if (!val.vacio(cor)) {
            validacion.put("cor", "El campo Correo es obligatorio");
        } else {
            if (!val.correo(cor)) {
                validacion.put("cor", "El campo Correo no es correcto");
            }else{
                if (personainter.existecorreoedit(cor,Integer.parseInt(idper)) == 1) {
                    validacion.put("cor", "El Correo ya existe");
                }
            }
        }
        if (validacion.isEmpty()) {
            DistritoEntity DistritoEntity = new DistritoEntity();
            DistritoEntity.setIddistrito(dist);
            PersonaEntity PersonaEntity = new PersonaEntity();
            PersonaEntity.setIdpersona(Integer.parseInt(idper));
            PersonaEntity.setApeper(ape);
            PersonaEntity.setNomper(nom);
            PersonaEntity.setDniper(dni);
            PersonaEntity.setCelper(cel);
            PersonaEntity.setDirper(dir);
            PersonaEntity.setCorreoper(cor);
            PersonaEntity.setDistrito(DistritoEntity);
            personainter.editarpersona(PersonaEntity);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @PostMapping("docente/cambiarestado")
    @ResponseBody
    public String CambiarEstado(@RequestParam(name = "iddoc") String iddoc, @RequestParam(name = "esta") String esta) {
        if (esta.equalsIgnoreCase("ACTIVO")) {
            docenteinter.CambiarEstado("INACTIVO", iddoc);
        }
        if (esta.equalsIgnoreCase("INACTIVO")) {
            docenteinter.CambiarEstado("ACTIVO", iddoc);
        }
        return "El Docente cambia de estado";
    }
}
