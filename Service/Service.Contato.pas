unit Service.Contato;

interface

uses
  System.SysUtils,
  Generics.Collections,
  Model.Contato,
  Model.Compromisso,
  Repository.Contato;

type
  IContatoService = interface
    function ObterContatos: TObjectList<TContatoModel>;
    function ObterContatosPorNome(trecho: string): TObjectList<TContatoModel>;
    procedure Salvar(contato: TContatoModel);
    procedure Excluir(id: Integer);
  end;

  TContatoService = class(TInterfacedObject, IContatoService)
  private
    FRepository: IContatoRepository;
    procedure Validar(contato: TContatoModel);
    procedure ValidarCompromisso(compromisso: TCompromissoModel);
  public
    constructor Create(repository: IContatoRepository);
    function ObterContatos: TObjectList<TContatoModel>;
    function ObterContatosPorNome(trecho: string): TObjectList<TContatoModel>;
    procedure Salvar(contato: TContatoModel);
    procedure Excluir(id: Integer);
  end;

implementation

constructor TContatoService.Create(repository: IContatoRepository);
begin
  FRepository := repository;
end;

function TContatoService.ObterContatos: TObjectList<TContatoModel>;
begin
  Result := FRepository.ObterContatos;
end;

function TContatoService.ObterContatosPorNome(trecho: string): TObjectList<TContatoModel>;
begin
  Result := FRepository.ObterContatosPorNome(trecho);
end;

procedure TContatoService.Salvar(contato: TContatoModel);
begin
  Validar(contato);
  FRepository.Salvar(contato);
end;

procedure TContatoService.Validar(contato: TContatoModel);
begin
  if (contato.Nome = '') then
    raise Exception.Create('Nome não informado.');

  for var compromisso in contato.Compromissos do
    ValidarCompromisso(compromisso);
end;

procedure TContatoService.ValidarCompromisso(compromisso: TCompromissoModel);
begin
  if (compromisso.Titulo = '') then
    raise Exception.Create('Título do compromisso não informado.');
end;

procedure TContatoService.Excluir(id: Integer);
begin
  FRepository.Excluir(id);
end;

end.
