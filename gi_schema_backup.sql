PGDMP         9                z           gltg-gi    13.5    14.4 /    q           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            r           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            s           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            t           1262    16384    gltg-gi    DATABASE     ]   CREATE DATABASE "gltg-gi" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE "gltg-gi";
                postgres    false            u           0    0    gltg-gi    DATABASE PROPERTIES     H   ALTER DATABASE "gltg-gi" SET search_path TO '$user', 'public', 'tiger';
                     postgres    false                        2615    19167    tiger    SCHEMA        CREATE SCHEMA tiger;
    DROP SCHEMA tiger;
                postgres    false                        2615    19445 
   tiger_data    SCHEMA        CREATE SCHEMA tiger_data;
    DROP SCHEMA tiger_data;
                postgres    false                        2615    19010    topology    SCHEMA        CREATE SCHEMA topology;
    DROP SCHEMA topology;
                postgres    false            v           0    0    SCHEMA topology    COMMENT     9   COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';
                   postgres    false    12                        3079    19156    fuzzystrmatch 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;
    DROP EXTENSION fuzzystrmatch;
                   false            w           0    0    EXTENSION fuzzystrmatch    COMMENT     ]   COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';
                        false    4                        3079    17995    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false            x           0    0    EXTENSION postgis    COMMENT     ^   COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';
                        false    2                        3079    19168    postgis_tiger_geocoder 	   EXTENSION     I   CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;
 '   DROP EXTENSION postgis_tiger_geocoder;
                   false    2    4    11            y           0    0     EXTENSION postgis_tiger_geocoder    COMMENT     ^   COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';
                        false    5                        3079    19011    postgis_topology 	   EXTENSION     F   CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;
 !   DROP EXTENSION postgis_topology;
                   false    12    2            z           0    0    EXTENSION postgis_topology    COMMENT     Y   COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';
                        false    3                       1259    19632    huc8    TABLE     ?   CREATE TABLE public.huc8 (
    gid integer NOT NULL,
    areaacres numeric,
    states character varying(50),
    huc8 character varying(8) NOT NULL,
    name character varying(120),
    geom public.geometry(MultiPolygon,4326)
);
    DROP TABLE public.huc8;
       public         heap    postgres    false    2    2    2    2    2    2    2    2                       1259    19638    huc8_geo_data_gid_seq    SEQUENCE     ?   CREATE SEQUENCE public.huc8_geo_data_gid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.huc8_geo_data_gid_seq;
       public          postgres    false    269            {           0    0    huc8_geo_data_gid_seq    SEQUENCE OWNED BY     F   ALTER SEQUENCE public.huc8_geo_data_gid_seq OWNED BY public.huc8.gid;
          public          postgres    false    270                       1259    27798    huc_practice_relations    TABLE     ?   CREATE TABLE public.huc_practice_relations (
    huc_practice_id integer NOT NULL,
    huc8_id character varying(8) NOT NULL,
    practice_id integer NOT NULL
);
 *   DROP TABLE public.huc_practice_relations;
       public         heap    postgres    false                       1259    27823    huc_practice_id_seq    SEQUENCE     |   CREATE SEQUENCE public.huc_practice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.huc_practice_id_seq;
       public          postgres    false    272            |           0    0    huc_practice_id_seq    SEQUENCE OWNED BY     b   ALTER SEQUENCE public.huc_practice_id_seq OWNED BY public.huc_practice_relations.huc_practice_id;
          public          postgres    false    273                       1259    27926    huc_practice_id_swq    SEQUENCE     |   CREATE SEQUENCE public.huc_practice_id_swq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.huc_practice_id_swq;
       public          postgres    false    272            }           0    0    huc_practice_id_swq    SEQUENCE OWNED BY     b   ALTER SEQUENCE public.huc_practice_id_swq OWNED BY public.huc_practice_relations.huc_practice_id;
          public          postgres    false    277                       1259    19649 	   practices    TABLE     Y  CREATE TABLE public.practices (
    practice_id integer NOT NULL,
    city character varying(50),
    county character varying(50),
    installation_date character varying(50),
    practice_cost double precision,
    practice_drainage_area double precision,
    new_development_or_retrofit character varying(50),
    type_id integer NOT NULL
);
    DROP TABLE public.practices;
       public         heap    postgres    false                       1259    27826    practice_id_seq    SEQUENCE     x   CREATE SEQUENCE public.practice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.practice_id_seq;
       public          postgres    false    271            ~           0    0    practice_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.practice_id_seq OWNED BY public.practices.practice_id;
          public          postgres    false    274                       1259    27910    practice_types    TABLE       CREATE TABLE public.practice_types (
    practice_type_id integer NOT NULL,
    practice_category_type_name character varying(255) NOT NULL,
    practice_category character varying(255) NOT NULL,
    practice_source character varying(255),
    practice_definition text
);
 "   DROP TABLE public.practice_types;
       public         heap    postgres    false                       1259    27908 #   practice_types_practice_type_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.practice_types_practice_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.practice_types_practice_type_id_seq;
       public          postgres    false    276                       0    0 #   practice_types_practice_type_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.practice_types_practice_type_id_seq OWNED BY public.practice_types.practice_type_id;
          public          postgres    false    275            X           2604    19652    huc8 gid    DEFAULT     m   ALTER TABLE ONLY public.huc8 ALTER COLUMN gid SET DEFAULT nextval('public.huc8_geo_data_gid_seq'::regclass);
 7   ALTER TABLE public.huc8 ALTER COLUMN gid DROP DEFAULT;
       public          postgres    false    270    269            Z           2604    27928 &   huc_practice_relations huc_practice_id    DEFAULT     ?   ALTER TABLE ONLY public.huc_practice_relations ALTER COLUMN huc_practice_id SET DEFAULT nextval('public.huc_practice_id_seq'::regclass);
 U   ALTER TABLE public.huc_practice_relations ALTER COLUMN huc_practice_id DROP DEFAULT;
       public          postgres    false    273    272            [           2604    27913    practice_types practice_type_id    DEFAULT     ?   ALTER TABLE ONLY public.practice_types ALTER COLUMN practice_type_id SET DEFAULT nextval('public.practice_types_practice_type_id_seq'::regclass);
 N   ALTER TABLE public.practice_types ALTER COLUMN practice_type_id DROP DEFAULT;
       public          postgres    false    276    275    276            Y           2604    27828    practices practice_id    DEFAULT     t   ALTER TABLE ONLY public.practices ALTER COLUMN practice_id SET DEFAULT nextval('public.practice_id_seq'::regclass);
 D   ALTER TABLE public.practices ALTER COLUMN practice_id DROP DEFAULT;
       public          postgres    false    274    271            ?           2606    27797    huc8 huc8_primary_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.huc8
    ADD CONSTRAINT huc8_primary_key PRIMARY KEY (huc8);
 ?   ALTER TABLE ONLY public.huc8 DROP CONSTRAINT huc8_primary_key;
       public            postgres    false    269            ?           2606    19715    huc8 huc8_unique 
   CONSTRAINT     K   ALTER TABLE ONLY public.huc8
    ADD CONSTRAINT huc8_unique UNIQUE (huc8);
 :   ALTER TABLE ONLY public.huc8 DROP CONSTRAINT huc8_unique;
       public            postgres    false    269            ?           2606    27802 2   huc_practice_relations huc_practice_relations_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.huc_practice_relations
    ADD CONSTRAINT huc_practice_relations_pkey PRIMARY KEY (huc_practice_id);
 \   ALTER TABLE ONLY public.huc_practice_relations DROP CONSTRAINT huc_practice_relations_pkey;
       public            postgres    false    272            ?           2606    19721    practices practice_id_pk 
   CONSTRAINT     _   ALTER TABLE ONLY public.practices
    ADD CONSTRAINT practice_id_pk PRIMARY KEY (practice_id);
 B   ALTER TABLE ONLY public.practices DROP CONSTRAINT practice_id_pk;
       public            postgres    false    271            ?           2606    27925 (   practice_types practice_type_primary_key 
   CONSTRAINT     t   ALTER TABLE ONLY public.practice_types
    ADD CONSTRAINT practice_type_primary_key PRIMARY KEY (practice_type_id);
 R   ALTER TABLE ONLY public.practice_types DROP CONSTRAINT practice_type_primary_key;
       public            postgres    false    276            ?           2606    27918 &   practice_types unique_practice_type_id 
   CONSTRAINT     m   ALTER TABLE ONLY public.practice_types
    ADD CONSTRAINT unique_practice_type_id UNIQUE (practice_type_id);
 P   ALTER TABLE ONLY public.practice_types DROP CONSTRAINT unique_practice_type_id;
       public            postgres    false    276            ?           1259    19724    huc8_geo_data_geom_idx    INDEX     F   CREATE INDEX huc8_geo_data_geom_idx ON public.huc8 USING gist (geom);
 *   DROP INDEX public.huc8_geo_data_geom_idx;
       public            postgres    false    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    269            ?           2606    27813    huc_practice_relations fk_huc8    FK CONSTRAINT     ~   ALTER TABLE ONLY public.huc_practice_relations
    ADD CONSTRAINT fk_huc8 FOREIGN KEY (huc8_id) REFERENCES public.huc8(huc8);
 H   ALTER TABLE ONLY public.huc_practice_relations DROP CONSTRAINT fk_huc8;
       public          postgres    false    269    272    4314            ?           2606    27818 "   huc_practice_relations fk_practice    FK CONSTRAINT     ?   ALTER TABLE ONLY public.huc_practice_relations
    ADD CONSTRAINT fk_practice FOREIGN KEY (practice_id) REFERENCES public.practices(practice_id);
 L   ALTER TABLE ONLY public.huc_practice_relations DROP CONSTRAINT fk_practice;
       public          postgres    false    272    4316    271            ?           2606    27919    practices fkey_practice_type_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public.practices
    ADD CONSTRAINT fkey_practice_type_id FOREIGN KEY (type_id) REFERENCES public.practice_types(practice_type_id) NOT VALID;
 I   ALTER TABLE ONLY public.practices DROP CONSTRAINT fkey_practice_type_id;
       public          postgres    false    271    276    4322            ?           2606    27803 :   huc_practice_relations huc_practice_relations_huc8_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.huc_practice_relations
    ADD CONSTRAINT huc_practice_relations_huc8_id_fkey FOREIGN KEY (huc8_id) REFERENCES public.huc8(huc8);
 d   ALTER TABLE ONLY public.huc_practice_relations DROP CONSTRAINT huc_practice_relations_huc8_id_fkey;
       public          postgres    false    4314    272    269            ?           2606    27808 >   huc_practice_relations huc_practice_relations_practice_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.huc_practice_relations
    ADD CONSTRAINT huc_practice_relations_practice_id_fkey FOREIGN KEY (practice_id) REFERENCES public.practices(practice_id);
 h   ALTER TABLE ONLY public.huc_practice_relations DROP CONSTRAINT huc_practice_relations_practice_id_fkey;
       public          postgres    false    271    272    4316           