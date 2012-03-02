unit unUnitConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unDM, StdCtrls, ExtCtrls, DB, ADODB, Grids, DBGrids, hh,
  unCommonFunc;

type
  TfmUnitConf = class(TForm)
    dbgUnitTags: TDBGrid;
    dbgTags: TDBGrid;
    tbProbTags: TADOTable;
    qUnitConf: TADOQuery;
    dsUnitConf: TDataSource;
    dsProbTags: TDataSource;
    btAdd: TButton;
    btDel: TButton;
    gbSearch: TGroupBox;
    leByTag: TLabeledEdit;
    leByName: TLabeledEdit;
    ADOQuery: TADOQuery;
    tbProbTagsid: TAutoIncField;
    tbProbTagsProbName: TStringField;
    tbProbTagsProbTag: TStringField;
    tbProbTagsSigTypeID: TIntegerField;
    tbProbTagsSigType: TStringField;
    qUnitConfid: TAutoIncField;
    qUnitConftagname: TStringField;
    qSigQuant: TADOQuery;
    dsSigQuant: TDataSource;
    dbgSigs: TDBGrid;
    qSigQuantSigType: TStringField;
    qSigQuantsigcount: TIntegerField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btHelp: TButton;
    procedure btAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btDelClick(Sender: TObject);
    procedure leByTagChange(Sender: TObject);
    procedure leByNameChange(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    UnitID:integer;
    UnitName:String;
    { Public declarations }
  end;

var
  fmUnitConf: TfmUnitConf;

implementation

{$R *.dfm}

// Добавить тег в набор
procedure TfmUnitConf.btAddClick(Sender: TObject);
begin
  if ConfirmAdd(self.Handle,'тег '+tbProbTagsProbTag.AsString+' в список') then
  begin
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('insert into unittags (unitid,tagid)');
    ADOQuery.SQL.Add('values ('+inttostr(UnitID)+','+tbProbTagsid.AsString+')');
    ADOQuery.ExecSQL;
    ReopenDatasets([qUnitConf,qSigQuant]);
  end;
end;

// Формирование набора
procedure TfmUnitConf.FormShow(Sender: TObject);
begin
// Теги юнита
  qUnitConf.Close;
  qUnitConf.SQL.Clear;
  qUnitConf.sql.Add('SELECT unittags.id as id,probtags.ProbTag as tagname');
  qUnitConf.sql.Add('FROM unittags,probtags');
  qUnitConf.sql.Add('WHERE unittags.tagid=probtags.id and unitid='+inttostr(UnitID));
  qUnitConf.Open;
// Количество необходимых контактов
  qSigQuant.Close;
  qSigQuant.SQL.Clear;
  qSigQuant.sql.Add('SELECT probtags.SigType,COUNT(probtags.SigTypeid) as sigcount');
  qSigQuant.sql.Add('FROM probtags');
  qSigQuant.sql.Add('WHERE id in (SELECT tagid FROM unittags where unittags.unitid='+inttostr(UnitID)+')');
  qSigQuant.sql.Add('GROUP BY probtags.SigType');
  qSigQuant.Open;
  fmUnitConf.Caption:='Настройка шкафа "'+UnitName+'"';
end;

// Убрать тег из набора
procedure TfmUnitConf.btDelClick(Sender: TObject);
begin
  if ConfirmDel(self.Handle,'из сипска тег '+qUnitConftagname.AsString) then
  begin
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('delete from unittags');
    ADOQuery.SQL.Add('where id='+qUnitConfid.AsString);
    ADOQuery.ExecSQL;
    ReopenDatasets([qUnitConf,qSigQuant]);
  end;
end;

// Поиск по тегу
procedure TfmUnitConf.leByTagChange(Sender: TObject);
begin
  tbProbTags.Locate('ProbTag',leByTag.Text,[loCaseInsensitive, loPartialKey]);
end;

// Поиск по имени
procedure TfmUnitConf.leByNameChange(Sender: TObject);
begin
  tbProbTags.Locate('ProbName',leByName.Text,[loCaseInsensitive, loPartialKey]);
end;

// Вызов справки по окну
procedure TfmUnitConf.btHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unUnitConf.dfm.html',HH_DISPLAY_TOPIC,0);
end;

end.
