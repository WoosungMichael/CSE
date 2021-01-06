package java_Week5;

import java.util.*;

public class dotComGame {
	public static int numRows = 10;
	public static int numCols = 10; //map의 행과 열을 10으로 설정한다.
	public static int computerComs; //남은com의 갯수
	public static int computerComs_prior; //com의 초기 갯수
	public static int com_x[]; //닷컴의 시작 x좌표의 배열
	public static int com_y[]; //닷컴의 시작 y좌표의 배열
	public static String[][] grid = new String[numRows][numCols]; //grid를 동적배열로 선언한다.
	public static int trial = 0; //시행 횟수

	public static void main(String[] args) {
		System.out.println("**** Welcome to dotComGame ****");

		createMap(); //map 생성

		deployComs(); //닷컴 생성

		System.out.println("닷컴이 총 " + dotComGame.computerComs + "개가 생성되었습니다.");
		
		do {
			playerTurn();
		} while (dotComGame.computerComs != 0); //모두 hit할때까지 반복한다.

	}

	public static void createMap() { //map을 초기화해주고 출력해준다.
		
		System.out.print("  ");
		for (int i = 0; i < numCols; i++)
			System.out.print(i);
		System.out.println();

		for (int i = 0; i < grid.length; i++) {
			for (int j = 0; j < grid[i].length; j++) {
				grid[i][j] = " ";
				if (j == 0)
					System.out.print(((char) ((int) 'a' + i)) + "|" + grid[i][j]);
				else if (j == grid[i].length - 1)
					System.out.print(grid[i][j] + "|" + ((char) ((int) 'a' + i)));
				else
					System.out.print(grid[i][j]);
			}
			System.out.println();
		}

		System.out.print("  ");
		for (int i = 0; i < numCols; i++)
			System.out.print(i);
		System.out.println();
	}

	public static void deployComs() {
		System.out.println("\nComputer is deploying Coms");
		
		dotComGame.computerComs = (int) (Math.random() * 3 + 3); //Math.random()을 이용해 총 닷컴의 갯수를 정해준다.
		dotComGame.computerComs_prior=dotComGame.computerComs; //초기의 닷컴 갯수를 저장해준다.
		com_x=new int[dotComGame.computerComs];
		com_y=new int[dotComGame.computerComs]; //닷컴이 생성된 갯수의 크기로 배열을 만든다.
		
		for (int i = 0; i < dotComGame.computerComs; i++) {
			int x = (int) (Math.random() * (numRows - 1));
			int y = (int) (Math.random() * (numCols - 1)); //닷컴의 시작 좌표(가장 작은 인덱스)를 랜덤으로 생성한다.
			
			com_x[i]=x;
			com_y[i]=y; //이를 각각의 배열에 순서대로 저장한다.
			
			if ((x >= 0 && x < numRows) && (y >= 0 && y < numCols) && (grid[x][y] == " ") && (grid[x + 1][y] == " ")
					&& (grid[x][y + 1] == " ") && (grid[x + 1][y + 1] == " ")) {
				grid[x][y] = "x";
				grid[x + 1][y] = "x";
				grid[x][y + 1] = "x";
				grid[x + 1][y + 1] = "x";
			} //중복이 아니라면 닷컴을 저장해준다.
			else{
				i--;
			} //중복이 생긴다면 다시 실행한다.
		}

		System.out.println("Coms DEPLOYED");
	}

	public static void playerTurn() {
		System.out.println("\nYOUR TURN");
		char x_c = 'z';
		int x;
		int y = -1;
		
		if (trial < 70) {
			Scanner input = new Scanner(System.in);
			System.out.print("X 좌표: ");
			x_c = input.next().charAt(0); //x좌표를 입력받는다.
			System.out.print("Y 좌표: ");
			y = input.nextInt(); //y좌표를 입력받는다.

			trial++; //시행을 1 더해준다.

			x = (int) x_c - (int) ('a'); //입력받은 알파벳을 배열에서 사용할 숫자로 바꿔준다.

			if ((x >= 0 && x < numRows) && (y >= 0 && y < numCols)) //정상적인 입력인 경우
			{
				if (grid[x][y] == "x")
				{
					System.out.println("hit");
					int comBefore = dotComGame.computerComs; //방금 입력한 좌표가 성공하기전의 남은 닷컴갯수를 저장한다.
					grid[x][y] = "o"; //입력한 좌표의 값을 바꿔준다.
					checkHit(comBefore); //kill여부를 확인한다.

				} else if (grid[x][y] == " ") { //hit에 실패한 경우
					System.out.println("miss");
					grid[x][y] = " ";
				} 
			} else if ((x < 0 || x >= numRows) || (y < 0 || y >= numCols)) //비정상적인 입력인 경우
				System.out.println("맵 사이즈를 초과한 입력입니다.");
		} else{ //주어진 횟수안에 성공하지 못한 경우
			System.out.println("Failure");
			System.out.println("주어진 횟수안에 성공하지 못했습니다.");
			dotComGame.computerComs = 0;
		}
	}

	public static void checkHit(int comBefore) { //kill여부를 확인한다.
		int comHit = 0;
		
		for(int i=0;i<dotComGame.computerComs_prior;i++) {
			if ((grid[com_x[i]][com_y[i]] == "o") && (grid[com_x[i] + 1][com_y[i]] == "o") && (grid[com_x[i]][com_y[i] + 1] == "o")
					&& (grid[com_x[i] + 1][com_y[i] + 1] == "o")) {
				comHit++;
			}
		} //kill된 닷컴의 갯수
		if ((dotComGame.computerComs_prior-comHit) != comBefore) { //kill한 경우
			--dotComGame.computerComs;
			System.out.println("kill!");
			System.out.println(dotComGame.computerComs + "coms remaining!");
		}
	}

}