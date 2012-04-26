unit unAdvSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls, StdCtrls, ExtCtrls, IniFiles;

type
  TfmAdvSettings = class(TForm)
    gb1Sensor: TGroupBox;
    gb2Sensor: TGroupBox;
    gbTSensor: TGroupBox;
    gbFuel: TGroupBox;
    btSave: TButton;
    lePoinsCount: TLabeledEdit;
    Label1: TLabel;
    udPointsCount: TUpDown;
    btSetFuelPoints: TButton;
    sgFuel: TStringGrid;
    Label2: TLabel;
    le1Median: TLabeledEdit;
    le1Kalman: TLabeledEdit;
    le2Median: TLabeledEdit;
    le2Kalman: TLabeledEdit;
    leTMedian: TLabeledEdit;
    leTKalman: TLabeledEdit;
    Label3: TLabel;
    ud1Kalman: TUpDown;
    ud1Median: TUpDown;
    ud2Median: TUpDown;
    ud2Kalman: TUpDown;
    udTMedian: TUpDown;
    udTKalman: TUpDown;
    le1Aperture: TLabeledEdit;
    le2Aperture: TLabeledEdit;
    leTAperture: TLabeledEdit;
    UpDown3: TUpDown;
    procedure btSetFuelPointsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAdvSettings: TfmAdvSettings;
  settings: TIniFile;

implementation

{$R *.dfm}

// Сохранение настроек в ini-файл
procedure TfmAdvSettings.btSaveClick(Sender: TObject);
var
  i: integer;
begin
  try
    // ShowMessage(ExtractFilePath(Application.ExeName));
    settings := TIniFile.Create(ExtractFilePath(Application.ExeName) +
      'tarconv.ini');
    // Запись настроек фильтров
    // Кальмана
    settings.WriteInteger('Filters', 'P1Kalman', ud1Kalman.Position);
    settings.WriteInteger('Filters', 'P2Kalman', ud2Kalman.Position);
    settings.WriteInteger('Filters', 'TKalman', udTKalman.Position);
    // Медианный
    settings.WriteInteger('Filters', 'P1Median', ud1Median.Position);
    settings.WriteInteger('Filters', 'P2Median', ud2Median.Position);
    settings.WriteInteger('Filters', 'TMedian', udTMedian.Position);
    // Апертура
    settings.WriteFloat('Filters', 'P1Aperture', StrToFloat(le1Aperture.Text));
    settings.WriteFloat('Filters', 'P2Aperture', StrToFloat(le2Aperture.Text));
    settings.WriteFloat('Filters', 'TAperture', StrToFloat(leTAperture.Text));
    // Тарировка бака
    settings.WriteInteger('Fuel', 'Pointscount', sgFuel.RowCount - 1);
    for i := 1 to sgFuel.RowCount - 1 do
    begin
      settings.WriteString('Fuel', 'H' + IntToStr(i), sgFuel.Cells[1, i]);
      settings.WriteString('Fuel', 'V' + IntToStr(i), sgFuel.Cells[2, i]);
    end;
    settings.Free;
    fmAdvSettings.Close;
  except
    on E: EConvertError do
      MessageBox(Self.Handle,
        Pchar(E.Message + #10#13 + 'Проверьте введенные значения.'),
        'Ошибка сохранения!', MB_OK or MB_ICONERROR);
    on E: EIniFileException do
      MessageBox(Self.Handle, Pchar('Не удалось сохранить файл настроек.' +
        #10#13 + E.Message), 'Ошибка сохранения!', MB_OK or MB_ICONERROR);
  end;

end;

// Настройка тарировочной таблицы бака
procedure TfmAdvSettings.btSetFuelPointsClick(Sender: TObject);
var
  i: integer;
begin
  sgFuel.RowCount := udPointsCount.Position + 1;
  // Нумерация
  for i := 1 to udPointsCount.Position do
    sgFuel.Cells[0, i] := IntToStr(i);
end;

// Подготовка интерфейса
procedure TfmAdvSettings.FormShow(Sender: TObject);
var
  i: integer;
begin
  sgFuel.Cells[1, 0] := 'H, мм';
  sgFuel.Cells[2, 0] := 'V, л';
  sgFuel.ColWidths[0] := 30;
  // Загрузка настроек
  try
    if FileExists(ExtractFilePath(Application.ExeName) + 'tarconv.ini') then
    begin
      settings := TIniFile.Create(ExtractFilePath(Application.ExeName) +
        'tarconv.ini');
      // Загрузка настроек фильтров
      // Кальмана
      ud1Kalman.Position := settings.ReadInteger('Filters', 'P1Kalman', 1);
      ud2Kalman.Position := settings.ReadInteger('Filters', 'P2Kalman', 1);
      udTKalman.Position := settings.ReadInteger('Filters', 'TKalman', 1);
      // Медианный
      ud1Median.Position := settings.ReadInteger('Filters', 'P1Median', 1);
      ud2Median.Position := settings.ReadInteger('Filters', 'P2Median', 1);
      udTMedian.Position := settings.ReadInteger('Filters', 'TMedian', 1);
      // Апертура
      le1Aperture.Text := settings.ReadString('Filters', 'P1Aperture', '0');
      le2Aperture.Text := settings.ReadString('Filters', 'P2Aperture', '0');
      leTAperture.Text := settings.ReadString('Filters', 'TAperture', '0');
      // Тарировка бака
      udPointsCount.Position := settings.ReadInteger('Fuel', 'Pointscount', 2);
      btSetFuelPointsClick(Self);
      for i := 1 to sgFuel.RowCount - 1 do
      begin
        sgFuel.Cells[1, i] := settings.ReadString('Fuel',
          'H' + IntToStr(i), '1');
        sgFuel.Cells[2, i] := settings.ReadString('Fuel',
          'V' + IntToStr(i), '1');
      end;
      settings.Free;
    end
    else
    // Настроек не нашли
    begin
      MessageBox(Self.Handle, 'Файл настроек не найден.' + #10#13 +
        'Загрузка базовых настроек.', 'Предупреждение',
        MB_OK or MB_ICONEXCLAMATION);
      // настройки фильтров
      // Кальмана
      ud1Kalman.Position := 1;
      ud2Kalman.Position := 1;
      udTKalman.Position := 1;
      // Медианный
      ud1Median.Position := 1;
      ud2Median.Position := 1;
      udTMedian.Position := 1;
      // Апертура
      le1Aperture.Text := '0';
      le2Aperture.Text := '0';
      leTAperture.Text := '0';
      // Тарировка бака
      udPointsCount.Position := 2;
      btSetFuelPointsClick(Self);
    end;
  except
    on E: EConvertError do
      MessageBox(Self.Handle,
        Pchar(E.Message + #10#13 + 'Проверьте введенные значения.'),
        'Ошибка сохранения!', MB_OK or MB_ICONERROR);
    on E: EIniFileException do
      MessageBox(Self.Handle, Pchar('Не удалось сохранить файл настроек.' +
        #10#13 + E.Message), 'Ошибка сохранения!', MB_OK or MB_ICONERROR);
  end;
end;

end.
