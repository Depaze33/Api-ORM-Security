DROP TABLE if exists public.account CASCADE;

/* TODO : ajouter la création de la table "client" */

CREATE TABLE client
(
    id UUID PRIMARY KEY,
    first_name VARCHAR(100),
    last_name  VARCHAR(50),
    email      VARCHAR(50),
    birthdate   date
);

CREATE TABLE account
(
    id           SERIAL PRIMARY KEY,
    creationTime timestamp,
    balance      bigint,
    id_client UUID references client (id)
);

CREATE TABLE USER (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(200),
    email VARCHAR(1000),
    password VARCHAR(100),
    creat_at DATE,
    update_at DATE
)