<div id="top">

<div align="center">

# DISTRIBUTED-CHAT-LOGICAL-CLOCKS

*Time Synchronization & Causal Ordering Simulation*

<p align="center">
<img src="https://img.shields.io/github/last-commit/reinoyk/tugas1?style=flat&logo=git&logoColor=white&color=0080ff" alt="last-commit">
<img src="https://img.shields.io/github/languages/top/reinoyk/tugas1?style=flat&color=0080ff" alt="repo-top-language">
<img src="https://img.shields.io/github/languages/count/reinoyk/tugas1?style=flat&color=0080ff" alt="repo-language-count">
</p>

<em>Built with Python, UDP Sockets, and Logical Clock Algorithms</em>

</div>
---

## Table of Contents

* [Overview](#overview)
* [Features](#features)
* [Why This Project?](#why-this-project)
* [Architecture & Concepts](#architecture--concepts)
* [Project Structure](#project-structure)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
  * [Usage](#usage)
* [Results & Logging](#results--logging)
* [How to Contribute](#how-to-contribute)
* [License](#license)

---

## Overview

**Distributed-Chat-Logical-Clocks** adalah sebuah proyek simulasi sistem terdistribusi yang mengimplementasikan aplikasi *chat* peer-to-peer (P2P) menggunakan Python. Proyek ini dirancang untuk mendemonstrasikan tantangan sinkronisasi waktu dalam sistem terdistribusi tanpa *global clock*.

Sistem ini menggunakan **Lamport Logical Clocks** dan **Vector Clocks** untuk menentukan urutan kausal (*causal ordering*) dari pesan-pesan yang dipertukarkan antar *node*, serta menyertakan sebuah **Logger Node** pusat untuk memvisualisasikan perbedaan antara waktu fisik (*wall-clock*) dan waktu logis.

---

## Features

* 🕒 **Logical Clocks Implementation:** Implementasi penuh dari algoritma Lamport Clock dan Vector Clock untuk pelacakan *event*.
* 📡 **Peer-to-Peer UDP Communication:** Komunikasi *stateless* antar node menggunakan socket UDP.
* 🎛️ **Simulated Network Conditions:** Fitur untuk mensimulasikan *clock skew* (offset waktu) dan *processing delays*.
* 📢 **Broadcast & Unicast:** Mendukung pengiriman pesan ke satu peer tertentu (`@NAME`) atau ke seluruh jaringan (`/broadcast`).
* 📊 **Centralized Logger:** Node khusus yang mengumpulkan event dan mengurutkannya berdasarkan topologi Vector Clock untuk memverifikasi *Happens-Before Relationship*.
* 🛡️ **Interactive CLI:** Antarmuka baris perintah yang interaktif untuk mengirim pesan secara *real-time*.

---

## Why This Project?

Dalam sistem terdistribusi, mengandalkan jam fisik (*physical timestamp*) seringkali tidak dapat diandalkan karena masalah latensi jaringan dan *clock drift*. Proyek ini bertujuan untuk:
1. Membuktikan bahwa urutan kejadian berdasarkan jam fisik bisa melanggar kausalitas.
2. Menunjukkan bagaimana *Logical Clocks* dapat menyelesaikan masalah pengurutan pesan.
3. Menyediakan kerangka kerja eksperimental untuk mempelajari algoritma terdistribusi.

---

## Architecture & Concepts

Proyek ini terdiri dari beberapa komponen utama:

1. **Peer Nodes (A, B, C, D):**
   - Setiap node memiliki *Lamport Clock* (`L`) dan *Vector Clock* (`V`).
   - Saat mengirim pesan, node menaikkan *counter* jamnya.
   - Saat menerima pesan, node melakukan sinkronisasi: `max(local, received) + 1`.

2. **Logger (Collector):**
   - Bertindak sebagai *observer* pasif.
   - Menerima salinan semua pesan yang dikirim di jaringan.
   - Mengurutkan pesan menggunakan algoritma *Topological Sort* berdasarkan Vector Clock untuk menampilkan urutan kejadian yang sebenarnya.

**Teknologi yang digunakan:**
* **Language:** Python 3.8+
* **Networking:** Python `socket` (UDP), `json` serialization
* **Concurrency:** `threading` untuk menghandle input user dan listener socket secara bersamaan.

---

## Project Structure

Susunan direktori dalam repositori ini adalah sebagai berikut:

```text
.
├── program/
│   ├── logger.py        # Script untuk node Logger/Collector
│   └── peer_node.py     # Script utama logic Peer Node
├── node_a/
│   ├── run.bash         # Script startup untuk Node A
│   ├── node_a.txt       # Catatan/Log Node A
│   └── peer_node.py     # Symlink/Copy dari program/peer_node.py
├── node_b/
│   └── run.bash         # Script startup untuk Node B
├── node_c/
│   └── run.bash         # Script startup untuk Node C
└── node_d/
    └── run.bash         # Script startup untuk Node D
```

# Getting Started

## Prerequisites

* Python 3.x terinstal di sistem.
* Terminal (Linux/Mac) atau PowerShell/WSL (Windows).
* Koneksi jaringan lokal (atau localhost) yang mengizinkan trafik UDP.

## Installation

1. Clone repository ini:
```bash
git clone https://github.com/reinoyk/tugas1.git
```

2. Masuk ke direktori project:
```bash
cd tugas1
```

3. Pastikan permission eksekusi (untuk Linux/Mac):
```bash
chmod +x node_*/run.bash
```

## Usage

Simulasi ini dirancang untuk dijalankan pada beberapa terminal berbeda (atau mesin berbeda). Berikut adalah skenario menjalankannya:

### 1. Jalankan Logger (Collector)
Logger harus berjalan terlebih dahulu untuk menangkap semua pesan.
```bash
# Dari direktori program atau root
python3 program/logger.py --bind 0.0.0.0 --port 5000
```

(Catatan: Sesuaikan IP di file `run.bash` jika Anda tidak menggunakan IP hardcoded `192.168.122.15` seperti di contoh).

### 2. Jalankan Peer Nodes
Buka terminal terpisah untuk setiap node dan jalankan script masing-masing.

* Terminal A (Node A):
```bash
cd node_a
./run.bash
```

* Terminal B (Node B):
```bash
cd node_b
./run.bash
```

(Lakukan hal yang sama untuk Node C dan D).

### 3. Interaksi Chat
Setelah node berjalan, Anda bisa mengetik perintah di terminal masing-masing node:
* Kirim pesan ke B: `@B Halo B, apa kabar?`
* Broadcast ke semua: `/broadcast Hello everyone!`
* Lihat Peer aktif: `/peers`
* Keluar: `/exit`

## Results & Logging

Setelah simulasi selesai atau jumlah pesan yang diharapkan tercapai, Logger akan mencetak laporan perbandingan urutan pesan:

1. Naive Order: Urutan berdasarkan wall-clock time (timestamp lokal pengirim). Ini seringkali tidak akurat.
2. Causal Order (Lamport): Urutan total berdasarkan nilai Lamport Clock.
3. Causal Order (Vector Clock): Urutan topologis yang paling akurat, menghormati relasi happens-before.

Contoh Output Logger:
```
=== Naive order (by sender local_ts) — may violate causality ===
CHAT-A-100 A->B local_ts=17100.100 "Hello"

=== Causal order (Vector-clock topological order) ===
CHAT-A-100 A->B V={'A':1, 'B':0} L=1 "Hello"
CHAT-B-101 B->C V={'A':1, 'B':1} L=2 "Reply to A"
```
