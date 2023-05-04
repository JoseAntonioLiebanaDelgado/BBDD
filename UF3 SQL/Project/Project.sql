use logs;
CREATE TABLE IF NOT EXISTS log (
    Id_logs INT AUTO_INCREMENT NOT NULL,
    fecha DATE,
    hora DATETIME,
    nameMachine VARCHAR(20),
    mensaje VARCHAR(100),
    PRIMARY KEY(Id_logs)
);

CREATE TABLE IF NOT EXISTS stats (
    Id_stats INT AUTO_INCREMENT NOT NULL,
    fecha DATE,
    nom_fitxer VARCHAR(100),
    num_filas_fichero INT,
    num_filas_proceso INT,
    esFinDeSemana BOOLEAN,
    PRIMARY KEY(Id_stats),
    FOREIGN KEY (Id_stats) references log(Id_logs)
);