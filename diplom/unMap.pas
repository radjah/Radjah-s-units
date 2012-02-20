unit unMap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unDM, unCommonFunc, Grids, DBGrids, DB, ADODB, StdCtrls, Menus,
  hh, unMapManual;

type
  TfmMap = class(TForm)
    dsUnits: TDataSource;
    dbgUnits: TDBGrid;
    adsSigByUnit: TADODataSet;
    dsSigByUnit: TDataSource;
    dbgSigByUnit: TDBGrid;
    btFind: TButton;
    qFindPlace: TADOQuery;
    dsFindPlace: TDataSource;
    dbgFindPlace: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btConnect: TButton;
    tbPlace: TADOTable;
    adsSigByUnitunid: TIntegerField;
    adsSigByUnitsigtypeid: TIntegerField;
    adsSigByUnitsigcount: TIntegerField;
    tbSigName: TADOTable;
    adsSigByUnitsigname: TStringField;
    dbgMap: TDBGrid;
    Label4: TLabel;
    mnMenu: TMainMenu;
    mnMap: TMenuItem;
    N2: TMenuItem;
    mnClose: TMenuItem;
    mnHelpMenu: TMenuItem;
    mnHelp: TMenuItem;
    dsMap: TDataSource;
    qMap: TADOQuery;
    qMapProbTag: TStringField;
    qMapsigtag: TStringField;
    qMapcontnum: TIntegerField;
    qMapconttag: TStringField;
    tbTemp: TADOTable;
    qTemp: TADOQuery;
    qCrTemp: TADOQuery;
    qTestUnits: TADOQuery;
    qTempid_place: TIntegerField;
    qTempid_sig: TIntegerField;
    qTempsigcount: TIntegerField;
    qClearTemp: TADOQuery;
    qFindPlaceid_place: TIntegerField;
    qFindPlaceplacename: TStringField;
    btClear: TButton;
    qClear: TADOQuery;
    qTestUnitsunid: TIntegerField;
    qTestUnitsunname: TStringField;
    mnReportMenu: TMenuItem;
    mnPrintReport: TMenuItem;
    mnExcelReport: TMenuItem;
    mnExcelExport: TMenuItem;
    adsSigPlace: TADODataSet;
    dsSigPlace: TDataSource;
    dbgSigPlace: TDBGrid;
    adsSigPlaceid_place: TIntegerField;
    adsSigPlacesigtag: TStringField;
    adsSigPlaceid_sig: TIntegerField;
    Label5: TLabel;
    procedure btFindClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnCloseClick(Sender: TObject);
    procedure mnHelpClick(Sender: TObject);
    procedure qMapCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure btConnectClick(Sender: TObject);
    procedure mnPrintReportClick(Sender: TObject);
    procedure mnExcelReportClick(Sender: TObject);
    procedure mnExcelExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMap: TfmMap;

implementation

{$R *.dfm}

// Поиск места для выбранного шкафа
procedure TfmMap.btFindClick(Sender: TObject);
var
  fromstr,groupby,having:AnsiString;
  i:integer;
begin
  qFindPlace.Close;
  if adsSigByUnit.RecordCount>0 then
  begin
    adsSigByUnit.First;
    // Таблицы для выборки
    fromstr:='FROM     places INNER JOIN ##contact A1 on A1.id_place=places.id ';
    // Группировка
    groupby:='GROUP BY id,placename,A1.id_sig,A1.sigcount';
    // Условие выборки
    having:='HAVING      (A1.id_sig = '+adsSigByUnitsigtypeid.AsString+' and A1.sigcount >= '+adsSigByUnitsigcount.AsString+')';
    // Переещение на вторую запись для инициализации цикла.
    i:=2;
    adsSigByUnit.Next;
    // Дополнение условий
    while NOT adsSigByUnit.Eof do
    begin
      fromstr:=fromstr+' CROSS JOIN ##contact A'+IntToStr(i);
      groupby:=groupby+',A'+IntToStr(i)+'.id_sig,A'+IntToStr(i)+'.sigcount';
      having:=having+' and (A'+inttostr(i)+'.id_sig = '+adsSigByUnitsigtypeid.AsString+' and A'+inttostr(i)+'.sigcount >= '+adsSigByUnitsigcount.AsString+')';
      adsSigByUnit.Next;
      i:=i+1;
    end;
    // Формирование запроса
    qFindPlace.SQL[1]:=fromstr;
    qFindPlace.SQL[2]:=groupby;
    qFindPlace.SQL[3]:=having;
    // Выполнение запроса
    ReopenDatasets([qFindPlace,adsSigPlace]);
    btConnect.Enabled:=True;
  end else ShowMessage('Шкаф пустой');
end;

procedure TfmMap.FormShow(Sender: TObject);
var
  i:integer;
begin
  ReopenDatasets([qTestUnits,adsSigByUnit,qMap]);
  // Заполнение временной таблицы
  ReopenDatasets([qTemp,tbTemp]);
  // Очистка такблицы
  qClearTemp.ExecSQL;
  // Открытие таблицы-приемника
  ReopenDatasets([tbTemp]);
  // Чтение записей и заполнение таблицы
  qTemp.First;
  for i:=0 to qTemp.RecordCount-1 do
  begin
    tbTemp.AppendRecord([qTempid_place,qTempid_sig,qTempsigcount]);
    qTemp.Next;
  end;
end;

// Закрыть окно
procedure TfmMap.mnCloseClick(Sender: TObject);
begin
  Close;
end;

// Вызов справки по окну
procedure TfmMap.mnHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unMap.dfm.html',HH_DISPLAY_TOPIC,0);
end;

// Значения вычисляемых полей
procedure TfmMap.qMapCalcFields(DataSet: TDataSet);
begin
  qMapconttag.AsString:=qMapsigtag.AsString+'.'+qMapcontnum.AsString;
end;

// Создание временной таблицы
procedure TfmMap.FormCreate(Sender: TObject);
begin
  qCrTemp.ExecSQL;
end;

// Удаление всех соединений
procedure TfmMap.btClearClick(Sender: TObject);
begin
  if ConfirmDel(Self.Handle,'все соединения') then
  begin
    qClear.ExecSQL;
    ReopenDatasets([qMap]);
  end;
end;

// Создание соединений выбранного шкафа с выбранным местом
procedure TfmMap.btConnectClick(Sender: TObject);
begin
  if qFindPlaceid_place.AsVariant<>NULL then
  begin
    // Подготовка
    fmMapManual.FormShow(Sender);
    fmMapManual.qTestUnits.Locate('unid',qTestUnitsunid.AsVariant,[]);
    fmMapManual.qPlace.Locate('id',qFindPlaceid_place.AsVariant,[]);
    // Создание соединений
    while NOT fmMapManual.adsUnitTags.Eof do
    begin
      fmMapManual.adsUnitTags.First;
      fmMapManual.adsCont.First;
      AutoMode:=True;
      fmMapManual.btAddClick(Sender);
      AutoMode:=False;
    end;
    ReopenDatasets([qMap]);
    ShowMessage('Готово!');
  end;
  btConnect.Enabled:=False;
end;

// Вызов процедуры создания отчета
procedure TfmMap.mnPrintReportClick(Sender: TObject);
begin
  fmMapManual.btReportClick(Sender);
end;

// Вызов процедуры создания отчета в Excel
procedure TfmMap.mnExcelReportClick(Sender: TObject);
begin
  fmMapManual.btExcelClick(Sender);
end;

// Вызов процедуры экспорта карты в Excel
procedure TfmMap.mnExcelExportClick(Sender: TObject);
begin
  fmMapManual.btExportClick(Sender);
end;

end.
