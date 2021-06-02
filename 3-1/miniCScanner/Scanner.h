/***************************************************************
*      scanner routine for Mini C language                    *
*                                   2003. 3. 10               *
***************************************************************/

#pragma once


#define NO_KEYWORD 16
#define ID_LENGTH 12

struct tokenType {
	int number;
	union {
		char id[ID_LENGTH];
		int num;
		//확장 내용
		char c; //character
		char* s; //string
		double d; //double
		char* dc; //documented comments
	} value;
	char* fileName;
	int lineNum;
	int columnNum;
};


enum tsymbol {
	tnull = -1,
	tnot, tnotequ, tremainder, tremAssign, tident, tnumber,
	/* 0          1            2         3            4          5     */
	tand, tlparen, trparen, tmul, tmulAssign, tplus,
	/* 6          7            8         9           10         11     */
	tinc, taddAssign, tcomma, tminus, tdec, tsubAssign,
	/* 12         13          14        15           16         17     */
	tdiv, tdivAssign, tsemicolon, tless, tlesse, tassign,
	/* 18         19          20        21           22         23     */
	tequal, tgreat, tgreate, tlbracket, trbracket, teof,
	/* 24         25          26        27           28         29     */
	tcolon, tc_lit, ts_lit, td_lit, tdc, tperiod,
	/* 30         31          32        33           34         35     */
	tsingQuo, tdoubQuo,
	/* 36         37                                                   */

	//   ...........    word symbols ................................. //
	
	/* 38         39          40        41           42         43     */
	tconst, telse, tif, tint, treturn, tvoid,
	/* 44         45          46        47           48         49     */
	twhile, tlbrace, tor, trbrace, tchar, tdouble,
	/* 50         51          52        53           54         55     */
	tfor, tdo, tgoto, tswitch, tcase, tbreak,
	/* 56                                                              */
	tdefault
};

struct tokenType scanner();

void printToken(struct tokenType token);

int superLetter(char ch);
int superLetterOrDigit(char ch);
double getNumber(char firstCharacter, int flag);
int hexValue(char ch);
void lexicalError(int n);
char getChar();
char* getString();