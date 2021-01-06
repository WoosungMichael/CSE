//2017112148 ��켺
#include "Common.h"
#include "P2017112148.h"

P2017112148::P2017112148() //������
{		
	for (int i = 0; i < BOARD_SIZE; i++) {
		for (int j = 0; j < BOARD_SIZE; j++) { //������ ��� �ε����� ������ 2���� ���͸� �̿��Ͽ� �־��ش�.
			vector<int> v2;
			v2.push_back(i);
			v2.push_back(j); //size�� 2�� v2���͸� �����
			v.push_back(v2); //v�� v ���͸� push_back���ش�.
		}
	}
}
Point P2017112148::inputFirst() //ù��° ī�带 ���� �� � ī�带 �������� ���ϴ� �Լ�
{	
	for (int s = 0; s < v.size(); s++) { //���� ���� ¦�� �̷��� ���� ������ ��� �ε����� ������ ���鼭
		Point p(v[s][0], v[s][1]); //v[s][0],v[s][1]�� ��ġ�� ������ p��ü ����

		if (isOpenSet()) {//���� ¦�������� ���� �̹� ���µ� ī����� �ִ� ���
			if (myboard[v[s][0]][v[s][1]] == index + 1) {//���� ¦�������� ���� ���µ� ��(index+1)�� ���� ī���� �ε��� [v[s][0]][v[s][1]]�� ã�� ���
				Point p2(v[s][0], v[s][1]); //�� ��ġ�� ������ Point��ü p2�� ����
				p_first = p2; //ù��° ���ÿ��� ���� ī���� ��ġ�� p2�� ����
				was_zero = false; //ù��° ī�带 ���� �� ���� ���µǾ��ִ� ī�带 �̾����� ǥ��
				return p2; //p2��ü ��ȯ
			}
		}
		else { //���� ¦�������� ���� ���µ� ī����� ���� ���
			if (myboard[v[s][0]][v[s][1]] != 0) { //�̹� ���µ� ī���� ���
				continue; //�ݺ����� ���� �ε����� ���ư����� �Ѵ�.
			}
			else { //���� ���µ��� ���� ī���� ���
				p_first = p; //ù��° ���ÿ��� ���� ī���� ��ġ�� p�� ����
				was_zero = true; //ù��° ī�带 ���� �� ���� ���µǾ������ʴ� ī�带 �̾����� ǥ��
				return p; //p��ü ��ȯ
			}
		}//���� ¦�������� ���� ���µ� ī����� ���� ���, �̹� ���µ� ī�带 ���� �̴� �� ���� ���� ���� �������� ī�带 ���� �����ϴ°��� ȿ�����̴�. �̴� ù��° ��, ���� ���� �������� ī�带 �������μ� �ι�° ī�带 ���� �� 1���̶� �� ���� ���µ� ī��� ù��° ī�带 ���غ��� ���� �� �ֱ� �����̴�.
		
	}
}
Point P2017112148::inputSecond() //�ι�° ī�带 ���� �� � ī�带 �������� ���ϴ� �Լ�
{
	if (was_zero == true) { //ù��° ī�带 ���� ��� ���� ī�忡 ���� ���� ������ ��� //isOpenSet�� falsed���� ���
		Point p(v[0][0], v[0][1]); //�Ʒ��� ���ǹ��� ��� �������� ���� ��� ��ȯ�� v[0][0],v[0][1]�� ��ġ�� ������ p��ü ����
		for (int s = 0; s < v.size(); s++) { //���� ���� ¦�� �̷��� ���� ������ ��� �ε����� ������ ���鼭
			if (myboard[v[s][0]][v[s][1]] == myboard[p_first.getX()][p_first.getY()] && ((v[s][0] != p_first.getX()) || (v[s][1] != p_first.getY()))) { //ù��° ���� ī��� ���� ���� ������ ù��° ���� ī�嵵 �ƴ� ī���� �ε��� [v[s][0]][v[s][1]]�� ã�� ���
				Point p2(v[s][0],v[s][1]); //�ι�° ���ÿ��� ���� ī���� ��ġ�� p�� ����
				return p2; //p2��ü ��ȯ
			}
		}

		for (int s = 0; s < v.size(); s++) { //���� ���� ¦�� �̷��� ���� ������ ��� �ε����� ������ ���鼭
			if (myboard[v[s][0]][v[s][1]] == 0) { //���� ���µ��� ���� ī���� ���
				Point p2(v[s][0], v[s][1]); //�� ��ġ�� �ι�° ���ÿ��� ���� ī���� ��ġ�� p�� ����
				return p2; //p2��ü ��ȯ
			}
			else { //�̹� ���µ� ī���� ���
				continue; //�ݺ����� ���� �ε����� ���ư����� �Ѵ�.
			}
		}
		return p; //p��ü ��ȯ
	}
	else { //ù��° ī�带 ���� ��� ���� ī�忡 ���� ���� �˾Ҵ� ���  //isOpenSet�� true���� ���
		for (int s = 0; s < v.size(); s++) { //���� ���� ¦�� �̷��� ���� ������ ��� �ε����� ������ ���鼭
			if (myboard[v[s][0]][v[s][1]] == myboard[p_first.getX()][p_first.getY()] && ((v[s][0] != p_first.getX()) || (v[s][1] != p_first.getY()))) { //ù��° ���� ī��� ���� ���� ������ �̹� ¦�� ���� ī�嵵 �ƴϰ� ù��° ���� ī�嵵 �ƴ� ī���� �ε��� [v[s][0]][v[s][1]]�� ã�� ���
				Point p2(v[s][0],v[s][1]); //�� ��ġ�� �ι�° ���ÿ��� ���� ī���� ��ġ�� p2�� ����
				return p2; //p2��ü ��ȯ
			}
		}
	}
}
void P2017112148::checkCardInfo(Point point, int card) //�÷��̾ ī�带 �������� ��, �̸� Ȯ���ϰ� ������ �۾��� ���ϴ� �Լ� //ī���� ���� �˰� �Ǵ� ���, �̸� ī�� �����⿡ Ȱ���� �� �����Ƿ� �̸� �����صд�.
{	
	if (myboard[point.getX()][point.getY()] == 0) { //���õǾ� ���µ� ī�尡 �������� ���� ���µ��� ���� ī�忴�� ���
		myboard[point.getX()][point.getY()] = card; //myboard�� �ش� ��ġ�� ���µ� ī���� ���� �������ش�.
		count[card - 1]++; //���µ� ī���� ���� ������ ���µǾ����� ��ġ�������� ī�� ���� 1 ������Ų��.
	}
}
void P2017112148::matchedCard(Point p1, Point p2, int card) //�÷��̾ �� �Ͽ� ������ �� ī�尡 ���Ӱ� ¦�� �̷�� �Ǿ��� ���� �۾��� ���ϴ� �Լ� //�̹� ¦�� ã�� ī��� �ٽ� ���� �ʾƾ� �� �̱� Ȯ���� ���� �� �����Ƿ� ¦�� ã�� ���θ� �����Ѵ�.
{	
	mymatched[p1.getX()][p1.getY()] = true; //myboard�� p1�� ��ġ�� ���� �̹� ¦�� �������� ��Ÿ���� true�� �����Ѵ�.
	mymatched[p2.getX()][p2.getY()] = true; //myboard�� p2�� ��ġ�� ���� �̹� ¦�� �������� ��Ÿ���� true�� �����Ѵ�.
	count[card - 1] -= 2; //���µ� ī���� ���� ������ ���µǾ����� ��ġ�������� ī�� ���� 2 ���ҽ�Ų��. (�־��� 2���� ��ġ�Ǿ��⶧����)
	for (int i = 0; i < v.size(); i++) { //���� ���� ¦�� �̷��� ���� ������ ��� �ε����� ������ ������ ���͸� ���鼭
		if ((v[i][0] == p1.getX() && v[i][1] == p1.getY()) || (v[i][0] == p2.getX() && v[i][1] == p2.getY())) { //p1�Ǵ� p2�� �ε��� ���հ� ���� ���� ������ ������ ã����
			v.erase(v.begin()+i); //�� �̻� �� �ε��� ������ ¦�� �̷��� ���� �ε����� ������ �ƴϹǷ� �ش��ϴ� ���͸� �����ش�.
			i--; //�־��� for���� ��� ���ư����ϴµ� ������ erase�� �ϸ� erase�� �ںκ��� �ε����� ������ �ٽ� ������ �ٷ� ������ �ε����� ���ؼ��� �˻簡 �̷������ �����Ƿ� �̸� �˻����ֱ� ���� i--�� ���ش�.
		}
	}
}

bool P2017112148::isOpenSet() //�̹� ���µ� ī��� �� ���� ��ġ�� �ȵ� ī����� �����ϴ����� ��ȯ�ϴ� �Լ� //�� ��쿡�� ���� �켱������ �̷��� ī����� �̾ƾ��ϹǷ� �� ��쿡 ���� Ȯ�����ִ� �Լ��� �ۼ��Ͽ���.
{
	bool isOpenSet = false; //isOpenSet�� false�� �ʱ�ȭ
	for (int i = 0; i < LAST_CARD_NUMBER; i++) { //��� count�迭�� �ε����� ����
		if (count[i] >= 2) { //�̹� ���µ� ī��� �� ���� ���� ������ ī�尡 2�� �̻��� ���
			isOpenSet = true; //isOpenSet�� true�� ����
			index = i; //count[i]�� 2 �̻��� �ǵ��� �ϴ� i�� ���� index�� ����
			return isOpenSet; //isOpenSet�� true�� ��ȯ
		}
	}
	return isOpenSet; //isOpenSet�� false�� ��ȯ
}