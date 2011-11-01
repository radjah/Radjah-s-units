unit uMain;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComObj, MyFunctions, IniFiles,
  ExcelAddOns, StdCtrls, ComCtrls, XPMan;

type
  TMainForm = class(TForm)
    gbSensors: TGroupBox;
    gbSummary: TGroupBox;
    Label1: TLabel;
    eTarFor: TEdit;
    Label2: TLabel;
    eTarNum: TEdit;
    udPartNum: TUpDown;
    Label3: TLabel;
    eComp1: TEdit;
    udComp1: TUpDown;
    eComp2: TEdit;
    Label4: TLabel;
    lPres1: TLabel;
    lPres2: TLabel;
    lPres3: TLabel;
    lPres4: TLabel;
    ePres1: TEdit;
    ePres2: TEdit;
    ePres3: TEdit;
    ePres4: TEdit;
    bTempFil: TButton;
    Label5: TLabel;
    lTemp2: TLabel;
    eTemp2: TEdit;
    bPrFil: TButton;
    eTemp1: TEdit;
    lTemp1: TLabel;
    bMakeTable: TBitBtn;
    sdTar: TSaveDialog;
    cbRO: TCheckBox;
    bNew: TBitBtn;
    XPManifest1: TXPManifest;
    procedure eComp1Change(Sender: TObject);
    procedure udComp1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure bPresFilClick(Sender: TObject);
    procedure bTempFilClick(Sender: TObject);
    procedure bMakeTableClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbROClick(Sender: TObject);
    procedure eComp2Change(Sender: TObject);
    procedure bNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
                     
{$R *.dfm}

procedure TMainForm.eComp1Change(Sender: TObject);
begin
  try
    eComp2.Text:=IntToStr(Strtoint(eComp1.Text)+1);
    lPres1.Caption:=eComp1.Text+'-1';
    lPres2.Caption:=eComp1.Text+'-2';
    lPres3.Caption:=eComp2.Text+'-1';
    lPres4.Caption:=eComp2.Text+'-2';
    lTemp1.Caption:=eComp1.Text+'-3';
    lTemp2.Caption:=eComp2.Text+'-3';
  except
  end;
end;

procedure TMainForm.udComp1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  // Автоизменение номера
  eComp2.Text:=IntToStr(udComp1.Position+1);
  // Автоизмененеие номеров датчиков
  lPres1.Caption:=eComp1.Text+'-1';
  lPres2.Caption:=eComp1.Text+'-2';
  lPres3.Caption:=eComp2.Text+'-1';
  lPres4.Caption:=eComp2.Text+'-2';
  lTemp1.Caption:=eComp1.Text+'-3';
  lTemp2.Caption:=eComp2.Text+'-3';
end;

procedure TMainForm.bPresFilClick(Sender: TObject);
begin
  try
    ePres2.Text:=inttostr(StrToInt64(ePres1.Text)+1);
    ePres3.Text:=inttostr(StrToInt64(ePres1.Text)+2);
    ePres4.Text:=inttostr(StrToInt64(ePres1.Text)+3);
  except
    on E:EConvertError do MessageBox(Self.Handle,
                                     pchar('Фигня введена!'+#10#13
                                     +'Ошибка: '+E.Message),
                                     'Ошибка!',
                                     MB_OK+MB_ICONSTOP);
  end;
end;

procedure TMainForm.bNewClick(Sender: TObject);
begin
  try
    // 4 новых датчика уровня
    ePres1.Text:=IntToStr(StrToInt64(ePres1.Text)+4);
    bPresFilClick(Self);
    // 2 новых датчика температуры
    eTemp1.Text:=IntToStr(StrToInt64(eTemp1.Text)+2);
    bTempFilClick(Self);
    // Один новый тепловоз
    udPartNum.Position:=udPartNum.Position+1;
    // Два новых блока
    udComp1.Position:=udComp1.Position+2;
  except
    on E:EConvertError do
      begin
        ShowMessage('Возникла ошибка:'+#10#13+E.Message+#10#13+#10#13+
        'Проверьте номера датчиков.');
      end;
  end;
end;

procedure TMainForm.bTempFilClick(Sender: TObject);
begin
  try
    eTemp2.Text:=inttostr(StrToInt64(eTemp1.Text)+1);
  except
    on E:EConvertError do MessageBox(Self.Handle,
                                     pchar('Фигня введена!'+#10#13
                                     +'Ошибка: '+E.Message),
                                     'Ошибка!',
                                     MB_OK+MB_ICONSTOP);
  end;
end;

procedure TMainForm.bMakeTableClick(Sender: TObject);
var
  Excel,Book,Sheet:variant;
begin
  try
    // Создаем новую таблицу
    Excel:=CreateOleObject('Excel.Application');
    // Молчать в тряпочку
    Excel.DisplayAlerts:=False;
    // Создаем книгупо шаблону
    Excel.WorkBooks.Add(GetPath(Application.ExeName)+'tpl.xls');
    Book:=Excel.WorkBooks.Item[1];
    Sheet:=Excel.WorkBooks.Item[1].Worksheets.Item[1];
    {=== Заполнение ===}
    // Название
    Sheet.Cells[1,1].FormulaR1C1:=
    'Тарировка для '+eTarFor.Text+' №'+Format('%4.4d',[udPartNum.Position])
    +' ('+eComp1.Text+', '+eComp2.Text+' комплект)';
    // Датчики в таблицах
    Sheet.Cells[3,1].FormulaR1C1:=lPres1.Caption;
    Sheet.Cells[3,3].FormulaR1C1:=lPres2.Caption;
    Sheet.Cells[3,5].FormulaR1C1:=lPres3.Caption;
    Sheet.Cells[3,7].FormulaR1C1:=lPres4.Caption;
    Sheet.Cells[20,1].FormulaR1C1:=lTemp1.Caption;
    Sheet.Cells[20,3].FormulaR1C1:=lTemp2.Caption;
    // Серийный номер
    Sheet.Cells[3,2].FormulaR1C1:='LMK_351 №'+ePres1.Text;
    Sheet.Cells[3,4].FormulaR1C1:='LMK_351 №'+ePres2.Text;
    Sheet.Cells[3,6].FormulaR1C1:='LMK_351 №'+ePres3.Text;
    Sheet.Cells[3,8].FormulaR1C1:='LMK_351 №'+ePres4.Text;
    Sheet.Cells[19,1].FormulaR1C1:='ДТС РТ100 № '+eTemp1.Text;
    Sheet.Cells[19,3].FormulaR1C1:='ДТС РТ100 № '+eTemp2.Text;
    // Графики
    //ShowMessage(Sheet.ChartObjects.count);
    Sheet.ChartObjects.Item(1).Activate;
    Book.ActiveChart.ChartTitle.Text:='Датчик '+lPres1.Caption;
    Sheet.ChartObjects.Item(2).Activate;
    Book.ActiveChart.ChartTitle.Text:='Датчик '+lPres2.Caption;
    Sheet.ChartObjects.Item(3).Activate;
    Book.ActiveChart.ChartTitle.Text:='Датчик '+lPres3.Caption;
    Sheet.ChartObjects.Item(4).Activate;
    Book.ActiveChart.ChartTitle.Text:='Датчик '+lPres4.Caption;
    Sheet.Cells[11,1].Select;
    sdTar.FileName:='Тарировка для '+eTarFor.Text+' №'+Format('%4.4d',[udPartNum.Position])
    +' ('+eComp1.Text+', '+eComp2.Text+' комплект).xls';
    if sdTar.Execute then
    begin
      Book.SaveAs(sdTar.FileName,xlWorkbookNormal);
      Excel.Quit;
    end else Excel.Quit;
  except
    Excel.Quit;
  end;
end;

{=== Чтение настроек ===}
procedure TMainForm.FormShow(Sender: TObject);
var
  inifile:TIniFile;
begin
  inifile:=TIniFile.Create(GetPath(Application.ExeName)+'tarprog.ini');
  eTarFor.Text:=inifile.ReadString('Settings','steamtrain','');
  udPartNum.Position:=inifile.ReadInteger('Settings','stnum',1);
  eComp1.Text:=inifile.ReadString('Settings','comp1','1');
  eComp2.Text:=inifile.ReadString('Settings','comp2','2');
  ePres1.Text:=inifile.ReadString('Settings','pr11','1');
  ePres2.Text:=inifile.ReadString('Settings','pr12','1');
  ePres3.Text:=inifile.ReadString('Settings','pr21','1');
  ePres4.Text:=inifile.ReadString('Settings','pr22','1');
  eTemp1.Text:=inifile.ReadString('Settings','temp1','1');
  eTemp2.Text:=inifile.ReadString('Settings','temp2','1');
  inifile.Free;
end;

{=== Запись настроек ===}
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  inifile:TIniFile;
begin
  inifile:=TIniFile.Create(GetPath(Application.ExeName)+'tarprog.ini');
  inifile.WriteString('Settings','steamtrain',eTarFor.Text);
  inifile.WriteInteger('Settings','stnum',udPartNum.Position);
  inifile.WriteString('Settings','comp1',eComp1.Text);
  inifile.WriteString('Settings','comp2',eComp2.Text);
  inifile.WriteString('Settings','pr11',ePres1.Text);
  inifile.WriteString('Settings','pr12',ePres2.Text);
  inifile.WriteString('Settings','pr21',ePres3.Text);
  inifile.WriteString('Settings','pr22',ePres4.Text);
  inifile.WriteString('Settings','temp1',eTemp1.Text);
  inifile.WriteString('Settings','temp2',eTemp2.Text);
  inifile.Free;
end;

procedure TMainForm.cbROClick(Sender: TObject);
begin
  eComp2.ReadOnly:=cbRO.Checked;
end;

procedure TMainForm.eComp2Change(Sender: TObject);
begin
  try
    lPres3.Caption:=eComp2.Text+'-1';
    lPres4.Caption:=eComp2.Text+'-2';
    lTemp2.Caption:=eComp2.Text+'-3';
  except
  end;
end;

end.
