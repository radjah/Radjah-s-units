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
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CycleID: integer; // Идентификатор цикла для загрузки
  end;

var
  fmCycleEditor: TfmCycleEditor;

implementation

uses
  unMain, unCommonFunc;

{$R *.dfm}

// Добавление этапа в конец цикла
// TODO: сделать что-нибудь с порядком
procedure TfmCycleEditor.Button1Click(Sender: TObject);
begin
  SwitchRW(false, [ztCStruct]);
  ztCStruct.AppendRecord([NULL, fmMain.ztCycle.FieldByName('cid').AsInteger, 10,
    ztStages.FieldByName('sid').AsInteger]);
  SwitchRW(true, [ztCStruct]);
end;

end.
