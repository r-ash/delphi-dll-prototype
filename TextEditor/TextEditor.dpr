program TextEditor;

uses
  System.StartUpCopy,
  FMX.Forms,
  TextEditorUnit in 'TextEditorUnit.pas' {TextEditorForm},
  CppRun in 'CppRun.pas',
  Projection in 'Projection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTextEditorForm, TextEditorForm);
  Application.Run;
end.
