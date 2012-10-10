unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls,
  unDataModule, ADODB, Grids, DBGrids, OleAuto;

type
  TfmMain = class(TForm)
    btConnect: TButton;
    btOpenQ: TButton;
    qExtractor: TADOQuery;
    dsTagGroup: TDataSource;
    dbgTagGroup: TDBGrid;
    Label1: TLabel;
    btGetTags: TButton;
    dsTagList: TDataSource;
    dbgTagList: TDBGrid;
    Label2: TLabel;
    procedure btConnectClick(Sender: TObject);
    procedure btOpenQClick(Sender: TObject);
    procedure btGetTagsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

{ === Подключение и отключение === }
procedure TfmMain.btConnectClick(Sender: TObject);
begin
  try
    if IVK_DM.connIVK_DB.Connected then
    // Обработка отключения
    begin
      IVK_DM.tbTags.Close;
      IVK_DM.tbTWX_GLOBAL.Close;
      IVK_DM.connIVK_DB.Connected := false;
      btConnect.Caption := 'Соединить';
      btOpenQ.Enabled := False;
      btGetTags.Enabled:=False;
    end
    else
    // Обработка подключения
    begin
      IVK_DM.connIVK_DB.Connected := True;
      IVK_DM.tbTWX_GLOBAL.Open;
      btConnect.Caption := 'Отключить';
      btGetTags.Enabled:=True;
      btOpenQ.Enabled := True;
    end;
  except
    // Если не смогли соединиться
    on E: EOleException do
      MessageBox(Self.Handle,
        pchar('Возникла ошибка при подключении/отключении:' + #10#13 +
        E.Message), 'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
    // Если не смогли открыть что-то
    on E: EADOError do
      MessageBox(Self.Handle, pchar('Возникла ошибка при работе с базой:' +
        #10#13 + E.Message), 'Ошибка подключения/отключения',
        MB_OK or MB_ICONERROR);
  end;
end;

{ === Получить список тегов в выбранной группе === }
procedure TfmMain.btGetTagsClick(Sender: TObject);
begin
  IVK_DM.tbTags.Close;
  IVK_DM.tbTags.TableName := IVK_DM.tbTWX_GLOBAL.FieldByName
    ('Table_Tags').AsString;
  IVK_DM.tbTags.Open;
end;

{ === Открытие набора данных === }
procedure TfmMain.btOpenQClick(Sender: TObject);
begin
  if qExtractor.Active then
  begin
    qExtractor.Close;
    btOpenQ.Caption := 'Открыть'
  end
  else
  begin
    qExtractor.Open;
    btOpenQ.Caption := 'Закрыть';
  end;
end;

end.
