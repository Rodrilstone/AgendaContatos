unit TelaCadastroContato;

interface

uses
  TelaCadastroCompromisso,
  Model.Contato,
  Model.Compromisso,
  Model.Endereco,
  Service.Cep,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, System.Threading;

type
  TfrmTelaCadastroContato = class(TForm)
    pnlContato: TPanel;
    lblNome: TLabel;
    edtNome: TEdit;
    lblTelefone: TLabel;
    mskTelefone: TMaskEdit;
    lblEmail: TLabel;
    edtEmail: TEdit;
    lblCep: TLabel;
    mskCep: TMaskEdit;
    btnBuscarCep: TButton;
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
    pnlCompromissoBotoes: TPanel;
    btnCompromissoAdicionar: TButton;
    btnCompromissoEditar: TButton;
    btnCompromissoExcluir: TButton;
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
    pnlBotoes: TPanel;
    btnCancelar: TButton;
    btnOK: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnBuscarCepClick(Sender: TObject);
    procedure btnCompromissoAdicionarClick(Sender: TObject);
    procedure btnCompromissoEditarClick(Sender: TObject);
    procedure btnCompromissoExcluirClick(Sender: TObject);
    procedure grdCompromissosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    FCepService: ICepService;
    FContatoId: Integer;
    FContato: TContatoModel;
    procedure PreencherCampos(contato: TContatoModel);
    procedure PreencherCompromissos(contato: TContatoModel);
    procedure SalvarCompromissosNoModelo;
    procedure Validar;
    procedure AdicionarCompromisso(Titulo, Descricao, Local: string; Data, Horario: TDateTime; Concluido: Boolean);
    procedure EditarCompromisso(Titulo, Descricao, Local: string; Data, Horario: TDateTime; Concluido: Boolean);
    procedure ExcluirCompromisso;
  public
    procedure Carregar(contato: TContatoModel; cepService: ICepService);
    property Contato: TContatoModel read FContato;
  end;

var
  frmTelaCadastroContato: TfrmTelaCadastroContato;

implementation

{$R *.dfm}

procedure TfrmTelaCadastroContato.FormCreate(Sender: TObject);
begin
  cdsCompromissos.CreateDataSet;
  cdsCompromissos.AddIndex('idxDataDesc', 'Data', [ixDescending]);
  cdsCompromissos.IndexName := 'idxDataDesc';
end;

procedure TfrmTelaCadastroContato.FormDestroy(Sender: TObject);
begin
  if Assigned(FContato) then
    FContato.Free;
end;

procedure TfrmTelaCadastroContato.Carregar(contato: TContatoModel; cepService: ICepService);
begin
  FCepService := cepService;
  FContatoId := 0;

  if Assigned(contato) then
  begin
    FContatoId := contato.Id;
    PreencherCampos(contato);
    PreencherCompromissos(contato);
  end
  else
  begin
    cdsCompromissos.EmptyDataSet;
  end;
end;

procedure TfrmTelaCadastroContato.PreencherCampos(contato: TContatoModel);
begin
  edtNome.Text := contato.Nome;
  mskTelefone.Text := contato.Telefone;
  edtEmail.Text := contato.Email;
  mskCep.Text := contato.Cep;
  edtNumero.Text := contato.Numero;
  edtEstado.Text := contato.Estado;
  edtLogradouro.Text := contato.Logradouro;
  edtBairro.Text := contato.Bairro;
  edtCidade.Text := contato.Cidade;
  edtComplemento.Text := contato.Complemento;
end;

procedure TfrmTelaCadastroContato.PreencherCompromissos(contato: TContatoModel);
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

procedure TfrmTelaCadastroContato.btnOKClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja salvar o contato?', 'Confirmar',
    MB_YESNO + MB_ICONQUESTION) <> IDYES then
    Exit;

  Validar;

  FContato := TContatoModel.Create;
  FContato.Id := FContatoId;
  FContato.Nome := edtNome.Text;
  FContato.Telefone := mskTelefone.Text;
  FContato.Email := edtEmail.Text;
  FContato.Cep := mskCep.Text;
  FContato.Logradouro := edtLogradouro.Text;
  FContato.Numero := edtNumero.Text;
  FContato.Bairro := edtBairro.Text;
  FContato.Cidade := edtCidade.Text;
  FContato.Estado := edtEstado.Text;
  FContato.Complemento := edtComplemento.Text;

  SalvarCompromissosNoModelo;

  ModalResult := mrOK;
end;

procedure TfrmTelaCadastroContato.btnCancelarClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja cancelar o cadastro do contato? As alterações serão perdidas.',
    'Confirmar', MB_YESNO + MB_ICONQUESTION) = IDYES then
    ModalResult := mrCancel;
end;

procedure TfrmTelaCadastroContato.btnBuscarCepClick(Sender: TObject);
var
  cep: string;
  service: ICepService;
begin
  cep := Trim(mskCep.Text);

  if cep = '' then
  begin
    Application.MessageBox('Informe o CEP para buscar o endereço.', 'Atenção',
      MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  btnBuscarCep.Enabled := False;
  service := FCepService;

  TTask.Run(
    procedure
    begin
      try
        var endereco := service.BuscarEndereco(cep);
        TThread.Synchronize(nil,
          procedure
          begin
            edtLogradouro.Text := endereco.Logradouro;
            edtBairro.Text := endereco.Bairro;
            edtCidade.Text := endereco.Cidade;
            edtEstado.Text := endereco.Estado;
            edtComplemento.Text := endereco.Complemento;
            btnBuscarCep.Enabled := True;
          end);
      except
        on E: Exception do
          TThread.Synchronize(nil,
            procedure
            begin
              Application.MessageBox(PChar('Erro ao buscar CEP: ' + E.Message),
                'Erro', MB_OK + MB_ICONERROR);
              btnBuscarCep.Enabled := True;
            end);
      end;
    end);
end;

procedure TfrmTelaCadastroContato.btnCompromissoAdicionarClick(Sender: TObject);
begin
  frmTelaCadastroCompromisso := TfrmTelaCadastroCompromisso.Create(Self);
  try
    if frmTelaCadastroCompromisso.ShowModal = mrOk then
      AdicionarCompromisso(
        frmTelaCadastroCompromisso.edtTitulo.Text,
        frmTelaCadastroCompromisso.edtDescricao.Text,
        frmTelaCadastroCompromisso.edtLocal.Text,
        frmTelaCadastroCompromisso.dtpData.DateTime,
        frmTelaCadastroCompromisso.dtpHorario.DateTime,
        frmTelaCadastroCompromisso.chkConcluido.Checked);
  finally
    frmTelaCadastroCompromisso.Free;
  end;
end;

procedure TfrmTelaCadastroContato.btnCompromissoEditarClick(Sender: TObject);
begin
  if cdsCompromissos.IsEmpty then
    Exit;

  frmTelaCadastroCompromisso := TfrmTelaCadastroCompromisso.Create(Self);
  try
    frmTelaCadastroCompromisso.edtTitulo.Text := cdsCompromissosTitulo.AsString;
    frmTelaCadastroCompromisso.edtDescricao.Text := cdsCompromissosDescricao.AsString;
    frmTelaCadastroCompromisso.dtpData.DateTime := cdsCompromissosData.AsDateTime;
    frmTelaCadastroCompromisso.dtpHorario.DateTime := cdsCompromissosHorario.AsDateTime;
    frmTelaCadastroCompromisso.edtLocal.Text := cdsCompromissosLocal.AsString;
    frmTelaCadastroCompromisso.chkConcluido.Checked := cdsCompromissosConcluido.AsBoolean;

    if frmTelaCadastroCompromisso.ShowModal = mrOk then
      EditarCompromisso(
        frmTelaCadastroCompromisso.edtTitulo.Text,
        frmTelaCadastroCompromisso.edtDescricao.Text,
        frmTelaCadastroCompromisso.edtLocal.Text,
        frmTelaCadastroCompromisso.dtpData.DateTime,
        frmTelaCadastroCompromisso.dtpHorario.DateTime,
        frmTelaCadastroCompromisso.chkConcluido.Checked);
  finally
    frmTelaCadastroCompromisso.Free;
  end;
end;

procedure TfrmTelaCadastroContato.btnCompromissoExcluirClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja excluir o compromisso selecionado?',
    'Confirmar exclusão', MB_YESNO + MB_ICONQUESTION) <> IDYES then
    Exit;
  ExcluirCompromisso;
end;

procedure TfrmTelaCadastroContato.AdicionarCompromisso(Titulo, Descricao, Local: string; Data, Horario: TDateTime; Concluido: Boolean);
begin
  cdsCompromissos.Append;
  cdsCompromissosTitulo.AsString := Titulo;
  cdsCompromissosDescricao.AsString := Descricao;
  cdsCompromissosData.AsDateTime := Data;
  cdsCompromissosHorario.AsDateTime := Horario;
  cdsCompromissosLocal.AsString := Local;
  cdsCompromissosConcluido.AsBoolean := Concluido;
  cdsCompromissos.Post;
end;

procedure TfrmTelaCadastroContato.EditarCompromisso(Titulo, Descricao, Local: string; Data, Horario: TDateTime; Concluido: Boolean);
begin
  if not cdsCompromissos.IsEmpty then
  begin
    cdsCompromissos.Edit;
    cdsCompromissosTitulo.AsString := Titulo;
    cdsCompromissosDescricao.AsString := Descricao;
    cdsCompromissosData.AsDateTime := Data;
    cdsCompromissosHorario.AsDateTime := Horario;
    cdsCompromissosLocal.AsString := Local;
    cdsCompromissosConcluido.AsBoolean := Concluido;
    cdsCompromissos.Post;
  end;
end;

procedure TfrmTelaCadastroContato.ExcluirCompromisso;
begin
  if not cdsCompromissos.IsEmpty then
    cdsCompromissos.Delete;
end;

procedure TfrmTelaCadastroContato.SalvarCompromissosNoModelo;
begin
  cdsCompromissos.First;
  while not cdsCompromissos.Eof do
  begin
    var compromisso := TCompromissoModel.Create;
    compromisso.Id := cdsCompromissosId.AsInteger;
    compromisso.IdContato := cdsCompromissosIdContato.AsInteger;
    compromisso.Titulo := cdsCompromissosTitulo.AsString;
    compromisso.Descricao := cdsCompromissosDescricao.AsString;
    compromisso.Data := cdsCompromissosData.AsDateTime;
    compromisso.Horario := cdsCompromissosHorario.AsDateTime;
    compromisso.Local := cdsCompromissosLocal.AsString;
    compromisso.Concluido := cdsCompromissosConcluido.AsBoolean;
    FContato.Compromissos.Add(compromisso);
    cdsCompromissos.Next;
  end;
end;

procedure TfrmTelaCadastroContato.Validar;
begin
  if Trim(edtNome.Text) = '' then
    raise Exception.Create('Nome não informado.');
end;

procedure TfrmTelaCadastroContato.grdCompromissosDrawColumnCell(Sender: TObject;
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
