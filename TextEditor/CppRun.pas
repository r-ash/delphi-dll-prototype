unit CppRun;

interface

function AddNumbers(a, b: Integer): Integer; stdcall; external 'CppWrapper.dll' name 'add';
function AddArrays(A, B: PDouble; d1, d2: Integer): Double; stdcall; external 'CppWrapper.dll' name 'addArrays';

implementation

end.
