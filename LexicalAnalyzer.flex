%%
%class  LexicalAnalyzer
%unicode 
%line
%column
 

%standalone 
// 1 : detecting end of lines and adding \n on each
%xstate YYINITIAL , LINEEND , CONDITION , LOOP

// this function is used to display whenever a given lexical unit is present 
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
NUMBER = ([0-9]+"."+[0-9]) | [0-9]  // integer or float numbers 
%%
// initial state 
<YYINITIAL>    { 
{ENDOFLINE}    {  handleOp(LexicalUnit.ENDLINE);  }
   // conditions 
    "IF"     { handleOp(LexicalUnit.IF); }
    "THEN"   { handleOp(LexicalUnit.THEN);  }
    "ENDIF"  { handleOp(LexicalUnit.ENDIF); }
    "ELSE"   { handleOp(LexicalUnit.ELSE);  }
   
    // loops 
     "WHILE"    { handleOp(LexicalUnit.WHILE); }
     "DO"       { handleOp(LexicalUnit.DO);  }
     "ENDWHILE" { handleOp(LexicalUnit.ENDWHILE); }
       
      // operations 
       "+"  { handleOp(LexicalUnit.PLUS); }
       "/"  { handleOp(LexicalUnit.DIVIDE); }
       "*"  { handleOp(LexicalUnit.TIMES); }
       ":="  { handleOp(LexicalUnit.ASSIGN); }
       "("  { handleOp(LexicalUnit.LPAREN); }
       ")"  { handleOp(LexicalUnit.RPAREN); }
       "-"  { handleOp(LexicalUnit.MINUS); }
       ","  { handleOp(LexicalUnit.COMMA); }

 

       // Other reserved words 
        "BEGINPROG"  { handleOp(LexicalUnit.BEGINPROG); }
        "ENDPROG"  { handleOp(LexicalUnit.ENDPROG); }

       // loops 
        "WHILE"  { handleOp(LexicalUnit.WHILE); }
        "DO"  { handleOp(LexicalUnit.DO); }
        "ENDWHILE"  { handleOp(LexicalUnit.ENDWHILE); }
        // reading and print 
        "READ"  { handleOp(LexicalUnit.READ); }
        "PRINT"  { handleOp(LexicalUnit.PRINT); }

         // numbers  real and integers
         {NUMBER} { handleOp(LexicalUnit.NUMBER); }
     


      .   { }
    

 
} 
 




