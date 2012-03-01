unit unNewStage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, TeEngine, Series, TeeProcs, Chart, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfmNewStage = class(TForm)
    sbPos: TScrollBox;
    eSwitchCount: TEdit;
    udSwitchCount: TUpDown;
    Label1: TLabel;
    btMaxPosSet: TButton;
    btCreate: TButton;
    leStageName: TLabeledEdit;
    chStagePreview: TChart;
    Series1: TLineSeries;
    udTpl: TUpDown;
    Label2: TLabel;
    btAddPos: TButton;
    btDelPos: TButton;
    zqGetStruct: TZQuery;
    zqClearSctruct: TZQuery;
    zqGetSCount: TZQuery;
    zqUpdateName: TZQuery;
    zqGetSCountpcount: TWideStringField;
    udPosTpl: TUpDown;
    procedure btMaxPosSetClick(Sender: TObject);
    procedure udTplChanging(Sender: TObject; var AllowChange: boolean);
    procedure ChartReplot;
    procedure btCreateClick(Sender: TObject);
    procedure ResetDialog;
    procedure btAddPosClick(Sender: TObject);
    procedure btDelPosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure udPosTplChanging(Sender: TObject; var AllowChange: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    EditArr: array of TEdit;
    LabelArr: array of TLabel;
    LabelSecArr: array of TLabel;
    UDArr: array of TUpDown;
    UDPosArr: array of TUpDown;
    EditPosArr: array of TEdit;
    IsEdit: boolean;
    StageID: integer;
  end;

var
  fmNewStage: TfmNewStage;

implementation

uses
  unStageEditor, unCommonFunc, unHCEditorMain;

{$R *.dfm}

// �������� ������� �����������
procedure TfmNewStage.btAddPosClick(Sender: TObject);
var
  i: integer; // ��������
begin
  btDelPos.Enabled := True;
  i := Length(EditArr);
  SetLength(EditArr, Length(EditArr) + 1);
  SetLength(LabelArr, Length(LabelArr) + 1);
  SetLength(LabelSecArr, Length(LabelSecArr) + 1);
  SetLength(UDArr, Length(UDArr) + 1);
  SetLength(UDPosArr, Length(UDPosArr) + 1);
  SetLength(EditPosArr, Length(EditPosArr) + 1);
  LabelArr[i] := TLabel.Create(sbPos);
  LabelArr[i].Caption := inttostr(i + 1) + ') ��=';
  LabelArr[i].Left := 10;
  LabelArr[i].Top := 20 + 30 * i;
  LabelArr[i].Name := 'Label' + inttostr(i);
  LabelArr[i].Parent := sbPos;
  // ������� Edit ��� �������
  EditPosArr[i] := TEdit.Create(sbPos);
  EditPosArr[i].Text := '1';
  EditPosArr[i].Left := 60;
  EditPosArr[i].Top := 15 + 30 * i;
  EditPosArr[i].Width := 50;
  EditPosArr[i].ReadOnly := True;
  EditPosArr[i].Parent := sbPos;
  // ������� Edit
  EditArr[i] := TEdit.Create(sbPos);
  EditArr[i].Text := '1';
  EditArr[i].Left := 150;
  EditArr[i].Top := 15 + 30 * i;
  EditArr[i].Width := 50;
  EditArr[i].ReadOnly := True;
  EditArr[i].Parent := sbPos;
  // ������� ����� ��� '���.'
  LabelSecArr[i] := TLabel.Create(sbPos);
  LabelSecArr[i].Caption := '���.';
  LabelSecArr[i].Left := 220;
  LabelSecArr[i].Top := 20 + 30 * i;
  LabelSecArr[i].Parent := sbPos;
  // ������� ������� ��� �������
  UDPosArr[i] := TUpDown.Create(sbPos);
  UDPosArr[i].Min := 0;
  UDPosArr[i].Max := 100;
  UDPosArr[i].Position := 0;
  UDPosArr[i].Parent := sbPos;
  UDPosArr[i].OnChanging := udPosTpl.OnChanging;
  UDPosArr[i].Associate := EditPosArr[i];
  // ������� �������
  UDArr[i] := TUpDown.Create(sbPos);
  UDArr[i].Min := 1;
  UDArr[i].Max := 1000;
  UDArr[i].Position := 1;
  UDArr[i].Parent := sbPos;
  UDArr[i].OnChanging := udTpl.OnChanging;
  UDArr[i].Associate := EditArr[i];
  udSwitchCount.Position := udSwitchCount.Position + 1;
  leStageName.Text := '�� ' + inttostr(udSwitchCount.Position) + ' ������.';
  if Length(LabelArr) = 1 then
    btDelPos.Enabled := false;
  ChartReplot;
end;

// ������ � ���� ������ �����
procedure TfmNewStage.btCreateClick(Sender: TObject);
var
  i: integer;
begin
  // ��������� ���
  SwitchRW(false, [fmStageEditor.ztStage, fmStageEditor.ztSStruct]);
  if NOT IsEdit then
    fmStageEditor.ztStage.AppendRecord([NULL, leStageName.Text])
  else
  // ��������� ��� � ������� ���������
  begin
    zqUpdateName.Close;
    zqUpdateName.SQL[2] := 'sname=''' + leStageName.Text + '''';
    zqUpdateName.SQL[4] := 'sid=' + inttostr(StageID);
    zqUpdateName.ExecSQL;
    zqClearSctruct.ExecSQL;
  end;
  // ������� ���������
  for i := 0 to Length(UDArr) - 1 do
  begin
    if NOT IsEdit then
      fmStageEditor.ztSStruct.AppendRecord
        ([NULL, fmStageEditor.ztStage.FieldByName('sid').AsInteger,
        UDPosArr[i].Position, UDArr[i].Position, i])
    else
      fmStageEditor.ztSStruct.AppendRecord([NULL, StageID, UDPosArr[i].Position,
        UDArr[i].Position, i])
  end;
  SwitchRW(True, [fmStageEditor.ztStage, fmStageEditor.ztSStruct]);
  // ������� � �������� �������
  ResetDialog;
  Close;
end;

// �������� ������������ �������
procedure TfmNewStage.btDelPosClick(Sender: TObject);
var
  i: integer; // ����� ���������� ��������
begin
  btDelPos.Enabled := false;
  i := Length(EditArr) - 1; // ��������� �������
  // ���� ������������ ������ 1
  if Length(LabelArr) > 1 then
  begin
    udSwitchCount.Position := udSwitchCount.Position - 1; // ��������� �������
    // ������� �������� ���������� ������������
    UDArr[i].Free;
    EditArr[i].Free;
    LabelArr[i].Free;
    UDPosArr[i].Free;
    EditPosArr[i].Free;
    LabelSecArr[i].Free;
    // ��������� ������
    SetLength(EditArr, Length(EditArr) - 1);
    SetLength(LabelArr, Length(LabelArr) - 1);
    SetLength(LabelArr, Length(LabelSecArr) - 1);
    SetLength(UDArr, Length(UDArr) - 1);
    SetLength(EditPosArr, Length(EditPosArr) - 1);
    SetLength(UDPosArr, Length(UDPosArr) - 1);
    // �������� �������� �����
    leStageName.Text := '�� ' + inttostr(udSwitchCount.Position) + ' ������.';
    // ����������� ������
    ChartReplot;
  end;
  // ���������� �������
  if Length(LabelArr) <= 1 then
    btDelPos.Enabled := false
  else
    btDelPos.Enabled := True;
end;

// ��������� ���������� �������
procedure TfmNewStage.ResetDialog;
var
  i: integer; // �������
begin
  // �������� ������
  if Length(LabelArr) > 0 then
    for i := Length(LabelArr) - 1 downto 0 do
    begin
      UDArr[i].Free;
      EditArr[i].Free;
      LabelArr[i].Free;
      UDPosArr[i].Free;
      EditPosArr[i].Free;
      LabelSecArr[i].Free;
    end;
  SetLength(EditArr, 0);
  SetLength(LabelArr, 0);
  SetLength(LabelSecArr, 0);
  SetLength(UDArr, 0);
  SetLength(UDPosArr, 0);
  SetLength(EditPosArr, 0);
  leStageName.Text := '';
  btCreate.Enabled := false;
  btDelPos.Enabled := false;
end;

// �������� ��������� � �����������
procedure TfmNewStage.btMaxPosSetClick(Sender: TObject);
var
  i: integer; // �������
  switchcount: integer; // ���������� ������������
begin
  switchcount := udSwitchCount.Position;
  ResetDialog;
  for i := 0 to switchcount - 1 do
  begin
    btAddPosClick(Self);
  end;
  udSwitchCount.Position := switchcount;
  ChartReplot;
  leStageName.Text := '�� ' + inttostr(udSwitchCount.Position) + ' ������.';
  btCreate.Enabled := True;
end;

// ������ �������� ��� �������
procedure TfmNewStage.udPosTplChanging(Sender: TObject;
  var AllowChange: boolean);
// var
// i: integer; // �������
begin
  // ������� ��� ����������� ��������� ��������� (��������� �����)
  // for i := 1 to Length(UDPosArr) - 1 do
  // begin
  // UDPosArr[i].Max := UDPosArr[i - 1].Position + 1;
  // if UDPosArr[i - 1].Position = 0 then
  // begin
  // UDPosArr[i].Min := 0;
  // UDPosArr[i].Increment := 1;
  // end
  // else
  // begin
  // UDPosArr[i].Min := UDPosArr[i - 1].Position - 1;
  // UDPosArr[i].Increment := 2;
  // end;
  // end;
  ChartReplot;
end;


// ������������ ���������� �������
procedure TfmNewStage.udTplChanging(Sender: TObject; var AllowChange: boolean);
begin
  ChartReplot;
end;

// ���������� �������
procedure TfmNewStage.ChartReplot;
var
  i: integer;
  totaltime: integer;
begin
  Series1.Clear;
  totaltime := 0;
  Series1.AddXY(0, 0);
  for i := 0 to Length(LabelArr) - 1 do
  begin
    totaltime := totaltime + UDArr[i].Position;
    Series1.AddXY(totaltime, UDPosArr[i].Position);
  end;
end;

// �� ��������� � ����������.
procedure TfmNewStage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseDS([zqGetStruct, zqClearSctruct, zqGetSCount, zqUpdateName]);
  ResetDialog;
  IsEdit := false;
  btCreate.Caption := '�������';
end;

// ���������� ������� � �������������� �����
procedure TfmNewStage.FormShow(Sender: TObject);
var
  pcnt, i: integer; // �������
begin
  if IsEdit then
  begin
    // ������� ������
    ResetDialog;
    // �������� ��������� �����
    zqGetStruct.Close;
    zqGetStruct.SQL[1] := 'sid=' + inttostr(StageID);
    zqGetStruct.Open;
    // �������� ���������� ������������ � �����
    zqGetSCount.Close;
    // ShowMessage(zqGetSCount.SQL[1]);
    zqGetSCount.SQL[1] := 'sid=' + inttostr(StageID);
    zqGetSCount.Open;
    // ShowMessage(zqGetSCount.SQL[1]);
    pcnt := zqGetSCount.FieldByName('pcount').AsInteger;
    // ShowMessage(inttostr(zqGetSCount.FieldByName('pcount').AsInteger));
    // ������������ �������
    zqClearSctruct.Close;
    zqClearSctruct.SQL[1] := 'sid=' + inttostr(StageID);
    // ShowMessage(zqClearSctruct.SQL[0] + #10#13 + zqClearSctruct.SQL[1]);
    // �� ��������� � �� ��������� SQL
    // ������� ���� ��� ��������������
    udSwitchCount.Position := pcnt;
    btMaxPosSetClick(Self);
    // ��������� ����
    for i := 0 to udSwitchCount.Position - 1 do
    begin
      UDArr[i].Position := zqGetStruct.FieldByName('ptime').AsInteger;
      UDPosArr[i].Position := zqGetStruct.FieldByName('clevel').AsInteger;
      zqGetStruct.Next;
    end;
    // ��������� ������
    ChartReplot;
    // �������� ������
    btCreate.Caption := '��������';
  end;
end;

end.
