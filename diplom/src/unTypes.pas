unit unTypes;

interface

uses
  SysUtils, Classes, Controls,
  Windows, Messages, Variants, Graphics, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls;

type
  TMainPlace = class(TPanel)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    PlID: integer;
    ListPlaces:Tlist;
    PlacesNum: integer;
    constructor Create(AOwner: TComponent); override;
    procedure CompactPlaces;
    { Public declarations }
  published
    { Published declarations }
  end;

  TPlace = class(TButton)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    PlID: integer;
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  published
    { Published declarations }
  end;


implementation

// Конструктор подставки
constructor TMainPlace.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ListPlaces:=Tlist.Create;
end;

// Убирает пустоты между местами
procedure TMainPlace.CompactPlaces;
var
i:integer;
begin
  for i:=0 to ListPlaces.Count-1 do
    Tbutton(ListPlaces[i]).Top:=(10+Tbutton(ListPlaces[i]).Height)*i+10;
end;

// Конструктор места
constructor TPlace.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

end.
