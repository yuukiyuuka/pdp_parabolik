program ReadDataFromFile
  implicit none

  character(len=100) :: filename = "data_properti_logam.txt"
  integer, parameter :: num_metals = 10
  integer, parameter :: max_len = 20

  integer :: i
  integer, dimension(num_metals) :: nomor
  character(len=max_len), dimension(num_metals) :: nama_metal, simbol
  real :: massa_atom_rel(num_metals), kapasitas_molar(num_metals), densitas(num_metals), konduktivitas_thermal(num_metals)

  integer :: no_logam, nama_logam

  ! Open the input file
  open(unit=10, file=filename, status='old', action='read')

  ! Skip the first line
  read(10, *)

  ! Read the data from the file
  do i = 1, num_metals
    read(10, *) nomor(i), nama_metal(i), simbol(i), massa_atom_rel(i), kapasitas_molar(i), densitas(i), konduktivitas_thermal(i)
  end do

  ! Close the input file
  close(unit=10)
  
write(*,*) "Pembacaan data berhasil, ingin menampilkan data logam apa?"
write(*,*) "ketika nomor logamnya saja berdasarkan list berikut"
do i = 1, 10
  write(*,*) i, ".", nama_metal(i)
end do

do
  write(*,*) "logam yang diinginkan nomor ="
  read(*,*) no_logam

  if (no_logam >= 1 .and. no_logam <= 10) then
     nama_logam = nomor(no_logam)
     exit
  else
     write(*,*) "Pilihan logam tidak ada, silahkan ulangi!"
  end if
end do

  write(*,*) "Data ditampilkan dalam format berikut"
  write(*,*) "Nama_Logam,Massa_Atom_Relatif,Kapasitas_Molar,Densitas,Konduktivitas_Termal"

  ! Display the read data
    write(*,*) trim(nama_metal(nama_logam)),'(' ,trim(simbol(nama_logam)),')', &
      massa_atom_rel(nama_logam), kapasitas_molar(nama_logam), densitas(nama_logam), konduktivitas_thermal(nama_logam)

  ! simpan sebagai file output
  ! Open the output file and write the name
  open(unit=20, file="properti_logam.txt", status="replace", action="write")
  write(20, *) trim(nama_metal(nama_logam)),'(' ,trim(simbol(nama_logam)),')'
  write(20,*) massa_atom_rel(nama_logam)
  write(20,*) kapasitas_molar(nama_logam)
  write(20,*) densitas(nama_logam)
  write(20,*) konduktivitas_thermal(nama_logam)
  close(20) 

  ! Open the output file and write the name
  open(unit=20, file="nama_logam.txt", status="replace", action="write")
  write(20,*) trim(nama_metal(nama_logam)),'(' ,trim(simbol(nama_logam)),')'
  close(20)

end program ReadDataFromFile
