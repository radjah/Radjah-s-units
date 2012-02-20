unit unReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, ExtCtrls, DB, ADODB, QRCtrls, unDM;

type
  TfmReport = class(TForm)
    QuickRep1: TQuickRep;
    ColumnHeaderBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    qReport: TADOQuery;
    DetailBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    qReportProbName: TStringField;
    qReportProbTag: TStringField;
    qReportunname: TStringField;
    qReportplacename: TStringField;
    qReportconnname: TStringField;
    qReportsigtag: TStringField;
    qReportcontnum: TIntegerField;
    qReportconttag: TStringField;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    procedure qReportCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmReport: TfmReport;

implementation

{$R *.dfm}

procedure TfmReport.qReportCalcFields(DataSet: TDataSet);
begin
  qReportconttag.AsString:=qReportsigtag.AsString+'.'+qReportcontnum.AsString;
end;

end.
