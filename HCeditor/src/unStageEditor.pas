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
    btPosDel: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    procedure btSCreateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfmStageEditor.btSCreateClick(Sender: TObject);
begin
  fmNewStage.ShowModal;
end;

procedure TfmStageEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseDS([ztStage,ztSStruct]);
end;

procedure TfmStageEditor.FormShow(Sender: TObject);
begin
  ReopenDS([ztStage,ztSStruct]);
end;

end.
