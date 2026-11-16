unit DataModulePrincipal;

interface

uses
  System.SyncObjs,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdtmPrincipal = class(TDataModule)
    fdConnection: TFDConnection;
    fdDriverLink: TFDPhysPgDriverLink;
    fdTableContato: TFDTable;
    fdTableCompromisso: TFDTable;
    dtsContato: TDataSource;
    fdTableCompromissoid: TIntegerField;
    fdTableCompromissoidcontato: TIntegerField;
    fdTableCompromissotitulo: TWideStringField;
    fdTableCompromissodescricao: TWideStringField;
    fdTableCompromissodata: TDateField;
    fdTableCompromissohorario: TTimeField;
    fdTableCompromissolocal: TWideStringField;
    fdTableCompromissoconcluido: TBooleanField;
    fdTableContatoid: TIntegerField;
    fdTableContatonome: TWideStringField;
    fdTableContatotelefone: TWideStringField;
    fdTableContatoemail: TWideStringField;
    fdTableContatocep: TWideStringField;
    fdTableContatologradouro: TWideStringField;
    fdTableContatonumero: TWideStringField;
    fdTableContatobairro: TWideStringField;
    fdTableContatocidade: TWideStringField;
    fdTableContatoestado: TWideStringField;
    fdTableContatocomplemento: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FCriticalSection: TCriticalSection;
    { Private declarations }
  public
    property CriticalSection: TCriticalSection read FCriticalSection;
    { Public declarations }
  end;

var
  dtmPrincipal: TdtmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmPrincipal.DataModuleCreate(Sender: TObject);
begin
  FCriticalSection := TCriticalSection.Create;
end;

procedure TdtmPrincipal.DataModuleDestroy(Sender: TObject);
begin
  FCriticalSection.Free;
end;

end.
