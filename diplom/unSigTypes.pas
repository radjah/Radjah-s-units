unit unSigTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unDM, unCommonFunc, StdCtrls, ExtCtrls, DB, ADODB, Grids,
  DBGrids, hh;

type
  TfmSigTypes = class(TForm)
    DBGrid1: TDBGrid;
    dsSig: TDataSource;
    qSig: TADOQuery;
    qSigAdd: TADOQuery;
    gbNew: TGroupBox;
    leTag: TLabeledEdit;
    leName: TLabeledEdit;
    btAdd: TButton;
    btHelp: TButton;
    procedure btAddClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSigTypes: TfmSigTypes;

implementation

{$R *.dfm}

procedure TfmSigTypes.btAddClick(Sender: TObject);
begin
  if (leTag.Text<>'') and (leName.Text<>'') then
  begin
    qSigAdd.Close;
    qSigAdd.SQL.Clear;
    qSigAdd.SQL.Add('insert into signame (sigtag,signame)');
    qSigAdd.SQL.Add('VALUES ('''+leTag.Text+''','''+leName.Text+''')');
    qSigAdd.ExecSQL;
    ReopenDatasets([qSig]);
  end else ShowMessage('Какое-то из полей не заполнено.');
end;

procedure TfmSigTypes.btHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unSigTypes.dfm.html',HH_DISPLAY_TOPIC,0);
end;

end.
