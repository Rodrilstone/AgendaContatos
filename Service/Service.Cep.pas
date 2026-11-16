unit Service.Cep;

interface

uses
  System.SysUtils,
  System.JSON,
  REST.Client,
  REST.Types,
  Model.Endereco;

type
  ICepService = interface
    function BuscarEndereco(cep: string): TEnderecoModel;
  end;

  TCepService = class(TInterfacedObject, ICepService)
  public
    function BuscarEndereco(cep: string): TEnderecoModel;
  end;

implementation

function TCepService.BuscarEndereco(cep: string): TEnderecoModel;
var
  RestClient: TRESTClient;
  RestRequest: TRESTRequest;
  RestResponse: TRESTResponse;
  JsonObj: TJSONObject;
  ErroVal: TJSONValue;
begin
  cep := StringReplace(cep, '-', '', [rfReplaceAll]);
  cep := StringReplace(cep, ' ', '', [rfReplaceAll]);
  cep := StringReplace(cep, '_', '', [rfReplaceAll]);

  RestClient := TRESTClient.Create('https://viacep.com.br');
  try
    RestResponse := TRESTResponse.Create(nil);
    RestRequest := TRESTRequest.Create(nil);
    try
      RestRequest.Client := RestClient;
      RestRequest.Response := RestResponse;

      RestRequest.Method := rmGET;

      RestRequest.Resource := 'ws/{cep}/json';
      RestRequest.Params.AddUrlSegment('cep', cep);

      RestRequest.Execute;

      JsonObj := TJSONObject.ParseJSONValue(RestResponse.Content) as TJSONObject;
      if JsonObj = nil then
        raise Exception.Create('Resposta inválida da API ViaCEP.');

      try
        ErroVal := JsonObj.FindValue('erro');
        if (ErroVal <> nil) and (ErroVal.Value = 'true') then
          raise Exception.Create('CEP não encontrado.');

        Result.Logradouro := JsonObj.GetValue<string>('logradouro');
        Result.Bairro := JsonObj.GetValue<string>('bairro');
        Result.Cidade := JsonObj.GetValue<string>('localidade');
        Result.Estado := JsonObj.GetValue<string>('uf');
        Result.Complemento := JsonObj.GetValue<string>('complemento');
      finally
        JsonObj.Free;
      end;
    finally
      RestRequest.Free;
      RestResponse.Free;
    end;
  finally
    RestClient.Free;
  end;
end;

end.
