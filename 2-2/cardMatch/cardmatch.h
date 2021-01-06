//2017112148 ��켺
#ifndef P2017112148_H
#define P2017112148_H
#include "Common.h"
#include "Player.h"
#include <vector> //���͸� ����ϱ� ���� �߰����ش�.
class P2017112148 : public Player
{	
public:
	Point p_first; //�� �Ͽ��� ù��° ���� ī���� ������ ��� ��ü
	bool was_zero; //�� �Ͽ��� ù��° ���� ī���� ���ڰ��� �˰��־������� �����ϴ� bool�� ���� (true�� �𸣴� ī��)
	int index; //isOpenSet���� count[i]�� 2�̻��� �ǵ��� �ϴ� �ε��� i�� ���� ������ ����

	vector<vector<int>> v; //���� ¦�� �̷��� ���� ī����� ��ġ�� ��Ÿ���� �ε��� ������ ������ 2���� ����
	
	int myboard[BOARD_SIZE][BOARD_SIZE] = { 0 }; //���ݱ��� ���µ� ��� ī����� ���� ����ص� 2�����迭(��� 0���� �ʱ�ȭ)
	bool mymatched[BOARD_SIZE][BOARD_SIZE] = { false }; //���ݱ��� ī����� ¦�� ������� ���θ� ����ص� 2���� �迭 (��� false�� �ʱ�ȭ)
	int count[LAST_CARD_NUMBER] = { 0 }; //���µǾ����� ��ġ�������� ī�� ���� ��Ÿ���� �迭(��� 0���� �ʱ�ȭ) (count[x]�� x+1�� ���� ���� ī��� �� ���� �Ǿ����� ¦�� ã�� ���� ī���� ���̴�.)
	
public:
	P2017112148();
	Point inputFirst(); //ù��° ī�带 ���� �� � ī�带 �������� ���ϴ� �Լ�
	Point inputSecond(); //�ι�° ī�带 ���� �� � ī�带 �������� ���ϴ� �Լ�
	void checkCardInfo(Point point, int card); //�÷��̾ ī�带 �������� ��, �̸� Ȯ���ϰ� ������ �۾��� ���ϴ� �Լ�
	void matchedCard(Point p1, Point p2, int card); //�÷��̾ �� �Ͽ� ������ �� ī�尡 ���Ӱ� ¦�� �̷�� �Ǿ��� ���� �۾��� ���ϴ� �Լ�
	bool isOpenSet(); //�̹� ���µ� ī��� �� ���� ��ġ�� �ȵ� ī����� �����ϴ����� ��ȯ�ϴ� �Լ� 
};
#endif