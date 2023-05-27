program pdp_parabolik
implicit none
integer, parameter :: dpr = kind(1.0D0)
real(dpr) :: D, Densitas, Kapasitas_Molar, Konduktivitas_Termal, Massa_Atom_Relatif
real(dpr) :: ht, hx, xmin, xmax, tmin, tmax, hu
real(dpr), allocatable :: x(:), t(:), psi(:,:), u(:)
integer :: i, j, kx, kt, kpsi
real(dpr) :: psi_x_0, psi_0_t, psi_100_t

character(100) :: nama_file
character(100) :: baris_data
  
  ! Nama file yang akan dibaca
  nama_file = "nama_logam.txt"
  
  ! Membuka file
  open(unit=100, file=nama_file, status='old')
  read(100, '(A)') baris_data
  close(100)

!membaca data logam
open(unit=10, file="properti_logam.txt", status='old', action='read')

 !men-skip baris pertama (cuman nama logamnya)
  read(10,*)
  read(10,*) Massa_Atom_Relatif
  read(10,*) Kapasitas_Molar
  read(10,*) Densitas
  read(10,*) Konduktivitas_Termal

close(10)

!menghitung konstanta D
D = Konstanta_Difusitas(Massa_Atom_Relatif,Densitas,Konduktivitas_Termal,Kapasitas_Molar)

!menampilkan nilai D dan nama logam
write(*,*) "Logam yang digunakan =", baris_data
write(*,*) "Konstanta Difusitas =", D, "cm^2/s"
write(*,*) " "

!membaca nilai step posisi x dan waktu t
write(*,*) "Masukkan step waktu ht dan step posisi hx yang diinginkan"
write(*,*) "ht ="
read(*,*) ht
write(*,*) "hx ="
read(*,*) hx

!mengenerate data nilai x untuk output
xmax = 100.0 !dalam cm
xmin = 0.0   !dalam cm
kx = 1 + floor((xmax-xmin)/hx) !jumlah titik data output x

allocate(x(kx))

do i = 1,kx
   x(i) = xmin + (i-1)*hx
end do

!menyimpan data nilai x ke file eksternal
open(unit=20, file="output_x_pdp_parabolic_tugas09.txt", status="replace", action="write")
write(20,*) "jumlah data output x =", kx
do i = 1,kx
   write(20,*) x(i)
end do
close(20)

!menentukan sampai kapan (tmax) hasil ingin dihitung
write(*,*) "Masukkan nilai waktu maksimum pengambilan data" 
write(*,*) "dalam detik, tmax ="
read(*,*) tmax

!mengenerate data nilai t untuk output
tmin = 0.0   !dalam s
kt = 1 + floor((tmax-tmin)/ht) !jumlah titik data output t

allocate(t(kt))

do i = 1,kt
   t(i) = tmin + (i-1)*ht
end do

!menyimpan data nilai t ke file eksternal
open(unit=30, file="output_t_pdp_parabolic_tugas09.txt", status="replace", action="write")
write(30,*) "jumlah data output t =", kt
do i = 1,kt
   write(30,*) t(i)
end do
close(30)

!!!!!----- menghitung solusi numerik -----!!!!!!

!nilai batas
psi_x_0 = 27.0        !suhu awal di seluruh batang = 27 celcius
psi_0_t = 0.0         !suhu akhir di ujung kiri = 0 celcius
psi_100_t = 110.0     !suhu akhir di ujung kanan = 110 celcius

!jumlah data psi
kpsi = kx*kt

allocate(psi(kx,kt))
do i = 1,kx
   do j = 1,kt
      psi(i,j) = 0.0
   end do
end do

!menyimpan syarat batas ke array psi(i,j)
do i = 1,kx
   psi(i,1) = psi_x_0
end do

do j = 1,kt
   psi(1,j) = psi_0_t
   psi(kx,j) = psi_100_t
end do

!menghitung psi(i,j) setiap waktu dengan metode numerik pdp parabolik

do j = 2,kt
   do i = 2,kx-1
      psi(i,j) = psi(i,j-1) + D*ht * (psi(i+1,j-1) - 2*psi(i,j-1) + psi(i-1,j-1)) / hx**2
   end do
end do

!menyimpan data nilai psi ke file eksternal
open(unit=40, file="output_psi_pdp_parabolic_tugas09.txt", status="replace", action="write")
write(40,*) "jumlah data output temperatur =", kpsi
do i = 1,kx
   write(40,*) psi(i,:)
end do
close(40)

write(*,*) "Perhitungan selesai, cek data output di file eksternal"

deallocate(x,t,psi)

stop

contains

function Konstanta_Difusitas(Ar,rho,kappa,Cm) result(D)
implicit none
real(dpr), intent(in) :: Ar, rho, kappa, Cm
real(dpr) :: D

D = kappa*Ar/(1000*Cm*rho)

end function Konstanta_Difusitas

end program pdp_parabolik