unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, DB, ADODB, unDM, Grids, DBGrids,
  unTypes, unConnector, unSys, unCompConf, unCommonFunc, unSigTypes,
  unProbTags, unMap, unMapManual, hh;

type
  TfmMain = class(TForm)
    mnMain: TMainMenu;
    mnFile: TMenuItem;
    mnEl: TMenuItem;
    mnPlace: TMenuItem;
    TplPanel: TPanel;
    mnCont: TPopupMenu;
    mnRemove: TMenuItem;
    ADOQuery: TADOQuery;
    tbPodst: TADOTable;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    mnCrPlace: TMenuItem;
    mnContPlace: TPopupMenu;
    mnPlaceDel: TMenuItem;
    TplButton: TButton;
    QPlaces: TADOQuery;
    QPlacesid: TIntegerField;
    QPlacesplacename: TStringField;
    tbPlaces: TADOTable;
    tbPlacesid: TIntegerField;
    tbPlacesid_podst: TIntegerField;
    tbPlacesplacename: TStringField;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    mnExit: TMenuItem;
    QConnector: TADOQuery;
    mnSystem: TMenuItem;
    mnCompConf: TMenuItem;
    mnUnitsConf: TMenuItem;
    N3: TMenuItem;
    mnSignal: TMenuItem;
    mnTags: TMenuItem;
    mnPodRnm: TMenuItem;
    mnPlaceRename: TMenuItem;
    mnMap: TMenuItem;
    mnMapManual: TMenuItem;
    mnConnector: TMenuItem;
    mnHelpMenu: TMenuItem;
    mnHelp: TMenuItem;
    procedure mnPlaceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnRemoveClick(Sender: TObject);
    procedure TplPanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CompactPanels;
    procedure FormShow(Sender: TObject);
    procedure TplPanelClick(Sender: TObject);
    procedure mnCrPlaceClick(Sender: TObject);
    procedure mnPlaceDelClick(Sender: TObject);
    procedure TplButtonClick(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure mnCompConfClick(Sender: TObject);
    procedure mnUnitsConfClick(Sender: TObject);
    procedure mnPodRnmClick(Sender: TObject);
    procedure mnSignalClick(Sender: TObject);
    procedure mnPlaceRenameClick(Sender: TObject);
    procedure mnTagsClick(Sender: TObject);
    procedure mnMapClick(Sender: TObject);
    procedure mnMapManualClick(Sender: TObject);
    procedure mnConnectorClick(Sender: TObject);
    procedure mnHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  ListPlace:TList;
  i:integer;
  PlaceNum:integer;
  workwith:TObject;


implementation

{$R *.dfm}
uses unName;

// �������� ����� ���������
procedure TfmMain.mnPlaceClick(Sender: TObject);
var
  NewPlace:TMainPlace;
begin
  if GetNewName('��������� '+inttostr(i)) then
  begin
  NewPlace:=TMainPlace.Create(fmMain);
  NewPlace.Width:=150;
  NewPlace.Height:=300;
  NewPlace.Caption:=ResultName;
  NewPlace.PlID:=i;
  NewPlace.OnClick:=TplPanel.OnClick;
  NewPlace.Left:=ListPlace.Count*160;
  NewPlace.Top:=10;
  NewPlace.Show;
  NewPlace.PopupMenu:=mnCont;
  NewPlace.OnMouseUp:=TplPanel.OnMouseUp;
  NewPlace.Parent:=fmMain;
  ListPlace.Add(NewPlace);
  tbPodst.AppendRecord([i,ResultName]);
  tbPodst.Close;
  tbPodst.Open;
  i:=i+1;
  end;
end;

// �������� ������
procedure TfmMain.FormCreate(Sender: TObject);
begin
  ListPlace:=TList.Create;
end;

// �������� ���������
procedure TfmMain.mnRemoveClick(Sender: TObject);
begin
if ConfirmDel(Self.Handle,'"'+TMainPlace(workwith).Caption+
  '"  � ��� �������� ��������')
then
begin
  // �������� ������� �� ����� �������� �����
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('delete from map');
  ADOQuery.SQL.Add('where contid in (select id from contact where '+
    'id_conn in (SELECT id from connector where id_place in (SELECT id '+
    'from places where id_podst='+inttostr(TMainPlace(workwith).PlID)+')))');
  ADOQuery.ExecSQL;
  // �������� ���� ���������
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('delete from contact');
  ADOQuery.SQL.Add('where id_conn in (select id from connector');
  ADOQuery.SQL.Add('where id_place in (select places.id from places where '+
    'id_podst='+inttostr(TMainPlace(workwith).PlID)+'))');
  ADOQuery.ExecSQL;
  // �������� ���� ��������
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('delete FROM connector');
  ADOQuery.SQL.Add('where id_place in (select places.id from places where '+
    'id_podst='+inttostr(TMainPlace(workwith).PlID)+')');
  ADOQuery.ExecSQL;
  // �������� ���� ����
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('delete from places where id_podst='+
    inttostr(TMainPlace(workwith).PlID));
  ADOQuery.ExecSQL;
  ReopenDatasets([tbPodst,tbPlaces]);
  // �������� ���������
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('delete from podst where ID='+
    inttostr(TMainPlace(workwith).PlID));
  ADOQuery.ExecSQL;
  ADOQuery.Close;
  // �������� �������
  workwith.Free;
  ListPlace.Delete(ListPlace.IndexOf(workwith));
  CompactPanels;
end;
end;

// ������������ ������� ��� ����������� ������ � ���
procedure TfmMain.TplPanelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  workwith:=Sender;
end;

// ������� ������ ����� ����� ��������
procedure TfmMain.CompactPanels;
var
j:integer;
begin
  ListPlace.Pack;
  for j:=0 to ListPlace.Count-1 do
    begin
      TPanel(ListPlace[j]).Left:=j*160;
    end;
end;

// �������� ������������ �� ����
procedure TfmMain.FormShow(Sender: TObject);
var
  NewPlace:TMainPlace;
  NewContPlace:TPlace;
begin
  ReopenDatasets([tbPodst,tbPlaces]);
  tbPodst.First;
  while tbPodst.Eof=false do
  begin
    // �������� � ���������� ������� �� �����
    NewPlace:=TMainPlace.Create(fmMain);
    NewPlace.Width:=150;
    NewPlace.Height:=300;
    NewPlace.OnClick:=TplPanel.OnClick;
    NewPlace.Caption:=tbPodst.FieldByName('podsname').AsString;
    NewPlace.PlID:=tbPodst.FieldByName('ID').AsInteger;
    NewPlace.Left:=ListPlace.Count*160;
    if i<NewPlace.PlID then i:=NewPlace.PlID;
    NewPlace.Top:=10;
    NewPlace.PopupMenu:=mnCont;
    NewPlace.OnMouseUp:=TplPanel.OnMouseUp;
    NewPlace.Parent:=fmMain;
    // ��������� ������ ���� ��� ���������
    QPlaces.Close;
    QPlaces.SQL.Clear;
    QPlaces.SQL.Add('Select id,placename from places where id_podst='+inttostr(tbPodst.FieldByName('ID').AsInteger));
    QPlaces.SQL.Add('order by id');
    QPlaces.Open;
    QPlaces.First;
    while QPlaces.Eof=false do
      begin
        // �������� � ���������� ������� �� �����
        NewContPlace:=TPlace.Create(self);
        NewContPlace.Caption:=QPlaces.FieldByName('placename').AsString;
        NewContPlace.Left:=10;
        NewContPlace.Height:=50;
        NewContPlace.Width:=130;
        NewContPlace.PopupMenu:=mnContPlace;
        NewContPlace.OnMouseUp:=TplPanel.OnMouseUp;
        NewContPlace.Parent:=NewPlace;
        NewContPlace.OnClick:=TplButton.OnClick;
        NewContPlace.PlID:=QPlaces.FieldByName('ID').AsInteger;
        NewContPlace.Top:=10+NewPlace.ListPlaces.Count*60;
        NewPlace.PlacesNum:=NewPlace.PlacesNum+1;
        if NewPlace.PlacesNum>4 then
          NewPlace.Height:=NewPlace.Height+60;
        if PlaceNum<QPlaces.FieldByName('ID').AsInteger then
          PlaceNum:=QPlaces.FieldByName('ID').AsInteger;
        NewPlace.ListPlaces.Add(NewContPlace);
        QPlaces.Next;
      end;
    ListPlace.Add(NewPlace);
    tbPodst.Next;
  end;
  i:=i+1;
  PlaceNum:=PlaceNum+1;
end;

// ���������� �������
procedure TfmMain.TplPanelClick(Sender: TObject);
begin
//  ShowMessage(inttostr(TMainPlace(Sender).PlID));
end;

// �������� ������ �����
procedure TfmMain.mnCrPlaceClick(Sender: TObject);
var
  ContPlace:TPlace;
begin
  if GetNewName('����� '+inttostr(TMainPlace(workwith).PlacesNum)) then
  begin
    // �������� � ���������� �������
    ContPlace:=TPlace.Create(self);
    ContPlace.Caption:=ResultName;
    ContPlace.Left:=10;
    ContPlace.Height:=50;
    ContPlace.Width:=130;
    ContPlace.PopupMenu:=mnContPlace;
    ContPlace.OnMouseUp:=TplPanel.OnMouseUp;
    ContPlace.Parent:=TWinControl(workwith);
    ContPlace.OnClick:=TplButton.OnClick;
    ContPlace.PlID:=PlaceNum;
    ContPlace.Top:=10+TMainPlace(workwith).ListPlaces.Count*60;
    TMainPlace(workwith).PlacesNum:=TMainPlace(workwith).PlacesNum+1;
    TMainPlace(workwith).ListPlaces.Add(ContPlace);
    // ���������� ������ � �������
    tbPlaces.AppendRecord([PlaceNum,TMainPlace(workwith).PlID,ContPlace.Caption]);
    PlaceNum:=PlaceNum+1;
    // ��������� ������� ������, ���� ���������� ���� ������ 4.
    if TMainPlace(workwith).PlacesNum>4 then
    TMainPlace(workwith).Height:=TMainPlace(workwith).Height+60;
  end;
end;

// �������� �����
procedure TfmMain.mnPlaceDelClick(Sender: TObject);
var
  Comp:TPlace;
  CompPar:TMainPlace;
begin
  Comp:=TPlace(workwith);
  CompPar:=TMainPlace(Comp.Parent);
  if ConfirmDel(self.Handle,'"'+Comp.Caption+'"  � ��� �������� ��������') then
  begin
    // �������� ������� �� ����� �������� �����
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('delete from map');
    ADOQuery.SQL.Add('where contid in (select id from contact where '+
      'id_conn in (SELECT id from connector where id_place='+
      inttostr(TPlace(workwith).PlID)+')');
    ADOQuery.ExecSQL;
    // �������� ���� ���������
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('delete from contact');
    ADOQuery.SQL.Add('where id_conn in (select id from connector where id_place='+
      inttostr(TPlace(workwith).PlID)+')');
    ADOQuery.ExecSQL;
    // �������� ���� ��������
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('delete from places where ID='+
      inttostr(TPlace(workwith).PlID));
    ADOQuery.ExecSQL;
    ReopenDatasets([tbPlaces]);
    // �������� �������
    Comp.Free;
    CompPar.ListPlaces.Delete(CompPar.ListPlaces.IndexOf(Comp));
    CompPar.ListPlaces.Pack;
    CompPar.CompactPlaces;
  end;
end;

// �������� ���� ������������ �����
procedure TfmMain.TplButtonClick(Sender: TObject);
begin
  fmConnector.PlaceID:=TPlace(Sender).PlID;
  fmConnector.Placename:=TPlace(Sender).Caption;
  fmConnector.ShowModal;
end;

// ����� �� ���������
procedure TfmMain.mnExitClick(Sender: TObject);
begin
  Close;
end;

// ���������� "������������ ���������"
procedure TfmMain.mnCompConfClick(Sender: TObject);
begin
  fmSys.ShowModal;
end;

// ����� ����� "������������ ������������"
procedure TfmMain.mnUnitsConfClick(Sender: TObject);
begin
  fmCompConf.ShowModal;
end;

// �������������� ���������
procedure TfmMain.mnPodRnmClick(Sender: TObject);
begin
  if GetNewName(TMainPlace(workwith).Caption) then
  begin
    TMainPlace(workwith).Caption:=ResultName;
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('UPDATE podst set podsname='''+ResultName+'''');
    ADOQuery.SQL.Add('where id='+IntToStr(TMainPlace(workwith).PlID));
    ADOQuery.ExecSQL;
    ReopenDatasets([tbPodst]);
  end;
end;

// ����� ����� "���� ��������"
procedure TfmMain.mnSignalClick(Sender: TObject);
begin
  fmSigTypes.ShowModal;
end;

// �������������� �����.
procedure TfmMain.mnPlaceRenameClick(Sender: TObject);
begin
  if GetNewName(TPlace(workwith).Caption) then
  begin
    TPlace(workwith).Caption:=ResultName;
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('UPDATE places set placename='''+ResultName+'''');
    ADOQuery.SQL.Add('where id='+IntToStr(TPlace(workwith).PlID));
    ADOQuery.ExecSQL;
    ReopenDatasets([tbPlaces]);
  end;
end;

// ����� ���� ��� �������������� ������ �����.
procedure TfmMain.mnTagsClick(Sender: TObject);
begin
  fmProbTags.ShowModal;
end;

// ����� ���� ������������������� ����������� ����� ������� �����.
procedure TfmMain.mnMapClick(Sender: TObject);
begin
  fmMap.ShowModal;
end;

// ����� ���� ������� ����������� ����� �������� �����
procedure TfmMain.mnMapManualClick(Sender: TObject);
begin
  fmMapManual.ShowModal;
end;

// �������� ���� ������������ ����� ����� ����
procedure TfmMain.mnConnectorClick(Sender: TObject);
begin
  TPlace(workwith).Click;
end;

procedure TfmMain.mnHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unMain.dfm.html',HH_DISPLAY_TOPIC,0);
end;

end.
