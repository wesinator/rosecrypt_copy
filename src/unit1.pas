unit Unit1;
(**
Rose Crypt
by Ali Abdul Ghani(ali miracle)
mail:
blade.vp2020@gmail.com
License:
gpl v3
*)
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  DCPrijndael, DCPsha256;

type

  { TForm1 }

  TForm1 = class(TForm)
    DCP_rijndael1: TDCP_rijndael;
    DCP_sha256_1: TDCP_sha256;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem2Click(Sender: TObject);
  var
q: string;
    Cipher: TDCP_rijndael;
    KeyStr: string;
    Source, Dest: TFileStream;
e: string;
  begin
    KeyStr:= '';
    if InputQuery('Passphrase','Enter passphrase',KeyStr) then  // get the passphrase 
    begin
      try
OpenDialog1.Execute;
q:=OpenDialog1.FileName;
e:=OpenDialog1.FileName;
e:=e+'.enc';
        Source:= TFileStream.Create(q,fmOpenRead);
        Dest:= TFileStream.Create(e,fmCreate);
        Cipher:= TDCP_rijndael.Create(Self);
        Cipher.InitStr(KeyStr,TDCP_SHA256);
        Cipher.EncryptStream(Source,Dest,Source.Size); // encrypt the contents of the file
        Cipher.Burn;
        Cipher.Free;
        Dest.Free;
        Source.Free;
        MessageDlg('File encrypted',mtInformation,[mbOK],0);
      except
        MessageDlg('File IO error',mtError,[mbOK],0);
      end;
    end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
  var
    Cipher: TDCP_rijndael;
    KeyStr: string;
    Source, Dest: TFileStream;
q, e: string;
  begin
    KeyStr:= '';
    if InputQuery('Passphrase','Enter passphrase',KeyStr) then  // get the passphrase 
    begin
      try
OpenDialog1.Execute;
q:=openDialog1.FileName;
e:=openDialog1.FileName;
        Source:= TFileStream.Create(q,fmOpenRead);
delete(e, length(e), 1);
delete(e, length(e), 1);
delete(e, length(e), 1);
delete(e, length(e), 1);
        Dest:= TFileStream.Create(e,fmCreate);
        Cipher:= TDCP_rijndael.Create(Self);
        Cipher.InitStr(KeyStr,TDCP_SHA256);
        Cipher.decryptStream(Source,Dest,Source.Size); // encrypt the contents of the file
        Cipher.Burn;
        Cipher.Free;
        Dest.Free;
        Source.Free;
        MessageDlg('File decrypted',mtInformation,[mbOK],0);
      except
        MessageDlg('File IO error',mtError,[mbOK],0);
      end;
    end;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
        MessageDlg('Rose Crypt by Ali Miracle mail:blade.vp2020@gmail.com',mtInformation,[mbOK],0);
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  Close;
end;

end.

