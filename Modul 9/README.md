Ini merupakan repository untuk pengerjaan Tugas Modul 9 pada Kelompok 8 (NixOS) Praktikum Mata Kuliah Basis Data.


Berikut nama contributornya:

1. Edgar Rizki P.N. 
2. Rifqi Adyasta M.
3. Bramanta Setya B.


Repository ini digunakan untuk mengerjakan soal unjuk kerja pada bagian ini:

| No. | Tugas / Unjuk Kerja                                                                                                                                                                                                                                                                                                                                         |
| --- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | Eksplorasi JOIN (Tahap 1): Tulis dan eksekusi satu query yang menggunakan JOIN (minimal 2 tabel) dikombinasikan dengan fungsi agregasi (misal: menghitung total transaksi per pelanggan atau total barang terjual). Catat kompleksitas query-nya.                                                                                                           |
| 2   | Penerapan Denormalisasi (Tahap 2): Eksekusi DDL (ALTER TABLE atau CREATE TABLE) untuk menambahkan satu atribut turunan pada tabel master ATAU membuat satu tabel rekapitulasi yang menyimpan hasil dari perhitungan tahap 1. [CONTOH ILUSTRASI, uji dulu di versi yang dipakai]:<br>ALTER TABLE pelanggan ADD COLUMN total_belanja DECIMAL(15,2) DEFAULT 0; |
| 3   | Pembuktian (Tahap 3): Tulis query SELECT sederhana untuk memanggil data dari kolom/tabel denormalisasi (Tahap 2) tanpa menggunakan JOIN<br>atau agregasi. Bandingkan dengan query Tahap 1.                                                                                                                                                                  |
| 4   | Presentasi Kelompok & Git: Simpan (commit & push) berkas .sql ke Git kelompok. Demonstrasikan perbandingan query JOIN (sebelum) vs query denormalisasi (sesudah) di DBMS Anda kepada dosen pengampu.                                                                                                                                                        |
