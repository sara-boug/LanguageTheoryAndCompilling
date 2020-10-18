%%
%class  LexicalAnalyzer
%unicode 
%line
%column
 

%standalone 
// 1 : detecting end of lines and adding \n on each
%xstate YYINITIAL , LINEEND , CONDITION , LOOP

%{
   StringBuffer string = new StringBuffer(); 
%}
// the end of the program 
%{ 
     private void handleOp(LexicalUnit l  ) { 
        if (l == LexicalUnit.ENDLINE) {
 
          Symbol s =  new Symbol( l ,  yyline , yycolumn, "/n" ); 
          System.out.println( s.toString());
          return ; 
        } else if( l != LexicalUnit.ENDLINE) { 
          Symbol s =  new Symbol( l ,  yyline , yycolumn, yytext() ); 
          System.out.println( s.toString());
          yybegin(YYINITIAL); 
          return;
        }
    }   
%}
 
ENDOFLINE  = "\n"|"\r" |"\n\r" 
CONDITIONS =  "IF" | "THEN"| "ENDIF"| "ELSE"
LOOPS      = "WHILE" | "DO" | "ENDWHILE"
 
%%
// initial state 
<YYINITIAL>    { 
{ENDOFLINE}    {  handleOp(LexicalUnit.ENDLINE);  }

{CONDITIONS}   {   yybegin(CONDITION);}
 
 .              { }

}


// condition state

<CONDITION> { 
    "IF"  { handleOp(LexicalUnit.IF); }
             
    "THEN"  { handleOp(LexicalUnit.THEN);  }
    "ENDIF"  { handleOp(LexicalUnit.ENDIF); }

    "ELSE"  { handleOp(LexicalUnit.ELSE);  }
     
 }
 
 
 




