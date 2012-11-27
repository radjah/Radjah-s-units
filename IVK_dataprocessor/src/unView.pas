unit unView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB;

type
  TfmView = class(TForm)
    DBGrid1: TDBGrid;
    dsView: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmView: TfmView;

implementation

uses unMain;

{$R *.dfm}

end.
