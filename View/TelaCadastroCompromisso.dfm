object frmTelaCadastroCompromisso: TfrmTelaCadastroCompromisso
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de compromisso'
  ClientHeight = 240
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 540
    Height = 200
    Align = alClient
    TabOrder = 0
    DesignSize = (
      540
      200)
    object lblTitulo: TLabel
      Left = 10
      Top = 10
      Width = 33
      Height = 15
      Caption = 'T'#237'tulo:'
    end
    object lblDescricao: TLabel
      Left = 10
      Top = 58
      Width = 52
      Height = 15
      Caption = 'Descri'#231#227'o:'
    end
    object lblData: TLabel
      Left = 10
      Top = 106
      Width = 26
      Height = 15
      Caption = 'Data:'
    end
    object lblHorario: TLabel
      Left = 180
      Top = 106
      Width = 42
      Height = 15
      Caption = 'Hor'#225'rio:'
    end
    object lblLocal: TLabel
      Left = 10
      Top = 154
      Width = 30
      Height = 15
      Caption = 'Local:'
    end
    object edtTitulo: TEdit
      Left = 10
      Top = 29
      Width = 520
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object edtDescricao: TEdit
      Left = 10
      Top = 77
      Width = 520
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object dtpData: TDateTimePicker
      Left = 10
      Top = 125
      Width = 150
      Height = 23
      Date = 45978.000000000000000000
      Time = 0.834038310182222600
      TabOrder = 2
    end
    object dtpHorario: TDateTimePicker
      Left = 180
      Top = 125
      Width = 150
      Height = 23
      Date = 45978.000000000000000000
      Time = 0.500000000000000000
      Kind = dtkTime
      TabOrder = 3
    end
    object edtLocal: TEdit
      Left = 10
      Top = 173
      Width = 300
      Height = 23
      TabOrder = 4
    end
    object chkConcluido: TCheckBox
      Left = 330
      Top = 177
      Width = 97
      Height = 17
      Caption = 'Conclu'#237'do'
      TabOrder = 5
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 200
    Width = 540
    Height = 40
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      540
      40)
    object btnCancelar: TButton
      Left = 460
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      ModalResult = 0
      TabOrder = 0
      OnClick = btnCancelarClick
    end
    object btnOK: TButton
      Left = 379
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      TabOrder = 1
      OnClick = btnOKClick
    end
  end
end
