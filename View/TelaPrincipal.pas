unit TelaPrincipal;

interface

uses
  TelaCadastroContato,
  Model.Contato,
  Model.Compromisso,
  Service.Cep,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient;

type
  TfrmTelaPrincipal = class(TForm)
    pnlLateral: TPanel;
    pnlPesquisa: TPanel;
    lblPesquisa: TLabel;
    edtPesquisa: TEdit;
    pnlContatoBotoes: TPanel;
    btnAdicionar: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    lstContatos: TListView;
    pnlPrincipal: TPanel;
    pnlContato: TPanel;
    lblNome: TLabel;
    edtNome: TEdit;
    lblTelefone: TLabel;
    edtTelefone: TMaskEdit;
    lblEmail: TLabel;
    edtEmail: TEdit;
    lblCep: TLabel;
    edtCep: TMaskEdit;
    lblNumero: TLabel;
    edtNumero: TEdit;
    lblEstado: TLabel;
    edtEstado: TEdit;
    lblLogradouro: TLabel;
    edtLogradouro: TEdit;
    lblBairro: TLabel;
    edtBairro: TEdit;
    lblCidade: TLabel;
    edtCidade: TEdit;
    lblComplemento: TLabel;
    edtComplemento: TEdit;
    pnlCompromissos: TPanel;
    lblCompromissos: TLabel;
    grdCompromissos: TDBGrid;
    cdsCompromissos: TClientDataSet;
    dtsCompromissos: TDataSource;
    cdsCompromissosId: TIntegerField;
    cdsCompromissosIdContato: TIntegerField;
    cdsCompromissosTitulo: TStringField;
    cdsCompromissosDescricao: TStringField;
    cdsCompromissosData: TDateField;
    cdsCompromissosHorario: TTimeField;
    cdsCompromissosLocal: TStringField;
    cdsCompromissosConcluido: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure lstContatosSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure grdCompromissosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    FTimerPesquisa: TTimer;
    procedure HabilitarDesabilitarBotoesContato(Habilitar: Boolean);
    procedure PreencherCampos(contato: TContatoModel);
    procedure PreencherCompromissos(contato: TContatoModel);
    procedure LimparCampos;
    procedure AbrirCadastro(contato: TContatoModel);
    procedure TimerPesquisaTimer(Sender: TObject);
  public
  end;

var
  frmTelaPrincipal: TfrmTelaPrincipal;

implementation

{$R *.dfm}

uses
  Factory.Contato,
  Controller.Contato;

var
  FController: TContatoController;
  FCepService: ICepService;

procedure TfrmTelaPrincipal.FormCreate(Sender: TObject);
begin
  FController := TContatoFactory.CriarController(Self);
  FCepService := TContatoFactory.CriarCepService;
  cdsCompromissos.CreateDataSet;
  cdsCompromissos.AddIndex('idxDataDesc', 'Data', [ixDescending]);
  cdsCompromissos.IndexName := 'idxDataDesc';

  FTimerPesquisa := TTimer.Create(Self);
  FTimerPesquisa.Enabled := False;
  FTimerPesquisa.Interval := 300;
  FTimerPesquisa.OnTimer := TimerPesquisaTimer;
end;

procedure TfrmTelaPrincipal.FormDestroy(Sender: TObject);
begin
  FTimerPesquisa.Enabled := False;
  FController.Free;
  FCepService := nil;
end;

procedure TfrmTelaPrincipal.FormShow(Sender: TObject);
begin
  FController.ObterContatos;
end;

procedure TfrmTelaPrincipal.edtPesquisaChange(Sender: TObject);
begin
  FTimerPesquisa.Enabled := False;
  FTimerPesquisa.Enabled := True;
end;

procedure TfrmTelaPrincipal.TimerPesquisaTimer(Sender: TObject);
begin
  FTimerPesquisa.Enabled := False;
  FController.ObterContatosPorNome(edtPesquisa.Text);
end;

procedure TfrmTelaPrincipal.lstContatosSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if (Selected) and (Assigned(Item.Data)) then
  begin
    HabilitarDesabilitarBotoesContato(True);
    var contato := TContatoModel(Item.Data);
    PreencherCampos(contato);
    PreencherCompromissos(contato);
  end
  else
  begin
    HabilitarDesabilitarBotoesContato(False);
    LimparCampos;
    cdsCompromissos.EmptyDataSet;
  end;
end;

procedure TfrmTelaPrincipal.btnAdicionarClick(Sender: TObject);
begin
  AbrirCadastro(nil);
end;

procedure TfrmTelaPrincipal.btnEditarClick(Sender: TObject);
begin
  if (lstContatos.Selected = nil) or (not Assigned(lstContatos.Selected.Data)) then
    Exit;
  AbrirCadastro(TContatoModel(lstContatos.Selected.Data));
end;

procedure TfrmTelaPrincipal.btnExcluirClick(Sender: TObject);
begin
  if (lstContatos.Selected = nil) or (not Assigned(lstContatos.Selected.Data)) then
    Exit;

  if Application.MessageBox('Deseja excluir o contato selecionado? Os compromissos associados também serão excluídos.',
    'Confirmar exclusão', MB_YESNO + MB_ICONQUESTION) <> IDYES then
    Exit;

  FController.Excluir(TContatoModel(lstContatos.Selected.Data).Id);
  FController.ObterContatosPorNome(edtPesquisa.Text);
end;

procedure TfrmTelaPrincipal.AbrirCadastro(contato: TContatoModel);
begin
  frmTelaCadastroContato := TfrmTelaCadastroContato.Create(Self);
  try
    frmTelaCadastroContato.Carregar(contato, FCepService);
    if frmTelaCadastroContato.ShowModal = mrOk then
    begin
      try
        FController.Salvar(frmTelaCadastroContato.Contato);
        FController.ObterContatosPorNome(edtPesquisa.Text);
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
    end;
  finally
    frmTelaCadastroContato.Free;
  end;
end;

procedure TfrmTelaPrincipal.PreencherCampos(contato: TContatoModel);
begin
  edtNome.Text := contato.Nome;
  edtTelefone.Text := contato.Telefone;
  edtEmail.Text := contato.Email;
  edtCep.Text := contato.Cep;
  edtNumero.Text := contato.Numero;
  edtEstado.Text := contato.Estado;
  edtLogradouro.Text := contato.Logradouro;
  edtBairro.Text := contato.Bairro;
  edtCidade.Text := contato.Cidade;
  edtComplemento.Text := contato.Complemento;
end;

procedure TfrmTelaPrincipal.PreencherCompromissos(contato: TContatoModel);
begin
  cdsCompromissos.EmptyDataSet;

  for var compromisso in contato.Compromissos do
  begin
    cdsCompromissos.Append;
    cdsCompromissosId.AsInteger := compromisso.Id;
    cdsCompromissosIdContato.AsInteger := compromisso.IdContato;
    cdsCompromissosTitulo.AsString := compromisso.Titulo;
    cdsCompromissosDescricao.AsString := compromisso.Descricao;
    cdsCompromissosData.AsDateTime := compromisso.Data;
    cdsCompromissosHorario.AsDateTime := compromisso.Horario;
    cdsCompromissosLocal.AsString := compromisso.Local;
    cdsCompromissosConcluido.AsBoolean := compromisso.Concluido;
    cdsCompromissos.Post;
  end;
end;

procedure TfrmTelaPrincipal.LimparCampos;
begin
  edtNome.Clear;
  edtTelefone.Clear;
  edtEmail.Clear;
  edtCep.Clear;
  edtNumero.Clear;
  edtEstado.Clear;
  edtLogradouro.Clear;
  edtBairro.Clear;
  edtCidade.Clear;
  edtComplemento.Clear;
end;

procedure TfrmTelaPrincipal.HabilitarDesabilitarBotoesContato(Habilitar: Boolean);
begin
  btnEditar.Enabled := Habilitar;
  btnExcluir.Enabled := Habilitar;
end;

procedure TfrmTelaPrincipal.grdCompromissosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  R: TRect;
  Estado: UINT;
begin
  if Column.Field is TBooleanField then
  begin
    grdCompromissos.Canvas.FillRect(Rect);
    R := Rect;
    R.Left := Rect.Left + ((Rect.Right - Rect.Left) - 16) div 2;
    R.Top := Rect.Top + ((Rect.Bottom - Rect.Top) - 16) div 2;
    R.Right := R.Left + 16;
    R.Bottom := R.Top + 16;
    if TBooleanField(Column.Field).AsBoolean then
      Estado := DFCS_BUTTONCHECK or DFCS_CHECKED
    else
      Estado := DFCS_BUTTONCHECK;
    DrawFrameControl(grdCompromissos.Canvas.Handle, R, DFC_BUTTON, Estado);
  end
  else
    grdCompromissos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
