-- Suppression des tables si elles existent
DROP TABLE IF EXISTS public.alerts CASCADE;
DROP TABLE IF EXISTS public.mesures CASCADE;
DROP TABLE IF EXISTS public.lots CASCADE;

-- Création des tables
CREATE TABLE public.lots (
    nom character varying(25) NOT NULL,
    type character varying(25) NOT NULL,
    max double precision,
    min double precision,
    description text,
    date_debut date DEFAULT CURRENT_DATE,
    duree_jours integer DEFAULT 365,
    CONSTRAINT lots_pkey PRIMARY KEY (nom)
);

CREATE TABLE public.mesures (
    id integer NOT NULL,
    nom character varying(25),
    valeur double precision,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT mesures_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE public.mesures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.mesures_id_seq OWNED BY public.mesures.id;
ALTER TABLE ONLY public.mesures ALTER COLUMN id SET DEFAULT nextval('public.mesures_id_seq'::regclass);

CREATE TABLE public.alerts (
    id integer NOT NULL,
    nom character varying(25),
    valeur double precision,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_checked boolean DEFAULT false,
    CONSTRAINT alerts_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE public.alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.alerts_id_seq OWNED BY public.alerts.id;
ALTER TABLE ONLY public.alerts ALTER COLUMN id SET DEFAULT nextval('public.alerts_id_seq'::regclass);

-- Ajout des contraintes de clé étrangère
ALTER TABLE ONLY public.mesures
    ADD CONSTRAINT mesures_nom_fkey FOREIGN KEY (nom) REFERENCES public.lots(nom);

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_nom_fkey FOREIGN KEY (nom) REFERENCES public.lots(nom);

-- Insertion des données pour les lots
INSERT INTO public.lots (nom, type, max, min, description, date_debut, duree_jours) VALUES
('dht22-h1', 'humidite', 29.0, NULL, 'Capteur de humidité de la zone 1', '2026-06-20', 365),
('dht22-t1', 'temperature', 300.0, NULL, 'Capteur de temerature de la zone 1', '2026-06-24', 365);