open(unit=20, file="nama_logam.txt", status="replace", action="write")
  write(20,*) trim(nama_metal(nama_logam)),'(' ,trim(simbol(nama_logam)),')'
  close(20)