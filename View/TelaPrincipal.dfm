object frmTelaPrincipal: TfrmTelaPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Agenda de Contatos'
  ClientHeight = 639
  ClientWidth = 1026
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object pnlLateral: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 639
    Align = alLeft
    TabOrder = 0
    object pnlContatoBotoes: TPanel
      Left = 1
      Top = 1
      Width = 318
      Height = 45
      Align = alTop
      TabOrder = 0
      object btnAdicionar: TButton
        Left = 1
        Top = 1
        Width = 100
        Height = 43
        Align = alLeft
        Caption = 'Adicionar'
        TabOrder = 0
        OnClick = btnAdicionarClick
      end
      object btnExcluir: TButton
        Left = 217
        Top = 1
        Width = 100
        Height = 43
        Align = alRight
        Caption = 'Excluir'
        Enabled = False
        TabOrder = 1
        OnClick = btnExcluirClick
      end
      object btnEditar: TButton
        Left = 101
        Top = 1
        Width = 116
        Height = 43
        Align = alClient
        Caption = 'Editar'
        Enabled = False
        TabOrder = 2
        OnClick = btnEditarClick
      end
    end
    object pnlPesquisa: TPanel
      Left = 1
      Top = 46
      Width = 318
      Height = 60
      Align = alTop
      TabOrder = 1
      object lblPesquisa: TLabel
        Left = 10
        Top = 8
        Width = 152
        Height = 15
        Caption = 'Pesquisar contato por nome:'
      end
      object edtPesquisa: TEdit
        Left = 10
        Top = 29
        Width = 298
        Height = 23
        TabOrder = 0
        TextHint = 'Digite o nome...'
        OnChange = edtPesquisaChange
      end
    end
    object lstContatos: TListView
      Left = 1
      Top = 106
      Width = 318
      Height = 532
      Align = alClient
      Columns = <
        item
          AutoSize = True
          Caption = 'Nome'
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 2
      ViewStyle = vsReport
      OnSelectItem = lstContatosSelectItem
    end
  end
  object pnlPrincipal: TPanel
    Left = 320
    Top = 0
    Width = 706
    Height = 639
    Align = alClient
    TabOrder = 1
    object pnlContato: TPanel
      Left = 1
      Top = 1
      Width = 704
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
        Left = 160
        Top = 110
        Width = 47
        Height = 15
        Caption = 'N'#250'mero:'
      end
      object lblEstado: TLabel
        Left = 280
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
        Left = 450
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
        ReadOnly = True
        TabOrder = 0
      end
      object edtTelefone: TMaskEdit
        Left = 10
        Top = 79
        Width = 200
        Height = 23
        EditMask = '!\(99\) 99999-9999;1;_'
        MaxLength = 15
        ReadOnly = True
        TabOrder = 1
        Text = '(  )      -    '
      end
      object edtEmail: TEdit
        Left = 230
        Top = 79
        Width = 300
        Height = 23
        ReadOnly = True
        TabOrder = 2
      end
      object edtCep: TMaskEdit
        Left = 10
        Top = 129
        Width = 130
        Height = 23
        EditMask = '99999-999;1;_'
        MaxLength = 9
        ReadOnly = True
        TabOrder = 3
        Text = '     -   '
      end
      object edtNumero: TEdit
        Left = 160
        Top = 129
        Width = 100
        Height = 23
        ReadOnly = True
        TabOrder = 4
      end
      object edtEstado: TEdit
        Left = 280
        Top = 129
        Width = 60
        Height = 23
        ReadOnly = True
        TabOrder = 5
      end
      object edtLogradouro: TEdit
        Left = 10
        Top = 179
        Width = 420
        Height = 23
        ReadOnly = True
        TabOrder = 6
      end
      object edtBairro: TEdit
        Left = 450
        Top = 179
        Width = 240
        Height = 23
        ReadOnly = True
        TabOrder = 7
      end
      object edtCidade: TEdit
        Left = 10
        Top = 229
        Width = 270
        Height = 23
        ReadOnly = True
        TabOrder = 8
      end
      object edtComplemento: TEdit
        Left = 300
        Top = 229
        Width = 390
        Height = 23
        ReadOnly = True
        TabOrder = 9
      end
    end
    object pnlCompromissos: TPanel
      Left = 1
      Top = 291
      Width = 704
      Height = 347
      Align = alClient
      TabOrder = 1
      object lblCompromissos: TLabel
        Left = 1
        Top = 1
        Width = 702
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
      object grdCompromissos: TDBGrid
        Left = 1
        Top = 18
        Width = 702
        Height = 328
        Align = alClient
        DataSource = dtsCompromissos
        ReadOnly = True
        TabOrder = 0
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
  end
  object cdsCompromissos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 860
    Top = 360
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
    Left = 960
    Top = 360
  end
end
