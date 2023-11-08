PGDMP  2                
    {         	   nutc_csie    14.9 (Homebrew)    16.0     .           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            /           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            0           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            1           1262    16385 	   nutc_csie    DATABASE     k   CREATE DATABASE nutc_csie WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE nutc_csie;
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
             	   imac-3373    false            2           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                	   imac-3373    false    4            �            1259    24586    category    TABLE     `   CREATE TABLE public.category (
    id uuid NOT NULL,
    name character varying(30) NOT NULL
);
    DROP TABLE public.category;
       public         heap    postgres    false    4            �            1259    24596    customer    TABLE     `   CREATE TABLE public.customer (
    id uuid NOT NULL,
    name character varying(20) NOT NULL
);
    DROP TABLE public.customer;
       public         heap    postgres    false    4            �            1259    24611    item    TABLE     �   CREATE TABLE public.item (
    id uuid NOT NULL,
    order_id uuid NOT NULL,
    product_id uuid NOT NULL,
    is_shipped boolean NOT NULL
);
    DROP TABLE public.item;
       public         heap    postgres    false    4            �            1259    24606    order    TABLE     s   CREATE TABLE public."order" (
    id uuid NOT NULL,
    customer_id uuid NOT NULL,
    is_paid boolean NOT NULL
);
    DROP TABLE public."order";
       public         heap    postgres    false    4            �            1259    24576    product    TABLE     �   CREATE TABLE public.product (
    id uuid NOT NULL,
    name character varying(20) NOT NULL,
    price integer NOT NULL,
    category_id uuid
);
    DROP TABLE public.product;
       public         heap    postgres    false    4            �            1259    16386    students    TABLE     �   CREATE TABLE public.students (
    id uuid NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    student_id character varying(20) NOT NULL,
    department_id uuid
);
    DROP TABLE public.students;
       public         heap    postgres    false    4            (          0    24586    category 
   TABLE DATA           ,   COPY public.category (id, name) FROM stdin;
    public          postgres    false    211   �       )          0    24596    customer 
   TABLE DATA           ,   COPY public.customer (id, name) FROM stdin;
    public          postgres    false    212   �       +          0    24611    item 
   TABLE DATA           D   COPY public.item (id, order_id, product_id, is_shipped) FROM stdin;
    public          postgres    false    214   W       *          0    24606    order 
   TABLE DATA           ;   COPY public."order" (id, customer_id, is_paid) FROM stdin;
    public          postgres    false    213          '          0    24576    product 
   TABLE DATA           ?   COPY public.product (id, name, price, category_id) FROM stdin;
    public          postgres    false    210   �       &          0    16386    students 
   TABLE DATA           X   COPY public.students (id, first_name, last_name, student_id, department_id) FROM stdin;
    public          postgres    false    209          �           2606    24595    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    211            �           2606    24600    customer custom_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT custom_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.customer DROP CONSTRAINT custom_pkey;
       public            postgres    false    212            �           2606    24615    item item_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.item DROP CONSTRAINT item_pkey;
       public            postgres    false    214            �           2606    24610    order order_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_pkey;
       public            postgres    false    213            �           2606    24580    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    210            �           2606    16390    students student_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.students
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY public.students DROP CONSTRAINT student_pkey;
       public            postgres    false    209            (   M   x����  �:�BQvIB��]��%��`n&ԕ��1��zٔ槪�4=��j���<���8q�|�� ����      )   T   x�ʱ�  ���/�q]�&@Rj��R����uoH>�y�y	��IH�<J�?���c�(����bJE����~po �݆�      +   �   x�ͻ�D!DQ��KO郐�e! ���[�ɳ��㍠�$�����k��������d�H'xy]�3�6J�1���m�>^t;�l_�n�Q2Y7�JCW��j�z�#�Y�U�x��9�~
A�̠��~�ӳYt+��IE+��J%w��r��߯���:      *   t   x����  �s�<�#��^`�%���db�lw�X'8�F8:�I��B�-iX'>�B��t@�B�$��s��*�٠5��,-�r��H������ �Zk�����x��;��	�&�      '      x��I  ����dQ����&m���p%N'U�����;���sT;�i��$v�1� Qu�4���l�ї�a+s��
Ka^!��;����V#��}mg�E2���,*ƚ�\ԟ����++	      &   q   x�U�!�0@Q��œ�8�MG'�v�B�&�Jz��|��1���0'��	x��#u6��kx�k��7�W��0'��f�4��98��
�c����0�a�[�������c< �� �     