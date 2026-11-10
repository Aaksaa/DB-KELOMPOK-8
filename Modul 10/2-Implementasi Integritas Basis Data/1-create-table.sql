CREATE DATABASE IF NOT EXISTS modul-10;
USE modul-10;

CREATE TABLE PENGGUNA (
    id_pengguna             INT          NOT NULL AUTO_INCREMENT,
    nama                    VARCHAR(100) NOT NULL,
    tanggal_lahir           DATE         NOT NULL,
    email                   VARCHAR(100) NOT NULL,
    status_aktif            BOOLEAN      NOT NULL,
    alamat                  VARCHAR(255),
    nomor_telepon           TEXT,
    role                    TEXT,
    jumlah_transaksi_dibuat INT,
    PRIMARY KEY (id_pengguna)
) ENGINE=InnoDB;

CREATE TABLE TRANSAKSI (
    id_transaksi      INT           NOT NULL AUTO_INCREMENT,
    tanggal_transaksi DATE          NOT NULL,
    waktu_transaksi   TIME          NOT NULL,
    keterangan        VARCHAR(255),
    status_validasi   VARCHAR(50)   NOT NULL,
    id_pengguna       INT           NOT NULL,
    total_nilai       DECIMAL(15,2),
    jenis_transaksi   VARCHAR(30)   NOT NULL,
    PRIMARY KEY (id_transaksi),
    CONSTRAINT fk_transaksi_pengguna
        FOREIGN KEY (id_pengguna) REFERENCES PENGGUNA (id_pengguna)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE DETAIL_PENJUALAN (
    id_transaksi        INT           NOT NULL,
    no_item             INT           NOT NULL,
    id_produk           INT           NOT NULL,
    id_pelanggan        INT           NOT NULL,
    jumlah              INT           NOT NULL,
    harga_satuan_actual DECIMAL(15,2) NOT NULL,
    diskon_item         DECIMAL(15,2) NOT NULL,
    subtotal            DECIMAL(15,2),
    PRIMARY KEY (id_transaksi, no_item),
    CONSTRAINT fk_detjual_transaksi
        FOREIGN KEY (id_transaksi) REFERENCES TRANSAKSI (id_transaksi)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB;

ALTER TABLE PENGGUNA ADD CONSTRAINT uq_pengguna_email UNIQUE (email);
ALTER TABLE DETAIL_PENJUALAN ADD CONSTRAINT chk_detjual_jumlah CHECK (jumlah > 0);
ALTER TABLE DETAIL_PENJUALAN ADD CONSTRAINT chk_detjual_diskon CHECK (diskon_item >= 0);
ALTER TABLE PENGGUNA ADD CONSTRAINT uq_pengguna_email UNIQUE (email);