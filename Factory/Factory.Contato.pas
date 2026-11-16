unit Factory.Contato;

interface

uses
  Controller.Contato,
  Service.Contato,
  Service.Cep,
  Repository.Contato,
  TelaPrincipal;

type
  TContatoFactory = class
  public
    class function CriarController(owner: TfrmTelaPrincipal): TContatoController;
    class function CriarService: IContatoService;
    class function CriarRepository: IContatoRepository;
    class function CriarCepService: ICepService;
  end;

implementation

class function TContatoFactory.CriarController(owner: TfrmTelaPrincipal): TContatoController;
begin
  var service := CriarService;
  Result := TContatoController.Create(owner, service);
end;

class function TContatoFactory.CriarService: IContatoService;
begin
  var repository := CriarRepository;
  Result := TContatoService.Create(repository);
end;

class function TContatoFactory.CriarRepository: IContatoRepository;
begin
  Result := TContatoRepository.Create;
end;

class function TContatoFactory.CriarCepService: ICepService;
begin
  Result := TCepService.Create;
end;

end.
