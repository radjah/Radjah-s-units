unit unNewStage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, TeEngine, Series, TeeProcs, Chart, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfmNewStage = class(TForm)
    sbPos: TScrollBox;
    eMaxPos: TEdit;
    udMaxPos: TUpDown;
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
    procedure btMaxPosSetClick(Sender: TObject);
    procedure udTplChanging(Sender: TObject; var AllowChange: boolean);
    procedure ChartReplot;
    procedure btCreateClick(Sender: TObject);
    procedure ResetDialog;
    procedure btAddPosClick(Sender: TObject);
    procedure btDelPosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    EditArr: array of TEdit;
    LabelArr: array of TLabel;
    UDArr: array of TUpDown;
    IsEdit: boolean;
    StageID: integer;
  end;

var
  fmNewStage: TfmNewStage;

implementation

uses
  unStageEditor, unCommonFunc, unMain;

{$R *.dfm}

// Добавить позицию контроллера
procedure TfmNewStage.btAddPosClick(Sender: TObject);
var
  i: integer; // максимум
begin
  i := Length(EditArr);
  SetLength(EditArr, Length(EditArr) + 1);
  SetLength(LabelArr, Length(LabelArr) + 1);
  SetLength(UDArr, Length(UDArr) + 1);
  LabelArr[i] := TLabel.Create(sbPos);
  LabelArr[i].Caption := 'ПК=' + IntToStr(i);
  LabelArr[i].Left := 20;
  LabelArr[i].Top := 20 + 30 * i;
  LabelArr[i].Name := 'Label' + IntToStr(i);
  LabelArr[i].Parent := sbPos;
  // СОздаем Edit
  EditArr[i] := TEdit.Create(sbPos);
  EditArr[i].Text := '1';
  EditArr[i].Left := 60;
  EditArr[i].Top := 15 + 30 * i;
  EditArr[i].Width := 50;
  EditArr[i].ReadOnly := true;
  EditArr[i].Parent := sbPos;
  // Создаем счетчик
  UDArr[i] := TUpDown.Create(sbPos);
  UDArr[i].Min := 1;
  UDArr[i].Max := 1000;
  UDArr[i].Position := 1;
  UDArr[i].Parent := sbPos;
  UDArr[i].OnChanging := udTpl.OnChanging;
  UDArr[i].Associate := EditArr[i];
  udMaxPos.Position := udMaxPos.Position + 1;
  leStageName.Text := 'ПК 0 -> ' + IntToStr(udMaxPos.Position);
  ChartReplot;
end;

// Запись в базу нового этапа
procedure TfmNewStage.btCreateClick(Sender: TObject);
var
  i: integer;
begin
  // Заполняем имя
  SwitchRW(false, [fmStageEditor.ztStage, fmStageEditor.ztSStruct]);
  if NOT IsEdit then
    fmStageEditor.ztStage.AppendRecord([NULL, leStageName.Text])
  else
  // Обновляем имя и очищаем структуру
  begin
    zqUpdateName.Close;
    zqUpdateName.SQL[2] := 'sname=''' + leStageName.Text + '''';
    zqUpdateName.SQL[4] := 'sid=' + IntToStr(StageID);
    zqUpdateName.ExecSQL;
    zqClearSctruct.ExecSQL;
  end;
  // Заносим структуру
  for i := 0 to Length(UDArr) - 1 do
  begin
    if NOT IsEdit then
      fmStageEditor.ztSStruct.AppendRecord
        ([NULL, fmStageEditor.ztStage.FieldByName('sid').AsInteger, i,
        UDArr[i].Position])
    else
      fmStageEditor.ztSStruct.AppendRecord
        ([NULL, StageID, i, UDArr[i].Position])
  end;
  SwitchRW(true, [fmStageEditor.ztStage, fmStageEditor.ztSStruct]);
  // Очистка и закрытие диалога
  ResetDialog;
  Close;
end;

// Удаление максимальной позиции
procedure TfmNewStage.btDelPosClick(Sender: TObject);
var
  i: integer; // Номер последнего элемента
begin
  i := Length(EditArr) - 1;
  if Length(LabelArr) > 1 then
  begin
    udMaxPos.Position := udMaxPos.Position - 1;
    UDArr[i].Free;
    EditArr[i].Free;
    LabelArr[i].Free;
    SetLength(EditArr, Length(EditArr) - 1);
    SetLength(LabelArr, Length(LabelArr) - 1);
    SetLength(UDArr, Length(UDArr) - 1);
    leStageName.Text := 'ПК 0 -> ' + IntToStr(udMaxPos.Position);
    ChartReplot;
  end
  else
    MessageBox(Self.Handle, 'В этапе должна быть хотя бы одна позиция!',
      'Ошибка!', MB_OK OR MB_ICONERROR);
end;

// Обнуление параметров диалога
procedure TfmNewStage.ResetDialog;
var
  i: integer; // Счетчик
begin
  // Удаление старых
  if Length(LabelArr) > 0 then
    for i := Length(LabelArr) - 1 downto 0 do
    begin
      UDArr[i].Free;
      EditArr[i].Free;
      LabelArr[i].Free;
    end;
  SetLength(EditArr, 0);
  SetLength(LabelArr, 0);
  SetLength(UDArr, 0);
  leStageName.Text := '';
  btCreate.Enabled := false;
end;

// Создание счетчиков в скроллбоксе
procedure TfmNewStage.btMaxPosSetClick(Sender: TObject);
var
  i: integer; // Счетчик
begin
  ResetDialog;
  // Указываем длины массивов
  SetLength(EditArr, udMaxPos.Position + 1);
  ZeroMemory(EditArr, sizeof(EditArr));
  SetLength(LabelArr, udMaxPos.Position + 1);
  ZeroMemory(LabelArr, sizeof(LabelArr));
  SetLength(UDArr, udMaxPos.Position + 1);
  ZeroMemory(UDArr, sizeof(UDArr));
  // Создаем контроллы и размещаем на форме
  for i := 0 to udMaxPos.Position do
  begin
    // Создаем метку
    LabelArr[i] := TLabel.Create(sbPos);
    LabelArr[i].Caption := 'ПК=' + IntToStr(i);
    LabelArr[i].Left := 20;
    LabelArr[i].Top := 20 + 30 * i;
    LabelArr[i].Name := 'Label' + IntToStr(i);
    LabelArr[i].Parent := sbPos;
    // СОздаем Edit
    EditArr[i] := TEdit.Create(sbPos);
    EditArr[i].Text := '1';
    EditArr[i].Left := 60;
    EditArr[i].Top := 15 + 30 * i;
    EditArr[i].Width := 50;
    EditArr[i].ReadOnly := true;
    EditArr[i].Parent := sbPos;
    // Создаем счетчик
    UDArr[i] := TUpDown.Create(sbPos);
    UDArr[i].Min := 1;
    UDArr[i].Max := 1000;
    UDArr[i].Position := 1;
    UDArr[i].Parent := sbPos;
    UDArr[i].OnChanging := udTpl.OnChanging;
    UDArr[i].Associate := EditArr[i];
  end;
  ChartReplot;
  leStageName.Text := 'ПК 0 -> ' + IntToStr(udMaxPos.Position);
  btCreate.Enabled := true;
end;

// Динамическое обновление графика
procedure TfmNewStage.udTplChanging(Sender: TObject; var AllowChange: boolean);
begin
  ChartReplot;
end;

// Обновление графика
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
    Series1.AddXY(totaltime, i);
  end;
end;

// Всё закрываем и сбрасываем.
procedure TfmNewStage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseDS([zqGetStruct, zqClearSctruct, zqGetSCount, zqUpdateName]);
  ResetDialog;
  IsEdit := false;
  btCreate.Caption := 'Создать';
end;

// Подготовка диалога к редактированию цикла
procedure TfmNewStage.FormShow(Sender: TObject);
var
  pcnt, i: integer; // счетчик
begin
  if IsEdit then
  begin
    // Очищаем диалог
    ResetDialog;
    // Получаем структуру этапа
    zqGetStruct.Close;
    zqGetStruct.SQL[1] := 'sid=' + IntToStr(StageID);
    zqGetStruct.Open;
    // Получаем количество переключений в этапе
    zqGetSCount.Close;
    // ShowMessage(zqGetSCount.SQL[1]);
    zqGetSCount.SQL[1] := 'sid=' + IntToStr(StageID);
    zqGetSCount.Open;
    // ShowMessage(zqGetSCount.SQL[1]);
    pcnt := zqGetSCount.FieldByName('pcount').AsInteger;
    // ShowMessage(inttostr(zqGetSCount.FieldByName('pcount').AsInteger));
    // Подготавлием очистку
    zqClearSctruct.Close;
    zqClearSctruct.SQL[1] := 'sid=' + IntToStr(StageID);
    // ShowMessage(zqClearSctruct.SQL[0] + #10#13 + zqClearSctruct.SQL[1]);
    // Не открываем и не запускаем SQL
    // Создаем поля для редактирования
    udMaxPos.Position := pcnt - 1;
    btMaxPosSetClick(Self);
    // Заполняем поля
    for i := 0 to udMaxPos.Position do
    begin
      UDArr[i].Position := zqGetStruct.FieldByName('ptime').AsInteger;
      zqGetStruct.Next;
    end;
    // Обновляем превью
    ChartReplot;
    // Изменяем кнопку
    btCreate.Caption := 'Изменить';
  end;
end;

end.
