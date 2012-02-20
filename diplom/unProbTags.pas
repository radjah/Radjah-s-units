unit unProbTags;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unDM, DB, Grids, DBGrids, ADODB, StdCtrls, DBCtrls, unCommonFunc, hh;

type
  TfmProbTags = class(TForm)
    tbTags: TADOTable;
    dsTags: TDataSource;
    DBGrid1: TDBGrid;
    tbTagsid: TAutoIncField;
    tbTagsProbName: TStringField;
    tbTagsProbTag: TStringField;
    tbTagsSigTypeID: TIntegerField;
    tbSigName: TADOTable;
    tbTagssigtag: TStringField;
    gbAdd: TGroupBox;
    eTag: TEdit;
    Label1: TLabel;
    eName: TEdit;
    btAdd: TButton;
    dsSigType: TDataSource;
    cbSigType: TDBLookupComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btHelp: TButton;
    procedure btAddClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProbTags: TfmProbTags;

implementation

{$R *.dfm}

procedure TfmProbTags.btAddClick(Sender: TObject);
begin
  if (eTag.Text<>'') and (eName.Text<>'') and (cbSigType.KeyValue<>NULL) then
  begin
    if ConfirmAdd(self.Handle,'тег '+eTag.Text+' с наименованием'+#10#13+
    '"'+eName.Text+'"'+#10#13+
    'и типом сигнала '+cbSigType.Text) then
      tbTags.AppendRecord([nil,eTag.Text,eName.Text,cbSigType.KeyValue]);
  end else ShowMessage('Введены не все данные!');
end;

// Вызов справки по окну
procedure TfmProbTags.btHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unProbTags.dfm.html',HH_DISPLAY_TOPIC,0);
end;

end.
