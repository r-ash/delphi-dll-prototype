unit TextEditorUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox,
  FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Menus, System.Actions,
  FMX.ActnList, CppRun, Projection;

type
  TTextEditorForm = class(TForm)
    ActionList: TActionList;
    MainMenu: TMainMenu;
    StatusBar: TStatusBar;
    Editor: TMemo;
    OpenFileDialog: TOpenDialog;
    SaveFileDialog: TSaveDialog;
    NewAction: TAction;
    OpenAction: TAction;
    SaveAction: TAction;
    SaveAsAction: TAction;
    ExitAction: TAction;
    CutAction: TAction;
    CopyAction: TAction;
    PasteAction: TAction;
    SelectAllAction: TAction;
    UndoAction: TAction;
    DeleteAction: TAction;
    WordWrapAction: TAction;
    FileMenu: TMenuItem;
    EditMenu: TMenuItem;
    FormatMenu: TMenuItem;
    NewMenu: TMenuItem;
    OpenMenu: TMenuItem;
    SaveMenu: TMenuItem;
    SaveAsMenu: TMenuItem;
    ExitMenu: TMenuItem;
    DeleteMenu: TMenuItem;
    CutMenu: TMenuItem;
    CopyMenu: TMenuItem;
    PasteMenu: TMenuItem;
    SelectAllMenu: TMenuItem;
    UndoMenu: TMenuItem;
    WordWrapMenu: TMenuItem;
    LineNumber: TLabel;
    ColumnNumber: TLabel;
    LineCount: TLabel;
    CppButton: TButton;
    CppArrayButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure EditorKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EditorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure NewActionExecute(Sender: TObject);
    procedure OpenActionExecute(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
    procedure SaveAsActionExecute(Sender: TObject);
    procedure ExitActionExecute(Sender: TObject);
    procedure CutActionExecute(Sender: TObject);
    procedure CopyActionExecute(Sender: TObject);
    procedure PasteActionExecute(Sender: TObject);
    procedure SelectAllActionExecute(Sender: TObject);
    procedure UndoActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    procedure WordWrapActionExecute(Sender: TObject);
    procedure ClickCppButton(Sender: TObject);
    procedure CppArrayButtonClick(Sender: TObject);
  private
    { Private declarations }
    CurrentFile: String;

    procedure UpdateStatusBar;
  public
    { Public declarations }
  end;

var
  TextEditorForm: TTextEditorForm;

implementation

{$R *.fmx}

uses
 FMX.DialogService.Sync, FMX.Memo.Types;

{ TTextEditorForm }

procedure TTextEditorForm.ClickCppButton(Sender: TObject);
  var InfoMessage: string; res: Integer;
begin
  res := AddNumbers(2, 3);
  InfoMessage := Format('Addition result is %d', [res]);
  ShowMessage(InfoMessage);
end;

procedure TTextEditorForm.CopyActionExecute(Sender: TObject);
begin
  Editor.CopyToClipboard;
end;

procedure TTextEditorForm.CppArrayButtonClick(Sender: TObject);
  var InfoMessage: string; res: Double;
begin
  res := RunProjection();
  InfoMessage := Format('Projection result is %f', [res]);
  ShowMessage(InfoMessage);
end;

procedure TTextEditorForm.CutActionExecute(Sender: TObject);
begin
  Editor.CutToClipboard;
  UpdateStatusBar;
end;

procedure TTextEditorForm.DeleteActionExecute(Sender: TObject);
begin
  if Editor.SelLength > 0 then
    Editor.DeleteSelection
  else
    Editor.DeleteFrom(Editor.CaretPosition, 1, [TDeleteOption.MoveCaret]);
  UpdateStatusBar;
end;

procedure TTextEditorForm.EditorKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  UpdateStatusBar;
end;

procedure TTextEditorForm.EditorMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  UpdateStatusBar;
end;

procedure TTextEditorForm.ExitActionExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TTextEditorForm.FormCreate(Sender: TObject);
begin
  Editor.Lines.Add('');
  UpdateStatusBar;
end;

procedure TTextEditorForm.NewActionExecute(Sender: TObject);
var
  UserResponse: Integer;
begin
  // Ask for confirmation if the memo is not empty.
  if not Editor.Text.IsEmpty then
  begin
    UserResponse := TDialogServiceSync.MessageDialog(
      'This will clear the current document. Do you want to continue?',
      TMsgDlgType.mtInformation, mbYesNo, TMsgDlgBtn.mbYes, 0);
    if UserResponse = mrYes then
    begin
      Editor.Text := '';
      Editor.Lines.Add(''); // Initialize the memo line count to "1".
      UpdateStatusBar;
      CurrentFile := ''; // New files have no file name until saved.
    end;
  end;
end;

procedure TTextEditorForm.OpenActionExecute(Sender: TObject);
var
  FileName: String;
begin
  if OpenFileDialog.Execute then
  begin
    FileName := OpenFileDialog.FileName;
    if FileExists(FileName) then
    begin
      Editor.Lines.LoadFromFile(FileName);
      CurrentFile := FileName;
      Caption := 'Text Editor - ' + ExtractFileName(FileName);
    end;
  end;
end;

procedure TTextEditorForm.PasteActionExecute(Sender: TObject);
begin
  Editor.PasteFromClipboard;
  UpdateStatusBar;
end;

procedure TTextEditorForm.SaveActionExecute(Sender: TObject);
begin
  if CurrentFile = '' then
    SaveAsAction.Execute()
  else
    Editor.Lines.SaveToFile(CurrentFile);
end;

procedure TTextEditorForm.SaveAsActionExecute(Sender: TObject);
var
  FileName: String;
  UserResponse: TModalResult;
begin
  if SaveFileDialog.Execute then
  begin
    FileName := SaveFileDialog.FileName;
    if FileExists(FileName) then
    begin
      UserResponse := TDialogServiceSync.MessageDialog(
        'File already exists. Do you want to overwrite?',
        TMsgDlgType.mtInformation, mbYesNo, TMsgDlgBtn.mbYes, 0);
      if UserResponse = mrNo then
        Exit;
    end;
    Editor.Lines.SaveToFile(FileName);
    CurrentFile := FileName;
    Caption := 'Text Editor - ' + ExtractFileName(FileName);
  end;
end;

procedure TTextEditorForm.SelectAllActionExecute(Sender: TObject);
begin
  Editor.SelectAll;
  UpdateStatusBar;
end;

procedure TTextEditorForm.UndoActionExecute(Sender: TObject);
begin
  Editor.UnDo;
  UpdateStatusBar;
end;

procedure TTextEditorForm.UpdateStatusBar;
begin
  LineNumber.Text := 'L: ' + (Editor.CaretPosition.Line+1).ToString;
  ColumnNumber.Text := 'C: ' + (Editor.CaretPosition.Pos+1).ToString;
  LineCount.Text := 'Lines: ' + Editor.Lines.Count.ToString;
end;

procedure TTextEditorForm.WordWrapActionExecute(Sender: TObject);
begin
  Editor.WordWrap := not Editor.WordWrap;
  WordWrapAction.Checked := Editor.WordWrap;
  UpdateStatusBar;
end;

end.
