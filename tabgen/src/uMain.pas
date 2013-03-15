unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, ExtCtrls, ComCtrls, XPMan;

type
  TfmMain = class(TForm)
    mXcoord: TMemo;
    mYcoord: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    sdTable: TSaveDialog;
    btGen: TButton;
    Label3: TLabel;
    pGenStatus: TPanel;
    pbGenState: TProgressBar;
    XPMan: TXPManifest;
    procedure FormShow(Sender: TObject);
    procedure btGenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

// ������� �����
procedure TfmMain.FormShow(Sender: TObject);
begin
  mXcoord.Lines.Clear;
  mYcoord.Lines.Clear;
end;

// ���������
procedure TfmMain.btGenClick(Sender: TObject);
var
  xycount, i: integer;
  tabfile: TIniFile;
  minmemo: string[1];
  X, Y: real;
begin
  // ���������� �����
  try
    if sdTable.Execute then
    begin
      // ��������� ����� ���������
      btGen.Enabled := False;
      mXcoord.Enabled := False;
      mYcoord.Enabled := False;
      // ����������� ������������
      pGenStatus.Visible := True;
      Self.Repaint;
      if mXcoord.Lines.Count > mYcoord.Lines.Count then
      // ����� ���������� ����� �������� ������?
      begin
        // X, ���� X ������
        xycount := mXcoord.Lines.Count;
        minmemo := 'Y';
      end
      else
      // Y, ���� Y ������
      begin
        xycount := mYcoord.Lines.Count;
        minmemo := 'X';
      end;
      // ��������� ������������
      pbGenState.Max := xycount;
      pbGenState.Position := 0;
      pbGenState.Step := 1;

      // ���� ��� ������
      tabfile := TIniFile.Create(sdTable.FileName);
      if FileExists(sdTable.FileName) then
        // ���� ���� ��� ����, �� ������ ���, ����� �� ��������� �������
        DeleteFile(sdTable.FileName);
      // ������ ��������
      tabfile.WriteInteger('InitialData', 'RegCount', xycount + 1);
      for i := 0 to xycount - 1 do
      // ������ �����
      begin
        // �������� �� ����� �� ������� ������� ����� �������� memo
        // ������ � ������� �� ������� �� X
        if (minmemo = 'X') and (i >= mXcoord.Lines.Count) then
        // ���� �������� ������ X
        begin
          Y := StrToFloat(mYcoord.Lines[i]);
          // ����� X
          tabfile.WriteFloat('TableData', 'X' + inttostr(i + 1), 0);
          tabfile.WriteFloat('TableData', 'F' + inttostr(i + 1), Y);
          pbGenState.StepIt;
        end
        else
        // ���� �������� ������ Y
          if (minmemo = 'Y') and (i >= mYcoord.Lines.Count) then
        begin
          X := StrToFloat(mXcoord.Lines[i]);
          // ����� ��������
          tabfile.WriteFloat('TableData', 'X' + inttostr(i + 1), X);
          tabfile.WriteFloat('TableData', 'F' + inttostr(i + 1), 0);
          pbGenState.StepIt;
        end
        else
        // ���� ������� �������
        begin
          X := StrToFloat(mXcoord.Lines[i]);
          Y := StrToFloat(mYcoord.Lines[i]);
          tabfile.WriteFloat('TableData', 'X' + inttostr(i + 1), X);
          tabfile.WriteFloat('TableData', 'F' + inttostr(i + 1), Y);
          pbGenState.StepIt;
        end; // �����
      end; // for
      // �������� ����� � ��������� � ����������
      tabfile.Free;
      pGenStatus.Visible := False;
      MessageBox(Self.Handle, '���������!', '����������',
        MB_OK or MB_ICONINFORMATION);
      // ��������� ���������
      btGen.Enabled := True;
      mXcoord.Enabled := True;
      mYcoord.Enabled := True;
    end;
  except
    on E: EIniFileException do
    // �������� � �������
    begin
      tabfile.Free;
      btGen.Enabled := True;
      mXcoord.Enabled := True;
      mYcoord.Enabled := True;
      pGenStatus.Visible := False;
      MessageBox(Self.Handle, pchar('�������� ������ ��� �������� �����:' +
        #10#13 + E.Message + #00), '������!', MB_OK or MB_ICONSTOP);
    End; // EIniFileException
    on E: EConvertError do
    // �������� � �������
    begin
      tabfile.Free;
      btGen.Enabled := True;
      mXcoord.Enabled := True;
      mYcoord.Enabled := True;
      pGenStatus.Visible := False;
      MessageBox(Self.Handle, pchar('�������� ������ ��� ��������� ��������:' +
        #10#13 + E.Message), '������!', MB_OK or MB_ICONSTOP);
    End; // EConvertError
  end; // except
end;

end.
