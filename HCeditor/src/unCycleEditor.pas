unit unCycleEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset,
  StdCtrls, Grids, DBGrids;

type
  TfmCycleEditor = class(TForm)
    ztCStruct: TZTable;
    dsCStruct: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    ztStages: TZTable;
    ztCStructid: TIntegerField;
    ztCStructcid: TIntegerField;
    ztCStructcorder: TIntegerField;
    ztCStructsid: TIntegerField;
    ztCStructsname: TStringField;
    dsStages: TDataSource;
    DBGrid2: TDBGrid;
    btAdd: TButton;
    btDel: TButton;
    zqGetOrder: TZQuery;
    zqGetOrdermaxord: TWideStringField;
    btUp: TButton;
    btDown: TButton;
    zqCheckEmpty: TZQuery;
    zqCommon: TZQuery;
    procedure btAddClick(Sender: TObject);
    procedure GetMaxOrderNumber;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btDelClick(Sender: TObject);
    procedure CheckEmpty;
    procedure btUpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CycleID: integer; // ������������� ����� ��� ��������
    CurOrd: integer;
  end;

var
  fmCycleEditor: TfmCycleEditor;

implementation

uses
  unMain, unCommonFunc;

{$R *.dfm}

// �������� ���������� ������ � �����
procedure TfmCycleEditor.CheckEmpty;
begin
  ReopenDS([zqCheckEmpty]);
  // ShowMessage(inttostr(zqCheckEmpty.FieldByName('scount').AsInteger));
  if zqCheckEmpty.FieldByName('scount').AsInteger = 0 then
  begin
    btDel.Enabled := False;
    btUp.Enabled := False;
    btDown.Enabled := False;
  end
  else
  begin
    btDel.Enabled := True;
    btUp.Enabled := True;
    btDown.Enabled := True;
  end;
end;

// ���������� ����� � ����� �����
procedure TfmCycleEditor.btAddClick(Sender: TObject);
begin
  GetMaxOrderNumber;
  SwitchRW(False, [ztCStruct]);
  CurOrd := CurOrd + 1;
  ztCStruct.AppendRecord([NULL, fmMain.ztCycle.FieldByName('cid').AsInteger,
    CurOrd, ztStages.FieldByName('sid').AsInteger]);
  SwitchRW(True, [ztCStruct]);
  CheckEmpty;
end;

// �������� ���������� �����
procedure TfmCycleEditor.btDelClick(Sender: TObject);
begin
  zqCommon.Close;
  zqCommon.SQL.Clear;
  zqCommon.SQL.Add('delete from cstruct');
  zqCommon.SQL.Add('where id='+ztCStruct.FieldByName('id').AsString);
  zqCommon.ExecSQL;
  ReopenDS([ztCStruct]);
  CheckEmpty;
end;

// ����������� ����� ����
procedure TfmCycleEditor.btUpClick(Sender: TObject);
begin
//
end;

// ��������� �� �� �����
procedure TfmCycleEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseDS([ztCStruct, ztStages]);
end;

procedure TfmCycleEditor.FormShow(Sender: TObject);
begin
  ReopenDS([ztCStruct, ztStages]);
  zqCheckEmpty.Close;
  zqCheckEmpty.SQL[1] := 'cid=' + inttostr(CycleID);
  zqGetOrder.Close;
  zqGetOrder.SQL[1] := 'cid=' + inttostr(CycleID);
  GetMaxOrderNumber;
  CheckEmpty;
end;

// �������� ������� ���������� ����� �����
procedure TfmCycleEditor.GetMaxOrderNumber;
begin
  ReopenDS([zqGetOrder]);
  // ��������� ������, ����� ���� ������ ������
  if zqGetOrder.FieldByName('maxord').AsString = '' then
    CurOrd := 0
  else
    CurOrd := zqGetOrder.FieldByName('maxord').AsInteger;
  // ShowMessage(IntToStr(CurOrd));
end;

end.
