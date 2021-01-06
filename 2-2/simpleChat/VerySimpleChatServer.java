package javaProject;
import java.io.*;
import java.net.*;
import java.util.*;


public class VerySimpleChatServer
{
    ArrayList clientOutputStreams;
    
    public class ClientHandler implements Runnable {
        BufferedReader reader;
        Socket sock;
        
        public ClientHandler(Socket clientSOcket) {
            try {
                sock = clientSOcket;
                InputStreamReader isReader = new InputStreamReader(sock.getInputStream()); //InputStreamReader를 이용하여 문자 스트림을 가져온다.
                reader = new BufferedReader(isReader); //BufferedReader를 이용하여 isReader를 가져온다.
                
            } catch (Exception ex) { ex.printStackTrace(); } //예외처리
        }
        
        public void run() {
            String message;
            try {
                while ((message = reader.readLine()) != null) { //더 이상 출력할것이 없을때까지
                    System.out.println("read " + message); //메세지를 출력한다.
                    tellEveryone(message);
                }
            } catch (Exception ex) { ex.printStackTrace(); } //예외처리
        }
    }
    
    public static void main(String[] args) {
        new VerySimpleChatServer().go();
    }
    
    public void go() {
        clientOutputStreams = new ArrayList();
        try {
            ServerSocket serverSock = new ServerSocket(5000); //서버를 생성한다.
            while(true) {
                Socket clientSocket = serverSock.accept(); //client 접속을 accept해준다.
                PrintWriter writer = new PrintWriter(clientSocket.getOutputStream()); //PrintWriter 객체를 선언해준다.
                clientOutputStreams.add(writer); //ArrayList에 writer를 추가해준다.
                
                Thread t = new Thread(new ClientHandler(clientSocket)); //스레드를 설정해준다.
                t.start(); //스레드를 실행해준다.
                System.out.println("got a connection");
            } //예외처리
        } catch (Exception ex) { ex.printStackTrace(); }
    }
    
    public void tellEveryone(String message) {
        Iterator it = clientOutputStreams.iterator(); //iterator를 설정한다.
        while (it.hasNext()) {
            try {
                PrintWriter writer = (PrintWriter) it.next(); //iterator를 증가시켜가며 실행한다.
                writer.println(message); //메세지를 출력한다.
                writer.flush(); //현재 버퍼에 저장되어 있는 내용을 클라이언트로 전송하고 버퍼를 비운다.
            } catch (Exception ex) { ex.printStackTrace(); }  //예외처리
        }
    }
}