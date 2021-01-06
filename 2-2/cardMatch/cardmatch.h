//2017112148 김우성
#ifndef P2017112148_H
#define P2017112148_H
#include "Common.h"
#include "Player.h"
#include <vector> //벡터를 사용하기 위해 추가해준다.
class P2017112148 : public Player
{	
public:
	Point p_first; //내 턴에서 첫번째 뽑은 카드의 정보를 담는 객체
	bool was_zero; //내 턴에서 첫번째 뽑은 카드의 숫자값을 알고있었는지를 저장하는 bool형 변수 (true면 모르는 카드)
	int index; //isOpenSet에서 count[i]가 2이상이 되도록 하는 인덱스 i의 값을 저장할 변수

	vector<vector<int>> v; //아직 짝을 이루지 못한 카드들의 위치를 나타내는 인덱스 조합을 가지는 2차원 벡터
	
	int myboard[BOARD_SIZE][BOARD_SIZE] = { 0 }; //지금까지 오픈된 모든 카드들의 값을 기록해둘 2차원배열(모두 0으로 초기화)
	bool mymatched[BOARD_SIZE][BOARD_SIZE] = { false }; //지금까지 카드들이 짝을 맞췄는지 여부를 기록해둘 2차원 배열 (모두 false로 초기화)
	int count[LAST_CARD_NUMBER] = { 0 }; //오픈되었지만 매치되지않은 카드 수를 나타내는 배열(모두 0으로 초기화) (count[x]는 x+1의 값을 가진 카드들 중 오픈 되었지만 짝은 찾지 못한 카드의 수이다.)
	
public:
	P2017112148();
	Point inputFirst(); //첫번째 카드를 뽑을 때 어떤 카드를 뽑을지를 정하는 함수
	Point inputSecond(); //두번째 카드를 뽑을 때 어떤 카드를 뽑을지를 정하는 함수
	void checkCardInfo(Point point, int card); //플레이어가 카드를 오픈했을 때, 이를 확인하고 수행할 작업을 행하는 함수
	void matchedCard(Point p1, Point p2, int card); //플레이어가 한 턴에 오픈한 두 카드가 새롭게 짝을 이루게 되었을 때의 작업을 행하는 함수
	bool isOpenSet(); //이미 오픈된 카드들 중 아직 매치가 안된 카드쌍이 존재하는지를 반환하는 함수 
};
#endif