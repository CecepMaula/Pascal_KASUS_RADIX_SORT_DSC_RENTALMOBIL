program Data_Penjualan_Mobil_RadixSort;
{I.S. : User memilih sebuah menu dari menu pilihan}
{F.S. : Menampilkan hasil dan mengasilkan proses dari menu yang dipilih}
uses crt;

{Kamus Global}
const
  maksMobil = 20;

Type
  reMobil = record
    nama   : string;
    terjual : integer;
  end;
  arMobil = array[1..maksMobil] of reMobil;

  point = ^node;
  node = record
    info : reMobil;
    next : point;
  end;
  arPoint = array[0..9] of point;

var
  mobil : arMobil;
  varMobil : reMobil;
  maksData, i : integer;

{------------------ Proses Penciptaan ------------------}
procedure penciptaan(var mobil : arMobil);
{I.S. : Proses menciptakan array yang akan digunakan}
{F.S. : Mengasilkan array yang sudah diciptakan}
begin
  maksData := 4;
  for i := 1 to maksData do
    begin
      mobil[i].nama := ' ';
      mobil[i].terjual := 0;
    end;
end; //endProcedure
{------------------ <<<<<<<<>>>>>>>> -------------------}

{------------------ Proses Traversal ------------------}
procedure isiData(isiMobil : reMobil);
{I.S. : User mengisi semua data sebanyak array}
{F.S. : Menghasilkan data yang sudah diisi oleh User}
begin
  mobil[i].nama := isiMobil.nama;
  mobil[i].terjual := isiMobil.terjual;
end;

procedure tampilData(mobil : arMobil; maksData : integer);
{I.S. : Data makanan telah terdefinisi}
{F.S. : Menampilkan semua data makanan yang telah diisi oleh User}
begin
  clrscr;
  gotoxy(25, 8); writeln('      Tampil Data Mobil     ');
  gotoxy(25, 9); writeln('|---------------------------|');
  gotoxy(25,10); writeln('| Nama Mobil   |  Terjual   |');
  gotoxy(25,11); writeln('|---------------------------|');
  for i := 1 to maksData do
    begin
      gotoxy(25,11+i); writeln('|              |     Unit   |');
      gotoxy(27,11+i); write(mobil[i].nama);
      gotoxy(42,11+i); writeln(mobil[i].terjual);
    end;
  gotoxy(25,12+maksData); writeln('|---------------------------|');
end;

procedure hapusData(posisi : integer);
{I.S. : Data yang ingin dihapus telah didefinisi}
{F.S. : Menghapus data sesuai keinginan User}
begin
  mobil[posisi].nama := ' ';
  mobil[posisi].terjual := 0;
end;

procedure GantiData(isiMobil : reMobil);
{I.S. : Data yang ingin ditimpa telah didefinisi}
{F.S. : Menimpa data sesuai keinginan User}
begin
  mobil[i].nama := isiMobil.nama;
  mobil[i].terjual := isiMobil.terjual;
end;
{------------------ <<<<<<<<>>>>>>>> ------------------}

{------------------ Proses Pencarian ------------------}
procedure cariData;
{I.S. : User memasukkan data mobil yang ingin dicari}
{F.S. : Mendapatkan atau tidak mendapatkan informasi mobil yang sesuai dengan yang dicari oleh User}
var
  ketemu : boolean;
  mobilCari : string;
begin
  gotoxy(43,11); readln(mobilCari);
  i := 0;
  ketemu := false;
  while(not ketemu) and (i <= maksData) do
  begin
    if mobil[i].nama = mobilCari
      then
        ketemu := true
      else
        i := i + 1;
    //endif
  end;
  if(ketemu)
    then
      begin
        gotoxy(22,13); write('|- Nama Mobil = ',mobil[i].nama); gotoxy(56,13);writeln(' -|');
        gotoxy(22,14); write('|- Terjual    = ',mobil[i].terjual);  gotoxy(56,14);writeln(' -|');
        gotoxy(22,15); writeln('|-----------------------------------|');
      end;
  //endif
  if(not ketemu)
    then
      begin
        gotoxy(22,13); write('|- Nama Mobil =  '); gotoxy(56,13);writeln(' -|');
        gotoxy(22,14); write('|- Terjual    =  ');  gotoxy(56,14);writeln(' -|');
        gotoxy(22,15); writeln('|-----------------------------------|');
        gotoxy(22,16); writeln('>> ',mobilCari,' tidak ditemukan');
      end;
  //endif
end; //endprocedure
{------------------ <<<<<<<<>>>>>>>> ------------------}

{------------------ Proses Pengurutan ------------------}
Procedure masukkanRDX(Var penunjuk : arPoint; dihitung : reMobil; posisi : Integer);
{I.S. : Memasukkan data kedalam tabel (Proses Radix Sort)}
{F.S. : Mendapatkan data yang sudah dimasukkan kedalam tabel (Proses Radix Sort)}
Var
  P, Q : point; {P & Q adalah inisialisasi dari pointer}
begin
  New (P);
  P^.info := dihitung;
  P^.next := Nil;
  Q := penunjuk [posisi];
  if Q = Nil then
    penunjuk [posisi] := P
  else
  begin
    While Q^.next <> Nil do
      Q := Q^.next;
    Q^.next := P;
  end;
end;

Procedure isiUlangRDX(Var mobil : arMobil; Var penunjuk : arPoint);
{I.S. : Mengisi ulang data yang akan diurutkan dengan metode Radix Sort}
{F.S. : Menghasilkan data untuk memenuhi proses pengurutan dengan metode Radix Sort}
Var
  indeks, j : integer;
  P    : point;
begin
  j := 1;
  For indeks := 9 downto 0 do
  begin
    P := penunjuk[indeks];
    While P <> Nil do
    begin
      mobil[j] := P^.info;
      P := P^.next;
      j := j + 1;
    end;
  end;
  For indeks := 9 downto 0 do
    penunjuk[indeks] := Nil;
end;

Procedure urutDataRDX(Var mobil : arMobil; maksimal : integer);
{I.S. : Data yang akan diurutkan telah terdefinisi}
{F.S. : Menghasilkan Data yang telah diurutkan dengan metode Radix Sort secara Descending}
Var
  penunjuk : arPoint;
  indeks,
  pembagi,
  daftarNo : integer;
  dihitung   : reMobil;
begin
  For indeks := 9 downto 0 do
  penunjuk[indeks] := Nil;
  pembagi := 1;
  While pembagi <= 1000 do
  begin
    indeks := 1;
    While indeks <= maksimal do
    begin
      dihitung := mobil[indeks];
      daftarNo := dihitung.terjual div pembagi mod 10;
      masukkanRDX(penunjuk, dihitung, daftarNo);
      indeks := indeks + 1;
    end;
    isiUlangRDX(mobil, penunjuk);
    pembagi := 10 * pembagi;
  end;
end;
{------------------ <<<<<<<<>>>>>>>> -------------------}

{------------------ Proses Penghancuran ------------------}
procedure penghancuran(maksData : integer);
{I.S. : User mengembalikan semua Data kenilai awal}
{F.S. : Semua Data yang telah diisi dikembalikan ke nilai awal}
begin
  for i := 1 to maksData do
    begin
      mobil[i].nama := ' ';
      mobil[i].terjual := 0;
    end;
  gotoxy(25,10); writeln('|----------------------------|');
  gotoxy(25,11); writeln('|- Semua Data telah dihapus -|');
  gotoxy(25,12); writeln('|----------------------------|');
end; //endProcedure
{------------------- <<<<<<<<>>>>>>>> --------------------}

{Menu Tampilan}
procedure menuMobil(maksData : Integer);
{I.S. : User memilih sebuah menu dari Menu pilihan}
{F.S. : Menampilkan hasil dan mengasilkan proses dari menu yang dipilih}
var
  pil, hapus : integer;
begin
  repeat
    clrscr;
    gotoxy(27, 3); writeln('      Data Penjualan Mobil     ');
    gotoxy(27, 6); writeln('          Menu Pilihan         ');
    gotoxy(27, 7); writeln('-------------------------------');
    gotoxy(27, 8); writeln('   1. Isi Data Mobil           ');
    gotoxy(27, 9); writeln('   2. Tampil Data Mobil        ');
    gotoxy(27,10); writeln('   3. Hapus Data Mobil         ');
    gotoxy(27,11); writeln('   4. Ganti Data Mobil         ');
    gotoxy(27,12); writeln('   5. Urutkan Data Mobil(Dsc)  ');
    gotoxy(27,13); writeln('   6. Cari Data Mobil          ');
    gotoxy(27,14); writeln('   7. Hapus Semua Data Mobil   ');
    gotoxy(27,15); writeln('   0. Keluar                   ');
    gotoxy(27,16); writeln('-------------------------------');
    gotoxy(27,17); writeln('   Pilihan Anda ?              ');
    gotoxy(50,17); readln(pil);
    case (pil) of
       1 : begin
             for i := 1 to maksData do
             begin
               clrscr;
               gotoxy(23, 9); writeln('       Isi Mobil Terjual       ');
               gotoxy(23,10); writeln('-------------------------------');
               gotoxy(23,11); writeln('Nama Mobil =                   ');
               gotoxy(23,12); writeln('Terjual    =              Unit ');
               gotoxy(23,13); writeln('-------------------------------');
               gotoxy(41,11); readln(varMobil.nama);
               gotoxy(41,12); readln(varMobil.terjual);
               isiData(varMobil);
             end;
             gotoxy(23,14); write('>> Tekan Enter untuk Kembali!'); readln;
           end;
       2 : begin
             clrscr;
             tampilData(mobil,maksData);
             gotoxy(25,13+maksData); write('>> Tekan Enter untuk Kembali!'); readln;
           end;
       3 : begin
             clrscr;
             gotoxy(22, 9); writeln('        Hapus Mobil Terjual        ');
             gotoxy(22,10); writeln('-----------------------------------');
             gotoxy(22,11); writeln('Hapus Data Mobil Keberapa ?        ');
             gotoxy(22,12); writeln('-----------------------------------');
             gotoxy(56,11); readln(hapus);
             hapusData(hapus);
             gotoxy(22,13); writeln('  Data Ke-',hapus,' Telah Terhapus       ');
             gotoxy(22,14); writeln('|-----------------------------------|');
             gotoxy(22,15); write('>> Tekan Enter untuk Kembali!'); readln;
           end;
       4 : begin
             clrscr;
             gotoxy(22, 8); writeln('         Ganti Data Mobil Terjual       ');
             gotoxy(22, 9); writeln('----------------------------------------');
             gotoxy(22,10); writeln('Ganti Data Mobil Keberapa ?             ');
             gotoxy(22,11); writeln('----------------------------------------');
             gotoxy(22,12); writeln(' Nama Mobil  =              ');
             gotoxy(22,13); writeln(' Terjual     =     Unit     ');
             gotoxy(22,14); writeln('-------------------------------------');
             gotoxy(56,10); readln(i);
             gotoxy(42,12); readln(varMobil.nama);
             gotoxy(42,13); readln(varMobil.terjual);
             GantiData(varMobil);
             gotoxy(22,15); write('>> Tekan Enter untuk Kembali!'); readln;
           end;
       5 : begin
             clrscr;
             urutDataRDX(mobil,maksData);
             gotoxy(18,10); writeln('   Data telah diurutkan secara Descending   ');
             gotoxy(18,11); writeln('       Berdasarkan Jumlah Terjualnya        ');
             gotoxy(18,12); writeln('--------------------------------------------');
             gotoxy(18,13); write('>> Tekan Enter untuk Kembali!'); readln;
           end;
       6 : begin
             clrscr;
             gotoxy(22, 9); writeln('              Cari Mobil            ');
             gotoxy(22,10); writeln('------------------------------------');
             gotoxy(22,11); writeln('    Nama Mobil ?                    ');
             gotoxy(22,12); writeln('------------------------------------');
             cariData;
             gotoxy(22,17); write('>> Tekan Enter untuk Kembali!'); readln;
           end;
       7 : begin
             clrscr;
             penghancuran(maksData);
             gotoxy(25,13); write('>> Tekan Enter untuk Kembali!'); readln;
           end;
       0 : begin
             clrscr;
             gotoxy(16,11); writeln('   Terimakasih telah menggunakan Program Kami   ');
             gotoxy(16,12); writeln(' ---------------------------------------------- ');
             gotoxy(16,13); write('>> Tekan Enter untuk Keluar!'); readln;
           end;
       else
         begin
           gotoxy(27,19); writeln('>> Anda Salah memasukkan Nilai');
           gotoxy(27,20); write('>> Tekan Enter untuk Mengulangi!'); readln;
         end;
    end; //endcase
  until(pil = 0);
end;

{Program Utama}
begin
  textbackground(green);
  textcolor(yellow);
  penciptaan(mobil);
  menuMobil(maksData);
end.

