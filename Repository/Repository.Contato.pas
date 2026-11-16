unit Repository.Contato;

interface

uses
  System.SysUtils,
  System.SyncObjs,
  Data.Db,
  DataModulePrincipal,
  Generics.Collections,
  Model.Compromisso,
  Model.Contato;

type
  IContatoRepository = interface
    function ObterContatos: TObjectList<TContatoModel>;
    function ObterContatosPorNome(trecho: string): TObjectList<TContatoModel>;
    procedure Salvar(contato: TContatoModel);
    procedure Excluir(id: Integer);
  end;

  TContatoRepository = class(TInterfacedObject, IContatoRepository)
  private
    procedure SalvarCompromissos(IdContato: Integer; compromissos: TObjectList<TCompromissoModel>);
    procedure SalvarCompromisso(IdContato: Integer; compromisso: TCompromissoModel);
    function ObterCompromissos: TObjectList<TCompromissoModel>;
    function ObterContatosInternal: TObjectList<TContatoModel>;
  public
    function ObterContatos: TObjectList<TContatoModel>;
    function ObterContatosPorNome(trecho: string): TObjectList<TContatoModel>;
    procedure Salvar(contato: TContatoModel);
    procedure Excluir(id: Integer);
  end;

implementation

function TContatoRepository.ObterContatos: TObjectList<TContatoModel>;
begin
  dtmPrincipal.CriticalSection.Enter;
  try
    dtmPrincipal.fdTableContato.Filtered := False;
    Result := ObterContatosInternal;
  finally
    dtmPrincipal.CriticalSection.Leave;
  end;
end;

function SemAcentos(const s: string): string;
const
  Acentos = 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ';
  Base   = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUCC';
var
  i, j: Integer;
  c: Char;
begin
  Result := s;
  for i := 1 to Length(Result) do
  begin
    c := Result[i];
    for j := 1 to Length(Acentos) do
      if Acentos[j] = c then
      begin
        Result[i] := Base[j];
        Break;
      end;
  end;
end;

function TContatoRepository.ObterContatosPorNome(trecho: string): TObjectList<TContatoModel>;
var
  todos: TObjectList<TContatoModel>;
  filtro: string;
  i: Integer;
begin
  filtro := SemAcentos(Trim(trecho)).ToLower;
  todos := ObterContatos;
  try
    Result := TObjectList<TContatoModel>.Create;
    for i := todos.Count - 1 downto 0 do
    begin
      if (filtro = '') or SemAcentos(todos[i].Nome).ToLower.Contains(filtro) then
        Result.Add(todos.Extract(todos[i]));
    end;

    Result.Reverse;
  finally
    todos.Free;
  end;
end;

function TContatoRepository.ObterContatosInternal: TObjectList<TContatoModel>;
begin
  Result := TObjectList<TContatoModel>.Create;

  dtmPrincipal.fdTableContato.First;

  while not dtmPrincipal.fdTableContato.Eof do
  begin
    var contato := TContatoModel.Create;
    contato.Id := dtmPrincipal.fdTableContatoid.AsInteger;
    contato.Nome := dtmPrincipal.fdTableContatonome.AsString;
    contato.Telefone := dtmPrincipal.fdTableContatotelefone.AsString;
    contato.Email := dtmPrincipal.fdTableContatoemail.AsString;
    contato.Cep := dtmPrincipal.fdTableContatocep.AsString;
    contato.Logradouro := dtmPrincipal.fdTableContatologradouro.AsString;
    contato.Numero := dtmPrincipal.fdTableContatonumero.AsString;
    contato.Bairro := dtmPrincipal.fdTableContatobairro.AsString;
    contato.Cidade := dtmPrincipal.fdTableContatocidade.AsString;
    contato.Estado := dtmPrincipal.fdTableContatoestado.AsString;
    contato.Complemento := dtmPrincipal.fdTableContatocomplemento.AsString;

    contato.Compromissos := ObterCompromissos;

    Result.Add(contato);

    dtmPrincipal.fdTableContato.Next;
  end;
end;

function TContatoRepository.ObterCompromissos: TObjectList<TCompromissoModel>;
begin
  Result := TObjectList<TCompromissoModel>.Create;

  dtmPrincipal.fdTableCompromisso.First;

  while not dtmPrincipal.fdTableCompromisso.Eof do
  begin
    var compromisso := TCompromissoModel.Create;
    compromisso.Id := dtmPrincipal.fdTableCompromissoid.AsInteger;
    compromisso.IdContato := dtmPrincipal.fdTableCompromissoidcontato.AsInteger;
    compromisso.Titulo := dtmPrincipal.fdTableCompromissotitulo.AsString;
    compromisso.Descricao := dtmPrincipal.fdTableCompromissodescricao.AsString;
    compromisso.Data := dtmPrincipal.fdTableCompromissodata.AsDateTime;
    compromisso.Horario := dtmPrincipal.fdTableCompromissohorario.AsDateTime;
    compromisso.Local := dtmPrincipal.fdTableCompromissolocal.AsString;
    compromisso.Concluido := dtmPrincipal.fdTableCompromissoconcluido.AsBoolean;

    Result.Add(compromisso);

    dtmPrincipal.fdTableCompromisso.Next;
  end;
end;

procedure TContatoRepository.Salvar(contato: TContatoModel);
begin
  dtmPrincipal.CriticalSection.Enter;
  try
    dtmPrincipal.fdTableContato.Filtered := False;

    if dtmPrincipal.fdTableContato.Locate('id', contato.Id, []) then
      dtmPrincipal.fdTableContato.Edit
    else
      dtmPrincipal.fdTableContato.Append;

    dtmPrincipal.fdTableContatonome.AsString := contato.Nome;
    dtmPrincipal.fdTableContatotelefone.AsString := contato.Telefone;
    dtmPrincipal.fdTableContatoemail.AsString := contato.Email;
    dtmPrincipal.fdTableContatocep.AsString := contato.Cep;
    dtmPrincipal.fdTableContatologradouro.AsString := contato.Logradouro;
    dtmPrincipal.fdTableContatonumero.AsString := contato.Numero;
    dtmPrincipal.fdTableContatobairro.AsString := contato.Bairro;
    dtmPrincipal.fdTableContatocidade.AsString := contato.Cidade;
    dtmPrincipal.fdTableContatoestado.AsString := contato.Estado;
    dtmPrincipal.fdTableContatocomplemento.AsString := contato.Complemento;
    dtmPrincipal.fdTableContato.Post;

    contato.Id := dtmPrincipal.fdTableContatoid.AsInteger;

    SalvarCompromissos(contato.Id, contato.Compromissos);
  finally
    dtmPrincipal.CriticalSection.Leave;
  end;
end;

procedure TContatoRepository.SalvarCompromissos(IdContato: Integer; compromissos: TObjectList<TCompromissoModel>);
begin
  while (not dtmPrincipal.fdTableCompromisso.IsEmpty) do
    dtmPrincipal.fdTableCompromisso.Delete;

  for var compromisso in compromissos do
    SalvarCompromisso(IdContato, compromisso);
end;

procedure TContatoRepository.SalvarCompromisso(IdContato: Integer; compromisso: TCompromissoModel);
begin
  dtmPrincipal.fdTableCompromisso.Append;
  dtmPrincipal.fdTableCompromissoidcontato.AsInteger := IdContato;
  dtmPrincipal.fdTableCompromissotitulo.AsString := compromisso.Titulo;
  dtmPrincipal.fdTableCompromissodescricao.AsString := compromisso.Descricao;
  dtmPrincipal.fdTableCompromissodata.AsDateTime := compromisso.Data;
  dtmPrincipal.fdTableCompromissohorario.AsDateTime := compromisso.Horario;
  dtmPrincipal.fdTableCompromissolocal.AsString := compromisso.Local;
  dtmPrincipal.fdTableCompromissoconcluido.AsBoolean := compromisso.Concluido;
  dtmPrincipal.fdTableCompromisso.Post;

  compromisso.Id := dtmPrincipal.fdTableCompromissoid.AsInteger;
end;

procedure TContatoRepository.Excluir(id: Integer);
begin
  dtmPrincipal.CriticalSection.Enter;
  try
    dtmPrincipal.fdTableContato.Filtered := False;
    if dtmPrincipal.fdTableContato.Locate('id', id, []) then
      dtmPrincipal.fdTableContato.Delete;
  finally
    dtmPrincipal.CriticalSection.Leave;
  end;
end;

end.
