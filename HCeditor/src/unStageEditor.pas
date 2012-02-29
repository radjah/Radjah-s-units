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

// Проверка наличия этапов и вкл/выкл кнопок
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

// Построить график этапа
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

// Редактирование этапа
procedure TfmStageEditor.btEditClick(Sender: TObject);
begin
  fmNewStage.IsEdit := true;
  fmNewStage.StageID := ztStage.FieldByName('sid').AsInteger;
  fmNewStage.ShowModal;
end;

// Создание нового этапа
procedure TfmStageEditor.btSCreateClick(Sender: TObject);
{ var
  stagename: string; }
begin
  fmNewStage.IsEdit := False;
  fmNewStage.ShowModal;
  { stagename:=InputBox('Запрос', 'Введите наименоване этапа:','');
    if stagename<>'' then
    ztStage.AppendRecord([NULL, stagename]); }
end;

// Удаление этапа и его структуры
procedure TfmStageEditor.btSDeleteClick(Sender: TObject);
var
  str: string;
begin
  // Запрос
  str := 'Удалить цикл "' + ztStage.FieldByName('sname').AsWideString +
    '" и все его этапы?';
  if MessageBox(Self.Handle, Pchar(str), 'Запрос', MB_YESNO OR MB_ICONQUESTION)
    = IDYES then
  begin
    // Просмотреть таблицу циклов на предмет присуствия этапа в них
    zqCommon.Close;
    zqCommon.SQL.Clear;
    zqCommon.SQL.Add('select count(sid) as sidc from cstruct');
    zqCommon.SQL.Add('where sid=' + ztStage.FieldByName('sid').AsString);
    zqCommon.Open;
    if (zqCommon.FieldByName('sidc').AsInteger) = 0 then
    begin
      // Удалить все составляющие этапа
      zqCommon.Close;
      zqCommon.SQL.Clear;
      zqCommon.SQL.Add('delete from sstruct where sid=' +
        ztStage.FieldByName('sid').AsString);
      zqCommon.ExecSQL;
      // Удалить сам этап
      zqCommon.Close;
      zqCommon.SQL.Clear;
      zqCommon.SQL.Add('delete from stages where sid=' +
        ztStage.FieldByName('sid').AsString);
      zqCommon.ExecSQL;
      // Обновить данные на форме
      ReopenDS([ztStage, ztSStruct]);
    end
    else
      MessageBox(Self.Handle, 'Такой этап участвует в созданных циклах.' +
        #10#13 + 'Удаление не возможно', 'Ошибка удалени',
        MB_OK OR MB_ICONEXCLAMATION);
  end;
end;

// Динамическое обновление графика
procedure TfmStageEditor.dbgStageCellClick(Column: TColumn);
begin
  Replot;
end;

procedure TfmStageEditor.dbgStageKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Replot;
end;

// Динамическое обновление графика
procedure TfmStageEditor.dbgStageMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  Replot;
end;

// Всё закрываем
procedure TfmStageEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseDS([ztStage, ztSStruct, zqCommon, zqCheckStages]);
end;

// Проверка при запуске
procedure TfmStageEditor.FormShow(Sender: TObject);
begin
  CheckStagesCount;
end;

end.
