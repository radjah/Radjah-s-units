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
    CycleID:integer; // ������������� ����� ��� ��������
  end;

var
  fmCycleEditor: TfmCycleEditor;

implementation

{$R *.dfm}

end.
