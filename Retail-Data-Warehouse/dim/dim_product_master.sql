-- Table: dim.product_master

DROP TABLE IF EXISTS dim.product_master;

CREATE TABLE dim.product_master
                 (
                              product_code    VARCHAR(255) primary key
                            , name            VARCHAR(255)
                            , category        VARCHAR(255)
                            , subcategory     VARCHAR(255)
                            , subsubcategory  VARCHAR(255)
                            , material        VARCHAR(255)
                            , color           VARCHAR(255)
                            , origin          VARCHAR(255)
                            , ean             bigint
                            , is_active       boolean
                            , has_bluetooth   boolean
                            , size            VARCHAR(255)
                 );
