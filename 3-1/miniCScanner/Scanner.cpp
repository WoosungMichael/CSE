/***************************************************************
*      scanner routine for Mini C language                    *
***************************************************************/

#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

#include <iostream>
using namespace std;
#include "Scanner.h"

extern FILE* sourceFile;                       // miniC source program


const char* tokenName[] = {
	"!",        "!=",      "%",       "%=",     "%ident",   "%number",
	/* 0          1           2         3          4          5        */
	"&&",       "(",       ")",       "*",      "*=",       "+",
	/* 6          7           8         9         10         11        */
	"++",       "+=",      ",",       "-",      "--",	    "-=",
	/* 12         13         14        15         16         17        */
	"/",        "/=",      ";",       "<",      "<=",       "=",
	/* 18         19         20        21         22         23        */
	"==",       ">",       ">=",      "[",      "]",        "eof",
	/* 24         25         26        27         28         29        */
	":", "%c_literal", "s_literal", "d_literal", "doc_comment", ".",
	/* 30         31         32        33         34         35        */
	"\'", "\"",
	/* 36         37                                                   */

	//   ...........    word symbols ................................. //
	
	/* 38         39         40        41         42         43        */
	"const",    "else",     "if",      "int",     "return",  "void",
	/* 44         45         46        47         48         49        */
	"while",    "{",        "||",      "}",       "char",    "double", 
	/* 50         51         52        53         54         55        */
	"for",      "do",       "goto",    "switch",  "case",    "break", 
	/* 56                                                              */
	"default"
};

const char* keyword[NO_KEYWORD] = {
	"const",  "else",    "if",    "int",    "return",  "void",    "while",
	"char", "double", "for", "do", "goto", "switch", "case", "break", "default"
};

enum tsymbol tnum[NO_KEYWORD] = {
	tconst,    telse,     tif,     tint,     treturn,   tvoid,     twhile,
	tchar, tdouble, tfor, tdo, tgoto, tswitch, tcase, tbreak, tdefault
};

int lineNum = 1;
int columnNum = -1;
bool isInt = true;

struct tokenType scanner()
{
	struct tokenType token;
	int i, index;
	char ch, id[ID_LENGTH];

	token.number = tnull;

	do {
		char docComment[10000] = { NULL, };
		int idx = 0;
		
		columnNum++;
		while (isspace(ch = fgetc(sourceFile))) {
			if (ch == ' ')
				columnNum++;
			if (ch == '\n') {
				lineNum++;
				columnNum = 0;
			}
		}

		// state 1: skip blanks
		token.columnNum = columnNum;
		token.lineNum = lineNum;

		if (superLetter(ch)) { // identifier or keyword
			i = 0;

			do {
				if (i < ID_LENGTH) id[i++] = ch;
				ch = fgetc(sourceFile);
				columnNum++;
			} while (superLetterOrDigit(ch));

			if (i >= ID_LENGTH) lexicalError(1);
			id[i] = '\0';

			ungetc(ch, sourceFile);  //  retract
			columnNum--;

			// find the identifier in the keyword table
			for (index = 0; index < NO_KEYWORD; index++)
				if (!strcmp(id, keyword[index])) break;
			if (index < NO_KEYWORD)    // found, keyword exit
				token.number = tnum[index];
			else {                     // not found, identifier exit
				token.number = tident;
				strcpy_s(token.value.id, id);
			}
		}  // end of identifier or keyword
		else if (isdigit(ch)) {  // number
			double num = getNumber(ch, 0);

			if (isInt == true) {
				token.number = tnumber;
				token.value.num = int(num);
			}
			else {
				token.number = td_lit;
				token.value.d = double(num);
			}
		}
		else switch (ch) {  // special character
		case '/':
			ch = fgetc(sourceFile);
			columnNum++;
			if (ch == '*') {
				ch = fgetc(sourceFile);
				columnNum++;
				if (ch == '*') {
					token.number = tdc;
					do {
						do {
							ch = fgetc(sourceFile);
							columnNum++;
							docComment[idx++] = ch;
							if (ch == '\n') {
								lineNum++;
								columnNum = 0;
							}
						} while (ch != '*');
						ch = fgetc(sourceFile);
						columnNum++;
					} while (ch != '/');
					docComment[idx - 1] = '\0';

					token.value.dc = (char*)malloc(sizeof(char) * strlen(docComment));
					strcpy(token.value.dc, docComment);
				}
				
				else {
					if (ch == '\n') {
						lineNum++;
						columnNum = 0;
					}
					do {
						do {
							ch = fgetc(sourceFile);
							columnNum++;
							if (ch == '\n') {
								lineNum++;
								columnNum = 0;
							}
						} while (ch != '*');
						ch = fgetc(sourceFile);
						columnNum++;
					} while (ch != '/');
				}
			} 
			// text comment
				
			else if (ch == '/') {
				ch = fgetc(sourceFile);
				columnNum++;
				if (ch == '/') {
					token.number = tdc;
					do {
						ch = fgetc(sourceFile);
						columnNum++;
						docComment[idx++] = ch;
						if (ch == '\n') {
							lineNum++;
							columnNum = 0;
						}
					} while (ch != '\n');
					docComment[idx - 1] = '\0';

					token.value.dc = (char*)malloc(sizeof(char) * strlen(docComment));
					strcpy(token.value.dc, docComment);
				}
				else {
					if (ch == '\n') {
						lineNum++;
						columnNum = 0;
					}
					do {
						ch = fgetc(sourceFile);
						columnNum++;
						if (ch == '\n') {
							lineNum++;
							columnNum = 0;
						}
					} while (ch != '\n');
				}
			}
			// line comment
				
			else if (ch == '=')  token.number = tdivAssign;
			else {
				token.number = tdiv;
				ungetc(ch, sourceFile); // retract
				columnNum--;
			}
			break;
		case '!':
			ch = fgetc(sourceFile);
			columnNum++;
			if (ch == '=')  token.number = tnotequ;
			else {
				token.number = tnot;
				ungetc(ch, sourceFile); // retract
				columnNum--;
			}
			break;
		case '%':
			ch = fgetc(sourceFile);
			columnNum++;
			if (ch == '=') {
				token.number = tremAssign;
			}
			else {
				token.number = tremainder;
				ungetc(ch, sourceFile);
				columnNum--;
			}
			break;
		case '&':
			ch = fgetc(sourceFile);
			columnNum++;
			if (ch == '&')  token.number = tand;
			else {
				lexicalError(2);
				ungetc(ch, sourceFile);  // retract
				columnNum--;
			}
			break;
		case '*':
			ch = fgetc(sourceFile);
			columnNum++;
			if (ch == '=')  token.number = tmulAssign;
			else {
				token.number = tmul;
				ungetc(ch, sourceFile);  // retract
				columnNum--;
			}
			break;
		case '+':
			ch = fgetc(sourceFile);
			columnNum++;
			if (ch == '+')  token.number = tinc;
			else if (ch == '=') token.number = taddAssign;
			else {
				token.number = tplus;
				ungetc(ch, sourceFile);  // retract
				columnNum--;
			}
			break;
		case '-':
			ch = fgetc(sourceFile);
			columnNum++;
			if (ch == '-')  token.number = tdec;
			else if (ch == '=') token.number = tsubAssign;
			else {
				token.number = tminus;
				ungetc(ch, sourceFile);  // retract
				columnNum--;
			}
			break;
		case '<':
			ch = fgetc(sourceFile);
			columnNum++;
			if (ch == '=') token.number = tlesse;
			else {
				token.number = tless;
				ungetc(ch, sourceFile);  // retract
				columnNum--;
			}
			break;
		case '=':
			ch = fgetc(sourceFile);
			columnNum++;
			if (ch == '=')  token.number = tequal;
			else {
				token.number = tassign;
				ungetc(ch, sourceFile);  // retract
				columnNum--;
			}
			break;
		case '>':
			ch = fgetc(sourceFile);
			columnNum++;
			if (ch == '=') token.number = tgreate;
			else {
				token.number = tgreat;
				ungetc(ch, sourceFile);  // retract
				columnNum--;
			}
			break;
		case '|':
			ch = fgetc(sourceFile);
			columnNum++;
			if (ch == '|')  token.number = tor;
			else {
				lexicalError(3);
				ungetc(ch, sourceFile);  // retract
				columnNum--;
			}
			break;
		case '(': token.number = tlparen;         break;
		case ')': token.number = trparen;         break;
		case ',': token.number = tcomma;          break;
		case ';': token.number = tsemicolon;      break;
		case '[': token.number = tlbracket;       break;
		case ']': token.number = trbracket;       break;
		case '{': token.number = tlbrace;         break;
		case '}': token.number = trbrace;         break;
		case EOF: token.number = teof;            break;
		case ':': token.number = tcolon;		  break;
		case '.':
			token.value.d = getNumber(ch, 1);
			if (token.value.d == -1) 
				lexicalError(5);
			else 
				token.number = td_lit;
			break;

		case '\'':
			token.value.c = getChar();
			token.number = ts_lit;
			break;
		case '\"':
			token.value.s = getString();
			token.number = ts_lit;
			break;

		default: {
			printf("Current character : %c", ch);
			lexicalError(4);
			break;
		}

		} // switch end
	} while (token.number == tnull);

	token.lineNum = lineNum;
	return token;
} // end of scanner

void lexicalError(int n)
{
	printf(" *** Lexical Error : ");
	switch (n) {
	case 1: printf("an identifier length must be less than 12.\n");
		break;
	case 2: printf("next character must be &\n");
		break;
	case 3: printf("next character must be |\n");
		break;
	case 4: printf("invalid character\n");
		break;
	case 5: printf("char value must contain only a single character\n");
		break;
	case 6:	printf("must not contain '\\n'");
	}
}

int superLetter(char ch)
{
	if (isalpha(ch) || ch == '_') return 1;
	else return 0;
}

int superLetterOrDigit(char ch)
{
	if (isalnum(ch) || ch == '_') return 1;
	else return 0;
}

double getNumber(char firstCharacter, int flag)
{
	double num = 0;
	int value;
	char ch;

	char* num_arr = (char*)malloc(sizeof(char));
	int idx = 0;
	if (flag == 0) {
		if (firstCharacter == '0') {
			ch = fgetc(sourceFile);
			columnNum++;
			if ((ch == 'X') || (ch == 'x')) {		// hexa decimal
				columnNum++;
				while ((value = hexValue(ch = fgetc(sourceFile))) != -1) {
					columnNum++;
					num = 16 * num + value;
				}
			}
			else if ((ch >= '0') && (ch <= '7'))	// octal
				do {
					num = 8 * num + (int)(ch - '0');
					ch = fgetc(sourceFile);
					columnNum++;
				} while ((ch >= '0') && (ch <= '7'));
			else num = 0;						// zero
		}
		else {									// decimal
			ch = firstCharacter;
			do {
				num = 10 * num + (int)(ch - '0');
				num_arr[idx++] = ch;
				ch = fgetc(sourceFile);
				columnNum++;
			} while (isdigit(ch));
		}
	}
	else {
		realloc(num_arr, sizeof(char) * 2);
		num_arr[idx++] = '0';
		ch = firstCharacter;
	}

	if (ch == '.') {
		isInt = false;
		num_arr[idx++] = '.';

		ch = fgetc(sourceFile);
		columnNum++;

		while (isdigit(ch) || (ch == 'e') || (ch == 'E') || (ch == '+') || (ch == '-')) {
			num_arr[idx++] = ch;
			
			ch = fgetc(sourceFile);
			columnNum++;
		}
		num = atof(num_arr);
		
		if (idx == 2)
			return -1;
	}

	ungetc(ch, sourceFile);  /*  retract  */
	columnNum--;

	return num;
}

int hexValue(char ch)
{
	switch (ch) {
	case '0': case '1': case '2': case '3': case '4':
	case '5': case '6': case '7': case '8': case '9':
		return (ch - '0');
	case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
		return (ch - 'A' + 10);
	case 'a': case 'b': case 'c': case 'd': case 'e': case 'f':
		return (ch - 'a' + 10);
	default: return -1;
	}
}

void printToken(struct tokenType token)
{
	if (token.number == tident) {
		printf("Token ------> %s (%d, %s, %s, %d, %d)\n", tokenName[token.number], token.number, token.value.id, token.fileName,
			token.lineNum, token.columnNum);
	}
	else if (token.number == tnumber) {
		printf("Token ------> %s (%d, %d, %s, %d, %d)\n", tokenName[token.number], token.number, token.value.num, token.fileName,
			token.lineNum, token.columnNum);
	}
	else if (token.number == tc_lit) {
		printf("Token ------> %s (%d, %s, %s, %d, %d)\n", tokenName[token.number], token.number, token.value.c, token.fileName,
			token.lineNum, token.columnNum);
	}
	else if (token.number == ts_lit) {
		printf("Token ------> %s (%d, %s, %s, %d, %d)\n", tokenName[token.number], token.number, token.value.s, token.fileName,
			token.lineNum, token.columnNum);
		free(token.value.s);
	}
	else if (token.number == td_lit) {
		printf("Token ------> %s (%d, %f, %s, %d, %d)\n", tokenName[token.number], token.number, token.value.d, token.fileName,
			token.lineNum, token.columnNum);
	}
	else if (token.number == tdc) {
		printf("...\n");
		printf("Documented Comments ------> %s\n", token.value.dc);
		printf("...\n");
	}
	else {
		printf("Token ------> %s (%d, 0, %s, %d, %d)\n", tokenName[token.number], token.number, token.fileName,
			token.lineNum, token.columnNum);
	}
}

char getChar() {
	char ch;

	int idx = 0;
	ch = fgetc(sourceFile);
	columnNum++;

	if (ch != '\'') {
		if (ch == '\\') {
			ch = fgetc(sourceFile);
			columnNum++;
		}
	}
	if (ch == '\n')
		lexicalError(6);

	char temp = fgetc(sourceFile);
	if (temp != '\'')
		lexicalError(5);	

	return ch;
}

char* getString() {
	char ch;
	char* str_arr = (char*)malloc(sizeof(char));

	int idx = 0;
	ch = fgetc(sourceFile);
	columnNum++;

	while (ch != '\"') {
		if (ch == '\\') {
			str_arr[idx++] = '\\';

			ch = fgetc(sourceFile);
			columnNum++;
		}
		if (ch == '\n')
			lexicalError(6);
		str_arr[idx++] = ch;
	}

	return str_arr;
}