object frmTelaCadastroContato: TfrmTelaCadastroContato
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de contato'
  ClientHeight = 640
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object pnlContato: TPanel
    Left = 0
    Top = 0
    Width = 760
    Height = 290
    Align = alTop
    TabOrder = 0
    object lblNome: TLabel
      Left = 10
      Top = 10
      Width = 36
      Height = 15
      Caption = 'Nome:'
    end
    object lblTelefone: TLabel
      Left = 10
      Top = 60
      Width = 48
      Height = 15
      Caption = 'Telefone:'
    end
    object lblEmail: TLabel
      Left = 230
      Top = 60
      Width = 37
      Height = 15
      Caption = 'E-mail:'
    end
    object lblCep: TLabel
      Left = 10
      Top = 110
      Width = 24
      Height = 15
      Caption = 'CEP:'
    end
    object lblNumero: TLabel
      Left = 255
      Top = 110
      Width = 47
      Height = 15
      Caption = 'N'#250'mero:'
    end
    object lblEstado: TLabel
      Left = 365
      Top = 110
      Width = 38
      Height = 15
      Caption = 'Estado:'
    end
    object lblLogradouro: TLabel
      Left = 10
      Top = 160
      Width = 65
      Height = 15
      Caption = 'Logradouro:'
    end
    object lblBairro: TLabel
      Left = 440
      Top = 160
      Width = 34
      Height = 15
      Caption = 'Bairro:'
    end
    object lblCidade: TLabel
      Left = 10
      Top = 210
      Width = 40
      Height = 15
      Caption = 'Cidade:'
    end
    object lblComplemento: TLabel
      Left = 300
      Top = 210
      Width = 80
      Height = 15
      Caption = 'Complemento:'
    end
    object edtNome: TEdit
      Left = 10
      Top = 29
      Width = 420
      Height = 23
      TabOrder = 0
    end
    object mskTelefone: TMaskEdit
      Left = 10
      Top = 79
      Width = 200
      Height = 23
      EditMask = '!\(99\) 99999-9999;1;_'
      MaxLength = 15
      TabOrder = 1
      Text = '(  )      -    '
    end
    object edtEmail: TEdit
      Left = 230
      Top = 79
      Width = 300
      Height = 23
      TabOrder = 2
    end
    object mskCep: TMaskEdit
      Left = 10
      Top = 129
      Width = 130
      Height = 23
      EditMask = '99999-999;1;_'
      MaxLength = 9
      TabOrder = 3
      Text = '     -   '
    end
    object btnBuscarCep: TButton
      Left = 145
      Top = 127
      Width = 100
      Height = 27
      Caption = 'Buscar CEP'
      TabOrder = 4
      OnClick = btnBuscarCepClick
    end
    object edtNumero: TEdit
      Left = 255
      Top = 129
      Width = 100
      Height = 23
      TabOrder = 5
    end
    object edtEstado: TEdit
      Left = 365
      Top = 129
      Width = 60
      Height = 23
      TabOrder = 6
    end
    object edtLogradouro: TEdit
      Left = 10
      Top = 179
      Width = 420
      Height = 23
      TabOrder = 7
    end
    object edtBairro: TEdit
      Left = 440
      Top = 179
      Width = 300
      Height = 23
      TabOrder = 8
    end
    object edtCidade: TEdit
      Left = 10
      Top = 229
      Width = 270
      Height = 23
      TabOrder = 9
    end
    object edtComplemento: TEdit
      Left = 300
      Top = 229
      Width = 440
      Height = 23
      TabOrder = 10
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 595
    Width = 760
    Height = 45
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      760
      45)
    object btnCancelar: TButton
      Left = 670
      Top = 10
      Width = 80
      Height = 28
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      TabOrder = 0
      OnClick = btnCancelarClick
    end
    object btnOK: TButton
      Left = 585
      Top = 10
      Width = 80
      Height = 28
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      TabOrder = 1
      OnClick = btnOKClick
    end
  end
  object pnlCompromissos: TPanel
    Left = 0
    Top = 290
    Width = 760
    Height = 305
    Align = alClient
    TabOrder = 2
    object lblCompromissos: TLabel
      Left = 1
      Top = 1
      Width = 758
      Height = 17
      Align = alTop
      Alignment = taCenter
      Caption = 'Compromissos do contato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 156
    end
    object pnlCompromissoBotoes: TPanel
      Left = 1
      Top = 18
      Width = 758
      Height = 41
      Align = alTop
      TabOrder = 0
      object btnCompromissoAdicionar: TButton
        Left = 1
        Top = 1
        Width = 80
        Height = 39
        Align = alLeft
        Caption = 'Adicionar'
        TabOrder = 0
        OnClick = btnCompromissoAdicionarClick
      end
      object btnCompromissoEditar: TButton
        Left = 81
        Top = 1
        Width = 80
        Height = 39
        Align = alLeft
        Caption = 'Editar'
        TabOrder = 1
        OnClick = btnCompromissoEditarClick
      end
      object btnCompromissoExcluir: TButton
        Left = 161
        Top = 1
        Width = 80
        Height = 39
        Align = alLeft
        Caption = 'Excluir'
        TabOrder = 2
        OnClick = btnCompromissoExcluirClick
      end
    end
    object grdCompromissos: TDBGrid
      Left = 1
      Top = 59
      Width = 758
      Height = 245
      Align = alClient
      DataSource = dtsCompromissos
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDrawColumnCell = grdCompromissosDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'Titulo'
          Title.Caption = 'T'#237'tulo'
          Width = 180
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Descricao'
          Title.Caption = 'Descri'#231#227'o'
          Width = 220
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Data'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Horario'
          Title.Caption = 'Hor'#225'rio'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Local'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Concluido'
          Title.Caption = 'Conclu'#237'do'
          Width = 60
          Visible = True
        end>
    end
  end
  object cdsCompromissos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 660
    Top = 470
    object cdsCompromissosId: TIntegerField
      FieldName = 'Id'
    end
    object cdsCompromissosIdContato: TIntegerField
      FieldName = 'IdContato'
    end
    object cdsCompromissosTitulo: TStringField
      FieldName = 'Titulo'
      Size = 100
    end
    object cdsCompromissosDescricao: TStringField
      FieldName = 'Descricao'
      Size = 500
    end
    object cdsCompromissosData: TDateField
      FieldName = 'Data'
    end
    object cdsCompromissosHorario: TTimeField
      FieldName = 'Horario'
    end
    object cdsCompromissosLocal: TStringField
      FieldName = 'Local'
      Size = 200
    end
    object cdsCompromissosConcluido: TBooleanField
      FieldName = 'Concluido'
    end
  end
  object dtsCompromissos: TDataSource
    DataSet = cdsCompromissos
    Left = 760
    Top = 470
  end
end
