#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

#include "Scanner.h"

void icg_error(int n);


FILE* astFile;                          // AST file
FILE* sourceFile;                       // miniC source program
FILE* ucodeFile;                        // ucode file

#define FILE_LEN 30

int main(int argc, char* argv[])
{
	char fileName[FILE_LEN];

	printf(" *** start of Mini C Compiler\n");
	if (argc != 2) {
		icg_error(1);
		exit(1);
	}

	strcpy_s(fileName, argv[1]);
	printf("   * source file name: %s\n", fileName);

	sourceFile = fopen(fileName, "r");
	if (sourceFile == NULL) {
		icg_error(2);
		exit(1);
	}

	struct tokenType token;

	printf(" === start of Scanner\n");

	token = scanner();

	while (token.number != teof) {
		token.fileName = fileName;
		printToken(token);
		token = scanner();

	} /* while (1) */

	printf(" === start of Parser\n");
	printf(" > Not yet implemented...\n");
	//root = parser();
	//printTree(root, 0);

	printf(" === start of ICG\n");
	printf(" > Not yet implemented...\n");

	//codeGen(root);
	printf(" *** end   of Mini C Compiler\n");
} // end of main

void icg_error(int n)
{
	printf("icg_error: %d\n", n);
	//3:printf("A Mini C Source file must be specified.!!!\n");
	//"error in DCL_SPEC"
	//"error in DCL_ITEM"
}