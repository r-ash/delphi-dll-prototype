unit CppRun;

interface

function AddNumbers(a, b: Integer): Integer; stdcall; external 'CppWrapper.dll' name 'add';

implementation

end.
