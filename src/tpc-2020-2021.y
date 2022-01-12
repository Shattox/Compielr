%{
/* tpc-2020-2021.y */

/* Syntaxe du TPC pour le projet d'analyse syntaxique de 2020-2021*/

#include <stdio.h>
#include <string.h>
#define YYERROR_VERBOSE 1

extern int yylineno;
extern int word_count2;
extern char line[100];

int yylex();
int yyerror(const char* s);

%}

%token TYPE
%token IDENT
%token VOID
%token IF
%token ELSE
%token WHILE
%token PRINT
%token OR
%token AND
%token EQ
%token ORDER
%token RETURN
%token DIVSTAR
%token ADDSUB
%token CHARACTER
%token NUM
%token READE
%token READC
%token STRUCT

%expect 1

%%
Prog:  DeclVarsGlob DeclFoncts 
    ;
DeclVarsGlob:
       DeclVarsGlob TYPE Declarateurs ';' 
    |  DeclVarsGlob STRUCT IDENT CorpsS
    |
    ;
DeclVars:
       DeclVars TYPE Declarateurs ';' 
    |  DeclVars STRUCT IDENT Declarateurs ';'
    |
    ;
Declarateurs:
       Declarateurs ',' IDENT 
    |  IDENT 
    ;
DeclFoncts:
       DeclFoncts DeclFonct 
    |  DeclFonct 
    ;
DeclFonct:
       EnTeteFonct Corps 
    ;
EnTeteFonct:
       TYPE IDENT '(' Parametres ')' 
    |  VOID IDENT '(' Parametres ')' 
    ;
Parametres:
       VOID 
    |  ListTypVar 
    ;
ListTypVar:
       ListTypVar ',' TYPE IDENT 
    |  TYPE IDENT 
    ;
Corps: '{' DeclVars SuiteInstr '}' 
    ;
CorpsS: '{' DeclVars '}' 
    ;
SuiteInstr:
       SuiteInstr Instr 
    |
    ;
Instr:
       LValue '=' Exp ';'
    |  READE '(' IDENT ')' ';'
    |  READC '(' IDENT ')' ';'
    |  PRINT '(' Exp ')' ';'
    |  IF '(' Exp ')' Instr 
    |  IF '(' Exp ')' Instr ELSE Instr
    |  WHILE '(' Exp ')' Instr
    |  IDENT '(' Arguments  ')' ';'
    |  RETURN Exp ';' 
    |  RETURN ';' 
    |  '{' SuiteInstr '}' 
    |  ';' 
    ;
Exp :  Exp OR TB 
    |  TB 
    ;
TB  :  TB AND FB 
    |  FB 
    ;
FB  :  FB EQ M
    |  M
    ;
M   :  M ORDER E 
    |  E 
    ;
E   :  E ADDSUB T 
    |  T 
    ;    
T   :  T DIVSTAR F 
    |  F 
    ;
F   :  ADDSUB F 
    |  '!' F 
    |  '(' Exp ')' 
    |  NUM 
    |  CHARACTER
    |  LValue
    |  IDENT '(' Arguments  ')' 
    ;
LValue:
       IDENT 
    ;
Arguments:
       ListExp 
    |
    ;
ListExp:
       ListExp ',' Exp 
    |  Exp 
    ;
%%

int yyerror(const char* s) {
    printf("syntax error near line %d, character %d:", yylineno, word_count2 + 1);
    printf("%s", line);
    for(int i = 1 ; i <= word_count2 ; i++) {
        printf(" ");
    }
    printf("^\n");
    return 1;
}

int main(void) {
    return yyparse();
}
