object dtmPrincipal: TdtmPrincipal
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 351
  Width = 408
  object dtsContato: TDataSource
    DataSet = fdTableContato
    Left = 43
    Top = 187
  end
  object fdConnection: TFDConnection
    Params.Strings = (
      'Database=agendacontatos'
      'User_Name=postgres'
      'Password=senha'
      'DriverID=PG')
    Connected = True
    Left = 43
    Top = 27
  end
  object fdDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files\PostgreSQL\18\bin\libpq.dll'
    Left = 155
    Top = 27
  end
  object fdTableContato: TFDTable
    Active = True
    IndexFieldNames = 'nome'
    Connection = fdConnection
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'contato'
    Left = 43
    Top = 107
    object fdTableContatoid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object fdTableContatonome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
    object fdTableContatotelefone: TWideStringField
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 20
    end
    object fdTableContatoemail: TWideStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 100
    end
    object fdTableContatocep: TWideStringField
      FieldName = 'cep'
      Origin = 'cep'
      Size = 9
    end
    object fdTableContatologradouro: TWideStringField
      FieldName = 'logradouro'
      Origin = 'logradouro'
      Size = 200
    end
    object fdTableContatonumero: TWideStringField
      FieldName = 'numero'
      Origin = 'numero'
      Size = 20
    end
    object fdTableContatobairro: TWideStringField
      FieldName = 'bairro'
      Origin = 'bairro'
      Size = 100
    end
    object fdTableContatocidade: TWideStringField
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 100
    end
    object fdTableContatoestado: TWideStringField
      FieldName = 'estado'
      Origin = 'estado'
      Size = 2
    end
    object fdTableContatocomplemento: TWideStringField
      FieldName = 'complemento'
      Origin = 'complemento'
      Size = 100
    end
  end
  object fdTableCompromisso: TFDTable
    Active = True
    IndexFieldNames = 'idcontato'
    MasterSource = dtsContato
    MasterFields = 'id'
    Connection = fdConnection
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'compromisso'
    Left = 155
    Top = 107
    object fdTableCompromissoid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object fdTableCompromissoidcontato: TIntegerField
      FieldName = 'idcontato'
      Origin = 'idcontato'
    end
    object fdTableCompromissotitulo: TWideStringField
      FieldName = 'titulo'
      Origin = 'titulo'
      Size = 100
    end
    object fdTableCompromissodescricao: TWideStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 500
    end
    object fdTableCompromissodata: TDateField
      FieldName = 'data'
      Origin = 'data'
    end
    object fdTableCompromissohorario: TTimeField
      FieldName = 'horario'
      Origin = 'horario'
    end
    object fdTableCompromissolocal: TWideStringField
      FieldName = 'local'
      Origin = 'local'
      Size = 200
    end
    object fdTableCompromissoconcluido: TBooleanField
      FieldName = 'concluido'
      Origin = 'concluido'
    end
  end
end
