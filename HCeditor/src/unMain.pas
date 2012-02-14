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
    zuCycle: TZUpdateSQL;
    zqAddCycle: TZQuery;
    procedure btStageEditorClick(Sender: TObject);
    procedure btCreatClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses unStageEditor;
{$R *.dfm}

// Отобразить окно редактора циклов
procedure TfmMain.btCreatClick(Sender: TObject);
var
  newname: string[128];
begin
  newname:=InputBox('Создание нового цикла','Введите название цикла','');
  if Length(newname)>0 then ;

end;

procedure TfmMain.btStageEditorClick(Sender: TObject);
begin
  fmStageEditor.ShowModal;
end;

end.
