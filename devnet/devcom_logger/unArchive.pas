unit unArchive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZDataset, DB, ZAbstractRODataset, ZAbstractDataset,
  ZAbstractTable, StdCtrls, Grids, DBGrids;

type
  TfmArchive = class(TForm)
    dbgArchive: TDBGrid;
    lArcTime: TLabel;
    lArcDiff: TLabel;
    lArcUd: TLabel;
    Label4: TLabel;
    ztMeasArchive: TZTable;
    dsArchive: TDataSource;
    zqArchive: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure dbgArchiveColEnter(Sender: TObject);
    procedure dbgArchiveCellClick(Column: TColumn);
    procedure dbgArchiveKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmArchive: TfmArchive;

implementation

uses unDevNetLogger;

{$R *.dfm}

procedure TfmArchive.FormShow(Sender: TObject);
begin
  ztMeasArchive.Close;
  ztMeasArchive.Open;
end;

{ === Обработка архива === }
procedure TfmArchive.dbgArchiveColEnter(Sender: TObject);
var
  WeightStart,WeightEnd:real; // Значение массы на начало и конец замера
  ArcTime:real; // Продолжительность замера
  WeightDiff:real; // Расход зазамер
begin
  if ztMeasArchive.RecordCount>0 then
  begin
    // Запускаем запрос
    zqArchive.Close;
    zqArchive.SQL.Strings[1]:='meas_id='+ztMeasArchive.FieldByName('id').AsString;
    zqArchive.Open;
    // Получение данных
    ArcTime:=ztMeasArchive.FieldByName('mtime').AsFloat;
    lArcTime.Caption:='Время: ' + FloatToStr(ArcTime) + ' сек.';
    zqArchive.First;
    WeightStart:=zqArchive.FieldByName('brutto').AsFloat;
    zqArchive.Last;
    WeightEnd:=zqArchive.FieldByName('brutto').AsFloat;
    WeightDiff:=Abs(WeightStart-WeightEnd);
    lArcDiff.Caption:='Разница: ' + Format('%.3f',[WeightDiff]);
    if ArcTime<>0 then
    lArcUd.Caption:='Часовой: ' +  Format('%.3f',[WeightDiff/ArcTime*3600])
    else
    lArcUd.Caption:='Часовой:'
  end;
end;

procedure TfmArchive.dbgArchiveCellClick(Column: TColumn);
begin
  dbgArchiveColEnter(Self);
end;

procedure TfmArchive.dbgArchiveKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  dbgArchiveColEnter(Self);
end;

end.
