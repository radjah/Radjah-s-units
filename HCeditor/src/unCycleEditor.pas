unit unCycleEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TfmCycleEditor = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    CycleID:integer; // Идентификатор цикла для загрузки
  end;

var
  fmCycleEditor: TfmCycleEditor;

implementation

{$R *.dfm}

end.
