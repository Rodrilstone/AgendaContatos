unit TelaCadastroCompromisso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.WinXPickers;

type
  TfrmTelaCadastroCompromisso = class(TForm)
    pnlPrincipal: TPanel;
    pnlBotoes: TPanel;
    btnCancelar: TButton;
    btnOK: TButton;
    lblTitulo: TLabel;
    edtTitulo: TEdit;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    lblData: TLabel;
    dtpData: TDateTimePicker;
    lblHorario: TLabel;
    dtpHorario: TDateTimePicker;
    lblLocal: TLabel;
    edtLocal: TEdit;
    chkConcluido: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    procedure Validar;
  public
    { Public declarations }
  end;

var
  frmTelaCadastroCompromisso: TfrmTelaCadastroCompromisso;

implementation

{$R *.dfm}

procedure TfrmTelaCadastroCompromisso.FormCreate(Sender: TObject);
begin
  dtpData.DateTime := Date;
end;

procedure TfrmTelaCadastroCompromisso.btnOKClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja salvar o compromisso?', 'Confirmar',
    MB_YESNO + MB_ICONQUESTION) <> IDYES then
    Exit;

  Validar;
  ModalResult := mrOK;
end;

procedure TfrmTelaCadastroCompromisso.btnCancelarClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja cancelar o cadastro do compromisso? As alterações serão perdidas.',
    'Confirmar', MB_YESNO + MB_ICONQUESTION) = IDYES then
    ModalResult := mrCancel;
end;

procedure TfrmTelaCadastroCompromisso.Validar;
begin
  if (edtTitulo.Text = '') then
    raise Exception.Create('Título não informado.');
end;

end.
