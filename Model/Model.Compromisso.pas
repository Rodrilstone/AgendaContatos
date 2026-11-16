unit Model.Compromisso;

interface

type
  TCompromissoModel = class
  private
    FId: Integer;
    FIdContato: Integer;
    FTitulo: string;
    FDescricao: string;
    FData: TDateTime;
    FHorario: TDateTime;
    FLocal: string;
    FConcluido: Boolean;
  public
    property Id: Integer read FId write FId;
    property IdContato: Integer read FIdContato write FIdContato;
    property Titulo: string read FTitulo write FTitulo;
    property Descricao: string read FDescricao write FDescricao;
    property Data: TDateTime read FData write FData;
    property Horario: TDateTime read FHorario write FHorario;
    property Local: string read FLocal write FLocal;
    property Concluido: Boolean read FConcluido write FConcluido;
  end;

implementation

end.
