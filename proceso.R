library(dplyr)
library(purrr)
library(jsonlite)
library(rjson)
library(tibble)

# --- Rutas de los JSON originales anidados ---
path_depresion_pais       <- "INPUT/Data/TODO/Dep1.1.json"
path_depresion_educacion  <- "INPUT/Data/TODO/Dep2.1.json"
path_egresados            <- "INPUT/Data/TODO/Egre1.1.json"
path_matriculados         <- "INPUT/Data/TODO/MatriRama.json"
path_alcohol              <- "INPUT/Data/TODO/alcohol.json"

# --- Cargar JSON originales ---
json_data1 <- fromJSON(file = path_depresion_pais)
json_data2 <- fromJSON(file = path_depresion_educacion)
json_data3 <- fromJSON(file = path_egresados)
json_data4 <- fromJSON(file = path_matriculados)
json_data6 <- fromJSON(file = path_alcohol)

# --- Función para aplanar coord + point ---
aplanar_coord_point <- function(json_list) {
  purrr::map_df(json_list, function(x) {
    c(x$coord, x$point)
  }) %>% 
    as_tibble()
}

# --- Aplicar la función a cada archivo ---
df_depresion_pais_limpia      <- aplanar_coord_point(json_data1)
df_depresion_educacion_limpia <- aplanar_coord_point(json_data2)
df_egresados_limpia           <- aplanar_coord_point(json_data3)
df_matriculados_limpia        <- aplanar_coord_point(json_data4)
df_alcohol_limpia             <- aplanar_coord_point(json_data6)

# --- Crear carpeta de salida ---
dir.create("OUTPUT/JSON_Planos", showWarnings = FALSE, recursive = TRUE)

# --- Guardar JSON planos ---
write_json(df_depresion_pais_limpia,
           "OUTPUT/JSON_Planos/DepresionPais_flat.json",
           pretty = TRUE, auto_unbox = TRUE)

write_json(df_depresion_educacion_limpia,
           "OUTPUT/JSON_Planos/DepresionEducacion_flat.json",
           pretty = TRUE, auto_unbox = TRUE)

write_json(df_egresados_limpia,
           "OUTPUT/JSON_Planos/Egresados_flat.json",
           pretty = TRUE, auto_unbox = TRUE)

write_json(df_matriculados_limpia,
           "OUTPUT/JSON_Planos/Matriculados_flat.json",
           pretty = TRUE, auto_unbox = TRUE)

write_json(df_alcohol_limpia,
           "OUTPUT/JSON_Planos/Alcohol_flat.json",
           pretty = TRUE, auto_unbox = TRUE)

# --- Verificación ---
print(head(df_depresion_pais_limpia))
