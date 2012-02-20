unit unConnector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Grids, DBGrids, DB, ADODB, hh,
  unDM, unCommonFunc, unAddSigGroup;

type
  TfmConnector = class(TForm)
    MainMenu1: TMainMenu;
    mnConn: TMenuItem;
    mnConnCr: TMenuItem;
    N1: TMenuItem;
    mnClose: TMenuItem;
    QConnector: TADOQuery;
    QContacts: TADOQuery;
    dbgConnector: TDBGrid;
    dbgContact: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    mnCrGroup: TMenuItem;
    DSConnect: TDataSource;
    DSContact: TDataSource;
    tbPlace: TADOTable;
    QConnectorid: TIntegerField;
    QConnectorconnname: TStringField;
    QConnectorplname: TStringField;
    adodsContacts: TADODataSet;
    ADOQuery: TADOQuery;
    adodsContactsid_conn: TIntegerField;
    adodsContactsid_sig: TIntegerField;
    adodsContactscontnum: TIntegerField;
    adodsContactsid: TAutoIncField;
    tbSigName: TADOTable;
    adodsContactssigtag: TStringField;
    adodsContactsconttag: TStringField;
    Label3: TLabel;
    qSigByTpe: TADOQuery;
    dsSigByType: TDataSource;
    DBGrid1: TDBGrid;
    qSigByTpeid_sig: TIntegerField;
    qSigByTpesigcount: TIntegerField;
    qSigByTpesigtag: TStringField;
    mnHelpMenu: TMenuItem;
    mnHelp: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure mnConnCrClick(Sender: TObject);
    procedure mnCrGroupClick(Sender: TObject);
    procedure adodsContactsCalcFields(DataSet: TDataSet);
    procedure mnHelpClick(Sender: TObject);
  private
    ConnID:integer;
    { Private declarations }
  public
    PlaceID:integer;
    Placename:string;
    { Public declarations }
  end;

var
  fmConnector: TfmConnector;

implementation

{$R *.dfm}
uses
unName, unMain;

// зугрузка конфигурации места
procedure TfmConnector.FormShow(Sender: TObject);
begin
//  ShowMessage(inttostr(PlaceID));
  QConnector.Close;
  QConnector.SQL.Clear;
  QConnector.SQL.Add('SELECT connector.id as id,connname,places.placename as plname');
  QConnector.SQL.Add('FROM connector,places');
  QConnector.SQL.Add('where connector.id_place=places.id and connector.id_place='+inttostr(PlaceID));
  QConnector.Open;
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('select MAX(ID) as id from connector');
  ADOQuery.Open;
  ConnID:=ADOQuery.FieldByName('ID').AsInteger;
//  showmessage(inttostr(ConnID));
  ConnID:=ConnID+1;
  qSigByTpe.SQL[4]:='WHERE     (places.id = '+inttostr(PlaceID)+')';
  qSigByTpe.Open;
  fmConnector.Caption:='Настройка разъёмов места "'+Placename+'"';
end;

// создание разъёма
procedure TfmConnector.mnConnCrClick(Sender: TObject);
begin
  if GetNewName('Разъём') then
  begin
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('insert into connector (id, id_place, connname)');
    ADOQuery.SQL.Add('VALUES ('+inttostr(ConnID)+','+inttostr(PlaceID)+','''+ResultName+''')');
    ADOQuery.ExecSQL;
    ReopenDatasets([QConnector,qSigByTpe]);
    ConnID:=ConnID+1;
  end;
end;

// Открытие диалога создание группы контактов
procedure TfmConnector.mnCrGroupClick(Sender: TObject);
begin
  if QConnectorid.AsString<>'' then
  begin
  fmAddSigGroup.id_conn:=QConnectorid.AsInteger;
  fmAddSigGroup.connname:=QConnectorconnname.AsString;
  fmAddSigGroup.ShowModal;
  ReopenDatasets([QConnector,adodsContacts,qSigByTpe]);
  end else showmessage('Обнаружена попытка добавить группу к несуществующему разъёму!');
end;

// Значение вычисляемого поля
procedure TfmConnector.adodsContactsCalcFields(DataSet: TDataSet);
begin
  adodsContactsconttag.Value:=adodsContactssigtag.AsString+'.'+adodsContactscontnum.AsString;
end;

procedure TfmConnector.mnHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unConnector.dfm.html',HH_DISPLAY_TOPIC,0);
end;

end.
