package java_Week13;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Vector;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.DataLine; //음악파일을 추가하기위해 import해준다.

public class blackjack {
	private User dealer = null;
	private User user = null;

	blackjack() throws Exception { // 생성자를 이용하여 init()을 실행한다.
		init();
	}

	private void init() throws Exception { // User객체를 new를 이용하여 선언해준다.

		dealer = new User("Dealer");
		user = new User("User"); // User 객체인 dealer와 user 선언

		System.out.println("Blackjack 게임에 오신걸 환영합니다!");
		
		Games();
	}

	private void initCard() { // User객체들에 대해 initCard()를 실행하는 함수
		dealer.initCard();
		user.initCard();
	}
	
	public static void bgm(String s) { //음악 파일을 재생해주는 함수
		File bgm;
		AudioInputStream stream;
		AudioFormat format;
		DataLine.Info info;
		
		bgm=new File("audio\\" + s); //매개변수로 받아온 파일의 경로를 저장
		
		Clip clip; //.wav파일 재생을 위한 clip
		
		try {
			stream=AudioSystem.getAudioInputStream(bgm);
			format = stream.getFormat();
			info = new DataLine.Info(Clip.class, format);
			clip=(Clip)AudioSystem.getLine(info);
			clip.open(stream);
			clip.start(); //매개변수로 넘어온 음악파일 재생
		}catch(Exception e) { //예외처리
			System.out.println("err : " + e);
		}
	}

	private void Games() throws Exception { // 게임을 실행하고 게임이 끝난 후 재실행 여부를 결정하는 함수

		do {
			startGame(); // 게임을 실행한다.
			String inputStr = "";
			while (true) {
				try {
					inputStr = inputString("한 게임 더 하시겠습니까? (Y/N)"); // 한게임 더 할지에 대한 여부를 입력받는다.

					if (inputStr.equals("") || inputStr.equals("Y") || inputStr.equals("y")) {
						System.out.println("계속 진행합니다.");
						break; // 게임을 다시 실행할 수 있도록 반복문을 나갑니다.
					} else if (inputStr.equals("N") || inputStr.equals("n")) {
						System.out.println("게임 종료.");
						System.exit(0); // 게임을 종료하도록 exit(0)을 실행한다.
					} else {
						System.out.println("Y/N 중에 고르세요");
					} // 다른 입력을 입력한 경우
				} catch (IOException e) {
					System.out.println("다시 입력하세요.");
					continue; // 예외처리
				}
			}

		} while (true);
	}

	private void startGame() throws Exception { // Blackjack게임을 실행하는 함수

		System.out.println("게임을 시작합니다.");
		blackjack.bgm("game_start.wav"); //게임이 시작할 때 이에 맞는 bgm을 넣어준다.

		initCard(); // user와 dealer의 카드를 초기화해준다.
		while (true) {
				// 기본카드 배분
				dealer.addCard(dealer.pickCard()); // dealer가 랜덤하게 카드를 받는 함수
				user.addCard(user.pickCard()); // user가 랜덤하게 카드를 받는 함수
				do {
					String inputStr = "";
					if (getValue(user.getMycard()) < 21) {// User카드의 합이 21보다 작은 경우만 더 받을지 결정
						if (user.getMycard().size() >= 2) {// 카드를 2장 이상 받은 이후에만 카드를 더 받을지 결정
							while (true) {
								try { 
									showCard(true); //현재 상황에서 user와 dealer의 모든 카드와 합을 보여준다.
									User.showProb(dealer, user); // 다음 뽑기에서 블랙잭이 될 확률을 구하는 함수
									inputStr = inputString("카드를 더 받으시겠습니까? (Y/N)");

									if (inputStr.equals("") || inputStr.equals("Y") || inputStr.equals("y")
											|| inputStr.equals("N") || inputStr.equals("n")) {
										break; // 제대로 입력을 한 경우
									} else {
										throw new Exception("Y/N 중에 고르세요"); //주어진 입력 이외의 입력을 선택한 경우도 Throw new Exception()을 이용해 예외로 처리해준다.
										//System.out.println("Y/N 중에 고르세요(엔터 = 계속)");
									} // 정상적인 입력이 아닌 경우
								}catch (Exception e) {
									System.out.println("\n"+e);
									System.out.println("다시 입력하세요.");
									continue; //제대로 된 명령이 들어올 때까지 반복
								} // 예외처리
							}
						}

						if (inputStr.equals("") || inputStr.equals("Y") || inputStr.equals("y")) {

							while (getValue(dealer.getMycard()) <= 16) {
								dealer.addCard(dealer.pickCard());
							} // dealer는 카드의 합이 16이하인 경우에만 카드를 더 받는다.
							if (user.getMycard().size() >= 2)
								blackjack.bgm("hit_the_card.wav"); //카드를 더 받을 때 이에 맞는 bgm을 넣어준다.
							user.addCard(user.pickCard()); // user가 카드를 더 받는다.
							

							continue;
						} else if (inputStr.equals("N") || inputStr.equals("n")) {
							break; // 더 이상 카드를 받지 않는다.
						} else {
							System.out.println("정의되지 않은 입력값입니다.");
						} // 정의되지 않은 입력인 경우
					} else {
						break;
					}

				} while (true);

				showCard(true); // user와 dealer의 모든 카드를 공개한다.
				break;
			} 
		
		getResult();// 게임 결과 확인

	}

	private void showCard(boolean isDealerCardShow) {

		Vector dealerCard = dealer.getMycard();
		System.out.print("딜러 카드 : ");
		if (isDealerCardShow) { //매개변수가 true인 경우에는 dealer의 모든 카드와 그 합을 출력한다.
			for (int i = 0; i < dealerCard.size(); i++) {
				System.out.print(dealerCard.get(i) + " ");
			}
			System.out.println("합 = " + getValue(dealer.getMycard()));
		} else { //매개변수가 false인 경우에는 dealer의 첫 두 카드와 그 합을 출력한다. (딜러의 카드를 처음 두개만 볼 수 있다고 가정하고 게임 할 경우를 위해)
			for (int i = 0; i < 2; i++) {
				System.out.print(dealerCard.get(i) + " ");
			}
			System.out.println("합 = " +  (calculate2((String) dealerCard.get(0))
					+ calculate2((String) dealerCard.get(1))));
		}

		Vector userCard = user.getMycard();
		System.out.print("유저 카드 : ");
		for (int i = 0; i < userCard.size(); i++) { //user의 모든 카드와 그 합을 출력한다.
			System.out.print(userCard.get(i) + " ");
		}
		System.out.println("합 = " + getValue(user.getMycard()));
	}
	
	private static int calculate(String s) { //카드 하나의 값을 계산하는 함수
		
		int val;
		
		if (s.equals("A"))
			val = 1;
		else if (s.equals("J"))
			val = 10;
		else if (s.equals("Q"))
			val = 10;
		else if (s.equals("K"))
			val = 10;
		else if (s.equals("Joker"))
			val = 11; //A, J, Q, K, Joker인 경우에 대한 기본값 설정
		else
			val=Integer.parseInt(s); //나머지 카드인 경우에 대한 기본값 설정
		
		return val;
	}
	
	private int calculate2(String s) { //(딜러의 카드를 처음 두개만 볼 수 있다고 가정하고 게임 할 경우, 그 때 dealer의 첫 두장을 계산할때를 위해)
		
		int val;
		
		if (s.equals("A"))
			val = 11;
		else if (s.equals("J"))
			val = 10;
		else if (s.equals("Q"))
			val = 10;
		else if (s.equals("K"))
			val = 10;
		else if (s.equals("Joker"))
			val = 11; //A, J, Q, K, Joker인 경우에 대한 기본값 설정
		else
			val=Integer.parseInt(s);
		
		return val;
	}

	private static int getValue(Vector cardVec) { //user의 현재 카드 모음의 점수를 계산해주는 함수

		int value = 0;
		int aCount = 0;
		int jokerCount = 0;

		for (int i = 0; i < cardVec.size(); i++) { //모든 카드의 경우에서 각각의 value값을 더해준다.
			value+=calculate((String)cardVec.get(i));
			if (calculate((String)cardVec.get(i)) == 1) { //A의 경우, 1도 되고 11도 되므로 A의 개수를 따로 저장해준다.
				aCount++;
			}
			if (calculate((String)cardVec.get(i)) == 11) { //Joker의 경우, 모든 숫자가 될 수 있으므로 Joker의 개수를 따로 저장해준다.
				jokerCount++;
			}
		}

		for (int i = 0; i < aCount; i++) {
			if (value <= 11) { //A가 11의 값을 가져도 된다면 원래 1을 추가했던 value값에 10을 더 더해준다.
				aCount--;
				value += 10;
			}
		}
		
		for (int i = 0; i < jokerCount; i++) {
			if (21<=value && value<= 31) { //Joker가 11의 값을 가져서 21을 넘게 된다면 합이 21이 되도록하는 더 작은 수로 Joker의 값을 바꿔준다.
				jokerCount--;
				value = 21;
			}
		}
		
		return value;
	}

	private void getResult() {

		int dealerValue = getValue(dealer.getMycard());
		int userValue = getValue(user.getMycard()); //user와 dealer의 점수 합을 가져온다.

		if (userValue == dealerValue || (userValue > 21 && dealerValue > 21)) { //둘이 점수가 같다면
			System.out.println("무승부\n");
		} else if (userValue > 21 || (dealerValue <= 21 && userValue < 21 && dealerValue > userValue)) {
			// user의 점수가 21을 넘거나 , 둘 다 21을 넘지 않으면서 dealer의 점수가 더 높을 때
			System.out.println("딜러 승\n");
			blackjack.bgm("lose.wav"); //게임에서 졌을 때 이에 맞는 bgm을 넣어준다.
		} else if (userValue > dealerValue || dealerValue > 21) { // dealer의 점수가 21을 넘거나 , 둘 다 21을 넘지 않으면서 user의 점수가 더 높을 때
			System.out.println("유저 승\n");
			blackjack.bgm("game_start.wav"); //게임에서 이겼을 때 이에 맞는 bgm을 넣어준다.
		} else { //예외의 경우
			showCard(true);
			System.out.println("조건 성립 안되어있음.");
		}
	}

	private String inputString(String msg) throws IOException {//입력을 받아오는 함수

		String result = "";
		BufferedReader br = null;

		System.out.print(msg + " : ");
		br = new BufferedReader(new InputStreamReader(System.in));
		result = br.readLine().trim();
		if (result.length() > 0) { //한단어만 받아온다.
			result = result.substring(0, 1);
		}
		return result;
	}

	private static class User { //User객체
		private String userName = "";
		private static String[] card = new String[] {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K","A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K","A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K","A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "Joker"}; //static으로 카드 배열을 선언해준다.
		private Vector<String> mycard = null; //카드 배열을 가진다.
		
		User(String name) {
			this.userName = name;
			mycard = new Vector<String>();
		} //매개변수를 name으로 가지도록 하는 생성자

		public void initCard() {
			mycard.clear();
		} //카드를 초기화해준다.
		
		public String pickCard() { //랜덤하게 카드를 뽑고, 뽑고 나면 그 카드를 0으로 초기화해주는 함수
			int rand;
			while(true){
				rand=(int)(Math.random()*53); //random함수를 이용하여 랜덤한 수를 갖는다.
				
				if(getCard(rand).equals("0")){ //이미 선택된 카드인 경우 다시 랜덤한 수를 뽑는 단계로 돌아간다.
					continue;
				}else {
					break;
				}
			}
			String s=card[rand];
			card[rand]="0"; //뽑은 카드는 0으로 초기화하여 다시 사용할 수 없도록 한다.
			return s;
			
		}
		
		public static void showProb(User dealer, User user) { // 다음 뽑기에서 블랙잭이 될 확률을 구하는 함수를 static으로 선언해준다.
			Vector dealerCard = dealer.getMycard();
			Vector userCard = user.getMycard();
			int need = 0;
			need = 21 - getValue(user.getMycard());
			// 블랙잭이 되기 위해 뽑아야하는 수를 구한다.

			int cnt;
			if (need == 10)
				cnt = 17; // 10,J,Q,K,Joker 모두 10 이 가능하므로 17개로 시작한다.
			else
				cnt = 5; // 다른 경우는

			if (need == 11) { //A는 1과 11모두 가능한데 A의 value가 1로 설정되어있으므로 따로 계산한다.
				for (int i = 0; i < dealerCard.size(); i++) {
					if (calculate((String)dealerCard.get(i)) == 1)
						cnt--;
					if((String)dealerCard.get(i)=="Joker")
						cnt--;
				}
				for (int i = 0; i < userCard.size(); i++) {
					if (calculate((String)userCard.get(i)) == 1)
						cnt--;
					if((String)userCard.get(i)=="Joker")
						cnt--;
				}
			} else { // 지금까지 딜러와 user가 뽑은 카드 중 그 수가 뽑힌 경우를 제외해준다.
				for (int i = 0; i < dealerCard.size(); i++) {
					if (calculate((String)dealerCard.get(i)) == need)
						cnt--;
					if((String)dealerCard.get(i)=="Joker")
						cnt--;
				}
				for (int i = 0; i < userCard.size(); i++) {
					if (calculate((String)userCard.get(i)) == need)
						cnt--;
					if((String)userCard.get(i)=="Joker")
						cnt--;
				}
			}
			if (getValue(user.getMycard()) < 10)
				cnt = 0; //다음번에 어떤 수를 뽑아도 블랙잭이 될 수 없으므로 분자를 0으로 해준다.

			double prob = (double) cnt / (53 - dealerCard.size() - userCard.size()); //(블랙잭이 되도록 하는 카드의 수)/남은 카드의 수 
			System.out.println();
			System.out.println("다음 뽑기에서 BlackJack이 될 확률은 " + prob + "입니다."); //블랙잭이 될 확률 출력

		}

		public void addCard(String s) {
			mycard.add(s);
		} //카드를 추가해준다.

		public String getUserName() {
			return userName;
		} //userName을 반환한다.

		public String getCard(int n) {
			return card[n];
		} //card를 반환한다.
		
		public Vector getMycard() {
			return mycard;
		} //mycard를 반환한다.
	}

	public static void main(String[] args) throws Exception {
		blackjack game = new blackjack(); //메인 함수에서 블랙잭 실행
	}
}