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
 
          Symbol s =  new Symbol( l ,  yyline , yycolumn, "\\n" ); 
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
NUMBER =((0{1}|([1-9]+[0-9]*))(\.([0-9])+){0,1})  // for both integers and floats 
 // (\.([0-9])+){0,1})      : describes the float part which is option {0,1} 
 // ((0{1}|([1-9]+[0-9]*))  :  the number is either from 1 to infinit without 0 on the left 
 // or a single 0 
PROGNAME =[A-Z](\d|[a-zA-Z])*[a-zA-Z]
 //the program name should start with a upper case letter and end up with letter
 // [A-Z]           : there can several upper case letter in the begining 
 // (\d|[a-zA-Z])*  : optional digits and letters on the middle 
 // [a-zA-Z]     :the program should always end up with a letter 
VARNAME = [a-z](\d|[a-z])*[a-z]  // similar to program name, just the upper case letters are ommited
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
       ">"  { handleOp(LexicalUnit.GT); }
       "="  { handleOp(LexicalUnit.EQ); }
 

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
         {NUMBER}  {   handleOp(LexicalUnit.NUMBER); } 
         // program name 
         {PROGNAME} { handleOp(LexicalUnit.PROGNAME); }
         {VARNAME} { handleOp(LexicalUnit.VARNAME); }
      .   { }
    

 
} 
 




