unit Model.Endereco;

interface

type
  TEnderecoModel = record
  private
    FLogradouro: string;
    FBairro: string;
    FCidade: string;
    FEstado: string;
    FComplemento: string;
  public
    property Logradouro: string read FLogradouro write FLogradouro;
    property Bairro: string read FBairro write FBairro;
    property Cidade: string read FCidade write FCidade;
    property Estado: string read FEstado write FEstado;
    property Complemento: string read FComplemento write FComplemento;
  end;

implementation

end.
