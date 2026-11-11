

CREATE DATABASE IF NOT EXISTS praktikum_modul10
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE praktikum_modul10;

-- 1. PENGGUNA
CREATE TABLE PENGGUNA (
    id_pengguna             INT          NOT NULL AUTO_INCREMENT,
    nama                    VARCHAR(100) NOT NULL,
    tanggal_lahir           DATE         NOT NULL,
    email                   VARCHAR(100) NOT NULL,
    status_aktif            BOOLEAN      NOT NULL,
    alamat                  VARCHAR(255),   -- composite: jalan, kecamatan, kota, provinsi, kode_pos
    nomor_telepon           TEXT,           -- multivalued
    role                    TEXT,           -- multivalued
    jumlah_transaksi_dibuat INT,            -- derived
    PRIMARY KEY (id_pengguna)
) ENGINE=InnoDB;

-- 2. PELANGGAN
CREATE TABLE PELANGGAN (
    id_pelanggan    INT          NOT NULL AUTO_INCREMENT,
    nama_pelanggan  VARCHAR(100) NOT NULL,
    kontak          VARCHAR(100),
    PRIMARY KEY (id_pelanggan)
) ENGINE=InnoDB;

-- 3. PEMASOK
CREATE TABLE PEMASOK (
    id_pemasok    INT          NOT NULL AUTO_INCREMENT,
    nama_pemasok  VARCHAR(100) NOT NULL,
    kontak        VARCHAR(100),
    email         VARCHAR(100),
    PRIMARY KEY (id_pemasok)
) ENGINE=InnoDB;

-- 4. PRODUK
CREATE TABLE PRODUK (
    id_produk          INT           NOT NULL AUTO_INCREMENT,
    nama_produk        VARCHAR(100)  NOT NULL,
    harga_satuan_baku  DECIMAL(15,2) NOT NULL,
    PRIMARY KEY (id_produk)
) ENGINE=InnoDB;

-- 5. KAS_REKENING
CREATE TABLE KAS_REKENING (
    id_kas         INT           NOT NULL AUTO_INCREMENT,
    nama_kas       VARCHAR(100)  NOT NULL,
    jenis_kas      VARCHAR(50)   NOT NULL,
    saldo_terkini  DECIMAL(15,2),           -- derived
    PRIMARY KEY (id_kas)
) ENGINE=InnoDB;

-- 6. TRANSAKSI
CREATE TABLE TRANSAKSI (
    id_transaksi      INT           NOT NULL AUTO_INCREMENT,
    tanggal_transaksi DATE          NOT NULL,
    waktu_transaksi   TIME          NOT NULL,
    keterangan        VARCHAR(255),
    status_validasi   VARCHAR(50)   NOT NULL,
    id_pengguna       INT           NOT NULL,
    total_nilai       DECIMAL(15,2),          -- derived
    jenis_transaksi   VARCHAR(30)   NOT NULL, -- discriminator
    PRIMARY KEY (id_transaksi),
    CONSTRAINT fk_transaksi_pengguna
        FOREIGN KEY (id_pengguna) REFERENCES PENGGUNA (id_pengguna)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 7. BUKTI_TRANSAKSI
CREATE TABLE BUKTI_TRANSAKSI (
    id_bukti        INT          NOT NULL AUTO_INCREMENT,
    id_transaksi    INT          NOT NULL,
    nomor_bukti     VARCHAR(50)  NOT NULL,
    tanggal_bukti   DATE         NOT NULL,
    jenis_transaksi VARCHAR(50)  NOT NULL,
    keterangan      VARCHAR(255),
    berkas_bukti    TEXT,                    -- multivalued
    id_pelanggan    INT          NULL,       -- opsional
    id_pemasok      INT          NULL,       -- opsional
    id_pengguna     INT          NOT NULL,
    PRIMARY KEY (id_bukti),
    CONSTRAINT fk_bukti_transaksi
        FOREIGN KEY (id_transaksi) REFERENCES TRANSAKSI (id_transaksi)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_bukti_pelanggan
        FOREIGN KEY (id_pelanggan) REFERENCES PELANGGAN (id_pelanggan)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_bukti_pemasok
        FOREIGN KEY (id_pemasok) REFERENCES PEMASOK (id_pemasok)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_bukti_pengguna
        FOREIGN KEY (id_pengguna) REFERENCES PENGGUNA (id_pengguna)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 8. PEMBAYARAN
CREATE TABLE PEMBAYARAN (
    id_transaksi      INT           NOT NULL,
    arah_pembayaran   VARCHAR(50)   NOT NULL,
    metode_bayar      VARCHAR(50)   NOT NULL,
    jumlah_bayar      DECIMAL(15,2) NOT NULL,
    id_kas            INT           NOT NULL,
    referensi         VARCHAR(100),
    status_verifikasi VARCHAR(50),          -- derived
    sisa_alokasi      DECIMAL(15,2),        -- derived
    PRIMARY KEY (id_transaksi),
    CONSTRAINT fk_pembayaran_transaksi
        FOREIGN KEY (id_transaksi) REFERENCES TRANSAKSI (id_transaksi)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_pembayaran_kas
        FOREIGN KEY (id_kas) REFERENCES KAS_REKENING (id_kas)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 9. TRANSAKSI_KAS_PEMILIK
CREATE TABLE TRANSAKSI_KAS_PEMILIK (
    id_transaksi        INT           NOT NULL,
    jenis_kas_pemilik   VARCHAR(50)   NOT NULL,
    jumlah              DECIMAL(15,2) NOT NULL,
    keterangan_tambahan VARCHAR(255),
    PRIMARY KEY (id_transaksi),
    CONSTRAINT fk_kaspemilik_transaksi
        FOREIGN KEY (id_transaksi) REFERENCES TRANSAKSI (id_transaksi)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- 10. DETAIL_PENJUALAN
CREATE TABLE DETAIL_PENJUALAN (
    id_transaksi        INT           NOT NULL,
    no_item             INT           NOT NULL,   -- partial key
    id_produk           INT           NOT NULL,
    id_pelanggan        INT           NOT NULL,
    jumlah              INT           NOT NULL,
    harga_satuan_actual DECIMAL(15,2) NOT NULL,
    diskon_item         DECIMAL(15,2) NOT NULL,
    subtotal            DECIMAL(15,2),            -- derived
    PRIMARY KEY (id_transaksi, no_item),
    CONSTRAINT fk_detjual_transaksi
        FOREIGN KEY (id_transaksi) REFERENCES TRANSAKSI (id_transaksi)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_detjual_produk
        FOREIGN KEY (id_produk) REFERENCES PRODUK (id_produk)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_detjual_pelanggan
        FOREIGN KEY (id_pelanggan) REFERENCES PELANGGAN (id_pelanggan)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 11. DETAIL_PEMBELIAN
CREATE TABLE DETAIL_PEMBELIAN (
    id_transaksi        INT           NOT NULL,
    no_item             INT           NOT NULL,   -- partial key
    id_produk           INT           NOT NULL,
    id_pemasok          INT           NOT NULL,
    jumlah              INT           NOT NULL,
    harga_satuan_actual DECIMAL(15,2) NOT NULL,
    diskon_item         DECIMAL(15,2) NOT NULL,
    subtotal            DECIMAL(15,2),            -- derived
    PRIMARY KEY (id_transaksi, no_item),
    CONSTRAINT fk_detbeli_transaksi
        FOREIGN KEY (id_transaksi) REFERENCES TRANSAKSI (id_transaksi)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_detbeli_produk
        FOREIGN KEY (id_produk) REFERENCES PRODUK (id_produk)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_detbeli_pemasok
        FOREIGN KEY (id_pemasok) REFERENCES PEMASOK (id_pemasok)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 12. LAPORAN_KEUANGAN
CREATE TABLE LAPORAN_KEUANGAN (
    id_laporan     INT          NOT NULL AUTO_INCREMENT,
    judul_laporan  VARCHAR(150) NOT NULL,
    periode        VARCHAR(50)  NOT NULL,
    tanggal_cetak  DATE         NOT NULL,
    id_pengguna    INT          NOT NULL,
    PRIMARY KEY (id_laporan),
    CONSTRAINT fk_laporan_pengguna
        FOREIGN KEY (id_pengguna) REFERENCES PENGGUNA (id_pengguna)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;
