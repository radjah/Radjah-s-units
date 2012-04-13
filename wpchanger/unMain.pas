unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComObj, ShlObj, XPMan, jpeg, ExtCtrls, pngimage,
  ExtDlgs;

type
  TfmMain = class(TForm)
    Button2: TButton;
    XPManifest1: TXPManifest;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure Button2Click(Sender: TObject);
    function jpegtobmp(const filename: tfilename):ANSIstring;
    function convert(const filename3: tfilename):ANSIstring;
    function pngtobmp(const filename1: tfilename):ANSIstring;
    function bmptobmp(const filename2: tfilename):ANSIstring;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

function TfmMain.bmptobmp(const filename2: tfilename):ANSIstring;
  var
    Bitmap: TBitmap;
    name:ANSIstring;
  begin
    Bitmap := TBitmap.Create;
    try
    Bitmap.LoadFromFile(filename2);
    name:=GetEnvironmentVariable('APPDATA')+'\'+'wallpaper.bmp';
    Bitmap.SaveToFile(name);
    result:=name;
 finally
   Bitmap.Free;
 end
end;

function TfmMain.pngtobmp(const filename1:tfilename):ANSIstring;
var
 Bitmap: TBitmap;
 PNG: TPNGObject;
 name:ANSIstring;
begin
 PNG := TPNGObject.Create;
 Bitmap := TBitmap.Create;
 {In case something goes wrong, free booth PNG and Bitmap}
 try
   PNG.LoadFromFile(filename1);
   Bitmap.Assign(PNG);    //Convert data into bitmap
   name:=GetEnvironmentVariable('APPDATA')+'\'+'wallpaper.bmp';
   Bitmap.SaveToFile(name);
   result:=name;
 finally
   PNG.Free;
   Bitmap.Free;
 end
end;

function TfmMain.convert(const filename3: tfilename):ANSIstring;
begin
  if Radiobutton2.Checked then Result:=jpegtobmp(filename3);
  if Radiobutton1.Checked then Result:=bmptobmp(filename3);
  if Radiobutton3.Checked then Result:=pngtobmp(filename3);
end;

function TfmMain.jpegtobmp(const filename: tfilename):ANSIstring;
var
  jpeg: tjpegimage;
  bmp: tbitmap;
  name:ANSIstring;
begin
  jpeg := tjpegimage.create;
try
  jpeg.compressionquality := 100; {default value}
  jpeg.loadfromfile(filename);
  bmp := tbitmap.create;
try
  bmp.assign(jpeg);
  name:=GetEnvironmentVariable('APPDATA')+'\'+'wallpaper.bmp';
  bmp.savetofile(name);
  result:=name;
finally
  bmp.free
end;
finally
  jpeg.free
end;
end;

procedure TfmMain.Button2Click(Sender: TObject);
//const
//  CLSID_ActiveDesktop: TGUID = '{75048700-EF1F-11D0-9888-006097DEACF9}';
//  ActiveDesktop: IActiveDesktop;
begin
//  ActiveDesktop := CreateComObject(CLSID_ActiveDesktop) as IActiveDesktop;
//  ActiveDesktop.SetWallpaper(pwchar(Edit1.Text), 0);
//  ActiveDesktop.ApplyChanges(AD_APPLY_ALL or AD_APPLY_FORCE);
  if Radiobutton2.Checked then OpenPictureDialog1.Filter:='jpeg|*.jpeg; *.jpg';
  if Radiobutton1.Checked then OpenPictureDialog1.Filter:='bmp|*.bmp';
  if Radiobutton3.Checked then OpenPictureDialog1.Filter:='png|*.png';
  if OpenPictureDialog1.Execute then
  if SystemParametersInfo(SPI_SETDESKWALLPAPER,0,pchar(convert(OpenPictureDialog1.FileName)),SPIF_UPDATEINIFILE) then ShowMessage('Сделано!')
    else Showmessage('Неудача!');
end;
end.
