unit Unit1;

interface

uses
//  Windows,
//  Messages,
  SysUtils,
//  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtDlgs,
  jpeg,
  StdCtrls,
  ComCtrls,
  XPMan,
  pngimage,
  GIFImage;

type
  TForm1 = class(TForm)
    sd1: TSaveDialog;
    opd1: TOpenPictureDialog;
    Button1: TButton;
    Button2: TButton;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Edit1: TEdit;
    XPManifest1: TXPManifest;
    Button3: TButton;
    Button4: TButton;
    UpDown1: TUpDown;
    Button5: TButton;
    Button6: TButton;
    cb: TCheckBox;
    cb2: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  jpeg: tjpegimage;
  bmp: tbitmap;
begin
  jpeg := tjpegimage.create;
try
  bmp := tbitmap.create;
  opd1.Filter:='jpeg|*.jpeg; *.jpg';
  opd1.Execute;
  if opd1.FileName<>'' then
    begin
      try
        jpeg.loadfromfile(opd1.FileName);
        bmp.assign(jpeg);
        sd1.Filter:='bmp|*.bmp';
        sd1.DefaultExt:='bmp';
        sd1.Execute;
        if sd1.FileName<>'' then bmp.savetofile(sd1.FileName);
        sd1.FileName:='';
      finally
        bmp.free
      end;
    end;
finally
  jpeg.free;
  opd1.FileName:=''
end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Edit1.Text:=inttostr(TrackBar1.Position);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  jpeg: tjpegimage;
  bmp: tbitmap;
begin
  bmp:=TBitmap.Create;
try
  jpeg := tjpegimage.create;
  opd1.Filter:='bmp|*.bmp';
  opd1.Execute;
  if opd1.FileName<>'' then
    begin
      try
        jpeg.compressionquality := TrackBar1.Position;
        if cb.Checked=true then jpeg.ProgressiveEncoding:=True else jpeg.ProgressiveEncoding:=False;
        if cb2.Checked=true then jpeg.Grayscale:=true else jpeg.Grayscale:=false;
        bmp.loadfromfile(opd1.FileName);
        jpeg.assign(bmp);
        sd1.Filter:='jpeg|*.jpeg; *.jpg';
        sd1.DefaultExt:='jpg';
        sd1.Execute;
        if sd1.FileName<>'' then jpeg.savetofile(sd1.FileName);
        sd1.FileName:='';
      finally
        jpeg.free
      end;
    end;
finally
  bmp.free;
  opd1.FileName:=''
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  jpeg: tjpegimage;
  png: tpngobject;
  bmp: Tbitmap;
begin
  png:=tpngobject.Create;
try
  jpeg := tjpegimage.create;
  opd1.Filter:='png|*.png';
  opd1.Execute;
  if opd1.FileName<>'' then
    begin
      try
        jpeg.compressionquality := TrackBar1.Position;
        if cb.Checked=true then jpeg.ProgressiveEncoding:=True else jpeg.ProgressiveEncoding:=False;
        if cb2.Checked=true then jpeg.Grayscale:=true else jpeg.Grayscale:=false;
        png.loadfromfile(opd1.FileName);
        bmp:=tbitmap.Create;
        bmp.Assign(png);
        jpeg.assign(bmp);
        sd1.Filter:='jpeg|*.jpg; *.jpeg';
        sd1.DefaultExt:='jpg';
        sd1.Execute;
        if sd1.FileName<>'' then jpeg.savetofile(sd1.FileName);
        bmp.free;
        sd1.FileName:='';
      finally
        jpeg.free;
      end;
    end;
finally
  png.free;
  opd1.FileName:=''
end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  jpegin,jpegout: tjpegimage;
  bmp:tbitmap;
begin
  jpegin := tjpegimage.create;
try
  jpegout := tjpegimage.create;
  opd1.Filter:='jpeg|*.jpeg; *.jpg';
  opd1.Execute;
  if opd1.FileName<>'' then
    begin
      try
        jpegout.compressionquality := TrackBar1.Position;
        if cb.Checked=true then jpegout.ProgressiveEncoding:=True else jpegout.ProgressiveEncoding:=False;
        if cb2.Checked=true then jpegout.Grayscale:=true else jpegout.Grayscale:=false;
        jpegin.loadfromfile(opd1.FileName);
        bmp:=Tbitmap.create;
        bmp.Assign(jpegin);
        jpegout.assign(bmp);
        sd1.Filter:='jpeg|*.jpeg; *.jpg';
        sd1.DefaultExt:='jpg';
        sd1.Execute;
        if sd1.FileName<>'' then jpegout.savetofile(sd1.FileName);
        bmp.free;
        sd1.FileName:='';
      finally
        begin
          jpegout.free;
        end;
      end;
    end;
finally
  jpegin.free;
  opd1.FileName:=''
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Button4.Hint:='Понижение качества'+#10+#13+'Даже при 100% картинка будет хуже';
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  Trackbar1.Position:=strtoint(Edit1.Text);
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  bmp:tbitmap;
  gif:TGIFImage;
begin
  bmp := tbitmap.create;
try
  gif := tgifimage.create;
  opd1.Filter:='bmp|*.bmp';
  opd1.Execute;
  if opd1.FileName<>'' then
    begin
      try
        bmp.loadfromfile(opd1.FileName);
        gif.assign(bmp);
        sd1.Filter:='gif|*.gif';
        sd1.DefaultExt:='gif';
        sd1.Execute;
        if sd1.FileName<>'' then gif.savetofile(sd1.FileName);
        sd1.FileName:='';
      finally
        gif.free
      end;
    end;
finally
  bmp.free;
  opd1.FileName:=''
end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  bmp:tbitmap;
  gif:TGIFImage;
  jpeg:tjpegimage;
begin
  gif := TGIFImage.create;
try
  bmp := tbitmap.create;
  jpeg := tjpegimage.Create;
  opd1.Filter:='gif|*.gif';
  opd1.Execute;
  if opd1.FileName<>'' then
    begin
      try
        jpeg.compressionquality := TrackBar1.Position;
        if cb.Checked=true then jpeg.ProgressiveEncoding:=True else jpeg.ProgressiveEncoding:=False;
        if cb2.Checked=true then jpeg.Grayscale:=true else jpeg.Grayscale:=false;
        gif.loadfromfile(opd1.FileName);
        bmp.assign(gif);
        jpeg.assign(bmp);
        sd1.Filter:='jpeg|*.jpeg; *.jpg';
        sd1.DefaultExt:='jpg';
        sd1.Execute;
        if sd1.FileName<>'' then jpeg.savetofile(sd1.FileName);
        bmp.free;
        sd1.FileName:='';
      finally
        jpeg.free;
        gif.Free;
      end;
    end;
finally
  opd1.FileName:=''
end;
end;


end.
