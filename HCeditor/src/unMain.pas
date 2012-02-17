unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZAbstractTable, ZDataset, ZAbstractConnection, ZConnection, StdCtrls,
  ZSqlUpdate;

type
  TfmMain = class(TForm)
    ZConnect: TZConnection;
    ztCycle: TZTable;
    dsCycle: TDataSource;
    dbgCycle: TDBGrid;
    btCreat: TButton;
    btEdit: TButton;
    btStageEditor: TButton;
    zqCommon: TZQuery;
    btDelete: TButton;
    zuCycle: TZUpdateSQL;
    procedure btStageEditorClick(Sender: TObject);
    procedure btCreatClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses unStageEditor, unCommonFunc;
{$R *.dfm}

// ���������� ���� ��������� ������
procedure TfmMain.btCreatClick(Sender: TObject);
var
  newname: string[128];
begin
  newname := InputBox('�������� ������ �����', '������� �������� �����', '');
  if Length(newname) > 0 then
    ztCycle.AppendRecord([NULL, newname]);

end;

procedure TfmMain.btDeleteClick(Sender: TObject);
var
  str: string;
begin
  str := '������� ���� "' + ztCycle.FieldByName('cname').AsWideString +
    '" � ��� ��� �����?';
  if MessageBox(self.Handle, Pchar(str), '������', MB_YESNO OR MB_ICONQUESTION)
    = IDYES then
  begin
    zqCommon.Close;
    zqCommon.SQL.Clear;
    zqCommon.SQL.Add('Delete from cycle where cid=' + ztCycle.FieldByName('cid')
      .AsString);
      zqCommon.ExecSQL;
    ReopenDS([ztCycle]);
  end;
end;
{
  procedure TfmMain.btDeleteClick(Sender: TObject);
  var
  str: String;
  begin
  str := concat('������� ���� "', ztCycle.FieldByName('cname').AsString,
  '" � ��� ��� �����?', #00);
  if MessageDlg(str, mtConfirmation, [mbYes, mbNo], 0,
  mbYes) = mrYes then
  ShowMessage('��!');
  end; }

procedure TfmMain.btStageEditorClick(Sender: TObject);
begin
  fmStageEditor.ShowModal;
end;

end.
