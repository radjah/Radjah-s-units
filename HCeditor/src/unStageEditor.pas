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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmStageEditor: TfmStageEditor;

implementation

uses
  unMain, unNewStage;

{$R *.dfm}

procedure TfmStageEditor.btSCreateClick(Sender: TObject);
begin
  fmNewStage.ShowModal;
end;

end.
