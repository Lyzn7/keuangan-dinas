-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Nov 2025 pada 06.45
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `monitor_keuangan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggaran`
--

CREATE TABLE `anggaran` (
  `id_anggaran` bigint(20) NOT NULL,
  `id_rekening` int(11) NOT NULL,
  `tahun` int(11) NOT NULL,
  `bulan` tinyint(4) NOT NULL CHECK (`bulan` between 1 and 12),
  `jenis` enum('murni','pergeseran','perubahan') NOT NULL,
  `nilai_bulanan` decimal(20,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `anggaran`
--

INSERT INTO `anggaran` (`id_anggaran`, `id_rekening`, `tahun`, `bulan`, `jenis`, `nilai_bulanan`, `created_at`) VALUES
(610, 206, 2025, 11, 'perubahan', 3000000.00, '2025-11-24 06:58:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggaran_tahunan`
--

CREATE TABLE `anggaran_tahunan` (
  `id` int(11) NOT NULL,
  `id_rekening` int(11) NOT NULL,
  `tahun` int(11) NOT NULL,
  `jenis` enum('murni','pergeseran','perubahan') NOT NULL,
  `nilai_tahunan` decimal(18,2) NOT NULL,
  `bulan_mulai` tinyint(4) NOT NULL DEFAULT 1,
  `bulan_selesai` tinyint(4) NOT NULL DEFAULT 12,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `anggaran_tahunan`
--

INSERT INTO `anggaran_tahunan` (`id`, `id_rekening`, `tahun`, `jenis`, `nilai_tahunan`, `bulan_mulai`, `bulan_selesai`, `is_active`) VALUES
(219, 206, 2025, 'perubahan', 20000000.00, 11, 12, 1),
(220, 163, 2025, 'perubahan', 20000000.00, 11, 12, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kegiatan`
--

CREATE TABLE `kegiatan` (
  `id_kegiatan` int(11) NOT NULL,
  `id_program` int(11) NOT NULL,
  `kode_kegiatan` varchar(50) NOT NULL,
  `nama_kegiatan` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kegiatan`
--

INSERT INTO `kegiatan` (`id_kegiatan`, `id_program`, `kode_kegiatan`, `nama_kegiatan`, `is_active`) VALUES
(1, 1, '2.23.01.2.01', 'Perencanaan, Penganggaran, dan Evaluasi Kinerja Perangkat Daerah', 1),
(2, 1, '2.23.01.2.02', 'Administrasi Keuangan Perangkat Daerah ', 1),
(3, 1, '2.23.01.2.05', 'Administrasi Kepegawaian Perangkat Daerah ', 1),
(4, 1, '2.23.01.2.06', 'Administrasi Umum Perangkat Daerah', 1),
(5, 1, '2.23.01.2.07', 'Pengadaan Barang Milik Daerah Penunjang Urusan Pemerintah Daerah', 1),
(6, 1, '2.23.01.2.08', 'Penyediaan Jasa Penunjang Urusan Pemerintahan Daerah', 1),
(7, 1, '2.23.01.2.09', 'Pemeliharaan Barang Milik Daerah Penunjang Urusan Pemerintahan Daerah', 1),
(8, 2, '2.23.02.2.01', 'Pengelolaan Perpustakaan Tingkat Daerah Kabupaten/Kota ', 1),
(9, 2, '2.23.02.2.02', 'Pembudayaan Gemar Membaca Tingkat Daerah Kabupaten/Kota', 1),
(10, 3, '2.23.03.2.01', 'Pelestarian Naskah Kuno Milik Daerah Kabupaten/Kota ', 1),
(11, 4, '2.24.02.2.01', 'Pengelolaan Arsip Dinamis Daerah Kabupaten/Kota ', 1),
(12, 4, '2.24.02.2.02', 'Pengelolaan Arsip Statis Daerah Kabupaten/Kota ', 1),
(14, 8, '123456', 'kegiatan baru', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `program`
--

CREATE TABLE `program` (
  `id_program` int(11) NOT NULL,
  `kode_program` varchar(50) NOT NULL,
  `nama_program` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `program`
--

INSERT INTO `program` (`id_program`, `kode_program`, `nama_program`, `is_active`) VALUES
(1, '2.23.01', 'PROGRAM PENUNJANG URUSAN PEMERINTAHAN DAERAH KABUPATEN/KOTA', 1),
(2, '2.23.02', 'PROGRAM PEMBINAAN PERPUSTAKAAN', 1),
(3, '2.23.03', 'PROGRAM PELESTARIAN KOLEKSI NASIONAL DAN NASKAH KUNO ', 1),
(4, '2.24.02', 'PROGRAM PENGELOLAAN ARSIP ', 1),
(8, '223-2002-54', 'program baru nich', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `realisasi_detail`
--

CREATE TABLE `realisasi_detail` (
  `id_detail` int(11) NOT NULL,
  `id_rekening` int(11) NOT NULL,
  `tahun` int(11) NOT NULL,
  `bulan` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah_realisasi` decimal(20,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `realisasi_detail`
--

INSERT INTO `realisasi_detail` (`id_detail`, `id_rekening`, `tahun`, `bulan`, `tanggal`, `jumlah_realisasi`, `created_at`) VALUES
(484, 206, 2025, 11, '2025-11-01', 400000.00, '2025-11-24 07:00:51'),
(485, 206, 2025, 11, '2025-11-05', 500000.00, '2025-11-24 07:01:34'),
(486, 206, 2025, 11, '2025-11-15', 600000.00, '2025-11-24 07:02:26'),
(487, 206, 2025, 11, '2025-11-22', 700000.00, '2025-11-24 07:03:20'),
(488, 206, 2025, 11, '2025-11-22', 400000.00, '2025-11-24 07:06:51'),
(489, 206, 2025, 11, '2025-11-24', 400000.00, '2025-11-24 07:08:59');

-- --------------------------------------------------------

--
-- Struktur dari tabel `rekening`
--

CREATE TABLE `rekening` (
  `id_rekening` int(11) NOT NULL,
  `id_subkegiatan` int(11) NOT NULL,
  `kode_rekening` varchar(50) NOT NULL,
  `nama_rekening` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `rekening`
--

INSERT INTO `rekening` (`id_rekening`, `id_subkegiatan`, `kode_rekening`, `nama_rekening`, `is_active`) VALUES
(1, 1, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(2, 1, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(3, 1, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(4, 1, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(5, 1, '5.1.02.02.01.0003', 'Honorarium Narasumber atau Pembahas, Moderator, Pembawa Acara, dan Panitia', 1),
(6, 1, '5.1.02.02.01.0071', 'Belanja Lembur', 1),
(7, 1, '5.1.02.04.01.0003', 'Belanja Perjalanan Dinas Dalam Kota \n Dinas Dalam Kota', 1),
(8, 2, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor Alat Tulis Kantor', 1),
(9, 2, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor-Kertas dan Cover', 1),
(10, 2, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(11, 3, '5.1.01.01.01.0001', 'Belanja Gaji Pokok PNS', 1),
(12, 3, '5.1.01.01.01.0002', 'Belanja Gaji Pokok PPPK', 1),
(13, 3, '5.1.01.01.02.0001', 'Belanja Tunjangan Keluarga PNS ', 1),
(14, 3, '5.1.01.01.02.0002', 'Belanja Tunjangan Keluarga PPPK', 1),
(15, 3, '5.1.01.01.03.0001', 'Belanja Tunjangan Jabatan PNS', 1),
(16, 3, '5.1.01.01.04.0001', 'Belanja Tunjangan Fungsional PNS ', 1),
(17, 3, '5.1.01.01.05.0001', 'Belanja Tunjangan Fungsional Umum PNS', 1),
(18, 3, '5.1.01.01.05.0002', 'Belanja Tunjangan Fungsional Umum PPPK', 1),
(19, 3, '5.1.01.01.06.0001', 'Belanja Tunjangan Beras PNS ', 1),
(20, 3, '5.1.01.01.06.0002', 'Belanja Tunjangan Beras PPPK', 1),
(21, 3, '5.1.01.01.07.0001', 'Belanja Tunjangan PPh/Tunjangan Khusus PNS', 1),
(22, 3, '5.1.01.01.07.0002', 'Belanja Tunjangan PPh/Tunjangan Khusus PPPK', 1),
(23, 3, '5.1.01.01.08.0001', 'Belanja Pembulatan Gaji PNS', 1),
(24, 3, '5.1.01.01.08.0002', 'Belanja Pembulatan Gaji PPPK', 1),
(25, 3, '5.1.01.01.10.0001', 'Belanja Iuran Jaminan Kecelakaan Kerja PNS', 1),
(26, 3, '5.1.01.01.10.0002', 'Belanja Iuran Jaminan Kecelakaan Kerja PPPK', 1),
(27, 3, '5.1.01.01.11.0001', 'Belanja Iuran Jaminan Kematian PNS', 1),
(28, 3, '5.1.01.01.11.0002', 'Belanja Iuran Jaminan Kematian PPPK', 1),
(29, 4, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(30, 4, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(31, 4, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(32, 4, '5.1.02.02.01.0001', 'Belanja Jasa Pengelolaan BMD yang Tidak Menghasilkan Pendapatan ', 1),
(33, 4, '5.1.02.02.01.0080', 'Belanja Honorarium Penanggungjawaban Pengelola Keuangan', 1),
(34, 5, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(35, 5, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(36, 5, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(37, 5, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(38, 5, '5.1.02.02.01.0071', 'Belanja Lembur', 1),
(39, 6, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(40, 6, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(41, 6, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(42, 6, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(43, 7, '5.1.02.02.12.0001', 'Belanja Kursus Singkat/Pelatihan ', 1),
(44, 8, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(45, 8, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(46, 8, '5.1.02.01.01.0027', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Benda Pos', 1),
(47, 8, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(48, 8, '5.1.02.02.01.0062', 'Belanja Langganan Jurnal/Surat Kabar/Majalah', 1),
(49, 9, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(50, 9, '5.1.02.01.01.0053', 'Belanja Makanan dan Minuman Jamuan Tamu', 1),
(51, 9, '5.1.02.04.01.0001', 'Belanja Perjalanan Dinas Biasa', 1),
(52, 9, '5.1.02.04.01.0003', 'Belanja Perjalanan Dinas Dalam Kota \n Dinas Dalam Kota', 1),
(53, 10, '5.2.02.05.01.0004', 'Belanja Modal Alat Penyimpan Perlengkapan Kantor', 1),
(54, 11, '5.1.02.02.01.0059', 'Belanja Tagihan Telepon', 1),
(55, 11, '5.1.02.02.01.0060', 'Belanja Tagihan Air', 1),
(56, 11, '5.1.02.02.01.0061', 'Belanja Tagihan Listrik', 1),
(57, 12, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(58, 12, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(59, 12, '5.1.02.01.01.0027', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Benda Pos', 1),
(60, 12, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(61, 12, '5.1.02.02.01.0030', 'Belanja Jasa Tenaga Kebersihan', 1),
(62, 12, '5.1.02.02.01.0031', 'Belanja Jasa Tenaga Keamanan', 1),
(63, 12, '5.1.02.02.01.0033', 'Belanja Jasa Tenaga Supir', 1),
(64, 12, '5.1.02.02.02.0005', 'Belanja Iuran Jaminan Kesehatan bagi Non ASN', 1),
(65, 12, '5.1.02.02.02.0006', 'Belanja Iuran Jaminan Kecelakaan Kerja bagi Non ASN', 1),
(66, 12, '5.1.02.02.02.0007', 'Belanja Iuran Jaminan Kematian bagi Non ASN', 1),
(67, 13, '5.1.02.01.01.0004', 'Belanja Bahan-Bahan Bakar dan Pelumas', 1),
(68, 13, '5.1.02.02.01.0067', 'Belanja Pembayaran Pajak, Bea, dan Perizinan', 1),
(69, 13, '5.1.02.03.02.0035', 'Belanja Pemeliharaan Alat Angkutan-Alat Angkutan Darat Bermotor-Kendaraan Dinas Bermotor Perorangan', 1),
(70, 13, '5.1.02.03.02.0038', 'Belanja Pemeliharaan Alat Angkutan-Alat Angkutan Darat Bermotor-Kendaraan Bermotor Beroda Dua', 1),
(71, 13, '', 'Belanja Pemeliharaan Alat Angkutan-Alat Angkutan Darat Bermotor-Kendaraan Bermotor Khusus', 1),
(72, 14, '5.1.02.01.01.0001', 'Belanja Bahan-Bahan Bangunan dan Konstruksi ', 1),
(73, 14, '5.1.02.01.01.0030', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Perabot Kantor ', 1),
(74, 14, '5.1.02.02.01.0029', 'Belanja Jasa Tenaga Ahli ', 1),
(75, 14, '', 'Belanja Pemeliharaan Bangunan Gedung-Bangunan Gedung Tempat Kerja-Bangunan Gedung Kantor ', 1),
(76, 15, '5.1.02.01.01.0030', 'Belanja Alat/Bahan untuk Kegiatan Kantor-Perabot Kantor', 1),
(77, 15, '5.1.02.01.01.0031', 'Belanja Alat/Bahan untuk Kegiatan Kantor-Alat Listrik', 1),
(78, 15, '5.1.02.02.01.0051', 'Belanja Jasa Pengolahan Sampah ', 1),
(79, 15, '5.1.02.02.01.0069', 'Belanja Pengolahan Air Limbah', 1),
(80, 15, '5.1.02.03.02.0121', 'Belanja Pemeliharaan Alat Kantor dan Rumah Tangga-Alat Rumah Tangga-Alat Pendingin', 1),
(81, 15, '5.1.02.03.02.0405', 'Belanja Pemeliharaan Komputer-Komputer Unit-Personal Computer', 1),
(82, 15, '5.1.02.03.02.0409', 'Belanja Pemeliharaan Komputer-Peralatan Komputer-Peralatan Personal Computer', 1),
(83, 16, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(84, 16, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(85, 16, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(86, 16, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(87, 16, '5.1.02.02.01.0003', 'Honorarium Narasumber atau Pembahas, Moderator, Pembawa Acara, dan Panitia', 1),
(88, 16, '5.1.02.04.01.0001', 'Belanja Perjalanan Dinas Biasa', 1),
(89, 16, '5.1.02.04.01.0003', 'Belanja Perjalanan Dinas Dalam Kota \n Dinas Dalam Kota', 1),
(90, 17, '5.1.02.01.01.0001', 'Belanja Bahan-Bahan Bangunan dan Konstruksi ', 1),
(91, 17, '5.1.02.01.01.0005', 'Belanja Bahan-Bahan Baku ', 1),
(92, 17, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(93, 17, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(94, 17, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(95, 17, '5.1.02.02.01.0003', 'Honorarium Narasumber atau Pembahas, Moderator, Pembawa Acara, dan Panitia', 1),
(96, 17, '5.1.02.02.01.0026', 'Belanja Jasa Tenaga Administrasi ', 1),
(97, 17, '5.1.02.02.01.0047', 'Belanja Jasa Penyelenggaraan Acara', 1),
(98, 17, '5.1.02.02.01.0071', 'Belanja Lembur', 1),
(99, 17, '5.1.02.04.01.0001', 'Belanja Perjalanan Dinas Biasa', 1),
(100, 17, '5.1.02.04.01.0003', 'Belanja Perjalanan Dinas Dalam Kota \n Dinas Dalam Kota', 1),
(101, 18, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(102, 18, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(103, 18, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(104, 18, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(105, 18, '5.1.02.04.01.0003', 'Belanja Perjalanan Dinas Dalam Kota \n Dinas Dalam Kota', 1),
(106, 19, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(107, 19, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(108, 19, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(109, 19, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(110, 19, '5.1.02.03.02.0404', 'Belanja Pemeliharaan Komputer-Komputer Unit-Komputer Jaringan', 1),
(111, 19, '5.2.02.08.03.0015', 'Belanja Modal Alat Peraga PAUD/TK', 1),
(112, 19, '5.2.05.01.01.0001', 'Belanja Modal Buku Umum', 1),
(113, 20, '', 'Belanja Bahan-Bahan Lannya', 1),
(114, 20, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(115, 20, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(116, 20, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(117, 20, '5.1.02.01.01.0035', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Suvenir/Cendera Mata', 1),
(118, 20, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(119, 20, '5.1.02.02.01.0003', 'Honorarium Narasumber atau Pembahas, Moderator, Pembawa Acara, dan Panitia', 1),
(120, 20, '5.1.02.02.01.0037', 'Belanja Jasa Juri Perlombaan/Pertandingan', 1),
(121, 20, '5.1.02.04.01.0003', 'Belanja Perjalanan Dinas Dalam Kota \n Dinas Dalam Kota', 1),
(122, 20, '5.1.02.05.01.0001', 'Belanja Hadiah yang Bersifat Perlombaan', 1),
(123, 21, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(124, 21, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(125, 21, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(126, 21, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(127, 21, '5.1.02.02.01.0003', 'Honorarium Narasumber atau Pembahas, Moderator, Pembawa Acara, dan Panitia', 1),
(128, 21, '5.1.02.04.01.0001', 'Belanja Perjalanan Dinas Biasa', 1),
(129, 21, '5.1.02.04.01.0003', 'Belanja Perjalanan Dinas Dalam Kota \n Dinas Dalam Kota', 1),
(130, 22, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(131, 22, '5.1.02.03.02.0036', 'Belanja Pemeliharaan Alat Angkutan-Alat Angkutan Darat Bermotor-Kendaraan Bermotor Penumpang', 1),
(132, 22, '5.1.02.03.03.0001', 'Belanja Pemeliharaan Bangunan Gedung-Bangunan Gedung Tempat Kerja-Bangunan Gedung Kantor ', 1),
(133, 23, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(134, 23, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(135, 23, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(136, 23, '5.1.02.01.01.0035', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Suvenir/Cendera Mata', 1),
(137, 23, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(138, 23, '5.1.02.02.01.0003', 'Honorarium Narasumber atau Pembahas, Moderator, Pembawa Acara, dan Panitia', 1),
(139, 23, '5.1.02.02.01.0025', 'Belanja Jasa Tenaga Kesenian dan Kebudayaan', 1),
(140, 23, '5.1.02.02.01.0030', 'Belanja Jasa Tenaga Kebersihan', 1),
(141, 23, '5.1.02.02.01.0031', 'Belanja Jasa Tenaga Keamanan', 1),
(142, 23, '5.1.02.02.01.0037', 'Belanja Jasa Juri Perlombaan/Pertandingan', 1),
(143, 23, '5.1.02.02.01.0043', 'Belanja Jasa Penulisan dan Penerjamahan', 1),
(144, 23, '5.1.02.02.01.0047', 'Belanja Jasa Penyelenggaraan Acara', 1),
(145, 23, '5.1.02.02.01.0055', 'Belanja Jasa Iklan/Reklame, Film, dan Pemotretan', 1),
(146, 23, '5.1.02.02.04.0117', 'Belanja Sewa Alat Kantor Lainnya ', 1),
(147, 23, '5.1.02.02.04.0118', 'Belanja Sewa Mebel', 1),
(148, 23, '5.1.02.02.04.0132', 'Belanja Sewa Peralatan Studi Audio ', 1),
(149, 23, '5.1.02.04.01.0001', 'Belanja Perjalanan Dinas Biasa', 1),
(150, 23, '5.1.02.04.01.0003', 'Belanja Perjalanan Dinas Dalam Kota \n Dinas Dalam Kota', 1),
(151, 23, '5.1.02.05.01.0001', 'Belanja Hadiah yang Bersifat Perlombaan', 1),
(152, 24, '5.1.02.01.01.0012', 'Belanja Bahan-Bahan Lainnya ', 1),
(153, 24, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(154, 24, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(155, 24, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(156, 24, '5.1.02.01.01.0035', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Suvenir/Cendera Mata', 1),
(157, 24, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(158, 24, '5.1.02.02.01.0003', 'Honorarium Narasumber atau Pembahas, Moderator, Pembawa Acara, dan Panitia', 1),
(159, 24, '5.1.02.02.01.0037', 'Belanja Jasa Juri Perlombaan/Pertandingan', 1),
(160, 24, '5.1.02.04.01.0001', 'Belanja Perjalanan Dinas Biasa', 1),
(161, 24, '5.1.02.04.01.0003', 'Belanja Perjalanan Dinas Dalam Kota \n Dinas Dalam Kota', 1),
(162, 24, '5.1.02.05.01.0001', 'Belanja Hadiah yang Bersifat Perlombaan', 1),
(163, 25, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(164, 25, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(165, 25, '5.1.02.01.01.0035', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Suvenir/Cendera Mata', 1),
(166, 25, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(167, 25, '5.1.02.02.01.0003', 'Honorarium Narasumber atau Pembahas, Moderator, Pembawa Acara, dan Panitia', 1),
(168, 25, '5.1.02.04.01.0001', 'Belanja Perjalanan Dinas Biasa', 1),
(169, 25, '5.1.02.04.01.0003', 'Belanja Perjalanan Dinas Dalam Kota \n Dinas Dalam Kota', 1),
(170, 26, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(171, 26, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(172, 26, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(173, 26, '5.1.02.01.01.0030', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Perabot Kantor ', 1),
(174, 26, '5.1.02.01.01.0037', 'Belanja Obat-Obatan-Obat', 1),
(175, 26, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(176, 26, '5.1.02.02.01.0003', 'Honorarium Narasumber atau Pembahas, Moderator, Pembawa Acara, dan Panitia', 1),
(177, 26, '5.1.02.02.01.0024', 'Belanja Jasa Tenaga Arsip dan Perpustakaan ', 1),
(178, 26, '5.1.02.04.01.0001', 'Belanja Perjalanan Dinas Biasa', 1),
(179, 26, '5.1.02.04.01.0003', 'Belanja Perjalanan Dinas Dalam Kota \n Dinas Dalam Kota', 1),
(180, 27, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(181, 27, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(182, 27, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(183, 27, '5.1.02.01.01.0035', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Suvenir/Cendera Mata', 1),
(184, 27, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(185, 28, '5.1.02.01.01.0001', 'Belanja Bahan-Bahan Bangunan dan Konstruksi ', 1),
(186, 28, '5.1.02.01.01.0005', 'Belanja Bahan-Bahan Baku ', 1),
(187, 28, '5.1.02.01.01.0024', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Tulis Kantor', 1),
(188, 28, '5.1.02.01.01.0025', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Kertas dan Cover', 1),
(189, 28, '5.1.02.01.01.0029', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Bahan Komputer', 1),
(190, 28, '5.1.02.01.01.0030', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Perabot Kantor ', 1),
(191, 28, '5.1.02.01.01.0031', 'Belanja Alat/Bahan untuk Kegiatan Kantor- Alat Listrik', 1),
(192, 28, '5.1.02.01.01.0037', 'Belanja Obat-Obatan-Obat', 1),
(193, 28, '5.1.02.01.01.0052', 'Belanja Makanan dan Minuman Rapat', 1),
(194, 28, '5.1.02.02.01.0024', 'Belanja Jasa Tenaga Arsip dan Perpustakaan ', 1),
(195, 28, '5.1.02.02.01.0043', 'Belanja Jasa Penulisan dan Penerjamahan', 1),
(196, 28, '5.1.02.02.04.0117', 'Belanja Sewa Alat Kantor Lainnya ', 1),
(197, 28, '5.1.02.04.01.0001', 'Belanja Perjalanan Dinas Biasa', 1),
(201, 25, '200254', 'coba tambah rekening lagi', 0),
(205, 28, '0123456789', 'belanja jasa pembersihan, pengendalian hama, dan fumigasi', 0),
(206, 29, '2002542', 'rekening baru lagi', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `subkegiatan`
--

CREATE TABLE `subkegiatan` (
  `id_subkegiatan` int(11) NOT NULL,
  `id_kegiatan` int(11) NOT NULL,
  `kode_subkegiatan` varchar(50) NOT NULL,
  `nama_subkegiatan` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `subkegiatan`
--

INSERT INTO `subkegiatan` (`id_subkegiatan`, `id_kegiatan`, `kode_subkegiatan`, `nama_subkegiatan`, `is_active`) VALUES
(1, 1, '2.23.01.2.01.1', 'Penyusunan Dokumen Perencanaan Perangkat Daerah', 1),
(2, 1, '2.23.01.2.01.7', 'Evaluasi Kinerja Perangkat Daerah', 1),
(3, 2, '2.23.01.2.02.1', 'Penyediaan Gaji dan Tunjangan ASN ', 1),
(4, 2, '2.23.01.2.02.2', 'Penyediaan Administrasi Pelaksanaan Tugas ASN ', 1),
(5, 2, '2.23.01.2.02.7', 'Koordinasi dan Penyusunan Laporan Keuangan Bulanan/Triwulanan/Semesteran SKPD', 1),
(6, 3, '2.23.01.2.05.5', 'Monitoring, Evaluasi, dan Penilaian Kinerja Pegawai ', 1),
(7, 3, '2.23.01.2.05.9', 'Pendidikan dan Pelatihan Pegawai Berdasarkan Tugas dan Fungsi', 1),
(8, 4, '2.23.01.2.06.2', 'Penyediaan Peralatan dan Perlengkapan Kantor', 1),
(9, 4, '2.23.01.2.06.9', 'Penyelenggaraan Rapat Koordinasi dan Konsultasi SKPD', 1),
(10, 5, '2.23.01.2.07.10', 'Pengadaan Sarana dan Prasarana Gedung Kantor atau Bangunan Lainnya', 1),
(11, 6, '2.23.01.2.08.2', 'Penyediaan Jasa Komunikasi, Sumber Daya Air dan Listrik', 1),
(12, 6, '2.23.1.2.08.4', 'Penyediaan Jasa Pelayanan Umum Kantor', 1),
(13, 7, '2.23.01.2.09.2', 'Penyediaan Jasa Pemeliharaan, Biaya Pemeliharaan, Pajak dan Perizinan Kendaraan Dinas Operasional atau Lapangan', 1),
(14, 7, '2.23.01.2.09.9', 'Pemeliharaan/Rehabilitasi Gedung Kantor dan Bangunan Lainnya', 1),
(15, 7, '2.23.01.2.09.10', 'Pemeliharaan/Rehabilitasi Sarana dan Prasarana Gedung Kantor atau Bangunan Lainnya \n', 1),
(16, 8, '2.23.02.2.01.4', 'Pembinaan Perpustakaan pada Satuan Pendidikan Dasar di Seluruh Wilayah Kabupaten/Kota Sesuai dengan Standar Nasional Perpustakaan', 1),
(17, 8, '2.23.02.2.01.11', 'Pengembangan Perpustakaan di Tingkat Daerah Kabupaten/Kota ', 1),
(18, 8, '2.23.02.2.01.17', 'Penyusunan Data dan Informasi Perpustakaan ', 1),
(19, 8, '2.23.02.2.01.18', 'Pengelolaan dan Pengembangan Bahan Perpustakaan', 1),
(20, 8, '2.23.02.2.01.19', 'Pengembangan Kekhasan Koleksi Perpustakaan Daerah Tingkat Kabupaten/Kota', 1),
(21, 9, '2.23.02.2.02.07', 'Pengembangan Literasi Berbasis Inklusi Sosial ', 1),
(22, 9, '2.23.02.2.02.08', 'Pembangunan dan Pemeliharaan Sarana Perpustakaan di Tempat-Tempat Umum yang Menjadi Kewenangan Daerah Kabupaten/Kota', 1),
(23, 9, '2.23.02.2.02.09', 'Pemberian Penghargaan Gerakan Budaya Gemar Membaca', 1),
(24, 9, '2.23.02.2.02.10', 'Sosialisasi Budaya Baca dan Literasi pada Satuan Pendidikan Dasar dan Masyarakat', 1),
(25, 10, '2.23.03.2.01.03', 'Peningkatan Peran Serta Masyarakat dalam Penyimpanan, Perawatan, Pelestarian, dan Pendaftaran Naskah Kuno ', 1),
(26, 11, '2.24.02.2.01.02', 'Pemeliharaan dan Penyusutan Arsip Dinamis ', 1),
(27, 11, '2.24.02.2.01.03', 'Pengawasan Arsip Dinamis Kewenangan Kabupaten/Kota ', 1),
(28, 12, '2.24.02.2.02.04', 'Akuisisi, Pengolahan, Preservasi, dan Akses Arsip Statis', 1),
(29, 14, '1821101710', 'subkegiatan baru nich', 1);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `anggaran`
--
ALTER TABLE `anggaran`
  ADD PRIMARY KEY (`id_anggaran`),
  ADD KEY `id_rekening` (`id_rekening`,`tahun`,`bulan`,`jenis`);

--
-- Indeks untuk tabel `anggaran_tahunan`
--
ALTER TABLE `anggaran_tahunan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_rekening` (`id_rekening`,`tahun`,`jenis`);

--
-- Indeks untuk tabel `kegiatan`
--
ALTER TABLE `kegiatan`
  ADD PRIMARY KEY (`id_kegiatan`),
  ADD UNIQUE KEY `kode_kegiatan` (`kode_kegiatan`),
  ADD KEY `id_program` (`id_program`);

--
-- Indeks untuk tabel `program`
--
ALTER TABLE `program`
  ADD PRIMARY KEY (`id_program`),
  ADD UNIQUE KEY `kode_program` (`kode_program`);

--
-- Indeks untuk tabel `realisasi_detail`
--
ALTER TABLE `realisasi_detail`
  ADD PRIMARY KEY (`id_detail`);

--
-- Indeks untuk tabel `rekening`
--
ALTER TABLE `rekening`
  ADD PRIMARY KEY (`id_rekening`),
  ADD KEY `id_subkegiatan` (`id_subkegiatan`),
  ADD KEY `kode_rekening` (`kode_rekening`);

--
-- Indeks untuk tabel `subkegiatan`
--
ALTER TABLE `subkegiatan`
  ADD PRIMARY KEY (`id_subkegiatan`),
  ADD UNIQUE KEY `kode_subkegiatan` (`kode_subkegiatan`),
  ADD KEY `id_kegiatan` (`id_kegiatan`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `anggaran`
--
ALTER TABLE `anggaran`
  MODIFY `id_anggaran` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=611;

--
-- AUTO_INCREMENT untuk tabel `anggaran_tahunan`
--
ALTER TABLE `anggaran_tahunan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- AUTO_INCREMENT untuk tabel `kegiatan`
--
ALTER TABLE `kegiatan`
  MODIFY `id_kegiatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `program`
--
ALTER TABLE `program`
  MODIFY `id_program` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `realisasi_detail`
--
ALTER TABLE `realisasi_detail`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=490;

--
-- AUTO_INCREMENT untuk tabel `rekening`
--
ALTER TABLE `rekening`
  MODIFY `id_rekening` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=207;

--
-- AUTO_INCREMENT untuk tabel `subkegiatan`
--
ALTER TABLE `subkegiatan`
  MODIFY `id_subkegiatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `anggaran`
--
ALTER TABLE `anggaran`
  ADD CONSTRAINT `anggaran_ibfk_1` FOREIGN KEY (`id_rekening`) REFERENCES `rekening` (`id_rekening`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `anggaran_tahunan`
--
ALTER TABLE `anggaran_tahunan`
  ADD CONSTRAINT `anggaran_tahunan_ibfk_1` FOREIGN KEY (`id_rekening`) REFERENCES `rekening` (`id_rekening`);

--
-- Ketidakleluasaan untuk tabel `kegiatan`
--
ALTER TABLE `kegiatan`
  ADD CONSTRAINT `kegiatan_ibfk_1` FOREIGN KEY (`id_program`) REFERENCES `program` (`id_program`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `rekening`
--
ALTER TABLE `rekening`
  ADD CONSTRAINT `rekening_ibfk_1` FOREIGN KEY (`id_subkegiatan`) REFERENCES `subkegiatan` (`id_subkegiatan`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `subkegiatan`
--
ALTER TABLE `subkegiatan`
  ADD CONSTRAINT `subkegiatan_ibfk_1` FOREIGN KEY (`id_kegiatan`) REFERENCES `kegiatan` (`id_kegiatan`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
