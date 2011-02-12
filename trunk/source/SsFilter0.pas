(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is TurboPower ShellShock
 *
 * The Initial Developer of the Original Code is
 * TurboPower Software
 *
 * Portions created by the Initial Developer are Copyright (C) 1996-2002
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 * ***** END LICENSE BLOCK ***** *)

{*********************************************************}
{* ShellShock: SsFilter0.pas 1.02                        *}
{*********************************************************}
{* ShellShock: Property Editor for TStDialogPanel        *}
{*********************************************************}

unit SsFilter0;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids;

type
  TFilterEdForm = class(TForm)
    FilterGrid: TStringGrid;
    OKBtn: TButton;
    CancelBtn: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadGrid(Value : string);
    function GetValue : string;
  end;

var
  FilterEdForm: TFilterEdForm;

implementation

{$R *.DFM}

function TFilterEdForm.GetValue : string;
var
  R : Integer;
  S : string;
begin
  R := 1;
  if FilterGrid.Cells[0, R] = '' then begin
    Result := '';
    Exit;
  end;
  S := FilterGrid.Cells[0, R];
  S := S + '|' + FilterGrid.Cells[1, R];
  Inc(R);
  while FilterGrid.Cells[0, R] <> '' do begin
    S := S + '|' + FilterGrid.Cells[0, R] + '|' + FilterGrid.Cells[1, R];
    Inc(R);
  end;
  Result := S;
end;

procedure TFilterEdForm.FormShow(Sender: TObject);
begin
  FilterGrid.Cells[0, 0] := 'Filter Name';
  FilterGrid.Cells[1, 0] := 'Filter';
end;

procedure TFilterEdForm.LoadGrid(Value : string);
var
  P, R, C : Integer;
  S : string;
begin
  if Value = '' then
    Exit;
  P := Pos('|', Value);
  R := 1;
  C := 0;
  while P <> 0 do begin
    S := Copy(Value, 1, P - 1);
    FilterGrid.Cells[C, R] := S;
    Inc(C);
    Delete(Value, 1, P);
    P := Pos('|', Value);
    if P = 0 then
      FilterGrid.Cells[C, R] := Value
    else begin
      S := Copy(Value, 1, P - 1);
      FilterGrid.Cells[C, R] := S;
      Delete(Value, 1, P);
    end;
    P := Pos('|', Value);
    Inc(R);
    C := 0;
  end;
end;

end.
