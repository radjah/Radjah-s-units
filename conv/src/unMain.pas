unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, StrUtils, IniFiles,
  ComObj, ComCtrls, ExcelAddOns, XPMan, sMemo, acProgressBar, sButton,
  sDialogs, sSkinManager, sLabel, sEdit, Buttons, sBitBtn, uSettings,
  sGauge, MyFunctions, uAbout;

type
  TMainForm = class(TForm)
    odSrc: TsOpenDialog;
    btOpenSrc: TsButton;
    mLog: TsMemo;
    sLabel1: TsLabel;
    sSkinManager1: TsSkinManager;
    leSrc: TsEdit;
    sLabel2: TsLabel;
    btSettings: TsBitBtn;
    pbDateConv: TsGauge;
    btAbout: TsBitBtn;
    btConvert: TsBitBtn;
    ConvTimer: TTimer;
    procedure btOpenSrcClick(Sender: TObject);
    procedure btConvertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btSettingsClick(Sender: TObject);
    procedure ReadSettings;
    procedure btAboutClick(Sender: TObject);
    procedure ConvTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    defpath:string;
    defpr:string;
    { Public declarations }
  end;
  TConvThread = class(TThread)
    procedure Execute; override;
  end;

procedure AddLog(str:string);
function FormatDate(date:string):string;

var
  MainForm: TMainForm;
  ConvThread:TConvThread;
  Seconds:integer;
//  DateArr1,DateArr2,DateArr3:Array of string;

implementation

{$R *.dfm}

{=== ������ �������� ===}
procedure TMainForm.ReadSettings;
var
  ini:TIniFile;
begin
  AddLog('������ ��������...');
  ini:=TIniFile.Create(GetPath(Application.ExeName)+'convset.ini');
  // ���� ��� ����������
  defpath:=ini.ReadString('settings','defpath','');
  if defpath='' then
    AddLog('���� ��� ����������: �� �����')
  else
    AddLog('���� ��� ����������: '+defpath);
  // ������
  defpr:=ini.ReadString('settings','defpr','');
  if defpr='' then
    AddLog('������: �� �����')
  else
    AddLog('������: '+defpr);
  ini.Free;
end;

procedure TConvThread.Execute;
var
  period,data,time,str:string;
  dt:TDateTime;
  Excel:variant;
  numrows,i:integer;
  Mess:ANSIString;
begin
  Seconds:=0;
  MainForm.ConvTimer.Enabled:=True;
  try
  if MainForm.defpath='' then
  // ��������� ����� �� ������� ���� � �����
  str:=GetPath(MainForm.leSrc.Text)
  else str:=MainForm.defpath+'\';
  //��������� Excel � ��������� ����
  Excel:=CreateOleObject('Excel.Application');
  Excel.Visible:=False;
  Excel.Application.DisplayAlerts:=False;
  AddLog('Excel �������.');
  Excel.Workbooks.Open(MainForm.odSrc.FileName);
  AddLog('������ ���� �������');
  {=== �������� �������� �������������� ===}
  Excel.Worksheets[1].Rows[1].Select;
  // Excel.Visible:=True;
  Excel.Selection.Delete(Shift:=xlUp);
  AddLog('������ ��� ������');
  //���������� ����� � �������
  Excel.WorkSheets[1].UsedRange.Select;
  numrows:=Excel.Selection.Rows.Count;
  Addlog('����� � ����: '+inttostr(numrows));
  // ������� BO
  Excel.Worksheets[1].Columns[67].Select;
  Excel.Selection.ClearContents;
  AddLog('������� BO ������');
  // ��������� �������� � ������� ������� � FALSE
  AddLog('��������� �������� BW, BX, BY, BZ, CD...');
  Excel.Worksheets[1].Range['BW1:BW'+inttostr(numrows)].Select;
  Excel.Selection.FormulaR1C1:=false;
  Excel.Worksheets[1].Range['BX1:BX'+inttostr(numrows)].Select;
  Excel.Selection.FormulaR1C1:=false;
  Excel.Worksheets[1].Range['BY1:BY'+inttostr(numrows)].Select;
  Excel.Selection.FormulaR1C1:=false;
  Excel.Worksheets[1].Range['BZ1:BZ'+inttostr(numrows)].Select;
  Excel.Selection.FormulaR1C1:=false;
  Excel.Worksheets[1].Range['CD1:CD'+inttostr(numrows)].Select;
  Excel.Selection.FormulaR1C1:=false;
  // ��������� ������ ��������
  AddLog('��������� ������ �������� E, M, N...');
  Excel.Worksheets[1].Columns[5].select;
  Excel.Selection.ColumnWidth:=30;
  Excel.Worksheets[1].Columns[13].select;
  Excel.Selection.ColumnWidth:=30;
  Excel.Worksheets[1].Columns[14].select;
  Excel.Selection.ColumnWidth:=30;
  // ��������� ����� � ������.
  AddLog('�������������� ����� � ������...');
  Excel.Worksheets[1].Range['A1'].Select;
  MainForm.pbDateConv.MinValue:=0;
  MainForm.pbDateConv.MaxValue:=numrows;
{  // ������
  Setlength(DateArr1,numrows);
  Setlength(DateArr2,numrows);
  Setlength(DateArr3,numrows);
  // ������
  AddLog('������ ��������...');
  for i:=0 to numrows-1 do
  begin
    DateArr1[i]:=Excel.Worksheets[1].Cells[i+1,5].Text;
    DateArr2[i]:=Excel.Worksheets[1].Cells[i+1,13].Text;
    DateArr3[i]:=Excel.Worksheets[1].Cells[i+1,14].Text;
    MainForm.pbDateConv.Progress:=i+1;
  end;
  // ��������������
  AddLog('�������������� ��������...');
  MainForm.pbDateConv.Progress:=0;
  for i:=0 to numrows-1 do
  begin
    DateArr1[i]:=FormatDate(DateArr1[i]);
    DateArr2[i]:=FormatDate(DateArr2[i]);
    DateArr3[i]:=FormatDate(DateArr3[i]);
    MainForm.pbDateConv.Progress:=i+1;
  end;
  // ������
  AddLog('������ ��������...');
  MainForm.pbDateConv.Progress:=0;
  for i:=0 to numrows-1 do
  begin
    Excel.Worksheets[1].Cells[i+1,5].FormulaR1C1:=DateArr1[i];
    Excel.Worksheets[1].Cells[i+1,13].FormulaR1C1:=DateArr2[i];
    Excel.Worksheets[1].Cells[i+1,14].FormulaR1C1:=DateArr3[i];
    MainForm.pbDateConv.Progress:=i+1;
  end;}
  for i:=1 to numrows do
    begin
      Excel.Worksheets[1].Cells[i,5].FormulaR1C1:=FormatDate(Excel.Worksheets[1].Cells[i,5].Text);
      Excel.Worksheets[1].Cells[i,13].FormulaR1C1:=FormatDate(Excel.Worksheets[1].Cells[i,13].Text);
      Excel.Worksheets[1].Cells[i,14].FormulaR1C1:=FormatDate(Excel.Worksheets[1].Cells[i,14].Text);
      MainForm.pbDateConv.Progress:=i;
    end;
  // ��������� �������� �����
  // NumberFormat:='0'
  AddLog('��������� �������� �����...');
  Excel.Worksheets[1].Range['A:A'].Select;
  Excel.Selection.NumberFormat:='0';
  Excel.Worksheets[1].Range['J:L'].Select;
  Excel.Selection.NumberFormat:='0';
  Excel.Worksheets[1].Range['T:AF'].Select;
  Excel.Selection.NumberFormat:='0';
  Excel.Worksheets[1].Range['AJ:AS'].Select;
  Excel.Selection.NumberFormat:='0';
  Excel.Worksheets[1].Range['AV:BN'].Select;
  Excel.Selection.NumberFormat:='0';
  Excel.Worksheets[1].Range['BS:BS'].Select;
  Excel.Selection.NumberFormat:='0';
  Excel.Worksheets[1].Range['BW:BZ'].Select;
  Excel.Selection.NumberFormat:='0';
  Excel.Worksheets[1].Range['CD:CD'].Select;
  Excel.Selection.NumberFormat:='0';
  // NumberFormat:='@';
  Excel.Worksheets[1].Range['B:I'].Select;
  Excel.Selection.NumberFormat:='@';
  Excel.Worksheets[1].Range['M:S'].Select;
  Excel.Selection.NumberFormat:='@';
  Excel.Worksheets[1].Range['AG:AI'].Select;
  Excel.Selection.NumberFormat:='@';
  Excel.Worksheets[1].Range['AT:AU'].Select;
  Excel.Selection.NumberFormat:='@';
  Excel.Worksheets[1].Range['BO:BR'].Select;
  Excel.Selection.NumberFormat:='@';
  Excel.Worksheets[1].Range['BT:BW'].Select;
  Excel.Selection.NumberFormat:='@';
  Excel.Worksheets[1].Range['CA:CC'].Select;
  Excel.Selection.NumberFormat:='@';
  Excel.Worksheets[1].Range['A1'].Select;
  Excel.Worksheets[1].Name:='kur2005';
  {=== ���������� ===}
  //���������� ���� � ������������ ����� �����
  dt:=Now;
  data:=DateToStr(dt);
  data:=MidStr(data,1,2)+MidStr(data,4,2)+MidStr(data,9,4);
  time:=TimeToStr(dt);
  if (Pos(':',time)=2) then
  data:=data+'0'+Midstr(time,1,1)+Midstr(time,3,2)
  else data:=data+Midstr(time,1,2)+Midstr(time,4,2);
  if MainForm.defpr='' then
  period:=InputBox('������','������� ����� ������� (210 ��� 2-10):','111')
  else period:=MainForm.defpr;
  data:='467_k2010_'+period+'_'+data;
  AddLog('��������� ���� '+data+'.xls');
  data:=str+data;
//  Excel.Worksheets[1].Range[M:M].Select;
  Excel.Workbooks[1].SaveAs(data,xlWorkbookNormal);
  Excel.Quit;
  AddLog('Excel ������');
  MainForm.ConvTimer.Enabled:=False;
  Mess:='�������������� ��������� �������.'+#10#13+
  '�������������� ������ '+ inttostr(Seconds)+' ���.';
  MessageBox(MainForm.Handle,pchar(Mess),
  '�������������� ���������',MB_OK+MB_ICONINFORMATION);
  except
    on E: Exception do
      begin
        AddLog('������: '+E.Message);
        Excel.Quit;
        AddLog('Excel ������');
        MainForm.ConvTimer.Enabled:=False;
      end;
  end;
end;


{=== ���� ������ ���� ������ ===}
procedure TMainForm.btOpenSrcClick(Sender: TObject);
begin
  if odSrc.Execute then
  begin
    leSrc.Text:=odSrc.FileName;
    btConvert.Enabled:=True;
  end;
end;

{=== ���������� ������ � �������� ===}
procedure AddLog(str:string);
begin
  MainForm.mLog.Lines.Add(TimeToStr(Now)+' '+str);
end;

{=== �������������� ���� ===}
function FormatDate(date:string):string;
var
  outdate:string;
begin
  if date='' then
  outdate:='' else
  If (Pos('.',date)=0) then
    begin
      //���
      outdate:=MidStr(date,1,4);
      //�����
      outdate:=MidStr(date,5,2)+'.'+outdate;
      //����
      outdate:=MidStr(date,7,2)+'.'+outdate;
    end
    else
    begin
      //���
      outdate:=MidStr(date,7,4);
      //�����
      outdate:=MidStr(date,1,2)+'.'+outdate;
      //����
      outdate:=MidStr(date,4,2)+'.'+outdate;
    end;
  Result:=outdate;
end;

{=== ����������� ===}
procedure TMainForm.btConvertClick(Sender: TObject);
begin
  ConvThread.Priority:=tpLower;
  ConvThread.Execute;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ConvThread:=TConvThread.Create(True);
  AddLog('��������� ��������');
  ReadSettings;
end;

procedure TMainForm.btSettingsClick(Sender: TObject);
begin
  fmSettings.ShowModal;
  ReadSettings;
end;

procedure TMainForm.btAboutClick(Sender: TObject);
begin
  fmAbout.ShowModal;
end;

procedure TMainForm.ConvTimerTimer(Sender: TObject);
begin
  Seconds:=Seconds+1;
end;

end.
