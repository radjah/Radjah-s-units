unit unAddSigGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unDM, DB, StdCtrls, DBCtrls, ADODB, unCommonFunc, hh;

type
  TfmAddSigGroup = class(TForm)
    qSigName: TADOQuery;
    qAdd: TADOQuery;
    dbcbSig: TDBLookupComboBox;
    Label1: TLabel;
    eQuant: TEdit;
    Label2: TLabel;
    dsSig: TDataSource;
    qSigNamesigtag: TStringField;
    qSigNamesigname: TStringField;
    qSigNamesigquant: TIntegerField;
    qSigNamesig: TStringField;
    btAdd: TButton;
    qSigNamesigid: TAutoIncField;
    btHelp: TButton;
    procedure qSigNameCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    id_conn:integer;
    connname:string;
    { Public declarations }
  end;

var
  fmAddSigGroup: TfmAddSigGroup;

implementation

{$R *.dfm}

// Значение вычисляемого поля
procedure TfmAddSigGroup.qSigNameCalcFields(DataSet: TDataSet);
begin
  qSigNamesig.AsString:='('+qSigNamesigtag.AsString+') '+qSigNamesigname.AsString;
end;

// Формирование заголовка и наборов
procedure TfmAddSigGroup.FormShow(Sender: TObject);
begin
  Caption:='Добавление клемм в разъем "'+connname+'"';
  ReopenDatasets([qSigName]);
end;

// Добавление группы контактов
procedure TfmAddSigGroup.btAddClick(Sender: TObject);
var
  maxcontnum:integer;
  maxcontnumstr:string;
begin
  try
    if (dbcbSig.KeyValue<>null) AND (eQuant.Text<>'') then
    begin
      qAdd.Close;
      qAdd.SQL.Clear;
      qAdd.SQL.Add('SELECT MAX(contnum) as max FROM contact WHERE id_sig='+qSigNamesigid.AsString);
      qAdd.Open;
      maxcontnum:=qAdd.FieldByName('max').AsInteger;
      maxcontnumstr:=inttostr(maxcontnum);
      ShowMessage(maxcontnumstr);
      qAdd.Close;
      qAdd.SQL.Clear;
      qAdd.SQL.Add('declare @i int');
      qAdd.SQL.Add('set @i = 1+'+maxcontnumstr);
      qAdd.SQL.Add('while (@i<='+inttostr(strtoint(eQuant.Text))+'+'+maxcontnumstr+')');
      qAdd.SQL.Add('begin');
      qAdd.SQL.Add('insert into contact (id_conn,id_sig,contnum)');
      qAdd.SQL.Add('values ('+inttostr(id_conn)+','+qSigNamesigid.AsString+',@i)');
      qAdd.SQL.Add('set @i = @i + 1');
      qAdd.SQL.Add('end');
      qAdd.ExecSQL;
      Close;
    end else ShowMessage('Введены не все данные!');
    except
      ShowMessage('Ошибка в веденных данных!');
    end;
end;

procedure TfmAddSigGroup.btHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unAddSigGroup.dfm.html',HH_DISPLAY_TOPIC,0);
end;

end.
