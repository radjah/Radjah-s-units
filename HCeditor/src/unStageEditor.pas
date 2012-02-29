unit unStageEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls, Grids,
  DBGrids, DB, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset;

type
  TfmStageEditor = class(TForm)
    ztStage: TZTable;
    ztSStruct: TZTable;
    dsStage: TDataSource;
    dsSStruct: TDataSource;
    dbgStage: TDBGrid;
    dbgSStruct: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    btSCreate: TButton;
    btSDelete: TButton;
    chPreview: TChart;
    Series1: TLineSeries;
    zqCommon: TZQuery;
    btEdit: TButton;
    zqCheckStages: TZQuery;
    procedure btSCreateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSDeleteClick(Sender: TObject);
    procedure Replot;
    procedure dbgStageKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgStageMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure btEditClick(Sender: TObject);
    procedure CheckStagesCount;
    procedure dbgStageCellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmStageEditor: TfmStageEditor;

implementation

uses
  unMain, unNewStage, unCommonFunc;

{$R *.dfm}

// �������� ������� ������ � ���/���� ������
procedure TfmStageEditor.CheckStagesCount;
begin
  zqCheckStages.Open;
  if zqCheckStages.FieldByName('scount').AsInteger = 0 then
  begin
    btSCreateClick(Self);
  end
  else
  begin
    ReopenDS([ztStage, ztSStruct]);
    btEdit.Enabled := true;
    btSDelete.Enabled := true;
    ztStage.First;
    Replot;
  end;
end;

// ��������� ������ �����
procedure TfmStageEditor.Replot;
var
  totaltime: Integer;
begin
  zqCommon.Close;
  zqCommon.SQL.Clear;
  zqCommon.SQL.Add('select sid, clevel, ptime from sstruct');
  zqCommon.SQL.Add('where sid=' + ztStage.FieldByName('sid').AsString);
  zqCommon.Open;
  zqCommon.First;
  Series1.Clear;
  Series1.AddXY(0, 0);
  totaltime := 0;
  while not zqCommon.Eof do
  begin
    totaltime := totaltime + zqCommon.FieldByName('ptime').AsInteger;
    Series1.AddXY(totaltime, zqCommon.FieldByName('clevel').AsInteger);
    zqCommon.Next;
  end;
  zqCommon.Close;
end;

// �������������� �����
procedure TfmStageEditor.btEditClick(Sender: TObject);
begin
  fmNewStage.IsEdit := true;
  fmNewStage.StageID := ztStage.FieldByName('sid').AsInteger;
  fmNewStage.ShowModal;
end;

// �������� ������ �����
procedure TfmStageEditor.btSCreateClick(Sender: TObject);
{ var
  stagename: string; }
begin
  fmNewStage.IsEdit := False;
  fmNewStage.ShowModal;
  { stagename:=InputBox('������', '������� ����������� �����:','');
    if stagename<>'' then
    ztStage.AppendRecord([NULL, stagename]); }
end;

// �������� ����� � ��� ���������
procedure TfmStageEditor.btSDeleteClick(Sender: TObject);
var
  str: string;
begin
  // ������
  str := '������� ���� "' + ztStage.FieldByName('sname').AsWideString +
    '" � ��� ��� �����?';
  if MessageBox(Self.Handle, Pchar(str), '������', MB_YESNO OR MB_ICONQUESTION)
    = IDYES then
  begin
    // ����������� ������� ������ �� ������� ���������� ����� � ���
    zqCommon.Close;
    zqCommon.SQL.Clear;
    zqCommon.SQL.Add('select count(sid) as sidc from cstruct');
    zqCommon.SQL.Add('where sid=' + ztStage.FieldByName('sid').AsString);
    zqCommon.Open;
    if (zqCommon.FieldByName('sidc').AsInteger) = 0 then
    begin
      // ������� ��� ������������ �����
      zqCommon.Close;
      zqCommon.SQL.Clear;
      zqCommon.SQL.Add('delete from sstruct where sid=' +
        ztStage.FieldByName('sid').AsString);
      zqCommon.ExecSQL;
      // ������� ��� ����
      zqCommon.Close;
      zqCommon.SQL.Clear;
      zqCommon.SQL.Add('delete from stages where sid=' +
        ztStage.FieldByName('sid').AsString);
      zqCommon.ExecSQL;
      // �������� ������ �� �����
      ReopenDS([ztStage, ztSStruct]);
    end
    else
      MessageBox(Self.Handle, '����� ���� ��������� � ��������� ������.' +
        #10#13 + '�������� �� ��������', '������ �������',
        MB_OK OR MB_ICONEXCLAMATION);
  end;
end;

// ������������ ���������� �������
procedure TfmStageEditor.dbgStageCellClick(Column: TColumn);
begin
  Replot;
end;

procedure TfmStageEditor.dbgStageKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Replot;
end;

// ������������ ���������� �������
procedure TfmStageEditor.dbgStageMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  Replot;
end;

// �� ���������
procedure TfmStageEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseDS([ztStage, ztSStruct, zqCommon, zqCheckStages]);
end;

// �������� ��� �������
procedure TfmStageEditor.FormShow(Sender: TObject);
begin
  CheckStagesCount;
end;

end.
