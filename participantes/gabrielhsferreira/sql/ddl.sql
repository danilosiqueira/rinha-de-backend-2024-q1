﻿CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "Clientes" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "Limite" integer NOT NULL,
    "Saldo" integer NOT NULL,
    CONSTRAINT "PK_Clientes" PRIMARY KEY ("Id")
);

CREATE TABLE "Transacoes" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "Tipo" integer NOT NULL,
    "Valor" integer NOT NULL,
    "Descricao" character varying(10) NOT NULL,
    "RealizadaEm" timestamp with time zone NOT NULL,
    "IdCliente" integer NOT NULL,
    CONSTRAINT "PK_Transacoes" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Transacoes_Clientes_IdCliente" FOREIGN KEY ("IdCliente") REFERENCES "Clientes" ("Id") ON DELETE CASCADE
);

INSERT INTO "Clientes" ("Id", "Limite", "Saldo")
VALUES (1, 100000, 0);
INSERT INTO "Clientes" ("Id", "Limite", "Saldo")
VALUES (2, 80000, 0);
INSERT INTO "Clientes" ("Id", "Limite", "Saldo")
VALUES (3, 1000000, 0);
INSERT INTO "Clientes" ("Id", "Limite", "Saldo")
VALUES (4, 10000000, 0);
INSERT INTO "Clientes" ("Id", "Limite", "Saldo")
VALUES (5, 500000, 0);

CREATE INDEX "IX_Transacoes_IdCliente" ON "Transacoes" ("IdCliente");

SELECT setval(
    pg_get_serial_sequence('"Clientes"', 'Id'),
    GREATEST(
        (SELECT MAX("Id") FROM "Clientes") + 1,
        nextval(pg_get_serial_sequence('"Clientes"', 'Id'))),
    false);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20240301183953_Initial', '8.0.2');

COMMIT;
