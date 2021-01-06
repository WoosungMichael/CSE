package javaProject;

import java.io.*;
import java.net.*;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class SimpleChatClient implements ActionListener, WindowListener //ActionListener, WindowListener 인터페이스를 구현
{
    JTextArea incoming;
    JTextField outgoing;
    BufferedReader reader;
    PrintWriter writer;
    Socket sock;
    
    JFrame frame;
    
    JFrame frame_ID;
    JLabel label;
    JTextField field;
    JButton button;
    String ID;
    
    public void go() {
        frame = new JFrame("Ludicrously Simple Chat Client"); //""안의 부분을 타이틀로 가지는 프레임을 만든다.
        JPanel mainPanel = new JPanel(); //Jpanel을 이용하여 보조 프레임(페널)을 만든다.
        incoming = new JTextArea(15, 50);
        incoming.setLineWrap(true);
        incoming.setWrapStyleWord(true);
        incoming.setEditable(false); //JTextArea를 설정해준다.
        JScrollPane qScroller = new JScrollPane(incoming); //incoming을 담은 JScrollPane을 생성해준다.
        qScroller.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
        qScroller.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
        outgoing = new JTextField(20); //한줄의 문자열을 입력받는 창을 만들어준다.
        JButton sendButton = new JButton("Send"); //send라는 버튼을 만들어준다.
        sendButton.addActionListener(new SendButtonListener()); //이벤트를 받아들인 컴포넌트 객체에 리스너 등록
        mainPanel.add(qScroller); //mainPanel에 qScoller를 추가해준다.
        mainPanel.add(outgoing); //mainPanel에 JTextField를 추가해준다.
        mainPanel.add(sendButton); //mainPanel에 sendButton을 추가해준다.
        frame.getContentPane().add(BorderLayout.CENTER, mainPanel); //프레임에 연결된 컨텐트팬에 mainPanel을 추가해준다.
        setUpNetworking();
        
        Thread readerThread = new Thread(new IncomingReader()); //Thread를 생성해준다.
        readerThread.start(); //Thread를 시작한다.
        
        frame.setSize(650, 500); //프레임의 사이즈를 설정해준다.
        frame.setVisible(false); //프레임이 보이지 않도록 설정한다.
    
        frame.addWindowListener(this); //frame에 대해 WindowListener를 연결해준다.
        
        
        
        frame_ID = new JFrame("Making ID"); //JFrame을 생성해준다.
        JPanel panel_ID = new JPanel(); //JPanel을 생성해준다.
        panel_ID.setLayout(null); //panel의 기본 레이아웃을 설정해준다.
        
        label=new JLabel();
		label.setText("채팅방 입장시 사용할 ID를 생성하세요."); //JLabel를 생성해주고 text를 정해준다.
		
		field = new JTextField("userID"); //JTextField를 만들어준다.
		button = new JButton("ID생성"); //JButton을 만들어준다.
		button.addActionListener(this); //button에 ActionListener를 연결해준다.
		
		panel_ID.add(label);
		panel_ID.add(field);
		panel_ID.add(button); //panel_ID에 요소들을 추가해준다.
		
		label.setBounds(100,40,300,30);
		field.setBounds(130,80,140,25);
		button.setBounds(140,150,120,25); //각 요소들의 위치를 정해준다.
        
		frame_ID.add(panel_ID); //frame에 panel을 추가해준다.
		frame_ID.setSize(400, 300); //frame의 크기를 정해준다.
		frame_ID.setVisible(true); //setVisible을 true로 해준다.
		
		frame_ID.addWindowListener(this); //frame_ID에 대해 WindowListener를 연결해준다.
	      
    }
    
    private void setUpNetworking() {
        try {
            sock = new Socket("127.0.0.1", 5000); //소켓 설정
            InputStreamReader streamReader = new InputStreamReader(sock.getInputStream());
            reader = new BufferedReader(streamReader);
            writer = new PrintWriter(sock.getOutputStream());
            System.out.println("networking established");
    		
        }
        catch(IOException ex) //예외처리
        {
            ex.printStackTrace();
        }
    }
    
    public class SendButtonListener implements ActionListener {
        public void actionPerformed(ActionEvent ev) {
            try {
            	SimpleDateFormat format=new SimpleDateFormat("HH:mm"); //출력할 포맷을 설정한다.
            	Date time=new Date(); //Date()를 이용하여 현재시간을 받아온다.
            	String time1=format.format(time); //현재시간을 형식에 맞게 저장한다.
            	writer.print("[" + time1 + "]" +" "+ID+ " : ");
                writer.println(outgoing.getText()); //outgoing 부분을 출력해준다.
                writer.flush(); //현재 버퍼에 저장되어 있는 내용을 클라이언트로 전송하고 버퍼를 비운다.
                
            }
            catch (Exception ex) { //예외처리
                ex.printStackTrace();
            }
            outgoing.setText(""); //outgoing부분을 초기화해준다.
            outgoing.requestFocus(); //강제로 focus를 준다.
        }
    }
    
    public static void main(String[] args) {
        new SimpleChatClient().go();
    }
    
    class IncomingReader implements Runnable {
        public void run() {
            String message;
            try { 
                while ((message = reader.readLine()) != null) { //message가 null이 되기 전까지
                    System.out.println("client read " + message);
                    incoming.append(message + "\n");
                }
            } catch (IOException ex) //예외처리
            {
                ex.printStackTrace();
            }
        }
    }
    
    public void actionPerformed(ActionEvent ev) { //입력창에 사용할 ID를 입력하면 
    	frame.setVisible(true); //채팅창을 띄워준다.
    	ID=field.getText(); //ID입력창에 입력한 text를 ID에 저장한다.
    	writer.println("********************<"+ID+"님이 입장했습니다."+">********************");
    	writer.flush(); //현재 버퍼에 저장되어 있는 내용을 클라이언트로 전송하고 버퍼를 비운다.
    	frame_ID.dispose(); //ID입력창을 닫는다.
	}
    
    public void windowClosing(WindowEvent e) {
    	if(ID!=null) { //ID가 null이 아닌 경우
    	writer.println("********************<"+ID+"님이 퇴장했습니다."+">********************");
        writer.flush(); //현재 버퍼에 저장되어 있는 내용을 클라이언트로 전송하고 버퍼를 비운다.
    	}
        frame.dispose(); //ID가 null이면 frame도 닫아준다.
	}

    @Override
	public void windowOpened(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowClosed(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowIconified(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowDeiconified(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowActivated(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowDeactivated(WindowEvent e) {
		// TODO Auto-generated method stub
		
	}
    
	
}