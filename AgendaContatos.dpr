program AgendaContatos;

uses
  Vcl.Forms,
  TelaPrincipal in 'View\TelaPrincipal.pas' {frmTelaPrincipal},
  DataModulePrincipal in 'DataModule\DataModulePrincipal.pas' {dtmPrincipal: TDataModule},
  Model.Contato in 'Model\Model.Contato.pas',
  Model.Compromisso in 'Model\Model.Compromisso.pas',
  Model.Endereco in 'Model\Model.Endereco.pas',
  Repository.Contato in 'Repository\Repository.Contato.pas',
  Service.Contato in 'Service\Service.Contato.pas',
  Service.Cep in 'Service\Service.Cep.pas',
  Controller.Contato in 'Controller\Controller.Contato.pas',
  Factory.Contato in 'Factory\Factory.Contato.pas',
  TelaCadastroCompromisso in 'View\TelaCadastroCompromisso.pas' {frmTelaCadastroCompromisso},
  TelaCadastroContato in 'View\TelaCadastroContato.pas' {frmTelaCadastroContato};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdtmPrincipal, dtmPrincipal);
  Application.CreateForm(TfrmTelaPrincipal, frmTelaPrincipal);
  Application.Run;
end.
