unit CppRun;

interface

{$ALIGN 8}
type
  TArrayPair = record
    A: PDouble;
    B: PDouble;
    D1, D2: Integer;
end;

function AddNumbers(a, b: Integer): Integer; stdcall; external 'CppWrapper.dll' name 'add';
function AddArrays(A, B: PDouble; d1, d2: Integer): Double; stdcall; external 'CppWrapper.dll' name 'addArrays';
procedure AddArraysInPlace(A, B: PDouble; d1, d2: Integer; Outa: PDouble); stdcall; external 'CppWrapper.dll' name 'addArraysInPlace';
procedure UseSafecall(i: Integer); safecall; external 'CppWrapper.dll' name 'useSafecall';
procedure AddPair(Pair: TArrayPair; Outa: PDouble); safecall; external 'CppWrapper.dll' name 'addPair';

implementation

end.
