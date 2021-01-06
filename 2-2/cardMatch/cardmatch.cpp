//2017112148 김우성
#include "Common.h"
#include "P2017112148.h"

P2017112148::P2017112148() //생성자
{		
	for (int i = 0; i < BOARD_SIZE; i++) {
		for (int j = 0; j < BOARD_SIZE; j++) { //가능한 모든 인덱스의 조합을 2차원 벡터를 이용하여 넣어준다.
			vector<int> v2;
			v2.push_back(i);
			v2.push_back(j); //size가 2인 v2벡터를 만들고
			v.push_back(v2); //v에 v 벡터를 push_back해준다.
		}
	}
}
Point P2017112148::inputFirst() //첫번째 카드를 뽑을 때 어떤 카드를 뽑을지를 정하는 함수
{	
	for (int s = 0; s < v.size(); s++) { //현재 아직 짝을 이루지 못한 가능한 모든 인덱스의 조합을 돌면서
		Point p(v[s][0], v[s][1]); //v[s][0],v[s][1]의 위치를 가지는 p객체 선언

		if (isOpenSet()) {//아직 짝지어지지 않은 이미 오픈된 카드쌍이 있는 경우
			if (myboard[v[s][0]][v[s][1]] == index + 1) {//아직 짝지어지지 않은 오픈된 값(index+1)을 가진 카드의 인덱스 [v[s][0]][v[s][1]]을 찾은 경우
				Point p2(v[s][0], v[s][1]); //그 위치를 가지는 Point객체 p2를 선언
				p_first = p2; //첫번째 선택에서 뽑은 카드의 위치로 p2를 저장
				was_zero = false; //첫번째 카드를 뽑을 때 원래 오픈되어있던 카드를 뽑았음을 표시
				return p2; //p2객체 반환
			}
		}
		else { //아직 짝지어지지 않은 오픈된 카드쌍이 없는 경우
			if (myboard[v[s][0]][v[s][1]] != 0) { //이미 오픈된 카드인 경우
				continue; //반복문의 다음 인덱스로 돌아가도록 한다.
			}
			else { //아직 오픈되지 않은 카드인 경우
				p_first = p; //첫번째 선택에서 뽑은 카드의 위치로 p를 저장
				was_zero = true; //첫번째 카드를 뽑을 때 원래 오픈되어있지않던 카드를 뽑았음을 표시
				return p; //p객체 반환
			}
		}//아직 짝지어지지 않은 오픈된 카드쌍이 없는 경우, 이미 오픈된 카드를 먼저 뽑는 것 보다 아직 오픈 되지않은 카드를 먼저 오픈하는것이 효과적이다. 이는 첫번째 때, 아직 오픈 되지않은 카드를 뽑음으로서 두번째 카드를 뽑을 때 1장이라도 더 많은 오픈된 카드와 첫번째 카드를 비교해보고 뽑을 수 있기 때문이다.
		
	}
}
Point P2017112148::inputSecond() //두번째 카드를 뽑을 때 어떤 카드를 뽑을지를 정하는 함수
{
	if (was_zero == true) { //첫번째 카드를 뽑을 당시 뽑은 카드에 적힌 수를 몰랐던 경우 //isOpenSet이 falsed였던 경우
		Point p(v[0][0], v[0][1]); //아래의 조건문을 모두 만족하지 않을 경우 반환할 v[0][0],v[0][1]의 위치를 가지는 p객체 선언
		for (int s = 0; s < v.size(); s++) { //현재 아직 짝을 이루지 못한 가능한 모든 인덱스의 조합을 돌면서
			if (myboard[v[s][0]][v[s][1]] == myboard[p_first.getX()][p_first.getY()] && ((v[s][0] != p_first.getX()) || (v[s][1] != p_first.getY()))) { //첫번째 뽑은 카드와 같은 값을 가졌고 첫번째 뽑은 카드도 아닌 카드의 인덱스 [v[s][0]][v[s][1]]을 찾은 경우
				Point p2(v[s][0],v[s][1]); //두번째 선택에서 뽑을 카드의 위치로 p를 저장
				return p2; //p2객체 반환
			}
		}

		for (int s = 0; s < v.size(); s++) { //현재 아직 짝을 이루지 못한 가능한 모든 인덱스의 조합을 돌면서
			if (myboard[v[s][0]][v[s][1]] == 0) { //아직 오픈되지 않은 카드인 경우
				Point p2(v[s][0], v[s][1]); //이 위치를 두번째 선택에서 뽑을 카드의 위치로 p에 저장
				return p2; //p2객체 반환
			}
			else { //이미 오픈된 카드인 경우
				continue; //반복문의 다음 인덱스로 돌아가도록 한다.
			}
		}
		return p; //p객체 반환
	}
	else { //첫번째 카드를 뽑을 당시 뽑은 카드에 적힌 수를 알았던 경우  //isOpenSet이 true였던 경우
		for (int s = 0; s < v.size(); s++) { //현재 아직 짝을 이루지 못한 가능한 모든 인덱스의 조합을 돌면서
			if (myboard[v[s][0]][v[s][1]] == myboard[p_first.getX()][p_first.getY()] && ((v[s][0] != p_first.getX()) || (v[s][1] != p_first.getY()))) { //첫번째 뽑은 카드와 같은 값을 가졌고 이미 짝을 맞춘 카드도 아니고 첫번째 뽑은 카드도 아닌 카드의 인덱스 [v[s][0]][v[s][1]]을 찾은 경우
				Point p2(v[s][0],v[s][1]); //이 위치를 두번째 선택에서 뽑을 카드의 위치로 p2에 저장
				return p2; //p2객체 반환
			}
		}
	}
}
void P2017112148::checkCardInfo(Point point, int card) //플레이어가 카드를 오픈했을 때, 이를 확인하고 수행할 작업을 행하는 함수 //카드의 값을 알게 되는 경우, 이를 카드 뒤집기에 활용할 수 있으므로 이를 저장해둔다.
{	
	if (myboard[point.getX()][point.getY()] == 0) { //선택되어 오픈된 카드가 이전까지 아직 오픈되지 않은 카드였던 경우
		myboard[point.getX()][point.getY()] = card; //myboard의 해당 위치에 오픈된 카드의 값을 저장해준다.
		count[card - 1]++; //오픈된 카드의 값을 가지는 오픈되었지만 매치되지않은 카드 수를 1 증가시킨다.
	}
}
void P2017112148::matchedCard(Point p1, Point p2, int card) //플레이어가 한 턴에 오픈한 두 카드가 새롭게 짝을 이루게 되었을 때의 작업을 행하는 함수 //이미 짝을 찾은 카드는 다시 뽑지 않아야 더 이길 확률을 높일 수 있으므로 짝을 찾은 여부를 저장한다.
{	
	mymatched[p1.getX()][p1.getY()] = true; //myboard의 p1의 위치에 값을 이미 짝을 맞췄음을 나타내는 true를 저장한다.
	mymatched[p2.getX()][p2.getY()] = true; //myboard의 p2의 위치에 값을 이미 짝을 맞췄음을 나타내는 true를 저장한다.
	count[card - 1] -= 2; //오픈된 카드의 값을 가지는 오픈되었지만 매치되지않은 카드 수를 2 감소시킨다. (주어진 2장이 매치되었기때문에)
	for (int i = 0; i < v.size(); i++) { //현재 아직 짝을 이루진 못한 가능한 모든 인덱스의 조합을 가지는 벡터를 돌면서
		if ((v[i][0] == p1.getX() && v[i][1] == p1.getY()) || (v[i][0] == p2.getX() && v[i][1] == p2.getY())) { //p1또는 p2의 인덱스 조합과 같은 값을 가지는 조합을 찾으면
			v.erase(v.begin()+i); //더 이상 그 인덱스 조합은 짝을 이루지 못한 인덱스의 조합이 아니므로 해당하는 벡터를 지워준다.
			i--; //주어진 for문은 계속 돌아가야하는데 위에서 erase를 하면 erase된 뒤부분의 인덱스가 땡겨져 다시 지워진 바로 직후의 인덱스에 대해서는 검사가 이루어지지 않으므로 이를 검사해주기 위해 i--를 해준다.
		}
	}
}

bool P2017112148::isOpenSet() //이미 오픈된 카드들 중 아직 매치가 안된 카드쌍이 존재하는지를 반환하는 함수 //이 경우에는 가장 우선적으로 이러한 카드쌍을 뽑아야하므로 이 경우에 대해 확인해주는 함수를 작성하였다.
{
	bool isOpenSet = false; //isOpenSet을 false로 초기화
	for (int i = 0; i < LAST_CARD_NUMBER; i++) { //모든 count배열의 인덱스에 대해
		if (count[i] >= 2) { //이미 오픈된 카드들 중 같은 값을 가지는 카드가 2장 이상인 경우
			isOpenSet = true; //isOpenSet을 true로 변경
			index = i; //count[i]가 2 이상이 되도록 하는 i의 값을 index에 저장
			return isOpenSet; //isOpenSet의 true값 반환
		}
	}
	return isOpenSet; //isOpenSet의 false값 반환
}
