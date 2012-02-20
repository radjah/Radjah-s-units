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

// ����� ����� ��� ���������� �����
procedure TfmMap.btFindClick(Sender: TObject);
var
  fromstr,groupby,having:AnsiString;
  i:integer;
begin
  qFindPlace.Close;
  if adsSigByUnit.RecordCount>0 then
  begin
    adsSigByUnit.First;
    // ������� ��� �������
    fromstr:='FROM     places INNER JOIN ##contact A1 on A1.id_place=places.id ';
    // �����������
    groupby:='GROUP BY id,placename,A1.id_sig,A1.sigcount';
    // ������� �������
    having:='HAVING      (A1.id_sig = '+adsSigByUnitsigtypeid.AsString+' and A1.sigcount >= '+adsSigByUnitsigcount.AsString+')';
    // ���������� �� ������ ������ ��� ������������� �����.
    i:=2;
    adsSigByUnit.Next;
    // ���������� �������
    while NOT adsSigByUnit.Eof do
    begin
      fromstr:=fromstr+' CROSS JOIN ##contact A'+IntToStr(i);
      groupby:=groupby+',A'+IntToStr(i)+'.id_sig,A'+IntToStr(i)+'.sigcount';
      having:=having+' and (A'+inttostr(i)+'.id_sig = '+adsSigByUnitsigtypeid.AsString+' and A'+inttostr(i)+'.sigcount >= '+adsSigByUnitsigcount.AsString+')';
      adsSigByUnit.Next;
      i:=i+1;
    end;
    // ������������ �������
    qFindPlace.SQL[1]:=fromstr;
    qFindPlace.SQL[2]:=groupby;
    qFindPlace.SQL[3]:=having;
    // ���������� �������
    ReopenDatasets([qFindPlace,adsSigPlace]);
    btConnect.Enabled:=True;
  end else ShowMessage('���� ������');
end;

procedure TfmMap.FormShow(Sender: TObject);
var
  i:integer;
begin
  ReopenDatasets([qTestUnits,adsSigByUnit,qMap]);
  // ���������� ��������� �������
  ReopenDatasets([qTemp,tbTemp]);
  // ������� ��������
  qClearTemp.ExecSQL;
  // �������� �������-���������
  ReopenDatasets([tbTemp]);
  // ������ ������� � ���������� �������
  qTemp.First;
  for i:=0 to qTemp.RecordCount-1 do
  begin
    tbTemp.AppendRecord([qTempid_place,qTempid_sig,qTempsigcount]);
    qTemp.Next;
  end;
end;

// ������� ����
procedure TfmMap.mnCloseClick(Sender: TObject);
begin
  Close;
end;

// ����� ������� �� ����
procedure TfmMap.mnHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unMap.dfm.html',HH_DISPLAY_TOPIC,0);
end;

// �������� ����������� �����
procedure TfmMap.qMapCalcFields(DataSet: TDataSet);
begin
  qMapconttag.AsString:=qMapsigtag.AsString+'.'+qMapcontnum.AsString;
end;

// �������� ��������� �������
procedure TfmMap.FormCreate(Sender: TObject);
begin
  qCrTemp.ExecSQL;
end;

// �������� ���� ����������
procedure TfmMap.btClearClick(Sender: TObject);
begin
  if ConfirmDel(Self.Handle,'��� ����������') then
  begin
    qClear.ExecSQL;
    ReopenDatasets([qMap]);
  end;
end;

// �������� ���������� ���������� ����� � ��������� ������
procedure TfmMap.btConnectClick(Sender: TObject);
begin
  if qFindPlaceid_place.AsVariant<>NULL then
  begin
    // ����������
    fmMapManual.FormShow(Sender);
    fmMapManual.qTestUnits.Locate('unid',qTestUnitsunid.AsVariant,[]);
    fmMapManual.qPlace.Locate('id',qFindPlaceid_place.AsVariant,[]);
    // �������� ����������
    while NOT fmMapManual.adsUnitTags.Eof do
    begin
      fmMapManual.adsUnitTags.First;
      fmMapManual.adsCont.First;
      AutoMode:=True;
      fmMapManual.btAddClick(Sender);
      AutoMode:=False;
    end;
    ReopenDatasets([qMap]);
    ShowMessage('������!');
  end;
  btConnect.Enabled:=False;
end;

// ����� ��������� �������� ������
procedure TfmMap.mnPrintReportClick(Sender: TObject);
begin
  fmMapManual.btReportClick(Sender);
end;

// ����� ��������� �������� ������ � Excel
procedure TfmMap.mnExcelReportClick(Sender: TObject);
begin
  fmMapManual.btExcelClick(Sender);
end;

// ����� ��������� �������� ����� � Excel
procedure TfmMap.mnExcelExportClick(Sender: TObject);
begin
  fmMapManual.btExportClick(Sender);
end;

end.
