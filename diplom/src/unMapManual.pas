unit unMapManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs ,unDM, DB, Grids, DBGrids, ADODB, StdCtrls, unReport,
  unCommonFunc, OleServer, ComObj, Menus, hh, ExtCtrls, DBCtrls;

type
  TfmMapManual = class(TForm)
    adsUnitTags: TADODataSet;
    dsTestUnits: TDataSource;
    dbgTestUnits: TDBGrid;
    adsUnitTagsunitid: TIntegerField;
    adsUnitTagstagid: TIntegerField;
    adsUnitTagsSigTypeID: TIntegerField;
    dbgTags: TDBGrid;
    dsUnitTags: TDataSource;
    tbProbTags: TADOTable;
    adsUnitTagsprobtag: TStringField;
    dsPlace: TDataSource;
    tbPlace: TADOTable;
    dbgPlace: TDBGrid;
    tbSigType: TADOTable;
    adsUnitTagssigname: TStringField;
    adsUnitTagsid: TAutoIncField;
    dbCont: TDBGrid;
    btCon: TButton;
    dsCont: TDataSource;
    adsCont: TADODataSet;
    tbMap: TADOTable;
    dbgMap: TDBGrid;
    dsMap: TDataSource;
    btReport: TButton;
    btAdd: TButton;
    btExcel: TButton;
    btExport: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    qTestUnits: TADOQuery;
    qPlace: TADOQuery;
    qAddDel: TADOQuery;
    adsContid_place: TIntegerField;
    adsContid_conn: TIntegerField;
    adsContcontid: TIntegerField;
    adsContid_sig: TIntegerField;
    adsContcontnum: TIntegerField;
    adsContconttag: TStringField;
    adsContsigtag: TStringField;
    btDel: TButton;
    tbMapid: TIntegerField;
    tbMapunittag: TIntegerField;
    tbMapcontid: TIntegerField;
    tbUnitTags: TADOTable;
    tbUnitTagsid: TIntegerField;
    tbUnitTagsunitid: TIntegerField;
    tbUnitTagstagid: TIntegerField;
    tbUnitTagstagname: TStringField;
    tbMapprobtag: TStringField;
    tbCont: TADOTable;
    tbContid: TAutoIncField;
    tbContid_conn: TIntegerField;
    tbContid_sig: TIntegerField;
    tbContcontnum: TIntegerField;
    tbContsigtag: TStringField;
    tbContconttag: TStringField;
    tbMapconttag: TStringField;
    mnMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    mnClose: TMenuItem;
    mnHelpMenu: TMenuItem;
    mnHelp: TMenuItem;
    mnReportMenu: TMenuItem;
    mnPrint: TMenuItem;
    mnReportExcel: TMenuItem;
    mnExcelExport: TMenuItem;
    dbnUnits: TDBNavigator;
    dbnUnitTags: TDBNavigator;
    dbnPlace: TDBNavigator;
    qTestUnitsunid: TIntegerField;
    qTestUnitsunname: TStringField;
    qPlaceid: TIntegerField;
    qPlaceplacename: TStringField;
    dbnContact: TDBNavigator;
    procedure btConClick(Sender: TObject);
    procedure dbgTagsCellClick(Column: TColumn);
    procedure adsUnitTagsAfterScroll(DataSet: TDataSet);
    procedure btAddClick(Sender: TObject);
    procedure btReportClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure btExportClick(Sender: TObject);
    procedure ContSelect;
    procedure adsContCalcFields(DataSet: TDataSet);
    procedure btDelClick(Sender: TObject);
    procedure tbContCalcFields(DataSet: TDataSet);
    procedure mnCloseClick(Sender: TObject);
    procedure mnHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMapManual: TfmMapManual;

implementation

{$R *.dfm}

// ���������� ������ �� ������
procedure TfmMapManual.btConClick(Sender: TObject);
begin
  ContSelect;
end;

// ���������� ������ ����� ��� ������ ������
procedure TfmMapManual.dbgTagsCellClick(Column: TColumn);
begin
  ContSelect;
end;

// ���������� ������ ����� ��� ����������� �� �������
procedure TfmMapManual.adsUnitTagsAfterScroll(DataSet: TDataSet);
begin
  ContSelect;
end;

// �������� ������ ����������
procedure TfmMapManual.btAddClick(Sender: TObject);
begin
  if (adsUnitTagstagid.AsVariant<>NULL) and (adsContcontid.AsVariant<>NULL) then
  begin
    if ConfirmAdd(self.Handle,'���������� '+adsUnitTagsprobtag.AsString+' � '+
    adsContconttag.AsString) then
    begin
      qAddDel.Close;
      qAddDel.SQL.Clear;
      qAddDel.SQL.Add('INSERT into map (unittag,contid)');
      qAddDel.SQL.Add('VALUES('+adsUnitTagsid.AsString+','+adsContcontid.AsString+')');
      qAddDel.ExecSQL;
  //  tbMap.AppendRecord([nil,adsUnitTagsid.AsInteger,adsContcontid.AsInteger]);
      ReopenDatasets([adsUnitTags,adsCont,tbMap]);
    end;
  end else ShowMessage('���������� � ������ ������!');
end;

// ������������ ������ ��� ������
procedure TfmMapManual.btReportClick(Sender: TObject);
begin
  ReopenDatasets([fmReport.qReport]);
  fmReport.QuickRep1.Preview;
end;

// ������������ ������� � Excel
procedure TfmMapManual.btExcelClick(Sender: TObject);
var
    ExcelApp, Workbook, Range, Cell1, Cell2, ArrayData  : Variant;
    BeginCol, BeginRow, i : integer;
    RowCount, ColCount : integer;
begin
// �������� Excel
  ExcelApp := CreateOleObject('Excel.Application');
// ��������� ������� Excel �� �������, ����� �������� ����� ����������
  ExcelApp.Application.EnableEvents := false;
//  ������� ����� (Workbook)
  Workbook := ExcelApp.WorkBooks.add;
  ExcelApp.Visible := true;
  ReopenDatasets([fmReport.qReport]);
// ���������� ������ �������� ���� �������, � ������� ����� �������� ������
  BeginCol := 1;
  BeginRow := 1;
// ������� ���������� ������� ������
  RowCount := fmReport.qReport.RecordCount;
  ColCount := fmReport.qReport.FieldCount;
// ������� ���������� ������, ������� �������� ��������� �������
  ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
 // ��������� ������
  fmReport.qReport.First;
  for I := 1 to RowCount do
  begin
    ArrayData[I, 1] := fmReport.qReportProbName.AsVariant;
    ArrayData[I, 2] := fmReport.qReportProbTag.AsVariant;
    ArrayData[I, 3] := fmReport.qReportunname.AsVariant;
    ArrayData[I, 4] := fmReport.qReportplacename.AsVariant;
    ArrayData[I, 5] := fmReport.qReportconnname.AsVariant;
    ArrayData[I, 6] := fmReport.qReportconttag.AsVariant;
    fmReport.qReport.Next;
  end;
  ExcelApp.Application.Worksheets.item[1].Activate;
// ����� ������� ������ �������, � ������� ����� �������� ������
  Cell1 := ExcelApp.Application.Worksheets.item[1].Cells[BeginRow, BeginCol];
// ������ ������ ������ �������, � ������� ����� �������� ������
  Cell2 := ExcelApp.Application.Worksheets.item[1].Cells[BeginRow  + RowCount - 1, BeginCol + ColCount - 1];
// �������, � ������� ����� �������� ������
  Range := ExcelApp.Application.Worksheets.item[1].Range[Cell1, Cell2];
// � ��� � ��� ����� ������
// ������� ������� ����������� ����������
  Range.Value := ArrayData;
//  FreeMemory(ArrayData);
// ������ Excel �������
  ExcelApp.Visible := true;
end;


// ������� ����� � Excel
procedure TfmMapManual.btExportClick(Sender: TObject);
var
    ExcelApp, Workbook, Range, Cell1, Cell2, ArrayData  : Variant;
    BeginCol, BeginRow, i : integer;
    RowCount, ColCount : integer;
begin
// �������� Excel
  ExcelApp := CreateOleObject('Excel.Application');
// ��������� ������� Excel �� �������, ����� �������� ����� ����������
  ExcelApp.Application.EnableEvents := false;
//  ������� ����� (Workbook)
//  ���� ��������� ������, ��
  Workbook := ExcelApp.WorkBooks.add;
  ExcelApp.Visible := true;
  ReopenDatasets([fmReport.qReport]);
// ���������� ������ �������� ���� �������, � ������� ����� �������� ������
  BeginCol := 1;
  BeginRow := 1;
// ������� ���������� ������� ������
  RowCount := fmReport.qReport.RecordCount;
  ColCount := fmReport.qReport.FieldCount;
//  ShowMessage(inttostr(ADOTable1.Fields.Count));
//  Workbook := ExcelApp.WorkBooks.Add;
// ������� ���������� ������, ������� �������� ��������� �������
  ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
 // ��������� ������
  fmReport.qReport.First;
  for I := 1 to RowCount do
  begin
    ArrayData[I, 1] := fmReport.qReportProbName.AsVariant;
    ArrayData[I, 2] := fmReport.qReportconttag.AsVariant;
    fmReport.qReport.Next;
  end;
  ExcelApp.Application.Worksheets.item[1].Activate;
// ����� ������� ������ �������, � ������� ����� �������� ������
  Cell1 := ExcelApp.Application.Worksheets.item[1].Cells[BeginRow, BeginCol];
// ������ ������ ������ �������, � ������� ����� �������� ������
  Cell2 := ExcelApp.Application.Worksheets.item[1].Cells[BeginRow  + RowCount - 1, BeginCol + ColCount - 1];
// �������, � ������� ����� �������� ������
  Range := ExcelApp.Application.Worksheets.item[1].Range[Cell1, Cell2];
// � ��� � ��� ����� ������
// ������� ������� ����������� ����������
  Range.Value := ArrayData;
//  FreeMemory(ArrayData);
// ������ Excel �������
  ExcelApp.Visible := true;
end;

// ���������� ������ �����
procedure TfmMapManual.ContSelect;
begin
  if adsUnitTagsSigTypeID.AsVariant<>NULL then
  begin
    adsCont.Close;
    adsCont.CommandText:='SELECT connector.id_place, contact.id_conn,'+
      ' contact.id as contid, contact.id_sig, contact.contnum FROM connector'+
      ' INNER JOIN contact ON connector.id = contact.id_conn'+
      ' where contact.id_sig='+adsUnitTagsSigTypeID.AsString+' and contact.id'+
      ' not in (SELECT contid from map)';
    adsCont.Open;
  end; //else ShowMessage('��� ������ �����������');
end;

// ��������� �������� ����������� �����
procedure TfmMapManual.adsContCalcFields(DataSet: TDataSet);
begin
  adsContconttag.AsString:=adsContsigtag.AsString+'.'+adsContcontnum.AsString;
end;

// �������� ����������
procedure TfmMapManual.btDelClick(Sender: TObject);
begin
  if tbMapid.AsVariant<>NULL then
  begin
    if ConfirmDel(self.Handle,'���������� '+tbMapprobtag.AsString+' � '+
    tbMapconttag.AsString) then
    begin
      qAddDel.Close;
      qAddDel.SQL.Clear;
      qAddDel.SQL.Add('DELETE FROM map where id = '+tbMapid.AsString);
      qAddDel.ExecSQL;
      ReopenDatasets([tbMap,adsUnitTags,adsCont]);
    end;
  end else ShowMessage('��� ���������� ��� ��������!');
end;

procedure TfmMapManual.tbContCalcFields(DataSet: TDataSet);
begin
  tbContconttag.AsString:=tbContsigtag.AsString+'.'+tbContcontnum.AsString;
end;

// �������� ����
procedure TfmMapManual.mnCloseClick(Sender: TObject);
begin
  Close;
end;

// ����� ������� �� ����
procedure TfmMapManual.mnHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unMapManual.dfm.html',HH_DISPLAY_TOPIC,0);
end;

// ���������� �������
procedure TfmMapManual.FormShow(Sender: TObject);
begin
  ReopenDatasets([qTestUnits,qPlace,adsUnitTags,adsCont,tbMap]);
end;

end.
