unit unCompConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, unDM, Grids, DBGrids, DB, ADODB, unCommonFunc, StdCtrls, hh;

type
  TfmCompConf = class(TForm)
    mnMain: TMainMenu;
    tbUnit: TADOTable;
    dsUnits: TDataSource;
    dbgUnits: TDBGrid;
    mnUnits: TMenuItem;
    mnAdd: TMenuItem;
    mnAddTags: TMenuItem;
    N1: TMenuItem;
    mnClose: TMenuItem;
    tbUnitunid: TAutoIncField;
    tbUnitunname: TStringField;
    btAdd: TButton;
    btDel: TButton;
    btTags: TButton;
    mnRemove: TMenuItem;
    ADOQuery: TADOQuery;
    mnHelpMenu: TMenuItem;
    mnHelp: TMenuItem;
    procedure mnCloseClick(Sender: TObject);
    procedure mnAddClick(Sender: TObject);
    procedure mnAddTagsClick(Sender: TObject);
    procedure mnRemoveClick(Sender: TObject);
    procedure mnHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCompConf: TfmCompConf;

implementation

uses unUnitConf;

{$R *.dfm}

procedure TfmCompConf.mnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmCompConf.mnAddClick(Sender: TObject);
begin
  if GetNewName('Шкаф') then
  begin
    tbUnit.AppendRecord([nil,ResultName]);
  end;
end;

procedure TfmCompConf.mnAddTagsClick(Sender: TObject);
begin
  fmUnitConf.UnitID:=tbUnitunid.AsInteger;
  fmUnitConf.UnitName:=tbUnitunname.AsString;
  fmUnitConf.ShowModal;
end;

procedure TfmCompConf.mnRemoveClick(Sender: TObject);
begin
//  ShowMessage(tbUnitunid.AsString);
  if tbUnitunid.AsString<>'' then
  begin
    if ConfirmDel(Self.Handle,'"'+tbUnitunname.AsString+'"') then
    begin
      // Удаление записей из карты клеммных полей
      ADOQuery.Close;
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('delete from map where unittag in (select id from '+
      'unittags where unitid='+tbUnitunid.AsString+')');
      ADOQuery.ExecSQL;
      // Удаление тегов воздействий
      ADOQuery.Close;
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('delete from unittags where unitid='+tbUnitunid.AsString);
      ADOQuery.ExecSQL;
      // Удаление шкафа оборудования
      ADOQuery.Close;
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('delete from testunits where unid='+tbUnitunid.AsString);
      ADOQuery.ExecSQL;
      ReopenDatasets([tbUnit]);
    end;
  end else ShowMessage('Нечего удалять.');
end;

procedure TfmCompConf.mnHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unCompConf.dfm.html',HH_DISPLAY_TOPIC,0);
end;

end.
