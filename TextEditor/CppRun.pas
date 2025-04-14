unit CppRun;

interface

function AddNumbers(a, b: Integer): Integer; stdcall; external 'CppWrapper.dll' name 'add';
function AddArrays(A, B: PDouble; d1, d2: Integer): Double; stdcall; external 'CppWrapper.dll' name 'addArrays';
procedure AddArraysInPlace(A, B: PDouble; d1, d2: Integer; Outa: PDouble); stdcall; external 'CppWrapper.dll' name 'addArraysInPlace';
procedure UseSafecall(i: Integer); safecall; external 'CppWrapper.dll' name 'useSafecall';

implementation

end.
