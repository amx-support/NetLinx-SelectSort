PROGRAM_NAME='selection_sort'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvTP	= 10001:1:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

integer	nNum[10]

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

DEFINE_FUNCTION selection_sort()
{
    STACK_VAR integer i
    STACK_VAR integer j
    STACK_VAR integer nMin
    STACK_VAR integer nMinLoc
    
    FOR(i=1;i<=10;i++)
    {
	nMin = nNum[i]
	nMinLoc = i
	
	FOR(j=i+1;j<=10;j++)
	{
	    IF (nMin > nNum[j])
	    {
		nMin = nNum[j]
		nMinLoc = j
	    }
	}

	nNum[nMinLoc] = nNum[i]
	nNum[i] = nMin
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT [dvTP,1]
{
    PUSH:
    {
	STACK_VAR integer i
	
	TO[BUTTON.INPUT]
	
	FOR(i=1;i<=10;i++)
	{
	    nNum[i] = RANDOM_NUMBER(100)
	    SEND_COMMAND dvTP,"'^TXT-',ITOA(i),',0,',ITOA(nNum[i])"
	    SEND_COMMAND dvTP,"'^TXT-',ITOA(i+10),',0,'"
	}
    }
}
BUTTON_EVENT [dvTP,2]
{
    PUSH:
    {
	STACK_VAR integer i
	
	selection_sort()
	
	FOR(i=1;i<=10;i++) SEND_COMMAND dvTP,"'^TXT-',ITOA(i+10),',0,',ITOA(nNum[i])"
    }
}

(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See “Differences in DEFINE_PROGRAM Program Execution” section *)
(* of the NX-Series Controllers WebConsole & Programming Guide   *)
(* for additional and alternate coding methodologies.            *)
(*****************************************************************)

DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


