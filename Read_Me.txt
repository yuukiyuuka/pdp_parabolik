Nama : Ahmad Basyir Najwan  ----- Pemilik
NPM  : 1906285314 --------------- Nomor Mahasiswa

Halo ... ini adalah panduan untuk menggunakan program solver pdp parabolik ini

Jadi, program ini saya bagi menjadi dua bagian terpisah.
1. Bagian 1 - Memilih jenis logam "baca_properti_logam.f90"
2. Bagian 2 - Menghitung solusi pdp "baca_properti_logam.f90"

Silahkan jalankan progam bagian 1 dulu untuk memilih jenis logam beserta karakteristik yang diiinginkan. Terdapat 10 pilihan jenis logam dan dapat dilihat pada file "data_properti_logam.txt".

Setelah program bagian 1 sukses, pilihan logam dan nilai-nilai karakteristiknya akan tersimpan di file "properti_logam.txt" serta teks nama logam di file "nama_logam.txt". 

Selanjutnya jalankan program bagian 2 untuk menghitung solusi pdp. Silahkan masukkan nilai step hx dan ht. Program ini akan menghasilkan data x, t, dan psi(=temperatur) dan disimpan dalam file berikut:
x -----> "output_x_pdp_parabolic_tugas09.txt"
t -----> "output_t_pdp_parabolic_tugas09.txt"
psi ---> "output_psi_pdp_parabolic_tugas09.txt"

Terakhir, untuk melihat plot grafiknya, jalankan program "plot_tugas_09.m" di Matlab.