unit Projection;

interface

uses System.SysUtils, FMX.Dialogs, CppRun;

const
  NUM_SEXES = 2;
  NUM_AGES = 61;

type
  TArrayA = array[0..(NUM_SEXES - 1), 0..(NUM_AGES - 1)] of Double;
  TArrayB = array[1..(NUM_SEXES), 0..(NUM_AGES - 1)] of Double;

function RunProjection(): Double;
function RunProjectionInPlace(): Double;
function RunProjectionPair(): Double;

implementation

function RunProjection(): Double;
var
  i, j: Integer;
  A: TArrayA;
  B: TArrayB;
begin
   Randomize();
   for i := 0 to NUM_SEXES - 1 do
     for j := 0 to NUM_AGES - 1 do
       begin;
         A[i, j] := Random(100);
         B[i + 1, j] := Random(100);
      end;
   Result := AddArrays(@A[0, 0], @B[1, 0], NUM_SEXES, NUM_AGES)
end;

function RunProjectionInPlace(): Double;
var
  i, j: Integer;
  res: Double;
  A, B, Outa: TArrayA;
begin
  Randomize();
  for i := 0 to NUM_SEXES - 1 do
    for j := 0 to NUM_AGES - 1 do
      begin;
        A[i, j] := Random(100);
        B[i, j] := Random(100);
      end;
  AddArraysInPlace(@A[0, 0], @B[0, 0], NUM_SEXES, NUM_AGES, @Outa[0, 0]);
  res := 0;
  for i := 0 to NUM_SEXES - 1 do
    for j := 0 to NUM_AGES - 1 do
      begin;
        res := res + Outa[i, j];
      end;
  Result := res;
end;

function RunProjectionPair(): Double;
var
  i, j: Integer;
  res: Double;
  A, B, Outa: TArrayA;
  MyPair: TArrayPair;
begin;
  Randomize();
  for i := 0 to NUM_SEXES - 1 do
    for j := 0 to NUM_AGES - 1 do
      begin;
        A[i, j] := Random(100);
        B[i, j] := Random(100);
      end;

  MyPair.A := @A[0, 0];
  MyPair.B := @B[0, 0];
  MyPair.D1 := NUM_SEXES;
  MyPair.D2 := NUM_AGES;
  AddPair(MyPair, @Outa[0, 0]);
  res := 0;
  for i := 0 to NUM_SEXES - 1 do
    for j := 0 to NUM_AGES - 1 do
      begin;
        res := res + Outa[i, j];
      end;
  Result := res;
end;

end.
