unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComObj, ShlObj, XPMan, jpeg, ExtCtrls, pngimage,
  ExtDlgs;

type
  TfmMain = class(TForm)
    btChange: TButton;
    XPManifest1: TXPManifest;
    RadioGroup1: TRadioGroup;
    rbBMP: TRadioButton;
    rbJPEG: TRadioButton;
    rbPNG: TRadioButton;
    opdImage: TOpenPictureDialog;
    procedure btChangeClick(Sender: TObject);
    function jpegtobmp(const filename: tfilename): ANSIstring;
    function convert(const filename3: tfilename): ANSIstring;
    function pngtobmp(const filename1: tfilename): ANSIstring;
    function bmptobmp(const filename2: tfilename): ANSIstring;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

// "Преобразование" BMP в BMP
function TfmMain.bmptobmp(const filename2: tfilename): ANSIstring;
var
  Bitmap: TBitmap;
  name: ANSIstring;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.LoadFromFile(filename2);
    name := GetEnvironmentVariable('APPDATA') + '\' + 'wallpaper.bmp';
    Bitmap.SaveToFile(name);
    result := name;
  finally
    Bitmap.Free;
  end
end;

// Преобразование PNG в BMP
function TfmMain.pngtobmp(const filename1: tfilename): ANSIstring;
var
  Bitmap: TBitmap;
  PNG: TPNGObject;
  name: ANSIstring;
begin
  PNG := TPNGObject.Create;
  Bitmap := TBitmap.Create;
  { In case something goes wrong, free booth PNG and Bitmap }
  try
    PNG.LoadFromFile(filename1);
    Bitmap.Assign(PNG); // Convert data into bitmap
    name := GetEnvironmentVariable('APPDATA') + '\' + 'wallpaper.bmp';
    Bitmap.SaveToFile(name);
    result := name;
  finally
    PNG.Free;
    Bitmap.Free;
  end
end;

// Выбор функции для преобразования
function TfmMain.convert(const filename3: tfilename): ANSIstring;
begin
  if rbJPEG.Checked then
    result := jpegtobmp(filename3);
  if rbBMP.Checked then
    result := bmptobmp(filename3);
  if rbPNG.Checked then
    result := pngtobmp(filename3);
end;

// Преобразование JPEG в BMP
function TfmMain.jpegtobmp(const filename: tfilename): ANSIstring;
var
  jpeg: tjpegimage;
  bmp: TBitmap;
  name: ANSIstring;
begin
  jpeg := tjpegimage.Create;
  try
    jpeg.compressionquality := 100; { default value }
    jpeg.LoadFromFile(filename);
    bmp := TBitmap.Create;
    try
      bmp.Assign(jpeg);
      name := GetEnvironmentVariable('APPDATA') + '\' + 'wallpaper.bmp';
      bmp.SaveToFile(name);
      result := name;
    finally
      bmp.Free
    end;
  finally
    jpeg.Free
  end;
end;

// Выбор файла, преобразование и установка обоев
procedure TfmMain.btChangeClick(Sender: TObject);
// Хитрый способ для установки обоев без преобразование
// const
// CLSID_ActiveDesktop: TGUID = '{75048700-EF1F-11D0-9888-006097DEACF9}';
// ActiveDesktop: IActiveDesktop;
begin
  // ActiveDesktop := CreateComObject(CLSID_ActiveDesktop) as IActiveDesktop;
  // ActiveDesktop.SetWallpaper(pwchar(Edit1.Text), 0);
  // ActiveDesktop.ApplyChanges(AD_APPLY_ALL or AD_APPLY_FORCE);

  // Настройка фильтра
  if rbJPEG.Checked then
    opdImage.Filter := 'jpeg|*.jpeg; *.jpg';
  if rbBMP.Checked then
    opdImage.Filter := 'bmp|*.bmp';
  if rbPNG.Checked then
    opdImage.Filter := 'png|*.png';
  // Преобразование
  if opdImage.Execute then
    if SystemParametersInfo(SPI_SETDESKWALLPAPER, 0,
      pchar(convert(opdImage.filename)), SPIF_UPDATEINIFILE) then
      MessageBox(Self.Handle, 'Обои изменены.', 'Информация',
        MB_OK or MB_ICONINFORMATION)
    else
      MessageBox(Self.Handle, 'Обои не изменены!', 'Ошибка!',
        MB_OK or MB_ICONERROR);
end;

end.
