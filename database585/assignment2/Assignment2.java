package assignment2;

import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.Label;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.JTable;
import java.util.*;


class LoginPanel extends JPanel{
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	JTextField username;
	JPasswordField password;
	JButton login;
	JButton signup;
	private String UserName;

	public void disablePanel(){
		if(this.getComponentCount()==0)
			return ;
		Component[] comps= new Component[this.getComponentCount()];
		comps = this.getComponents();
		for(int i=0;i<comps.length;i++){
				comps[i].disable();
		}
	}

	public void enablePanel(){
		if(this.getComponentCount()==0)
			return ;
		Component[] comps= new Component[this.getComponentCount()];
		comps = this.getComponents();
		for(int i=0;i<comps.length;i++){
				comps[i].enable();
		}
	}

	LoginPanel(){
		this.setBounds(810, 30, 250, 100);
		this.setLayout(new GridLayout(3,2));
		this.add(new Label("UserName: "));
		username = new JTextField();
        this.add(username);
		this.add(new Label("Password: "));
		password = new JPasswordField();
        this.add(password);
        login = new JButton("Login");
        signup = new JButton("Signup");
        this.add(login);
        this.add(signup);
	}
	public String getUserName(){
		return UserName;
	}
	public void setUserName(String user){
		UserName=user;
	}
}

class SignupPanel extends JPanel{
    /**
	 *
	 */
	private static final long serialVersionUID = 1L;
	JButton login;
	JButton signup;
	JPasswordField password;
	JPasswordField password2;

	JTextField country;
	JTextField state;
	JTextField city;
	JTextField email;
	JTextField birthday;
	JTextField fname;
	JTextField lname;
	JTextField str_no;
	JTextField str_address;
	JTextField zip;

	public void disablePanel(){
		if(this.getComponentCount()==0)
			return ;
		Component[] comps= new Component[this.getComponentCount()];
		comps = this.getComponents();
		for(int i=0;i<comps.length;i++){
				comps[i].disable();
		}
		disableButton();
	}

	public void enablePanel(){
		if(this.getComponentCount()==0)
			return ;
		Component[] comps= new Component[this.getComponentCount()];
		comps = this.getComponents();
		for(int i=0;i<comps.length;i++){
				comps[i].enable();
		}
		enableButton();
	}

	SignupPanel(){
		this.setBounds(810, 150, 250, 300);
		this.setLayout(new GridLayout(11,2));
		this.add(new Label("Email: "));
		email = new JTextField();
        this.add(email);
		this.add(new Label("Password: "));
		password = new JPasswordField();
        this.add(password);
		this.add(new Label("ReEnter Password: "));
		password2 = new JPasswordField();
        this.add(password2);
		this.add(new Label("First Name: "));
		fname = new JTextField();
        this.add(fname);
		this.add(new Label("Last Name: "));
		lname = new JTextField();
        this.add(lname);
		this.add(new Label("City: "));
		city = new JTextField();
        this.add(city);
		this.add(new Label("Birthday : "));
		birthday = new JTextField();
        this.add(birthday);
		this.add(new Label("strNo : "));
		str_no = new JTextField();
        this.add(str_no);
		this.add(new Label("strAdress : "));
		str_address = new JTextField();
        this.add(str_address);
        this.add(new Label("Zip : "));
		zip = new JTextField();
        this.add(zip);
        this.add(new Label(""));
        signup = new JButton("signup");
        this.add(signup);
        disablePanel();
	}

	public void disableButton(){
		signup.setEnabled(false);
	}
	public void enableButton(){
		signup.setEnabled(true);
	}
}

class SqlPanel extends JPanel{
    /**
	 *
	 */
	private static final long serialVersionUID = 1L;
	JTextArea SQLArea = null;
	JScrollPane scrollPane = null;
	JLabel showLabel;
	SqlPanel(){
		setInputArea();
	}

	public void disablePanel(){
		if(this.getComponentCount()==0)
			return ;
		Component[] comps= new Component[this.getComponentCount()];
		comps = this.getComponents();
		for(int i=0;i<comps.length;i++){
				comps[i].disable();
		}
	}

	public void enablePanel(){
		if(this.getComponentCount()==0)
			return ;
		Component[] comps= new Component[this.getComponentCount()];
		comps = this.getComponents();
		for(int i=0;i<comps.length;i++){
				comps[i].enable();
		}
	}

	private void setInputArea(){
		setBounds(0, 495,810, 150);
		SQLArea = new JTextArea(6,68);
		SQLArea.setLineWrap(true);
		scrollPane = new JScrollPane(SQLArea);
		this.add(scrollPane);
	}
}

class Frame0 extends JFrame{//add friend..
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	JTextField txtfield;
	JButton btn1;
	String lbltext;
	JLabel label;
	String FriendType[] = { "Regular Friend", "Close Friend", "Family" };
        String plevel[]={"Only sender Can see","Only friends","Public"};
	JComboBox combo;

	Frame0(String text,int mode){
		this.lbltext = text;
		 this.setSize(300, 120);
		 this.setResizable(false);
		setLayout(new FlowLayout());
		int width=Toolkit.getDefaultToolkit().getScreenSize().width;
		int height=Toolkit.getDefaultToolkit().getScreenSize().height;
		setLocation((width-this.getWidth())/2,(height-this.getHeight())/2);
		label = new JLabel(text);
		add(label);
		txtfield = new JTextField(10);
        add(txtfield);
        
        if(mode==1)
                {combo= new JComboBox(plevel);
        	add(combo);
                }
        else if (mode==2)
                {combo= new JComboBox(FriendType);
                add(combo);
                }
       
        
        btn1 = new JButton("OK");
        add(btn1);

	}
}

class Frame1 extends JFrame {//comments on post
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	JTextField txtfield;
	JButton btn1;
	JButton btn2;
	String lbltext0;
	String lbltext1;
	JLabel lbl0;
	JLabel lbl1;
	JTextArea textArea = null;

	Frame1(String text0, String text1) {
		this.lbltext0 = text0;
		this.lbltext1 = text1;
		this.setResizable(false);
		setLayout(null);
		 this.setSize(300, 256);
		int width=Toolkit.getDefaultToolkit().getScreenSize().width;
		int height=Toolkit.getDefaultToolkit().getScreenSize().height;
		setLocation((width-this.getWidth())/2,(height-this.getHeight())/2);
		lbl0 = new JLabel(text0);
		add(lbl0);
		lbl0.setBounds(10, 10, 70, 30);

		txtfield = new JTextField(10);
		add(txtfield);
		txtfield.setBounds(85, 10, 150, 30);

		lbl1 = new JLabel(text1);
		add(lbl1);
		lbl1.setBounds(10, 45, 70, 30);

		textArea = new JTextArea(8, 10);
		textArea.setLineWrap(true);
		JScrollPane scrollPane = new JScrollPane(textArea);
		this.add(scrollPane);
		scrollPane.setBounds(85,55,180,90);

		btn1 = new JButton("OK");
		btn1.setBounds(90,165,90, 30);
		add(btn1);

	}
}


class Frame2 extends JFrame {//accept/decline requests
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	JTextField txtfield;
	JButton btn1;
	JButton btn2;
	String lbltext0;
	JLabel lbl0;

	Frame2(String text0) {
		this.setResizable(false);
		this.lbltext0 = text0;
        this.setSize(300, 150);
        this.setResizable(false);
		setLayout(null);

		int width=Toolkit.getDefaultToolkit().getScreenSize().width;
		int height=Toolkit.getDefaultToolkit().getScreenSize().height;
		setLocation((width-this.getWidth())/2,(height-this.getHeight())/2);
		lbl0 = new JLabel(text0);
		add(lbl0);
		lbl0.setBounds(10, 10, 70, 30);

		txtfield = new JTextField(10);
		add(txtfield);
		txtfield.setBounds(85, 10, 100, 30);

		btn1 = new JButton("Decline");
		btn2 = new JButton("Accept ALL");

		btn1.setBounds(190,10,90, 30);
		btn2.setBounds(70,60,150, 30);
		add(btn1);
		add(btn2);

	}
}


class Frame3 extends JFrame {//for search using cordinates
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	JTextField []txtfield;
	JButton btn1;
	JLabel []lbl;
	Frame3(String text0) {
		this.setResizable(false);
		this.setTitle(text0);
        this.setSize(1000, 70);
        this.setResizable(false);
		setLayout(new GridLayout(1,9));

		int width=Toolkit.getDefaultToolkit().getScreenSize().width;
		int height=Toolkit.getDefaultToolkit().getScreenSize().height;
		setLocation((width-this.getWidth())/2,(height-this.getHeight())/2);
		lbl = new JLabel[4];
		for(int i=0;i<4;i++)
			lbl[i] = new JLabel();
		lbl[0].setText("topleft x:");
		lbl[1].setText("topleft y:");
		lbl[2].setText("bottomright x:");
		lbl[3].setText("bottomright y:");

		txtfield = new JTextField[4];
		for(int i=0;i<4;i++)
			txtfield[i] = new JTextField();

		btn1 = new JButton("search");
		for(int i=0;i<4;i++)
		{
			add(lbl[i]);
			add(txtfield[i]);
		}
		add(btn1);
	}
}


class PostandSearchPanel extends JPanel{
    /**
	 *
	 */
	private static final long serialVersionUID = 1L;
	JTextArea textArea = null;//posts TA
	JScrollPane scrollPane = null;

	JTextField text;
	JLabel showLabel;
	JButton []buttons;
     
	public void disableButton(){
		for(int i=0;i<buttons.length;i++)
			buttons[i].setEnabled(false);
	}

	public void enableButton(){
		for(int i=0;i<buttons.length;i++)
			buttons[i].setEnabled(true);
	}

	PostandSearchPanel(){
		setLayout(null);
                setInputArea();
		this.setBounds(0, 10,780, 120);                              
		buttons = new JButton[2];
		buttons[0]= new JButton("Post");
		buttons[1]= new JButton("Search For Friend");

		text  = new JTextField(15);
		text.setLocation(10,3);
                text.setText("");
		text.setBounds(460, 40, 150, 25);
		buttons[0].setBounds(380,40,60,25);
		buttons[1].setBounds(620,40,130,25);

		
		this.add(buttons[0]);
		this.add(text);
		this.add(buttons[1]);        
	}
	public void disablePanel(){
		if(this.getComponentCount()==0)
			return ;
		Component[] comps= new Component[this.getComponentCount()];
		comps = this.getComponents();
		for(int i=0;i<comps.length;i++){
				comps[i].disable();
		}
		disableButton();
	}

	public void clearPanel(){
		text.setText("");
	    textArea.setText("");
	}

	public  void enablePanel(){
		if(this.getComponentCount()==0)
			return ;
		Component[] comps= new Component[this.getComponentCount()];
		comps = this.getComponents();
		for(int i=0;i<comps.length;i++){
				comps[i].enable();
		}
		enableButton();
	}

	public void setInputArea(){
		textArea = new JTextArea(4,29);
		textArea.setLineWrap(true);
		textArea.setBounds(10, 10, 360, 90);
		this.add(textArea);
	}
 }

class ResultPanel extends JPanel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	JTextArea resultArea = null;
	JScrollPane scrollPane = null;
	ResultPanel(){
		setResultArea();
	}

	public void setResultArea(){
		/*resultArea = new JTextArea(10,30);  
		resultArea.setLineWrap(true);
		resultArea.setBounds(10, 140,750, 250);
		scrollPane = new JScrollPane(resultArea);
		add(scrollPane);*/

	}
}

class ButtonPanel extends JPanel{
    /**
	 *
	 */
	private static final long serialVersionUID = 1L;
	JTextArea textArea = null;
	JScrollPane scrollPane = null;
	JLabel showLabel;
	JButton []buttons;

	ButtonPanel(){
	  this.setBounds(10, 415, 770, 40);
	 	buttons = new JButton[8];
		this.setLayout(new GridLayout(2,4));
        for(int i=0;i<8;i++){
        	buttons[i]= new JButton();
        	this.add(buttons[i]);
        }
        buttons[0].setText("Add Friend");
        buttons[1].setText("List all posts");
        buttons[2].setText("List all comments on a post");
        buttons[3].setText("Comment on A post");
        buttons[4].setText("List all events");
        buttons[5].setText("Friend request");   
        buttons[6].setText("Find nearest friend");
        buttons[7].setText("Range query");

	}

	public void disableButton(){
		for(int i=0;i<buttons.length;i++)
			buttons[i].setEnabled(false);
	}

	public void enableButton(){
		for(int i=0;i<buttons.length;i++)
			buttons[i].setEnabled(true);
	}

	public void disablePanel(){
		if(this.getComponentCount()==0)
			return ;
		Component[] comps= new Component[this.getComponentCount()];
		comps = this.getComponents();
		for(int i=0;i<comps.length;i++){
				comps[i].disable();
		}
		disableButton();
	}

	public void enablePanel(){
		if(this.getComponentCount()==0)
			return ;
		Component[] comps= new Component[this.getComponentCount()];
		comps = this.getComponents();
		for(int i=0;i<comps.length;i++){
			comps[i].enable();
		}
		enableButton();
	}
}


class MainFrame extends JFrame{
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	JLabel LogoLabel;
	JButton notifyButton;
	LoginPanel loginPanel;
	SignupPanel signUpPanel;
	SqlPanel sqlPanel;
	ButtonPanel buttonPanel;
	PostandSearchPanel postandsearch;
	ResultPanel resultPanel;
	Connection conn=null;       
	ArrayList<String> requester = new ArrayList<String>();
	ArrayList<String> Relation= new ArrayList<String>();
	int countrequest=0;
	JTextArea resultArea = null;
	JScrollPane scrollPane = null;
	int trigger = 0;
	JLabel showLabel;
	int hasRequest = 0; 
        JTable jtab;
	StringBuffer SQLOut = new StringBuffer ();
	MainFrame(){                
		setResizable(false);
		setLayout(null);
		setSize(1100, 700);
		int width=Toolkit.getDefaultToolkit().getScreenSize().width;
		int height=Toolkit.getDefaultToolkit().getScreenSize().height;
		setLocation((width-1100)/2,(height-700)/2);
		setTitle("This is GUI for database homework");
		setNotifyLabel();                
		SetLogo();
		setLoginPanel();
		setSignupPanel();
		setSqlPanel();
		setButtonPanel();
		setPostandSearchPanel();
		setResultPanel();
		postandsearch.disablePanel();
		buttonPanel.disablePanel();                                
                //checkNotifyHide();
	}

	public void disableResult(){
    	resultArea.setText("");
    	resultArea.setEditable(false);
    	resultArea.setEnabled(false);
    	scrollPane.setEnabled(false);
	}

	public void setResultPanel(){
		resultArea = new JTextArea(10,60);               
		resultArea.setLineWrap(true);               
		scrollPane = new JScrollPane(resultArea);
                scrollPane.setBounds(10, 140,750, 240);                
                add(scrollPane);
                resultArea.setEnabled(true);
                resultArea.setEditable(false);
	}
        
        public void setSQLArea()
            {sqlPanel.SQLArea.setText("");}
        public void clearAll() //when u preass any button...post and search panel should be empty..
            {postandsearch.text.setText("");
            postandsearch.textArea.setText("");
            }
	public void SetLogo(){
	Image image;
	try {
		image = ImageIO.read(new File("C:\\monil computer\\fall2013\\csci585db systems\\assignments\\Assignment2\\Assignment2\\Assignment2\\src\\assignment2\\usc_viterbi_logo.jpg"));
		ImageIcon icon = new ImageIcon(image);
		LogoLabel = new JLabel();
		LogoLabel.setIcon(icon);
		LogoLabel.setBounds(830,480,300,150);
		add(LogoLabel);
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}  //this generates an image file

	}

	public void setNotifyLabel(){
		Image image;                          
		try {
                    image = ImageIO.read(new File("C:\\monil computer\\fall2013\\csci585db systems\\assignments\\Assignment2\\Assignment2\\Assignment2\\src\\assignment2\\notify.png"));                                                	
                    ImageIcon icon = new ImageIcon(image);
                    notifyButton = new JButton();                       
                    notifyButton.setIcon(icon);			
                    notifyButton.setBounds(781,4,25,25); 
                    add(notifyButton);                      
                    notifyButton.setEnabled(true);
                    notifyButton.setVisible(false);                        
                    notifyButton.addActionListener(new ActionListener() {                                              
	            public void actionPerformed(ActionEvent e) {
	            	/*Fill this function*/
	            	/*Press this notification button, you should list all the friend request on the ResultPanel*/
	            	/*the output format is like "... wants to add you as 'friend type'." */
                        try
                            {ConnectDB.openConnection();
                            sqlPanel.SQLArea.setText("");
                            ResultSet rs=ConnectDB.st.executeQuery("select sender,ftype from request where receiver='"+loginPanel.username.getText()+"'");
                            sqlPanel.SQLArea.append("select sender,ftype from request where receiver='"+loginPanel.username.getText()+"' \n");
                            //setResultPanel();
                            resultArea.setText("");
                           if (rs.next())
                           {        do
                                    {resultArea.append(rs.getString(1)+" wants to add you as '"+rs.getString(2)+"' \n");
                                    }while (rs.next());
                            //add(notifyButton);                                   
                            //notifyButton.setVisible(true);  
                            //getContentPane().repaint();
                           }
                           else
                            {notifyButton.setVisible(false);  
                            getContentPane().repaint();
                            }
                            ConnectDB.closeConnection(conn);                                                                                    
                            }
                        catch (Exception logo)
                            {System.out.println("Error"+logo);
                            }
                            
	            }
	        });			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  //this generates an image file


	}

        public void checkNotifyHide()
            {
                try
                {ConnectDB.openConnection();
                ResultSet rs=ConnectDB.st.executeQuery("select * from request where receiver='"+loginPanel.username.getText()+"'");                
                sqlPanel.SQLArea.append("select * from request where receiver='"+loginPanel.username.getText()+"' \n");                
                //System.out.println(rs.getRow()+" getRow brfore ");
                if (rs.next()==false)
                    {                    
                    notifyButton.setVisible(false);                    
                    getContentPane().repaint();                
                    }
                rs.close();
                }                
            catch(Exception notifyl)
                {System.out.println("Error: "+notifyl);
                }   
                ConnectDB.closeConnection(conn);
                
            }
	public void setButtonPanel(){
		buttonPanel = new ButtonPanel();
		this.add(buttonPanel);

		buttonPanel.buttons[0].addActionListener(new ActionListener() {
           
            public void actionPerformed(ActionEvent e) {               
            	final Frame0 frame=new Frame0("User Email",2);//2== freindship type..i have changed 1 to plevel
                frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
                frame.setVisible(true);                  
                //setResultPanel();
                resultArea.setText("");
                clearAll();
                sqlPanel.SQLArea.setText("");
                frame.btn1.addActionListener(new ActionListener() {     
                        public void actionPerformed(ActionEvent e) {
                    	/*Fill this function*/
    	            	/*Press this add friend button, input user Email information, press OK, you should be able to send friend request*/
    	            	/*After press ok, you should also pop up a standard dialog box to show the request send status <succeed or failed>*/
                        String femail=frame.txtfield.getText();
                        if (femail.length()==0)
                            JOptionPane.showMessageDialog(null,"Please enter Email address of friend","Add Friend Error",JOptionPane.ERROR_MESSAGE);                                                                     
                        else if (femail.equals(loginPanel.username.getText()))
                            JOptionPane.showMessageDialog(null,"You cannot send request to yourself.","Add Friend Error",JOptionPane.ERROR_MESSAGE);                                                                     
                        else
                            {try
                                {ConnectDB.openConnection();
                                ResultSet rs=ConnectDB.st.executeQuery("select email from member1 where email='"+femail+"'");
                                sqlPanel.SQLArea.append("select email from member1 where email='"+femail+"' \n");
                                if (rs.next()==false)
                                    {JOptionPane.showMessageDialog(null,"No such member in our System","Add Friend Error",JOptionPane.ERROR_MESSAGE);
                                    }
                                else
                                    {rs.close();
                                    ConnectDB.closeConnection(conn);
                                    ConnectDB.openConnection();
                                    rs=ConnectDB.st.executeQuery("select * from friendship where email1='"+loginPanel.username.getText()+"' and email2='"+femail+"'");                                                                
                                    sqlPanel.SQLArea.append("select * from friendship where email1='"+loginPanel.username.getText()+"' and email2='"+femail+"' \n");                                    
                                    if (rs.next())
                                        {JOptionPane.showMessageDialog(null,"This member is already your Friend. \n Friend request cannot be sent.","Add Friend Error",JOptionPane.ERROR_MESSAGE);
                                        frame.setVisible(false);
                                        }
                                    else
                                        {rs.close();
                                        ConnectDB.closeConnection(conn);
                                        ConnectDB.openConnection();//Delancy Dessaints prince
                                        int freq=ConnectDB.st.executeUpdate("insert into request values('"+loginPanel.username.getText()+"','"+frame.txtfield.getText()+"','Pending','"+frame.FriendType[frame.combo.getSelectedIndex()]+"')");
                                        JOptionPane.showMessageDialog(null,"Friend Request sent successfully to "+frame.txtfield.getText(),"Add Friend Success",JOptionPane.INFORMATION_MESSAGE);                                                                     
                                        sqlPanel.SQLArea.append("insert into request values('"+loginPanel.username.getText()+"','"+frame.txtfield.getText()+"','Pending','"+frame.FriendType[frame.combo.getSelectedIndex()]+"') \n");
                                        frame.setVisible(false);
                                        postandsearch.textArea.setText("");
                                        }
                                    }                                                                                                                                                                
                                }
                            catch (Exception adde)
                                {System.out.println("Error"+adde);
                                JOptionPane.showMessageDialog(null,"Friend request already sent","Add Friend Error",JOptionPane.ERROR_MESSAGE);
                                frame.txtfield.setText("");
                                }
                            }
                        ConnectDB.closeConnection(conn);
                        }//acp for button of frame                    
                        });//listener for button of frame
                }//acp for button on main

            });//listener for main button
        
		buttonPanel.buttons[1].addActionListener(new ActionListener() {
          
            public void actionPerformed(ActionEvent e) {
            	/*Fill this function*/
            	/*Press this list all post button, you should be able to list all the post which are visible to you*/
            	/*You can define the output format*/
                disableResult();
                //setResultPanel();
                resultArea.setText("");
                sqlPanel.SQLArea.setText("");
                clearAll();
                ResultSet rs;
                String query="select * from post where post_id in (select a.post_id from\n" +
                            "(\n" +
                            "select post_id from post\n" +
                            "where sender='"+loginPanel.username.getText()+"' and privacy='0') a\n" +
                            "union \n" +
                            "(select post_id\n" +
                            "from post\n" +
                            "where privacy='2'\n" +
                            ")\n" +
                            "union\n" +
                            "(select post_id from post\n" +
                            "where sender='"+loginPanel.username.getText()+"'\n" +
                            ")\n" +
                            "union\n" +
                            "(select post_id  from post\n" +
                            "where privacy=1 and sender in\n" +
                            "                            (select b.email1 --these are all angelinas friend\n" +
                            "                            from\n" +
                            "                            (select email1 from friendship where email2='"+loginPanel.username.getText()+"') b union (select email2 from friendship where email1='"+loginPanel.username.getText()+"'))\n" +
                            "\n" +
                            "))";
                try
                    {ConnectDB.openConnection();                    
                    rs=ConnectDB.st.executeQuery(query);
                    sqlPanel.SQLArea.setText(query);
                    if (rs.next())
                        {rs.first();
                            do
                                {resultArea.append("Post #: "+rs.getString(1)+"\n Post Message: "+rs.getString(2)+"\n Sender: "+rs.getString(3)+"\n Privacy Level: "+rs.getString(4)+"\n Post Date:"+rs.getString(5).substring(0,10)+"\n");
                                resultArea.append("----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n");
                                }while(rs.next());
                         }                        
                    else
                        {JOptionPane.showMessageDialog(null,"Hi, "+loginPanel.username.getText()+ "you do not have any post to see.","Post Update",JOptionPane.INFORMATION_MESSAGE);
                        }
                    rs.close();
                    }
                catch(Exception poste)
                    {System.out.println("Error"+poste);
                    }
                
                ConnectDB.closeConnection(conn);
            }
        });

		buttonPanel.buttons[2].addActionListener(new ActionListener() {
          
            public void actionPerformed(ActionEvent e) {
            	final Frame0 frame=new Frame0("Post ID: ",3);
                frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
                frame.setVisible(true);
                //setResultPanel();
                resultArea.setText("");
                sqlPanel.SQLArea.setText("");  
                clearAll();
                frame.btn1.addActionListener(new ActionListener() {                 
                    public void actionPerformed(ActionEvent e) {
                    	/*Fill this function*/
    	            	/*Press this List Comments Button, input Post ID, press OK, you should be able to list all the comment about this post*/
                    String postno=frame.txtfield.getText();
                    postno=postno.trim();
                    int commentno=1;
                    String query="select pc.post_id,pc.text,maint.note,pc.email,pc.datetime\n" +
                                "from post_comment pc,\n" +
                                "(select post_id,note from post where post_id in \n" +
                                "(select a.post_id from\n" +
                                "(\n" +
                                "select post_id from post\n" +
                                "where sender='"+loginPanel.username.getText()+"' and privacy='0') a\n" +
                                "union \n" +
                                "(select post_id\n" +
                                "from post\n" +
                                "where privacy='2'\n" +
                                ")\n" +
                                "union\n" +
                                "(select post_id from post\n" +
                                "where sender='"+loginPanel.username.getText()+"'\n" +
                                ")\n" +
                                "union\n" +
                                "(select post_id  from post\n" +
                                "where privacy=1 and sender in\n" +
                                "                            (select b.email1 --these are all angelinas friend\n" +
                                "                            from\n" +
                                "                            (select email1 from friendship where email2='"+loginPanel.username.getText()+"') b union (select email2 from friendship where email1='"+loginPanel.username.getText()+"'))\n" +
                                "\n" +
                                "))) maint where maint.post_id=pc.post_id and pc.post_id='"+postno+"'";
                    if (postno.length()==0)
                        JOptionPane.showMessageDialog(null,"Please enter the post number.","Post Comment Error",JOptionPane.ERROR_MESSAGE);
                    else
                        {try
                            {ConnectDB.openConnection();
                            ResultSet rs=ConnectDB.st.executeQuery(query);
                            sqlPanel.SQLArea.setText(query);
                            if(rs.next())
                                {//rs.first();
                                resultArea.append("Post #: "+rs.getString(1)+" \t Post Note: "+rs.getString(3)+"\n");                                
                                resultArea.append("-----------------------------------------COMMENTS---------------------------------------------------------------\n");
                                do
                                    {resultArea.append("Comment #: "+commentno+"--"+rs.getString(2)+"   by   "+rs.getString(4)+"   on   "+rs.getString(5)+"\n");
                                    commentno++;
                                    }while(rs.next());                                
                                }
                            else
                                {JOptionPane.showMessageDialog(null,"No such post #: "+postno+" Available in system","Post Comment Info",JOptionPane.INFORMATION_MESSAGE);
                                }
                            }
                        catch(Exception postc)
                            {JOptionPane.showMessageDialog(null,"Invalid Post #: "+postno,"Post Comment Info",JOptionPane.INFORMATION_MESSAGE);
                            }
                        frame.setVisible(false);
                        }
                    }
                });
            }
        });
		
		buttonPanel.buttons[3].addActionListener(new ActionListener() {
           
            public void actionPerformed(ActionEvent e) {
            	final Frame1 frame=new Frame1("Post ID: ","Content: ");
                frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
                frame.setVisible(true);
                //setResultPanel();
                resultArea.setText("");
                sqlPanel.SQLArea.setText("");
                clearAll();
                frame.btn1.addActionListener(new ActionListener() {                                
                    public void actionPerformed(ActionEvent e) {
                    	/*Fill this function*/
    	            	/*Press this Comment Button, input Post ID, and comment, press OK, you should be able to comment on this post*/
                    	/*After press ok, you should also pop up a standard dialog box to show the comment's status <succeed or failed>*/	
                        String postno=frame.txtfield.getText();
                        String com=frame.textArea.getText();
                        postno=postno.trim();
                        com=com.trim();
                        Boolean permission=false;
                        int update;
                        String query="select post_id from post where post_id in \n" +
                                    "(select a.post_id from\n" +
                                    "(\n" +
                                    "select post_id from post\n" +
                                    "where sender='"+loginPanel.username.getText()+"' and privacy='0') a\n" +
                                    "union \n" +
                                    "(select post_id\n" +
                                    "from post\n" +
                                    "where privacy='2'\n" +
                                    ")\n" +
                                    "union\n" +
                                    "(select post_id from post\n" +
                                    "where sender='"+loginPanel.username.getText()+"'\n" +
                                    ")\n" +
                                    "union\n" +
                                    "(select post_id  from post\n" +
                                    "where privacy=1 and sender in\n" +
                                    "                            (select b.email1 --these are all angelinas friend\n" +
                                    "                            from\n" +
                                    "                            (select email1 from friendship where email2='"+loginPanel.username.getText()+"') b union (select email2 from friendship where email1='"+loginPanel.username.getText()+"'))\n" +
                                    "\n" +
                                    "))";
                        if (postno.length()==0 || com.length()==0)
                            JOptionPane.showMessageDialog(null,"Please enter information.","Commenting Error",JOptionPane.ERROR_MESSAGE);
                        else
                            {try
                                {ConnectDB.openConnection();
                                ResultSet rs=ConnectDB.st.executeQuery(query);
                                sqlPanel.SQLArea.append(query+"\n");
                                if(rs.next())
                                    {do
                                        {if (postno.equals(rs.getString(1)))
                                            {permission=true;
                                            }
                                        }while(rs.next());
                                    }
                                else
                                    {JOptionPane.showMessageDialog(null,"We could not find post #: "+postno+".\n Or The post # is invalid/ do not exists in system","Commenting Error",JOptionPane.INFORMATION_MESSAGE);
                                    }
                                if (permission)
                                    {update=ConnectDB.st.executeUpdate("insert into post_comment values('"+postno+"','"+com+"','"+loginPanel.username.getText()+"',(select sysdate from dual))");
                                    JOptionPane.showMessageDialog(null,"Your Comment has been successfully posted on post #."+postno,"Commenting Success",JOptionPane.INFORMATION_MESSAGE);
                                    sqlPanel.SQLArea.append("insert into post_comment values('"+postno+"','"+com+"','"+loginPanel.username.getText()+"',(select sysdate from dual))");
                                    }
                                else
                                    {JOptionPane.showMessageDialog(null,"You do not have permission to comment on post #:" +postno+".\n Or The post # is invalid/ do not exists in system","Commenting Error",JOptionPane.INFORMATION_MESSAGE);
                                    }
                                }
                            catch(Exception putcomm)
                                {System.out.println("Error "+putcomm);
                                }
                            frame.setVisible(false);
                            }
                    }
                });
            }
        });
		
		buttonPanel.buttons[4].addActionListener(new ActionListener() {
            
            public void actionPerformed(ActionEvent e) {
            	/*Fill this function*/
            	/*Press this List all event Button, you should be able to list all available event*/ 
                resultArea.setText("");
                setSQLArea();
                clearAll();
            	try
                    {ConnectDB.openConnection();
                    ResultSet rs=ConnectDB.st.executeQuery("select e.title,e.description,e.starttime,e.duration,a.street_no,a.street_address,a.city,a.state,a.zip,a.country from event e,address a where e.starttime >= (select sysdate from dual) and e.aid=a.aid");                                                            
                    sqlPanel.SQLArea.setText("select e.title,e.description,e.starttime,e.duration,a.street_no,a.street_address,a.city,a.state,a.zip,a.country from event e,address a where e.starttime >= (select sysdate from dual) and e.aid=a.aid");
                    if (rs.next())                        
                    {rs.first();
                            do
                            {resultArea.append("Event Name: "+rs.getString(1)+"\nEvent Info: "+rs.getString(2)+"\nStart Time:"+rs.getString(3).substring(0,10)+"\n Duration"+rs.getString(4)+"\n Street #: "+rs.getString(5)+"\n Street name: "+rs.getString(6)+"\n City:"+rs.getString(7)+"\n State:"+rs.getString(8)+"\n Zip:"+rs.getString(9)+"\n Country:"+rs.getString(10)+"\n");
                            resultArea.append("---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n");
                            }while (rs.next());
                    }
                    else
                        {JOptionPane.showMessageDialog(null,"No Current Events taking place","Event Info",JOptionPane.INFORMATION_MESSAGE);
                        }
                    }
                catch (Exception eventse)
                    {System.out.println("Error: "+eventse);
                    }
            }
        });

                
        

		buttonPanel.buttons[5].addActionListener(new ActionListener() {
           
        public void actionPerformed(ActionEvent e) {
            final Frame2 frame=new Frame2("Decline: ");
            frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
            frame.setVisible(true);
            //setNotifyLabel(); 
            sqlPanel.SQLArea.setText("");
            //resultPanel.resultArea.setText("");
            clearAll();
            frame.btn1.addActionListener(new ActionListener() {            
                public void actionPerformed(ActionEvent e) {
                	/*Fill this function*/
                	/*Press this decline Button, you should be able to decline friend request*/
                	/*You could decline one at a time, or decline many at a time. e.g. using comma to separate each request*/
                	/*pop up a standard dialog box to show <succeed or failed>*/
                	String dec=frame.txtfield.getText();
                        dec=dec.trim();
                        int update;
                        String successdec="";
                        ResultSet rs;
                        Boolean deleted=false;                        
                        if (dec.length()==0)
                            JOptionPane.showMessageDialog(null,"Please enter the Email ID","Decline Error",JOptionPane.ERROR_MESSAGE);
                        else
                            {try
                                {if (dec.indexOf(",")>0)
                                    {String[] reqdec=dec.split(",");                                    
                                    for (int i=0;i<reqdec.length;i++)
                                        reqdec[i]=reqdec[i].trim();                                        
                                    for(int i=0;i<reqdec.length;i++)
                                        {ConnectDB.openConnection();
                                        rs=ConnectDB.st.executeQuery("select * from request where sender='"+reqdec[i]+"' and receiver='"+loginPanel.username.getText()+"'");
                                        if (rs.next()==false)
                                            {JOptionPane.showMessageDialog(null,"Email ID:"+reqdec[i]+"not found in requests","Decline Error",JOptionPane.ERROR_MESSAGE);
                                            }
                                        else
                                            {update=ConnectDB.st.executeUpdate("delete from request where sender='"+reqdec[i]+"' and receiver='"+loginPanel.username.getText()+"'");                                            
                                            sqlPanel.SQLArea.append("delete from request where sender='"+reqdec[i]+"' and receiver='"+loginPanel.username.getText()+"' \n");
                                            deleted=true;
                                            successdec+=reqdec[i];
                                            successdec+=", ";
                                            }
                                        rs.close();
                                        ConnectDB.closeConnection(conn);
                                        }
                                    if (deleted)
                                        JOptionPane.showMessageDialog(null,"Below Email ID requests are deleted Successfully \n"+successdec,"Decline SUCCESS",JOptionPane.INFORMATION_MESSAGE);                                    
                                    frame.setVisible(false);
                                    }
                                else
                                    {ConnectDB.openConnection();
                                        sqlPanel.SQLArea.setText("");
                                        rs=ConnectDB.st.executeQuery("select * from request where sender='"+dec+"' and receiver='"+loginPanel.username.getText()+"'");
                                        sqlPanel.SQLArea.setText("select * from request where sender='"+dec+"' and receiver='"+loginPanel.username.getText()+"' \n");
                                        if (rs.next()==false)
                                            {JOptionPane.showMessageDialog(null,"Email ID:"+dec+"not found in requests","Decline Error",JOptionPane.ERROR_MESSAGE);
                                            }
                                        else
                                            {update=ConnectDB.st.executeUpdate("delete from request where sender='"+dec+"' and receiver='"+loginPanel.username.getText()+"'");                                           
                                            sqlPanel.SQLArea.append("delete from request where sender='"+dec+"' and receiver='"+loginPanel.username.getText()+"' \n");                                            
                                            JOptionPane.showMessageDialog(null,"Email ID"+dec+"'s requests is deleted Successfully","Decline SUCCESS",JOptionPane.INFORMATION_MESSAGE);                                        
                                            }
                                        rs.close();
                                        //checkNotifyHide();
                                        frame.setVisible(false);
                                        ConnectDB.closeConnection(conn);                                                                            
                                    }   
                                
                                }
                            catch(Exception dece)
                                {System.out.println("Error"+dece);
                                }
                            }
                    //frame.setVisible(false);                    
                    checkNotifyHide();                    
                }
            });


            frame.btn2.addActionListener(new ActionListener() {
           
                public void actionPerformed(ActionEvent e) {
                	/*Fill this function*/
                	/*Press this accept all Button, you should be able to accept all friend request and add this information into friend relationship table*/
                	/*pop up a standard dialog box to show <succeed or failed>*/
                        sqlPanel.SQLArea.setText("");                        
                        String acc="";
                        int update;
                        String ftype="";
                        String successacc="";
                        ResultSet rs;//for del from request
                        Boolean accepted=false;
                        //Boolean ac=false;
                        ResultSet rsf;
                        try
                            {
                            ConnectDB.openConnection();
                            rsf=ConnectDB.st.executeQuery("select * from request where receiver='"+loginPanel.username.getText()+"'");
                            if(rsf.next())
                                {//while(rs.next())
                                    rsf.first();
                                    do
                                    {acc+=rsf.getString(1);
                                    acc+=",";
                                    }while(rsf.next());
                                acc=acc.substring(0,acc.length()-1);
                                //System.out.println(acc);
                                }
                            else
                                {JOptionPane.showMessageDialog(null,"You do not have any requests to accept.","Accept Info",JOptionPane.INFORMATION_MESSAGE);
                                }
                            rsf.close();
                            ConnectDB.closeConnection(conn);
                            }
                        catch (Exception accept)
                            {System.out.println("Error:"+accept);
                            }                                               
                        //if (acc.length()==0)
                        //    JOptionPane.showMessageDialog(null,"Please enter the Email ID","Decline Error",JOptionPane.ERROR_MESSAGE);
                        if (acc.length()>0)
                            {ConnectDB.openConnection();
                                try
                                {if (acc.indexOf(",")>0)
                                    {String[] reqacc=acc.split(",");                                    
                                        for(int i=0;i<reqacc.length;i++)
                                            {//ConnectDB.openConnection();
                                            rs=ConnectDB.st.executeQuery("select * from request where sender='"+reqacc[i]+"' and receiver='"+loginPanel.username.getText()+"'");
                                            rs.next();
                                            ftype=rs.getString(4);
                                            update=ConnectDB.st.executeUpdate("insert into friendship values('"+loginPanel.username.getText()+"','"+reqacc[i]+"','"+ftype+"')");                                            
                                            sqlPanel.SQLArea.append("insert into friendship values('"+loginPanel.username.getText()+"','"+reqacc[i]+"','"+ftype+"') \n");    
                                            update=ConnectDB.st.executeUpdate("delete from request where sender='"+reqacc[i]+"' and receiver='"+loginPanel.username.getText()+"'");                                           
                                            sqlPanel.SQLArea.append("delete from request where sender='"+reqacc[i]+"' and receiver='"+loginPanel.username.getText()+"' \n");                                                                                        
                                            successacc+=reqacc[i];
                                            successacc+=", ";
                                            ftype="";
                                            rs.close();
                                            } 
                                        JOptionPane.showMessageDialog(null,"Below Email ID requests are Accepted Successfully \n"+successacc,"Decline SUCCESS",JOptionPane.INFORMATION_MESSAGE);
                                        ConnectDB.closeConnection(conn);
                                        }                                                                           
                                        else
                                        {rs=ConnectDB.st.executeQuery("select * from request where sender='"+acc+"' and receiver='"+loginPanel.username.getText()+"'");
                                        rs.next();
                                        ftype=rs.getString(4);
                                        update=ConnectDB.st.executeUpdate("insert into friendship values('"+loginPanel.username.getText()+"','"+acc+"','"+ftype+"')");                                            
                                        sqlPanel.SQLArea.append("insert into friendship values('"+loginPanel.username.getText()+"','"+acc+"','"+ftype+"') \n");    
                                        update=ConnectDB.st.executeUpdate("delete from request where sender='"+acc+"' and receiver='"+loginPanel.username.getText()+"'");                                           
                                        sqlPanel.SQLArea.append("delete from request where sender='"+acc+"' and receiver='"+loginPanel.username.getText()+"' \n");                                                                                        
                                        //successacc+=acc;
                                        //successacc+=", ";
                                        ftype="";
                                        rs.close();
                                        JOptionPane.showMessageDialog(null,"Below Email ID requests are Accepted Successfully \n"+acc,"Decline SUCCESS",JOptionPane.INFORMATION_MESSAGE);
                                        ConnectDB.closeConnection(conn);
                                        }
                                        
                                }
                            catch(Exception dece)
                                {System.out.println("Error"+dece);
                                }
                            
                            }                         
                        ConnectDB.closeConnection(conn);
                        frame.setVisible(false);
                        //ac=true;
                        checkNotifyHide();                        
                }
            });

        }
		});

		buttonPanel.buttons[6].addActionListener(new ActionListener() {
         
            public void actionPerformed(ActionEvent e) {
            	/*Fill this function*/
            	/*Press this Button, you should be able list the information(including address information) about your friend who live nearest to you*/
            	/*This is a spatial query*/
                resultArea.setText("");
                sqlPanel.SQLArea.setText("");
                clearAll();
                String query="select mem.email,mem.fname,mem.lname,a.street_no,a.street_address,a.city,a.state,a.zip,a.country\n" +
                            "from member1 mem,address a,\n" +
                            "(select distinct m.email\n" +
                            "/*+ordered*/\n" +
                            "/*+ INDEX(s address_index)*/\n" +
                            "/*+ LEADING(c) USE_NL(c s) INDEX(s address_index)*/ \n" +
                            "from address a1,address a2, friendship f,member1 m,member1 m1,\n" +
                            "((select email1 \n" +
                            "from friendship\n" +
                            "where email2='"+loginPanel.username.getText()+"')\n" +
                            "union \n" +
                            "(select email2 \n" +
                            "from friendship\n" +
                            "where email1='"+loginPanel.username.getText()+"')) temp\n" +
                            "where m1.email='"+loginPanel.username.getText()+"' \n" +
                            "and m.email=temp.email1\n" +
                            "and m.aid=a2.aid and m1.aid=a1.aid \n" +
                            "and sdo_nn(a2.coordinat,a1.coordinat,'sdo_num_res=40')='TRUE'\n" +
                            "and rownum<=1) fin where fin.email=mem.email and mem.aid=a.aid";
                //String query="select /*+ LEADING(c) USE_NL(c s) INDEX(s address_index)*/ /*+ INDEX(s address_index)*/ \n" +
                //            "m2.email,m2.fname,m2.lname,a1.street_no,a1.street_address,a1.city,a1.state,a1.zip,a1.country\n" +
                //            "from member1 m1,member1 m2,address a1, address a2 ,friendship f \n" +
                //            "where m1.email!=m2.email  and m1.aid=a1.aid and m2.aid=a2.aid and \n" +
                //            "m1.email='"+loginPanel.username.getText()+"' and (( f.email1=m1.email and f.email2=m2.email  ) \n" +
                //            "or (f.email1=m2.email and f.email2=m1.email)) and \n" +
                //            "sdo_nn(a2.coordinat,a1.coordinat,'sdo_num_res=1')='TRUE' and rownum <= 1";          
                try
                    {sqlPanel.SQLArea.append(query);
                    ConnectDB.openConnection();
                    ResultSet rs=ConnectDB.st.executeQuery(query);
                    resultArea.setText("--------------------------------Information of your Nearest Friend-----------------------------------------\n");
                    while (rs.next())
                        {resultArea.append("Email: "+rs.getString(1)+"\n Fname: "+rs.getString(2)+"\n Lname: "+rs.getString(3)+"\n Street #: "+rs.getString(4)+"\n Street Addr: "+rs.getString(5)+"\n City: "+rs.getString(6)+"\n State: "+rs.getString(7)+"\n zip: "+rs.getString(8)+"\n Country: "+rs.getString(9)+"\n");
                        }
                    rs.close();
                    ConnectDB.closeConnection(conn);
                    }
                catch(Exception nearestf)
                    {System.out.println("Error:"+nearestf);
                    }
            }
        });
		buttonPanel.buttons[7].addActionListener(new ActionListener() {
           
            public void actionPerformed(ActionEvent e) {
            	final Frame3 frame=new Frame3("Please input coordinate: ");
                frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
                frame.setVisible(true);
                sqlPanel.SQLArea.setText("");
                clearAll();                
                resultArea.setText("");
                frame.btn1.addActionListener(new ActionListener() {
                  
                    public void actionPerformed(ActionEvent e) {
                    	/*Fill this function*/
                    	/*Press this Button, input left top corner coordinate and right down corner coordinate*/
                    	/*press ok, you should be able list the information(including address information) about your friend who lives in this area. Close query window*/
                    	/*This is a spatial query*/
                        String ltopx=frame.txtfield[0].getText();
                        String ltopy=frame.txtfield[1].getText();
                        String rbotx=frame.txtfield[2].getText();
                        String rboty=frame.txtfield[3].getText();                        
                        String query="select m.email,m.fname,m.lname,fin1.street_no,fin1.street_address,\n" +
                                    "fin1.city,fin1.state,fin1.zip,fin1.country\n" +
                                    "from member1 m\n" +
                                    "inner join\n" +
                                    "(select main1.email1,main1.coordinat,main1.street_no,main1.street_address,main1.city,main1.state,main1.zip,main1.country\n" +
                                    "/*+ INDEX(s address_index)*/\n" +
                                    "/*+ LEADING(c) USE_NL(c s) INDEX(s address_index)*/ \n" +
                                    "from\n" +
                                    "(select addr.coordinat,t1.email1,addr.street_no,addr.street_address,addr.city,addr.state,addr.zip,addr.country\n" +
                                    "from address addr,\n" +
                                    "(select distinct t.email1,m.aid\n" +
                                    "from member1 m,\n" +
                                    "((select email1 \n" +
                                    "from friendship\n" +
                                    "where email2='"+loginPanel.username.getText()+"')\n" +
                                    "union \n" +
                                    "(select email2 \n" +
                                    "from friendship\n" +
                                    "where email1='"+loginPanel.username.getText()+"')) t\n" +
                                    "where t.email1=m.email) t1 where t1.aid=addr.aid) main1,\n" +
                                    "(select a.coordinat,m.email\n" +
                                    "from address a,member1 m\n" +
                                    "where m.email='"+loginPanel.username.getText()+"' and m.aid=a.aid) main2\n" +
                                    "where MDSYS.SDO_INSIDE (main1.coordinat,\n" +
                                    "MDSYS.SDO_GEOMETRY(2003,null,null,MDSYS.SDO_ELEM_INFO_ARRAY (1,1003,3),MDSYS.SDO_ORDINATE_ARRAY ("+ltopx+","+rboty+","+rbotx+","+ltopy+"))) = 'TRUE') fin1\n" +
                                    "on fin1.email1=m.email";
                        
                        resultArea.setText("---------------------------------------------------Information of Friends in specified Range----------------------------------------------------------------------------------\n");                        
                        if (ltopx.length()==0 || ltopy.length()==0 || rbotx.length()==0 || rboty.length()==0)
                            JOptionPane.showMessageDialog(null,"Please provide all coordinates \n","Empty Coordinates",JOptionPane.ERROR_MESSAGE);
                        else
                            {try
                                {ConnectDB.openConnection();                                
                                ResultSet rs=ConnectDB.st.executeQuery(query);
                                sqlPanel.SQLArea.setText(query);
                                if (rs.next()==false)
                                    JOptionPane.showMessageDialog(null,"No friend found in the specified range \n","No Result Found",JOptionPane.INFORMATION_MESSAGE);
                                else
                                    {rs.first();
                                    do
                                        {resultArea.append("Email: "+rs.getString(1)+"\n Fname: "+rs.getString(2)+"\n Lname: "+rs.getString(3)+"\n Street #: "+rs.getString(4)+"\n Street Addr: "+rs.getString(5)+"\n City: "+rs.getString(6)+"\n State: "+rs.getString(7)+"\n zip: "+rs.getString(8)+"\n Country: "+rs.getString(9)+"\n");
                                        resultArea.append("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n \n");
                                        }while(rs.next());
                                    }
                                rs.close();                                
                                frame.setVisible(false);                                                              
                                ConnectDB.closeConnection(conn);
                                }
                            catch(Exception coorde)
                                {System.out.println("Error:"+coorde);
                                JOptionPane.showMessageDialog(null,"Please enter valid values for search. \n","No Result Found",JOptionPane.ERROR_MESSAGE);
                                }
                            }
                    	
                    }
                });
            }
        });
		
	}

	public void setPostandSearchPanel(){
		postandsearch = new PostandSearchPanel();
		this.add(postandsearch);
		StringBuffer result= new StringBuffer();
		postandsearch.buttons[0].addActionListener(new ActionListener() {
            
            public void actionPerformed(ActionEvent e) { 
            	/*Fill this function*/
            	/*Press this Button, you should be able post the information written in the textArea*/
            	/*pop up a standard dialog box to show <succeed or failed>*/
                final String postt=postandsearch.textArea.getText().trim();                
                if (postt.length()==0)
                    JOptionPane.showMessageDialog(null,"Empty Post cannot be made.","Post Error",JOptionPane.ERROR_MESSAGE);                                                                     
                else{
                try
                {
            	final Frame0 frame=new Frame0("Select Privacy Level",1);
                frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
                frame.setVisible(true);
                System.out.println(frame.combo.getSelectedIndex()+"before");
                frame.txtfield.setText("Default-Option 1");
                frame.txtfield.setEditable(false);
                frame.btn1.addActionListener(new ActionListener() {
                 
                        public void actionPerformed(ActionEvent e) {
                            int rowcount=0;
                            /*Fill this function*/
                            /*Press this List Comments Button, input Post ID, press OK, you should be able to list all the comment about this post*/
                            if (frame.combo.getSelectedIndex()!=-1)//its never gonna be -1
                                {try{
                                int plevel=frame.combo.getSelectedIndex();
                                System.out.println(plevel+"plevel");
                                ConnectDB.openConnection();
                                sqlPanel.SQLArea.setText("");
                                ResultSet rs=ConnectDB.st.executeQuery("select count(post_id) from post");
                                sqlPanel.SQLArea.append("select count(post_id) from post \n");
                                if (rs.next())
                                    rowcount=rs.getInt(1);
                                rowcount++;//next post number
                                System.out.println("rowcount"+rowcount);                                                                
                                rs.close();
                                ConnectDB.closeConnection(conn);
                                ConnectDB.openConnection();
                                int update=ConnectDB.st.executeUpdate("insert into post values("+rowcount+",'"+postt+"','"+loginPanel.username.getText()+"',"+plevel+",(select sysdate from dual))");
                                JOptionPane.showMessageDialog(null,"Post Posted Successfully!!","Post Success",JOptionPane.INFORMATION_MESSAGE);                                                                
                                sqlPanel.SQLArea.append("insert into post values("+rowcount+",'"+postt+"','"+loginPanel.username.getText()+"',"+plevel+",(select sysdate from dual))\n");                                
                                frame.setVisible(false);
                                postandsearch.textArea.setText("");
                                }
                                catch (SQLException poste)
                                    {System.out.println("error"+poste);                                    
                                    }
                                //int addpost=ConnectDB.st.executeUpdate("insert into post values('"+postt+"',"+plevel)
                                }
                            else
                                JOptionPane.showMessageDialog(null,"Please select a privacy Level for your Post","Post Error",JOptionPane.ERROR_MESSAGE);
                        }//end btn1 ap 
                    });//btn acli
                    }//end try
                catch (Exception s)
                    {System.out.println("error"+s);
                    }
                    }//end else                    
                
                
                }                                
        });


		postandsearch.buttons[1].addActionListener(new ActionListener() {
           
            public void actionPerformed(ActionEvent e) {  
            	/*Fill this function*/
            	/*Press this Button, you should be able search user information, list the information on the result panel*/
            	/*The search should based on email, first name or last name*/                       
                resultArea.setText("");                                
                scrollPane=new JScrollPane();
                String query="";                                                
                try{
                    String search=postandsearch.text.getText();
                    search=search.trim();
                    search=search.toLowerCase();
                    if (search.length()==0)
                        JOptionPane.showMessageDialog(null,"Search String cannot be empty","Search Error",JOptionPane.ERROR_MESSAGE);
                    else
                        {//JOptionPane.showMessageDialog(null,"Entered","Search result",JOptionPane.INFORMATION_MESSAGE);
                        ConnectDB.openConnection();
                        query="select t.email,t.fname,t.lname,t.birthdate,a.street_no,a.street_address,a.city,a.state,a.zip,a.country from address a,(select email,fname,lname,birthdate,aid from member1 where (email like '%"+search+"%' or fname like '%"+search+"%' or lname like '%"+search+"%') and email!='"+loginPanel.username.getText()+"') t where a.aid=t.aid";
                        //ResultSet rs=ConnectDB.st.executeQuery("select m.email,m.fname,m.lname,m.birthdate,a.street_no,a.street_address,a.city,a.state,a.zip,a.country from member1 m,address a where email like '%"+search+"%' and a.aid=m.aid");                                               
                        ResultSet rs=ConnectDB.st.executeQuery(query);                      
                        setSQLArea();                       
                        sqlPanel.SQLArea.append(query); 
                        resultArea.setText("");                                               
                        if (rs.next())
                                {
                                rs.first();                                
                                    do
                                    {
                                        {resultArea.append("Email:"+rs.getString(1)+"\nFname: "+rs.getString(2)+"\nLname"+rs.getString(3)+"\nBirthdate"+rs.getString(4).substring(0,10)+"\n Street #: "+rs.getString(5)+"\n Street name: "+rs.getString(6)+"\n City:"+rs.getString(7)+"\n State:"+rs.getString(8)+"\n Zip:"+rs.getString(9)+"\n Country:"+rs.getString(10)+"\n");
                                        resultArea.append("----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n");
                                        System.out.println(rs.getString(1));
                                        }
                                    }while (rs.next());     
                                                                                                                              
                                }                        
                        else
                                {JOptionPane.showMessageDialog(null,"No results found","Search result",JOptionPane.INFORMATION_MESSAGE);                                
                                disableResult();
                                }                                                                                                                      
                        ConnectDB.closeConnection(conn);
                        }
                    }
                catch (Exception pase)
                    {System.out.println("error"+pase);                    
                    JOptionPane.showMessageDialog(null,"No results found","Search result",JOptionPane.INFORMATION_MESSAGE);
                    }
                    }                            
        });
	}
	public void setSQLOutput(StringBuffer sb)
	{
		sqlPanel.SQLArea.setText(sb.toString());
		sqlPanel.SQLArea.setEnabled(true);
                sqlPanel.SQLArea.setEditable(false);
	}
	public void setSqlPanel(){
		sqlPanel = new SqlPanel();
		this.add(sqlPanel);
		showLabel = new JLabel("The corresponding SQL :");
		showLabel.setBounds(20, 470, 200, 20);//setBounds(0, 495,810, 150);
		this.add(showLabel);
                sqlPanel.SQLArea.setEnabled(true);  
                sqlPanel.SQLArea.setEditable(false);
	}

	public void setLoginPanel(){
		loginPanel = new LoginPanel();
		this.add(loginPanel);

		loginPanel.signup.addActionListener(new ActionListener(){
			
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
		        signUpPanel.enablePanel();
			}
        });
        loginPanel.login.addActionListener(new ActionListener() {
           
            public void actionPerformed(ActionEvent e) {  
            	/*Fill this function*/
            	/*Press this Button, you should be able match the user information. If valid, keep the user email information(but can't modified) and clear the password*/
            	/*at the same time, you should scan the friend request table, to determine whether current logged in user has friend request, if has, set notification icon*/
            	/*If invalid, you should pop up a dialog box to notify user, then enable signup panel for user to register*/
            	/*After logged in, you should change this button's function as logout which means disable all the panel, return to the original state*/
                //now only implementing the login function.....not notification icon..
                //signUpPanel.disablePanel();
                String button_text=loginPanel.login.getText();
                if (button_text.equals("Login")){
                signUpPanel.email.setText("");
                signUpPanel.password.setText("");
                signUpPanel.password2.setText("");
                signUpPanel.fname.setText("");
                signUpPanel.lname.setText("");
                signUpPanel.city.setText("");
                signUpPanel.birthday.setText("");
                signUpPanel.zip.setText("");                             
                signUpPanel.str_address.setText("");
                signUpPanel.str_no.setText("");
                try
                {
                String uname=loginPanel.username.getText();
                char[] passc=loginPanel.password.getPassword();
                String pass_str=new String(passc);
                sqlPanel.SQLArea.setText("");
                sqlPanel.SQLArea.setText("select * from member1 where email='"+uname+"' and pass='"+pass_str+"' \n\n");
                if (uname.length()==0)
                    JOptionPane.showMessageDialog(null,"Login Input Fields cannot be empty.","Empty Fields",JOptionPane.ERROR_MESSAGE);
                
                ConnectDB.openConnection();
                ResultSet rs=ConnectDB.st.executeQuery("select * from member1 where email='"+uname+"' and pass='"+pass_str+"'");
                if (rs.next())
                    {signUpPanel.disablePanel();
                    loginPanel.login.setText("Logout");
                    sqlPanel.enablePanel();
                    postandsearch.enablePanel();                    
                    buttonPanel.enablePanel();
                    loginPanel.password.setText("");
                    loginPanel.password.setEnabled(false);
                    loginPanel.username.setEditable(false);
                    loginPanel.signup.setEnabled(false);                      
                    ConnectDB.closeConnection(conn);//notification part
                    rs.close();
                    ConnectDB.openConnection();
                    rs=ConnectDB.st.executeQuery("select sender,ftype from request where receiver='"+loginPanel.username.getText()+"'");
                    sqlPanel.SQLArea.append("select sender,ftype from request where receiver='"+loginPanel.username.getText()+"'");
                    if (rs.next())                        
                        {//add(notifyButton);                                    
                        notifyButton.setVisible(true);                                                
                        getContentPane().repaint();
                        
                        }
                    else
                        {notifyButton.setVisible(false);                                                
                        getContentPane().repaint();
                        }
                    ConnectDB.closeConnection(conn);
                    }
                else
                    {JOptionPane.showMessageDialog(null,"Username and password did not match. Try again..","LOGIN ERROR!!",JOptionPane.ERROR_MESSAGE);
                    signUpPanel.enablePanel();
                    loginPanel.password.setText("");                    
                    }
                ConnectDB.closeConnection(conn);
                }
                catch (Exception elogin)
                {JOptionPane.showMessageDialog(null,"Login Error.","ERROR!!",JOptionPane.ERROR_MESSAGE);
                }
                }
                else if (button_text.equals("Logout"))
                    {loginPanel.login.setText("Login");
                    loginPanel.password.setEnabled(true);
                    sqlPanel.disablePanel();
                    postandsearch.disablePanel();
                    buttonPanel.disablePanel();
                    loginPanel.username.setEditable(true);
                    loginPanel.username.setText(""); 
                    loginPanel.signup.setEnabled(true);
                    resultArea.setText("");
                    sqlPanel.SQLArea.setText("");
                    postandsearch.text.setText("");
                    postandsearch.textArea.setText(""); 
                     notifyButton.setVisible(false);                    
                    //remove(notifyButton);
                    getContentPane().repaint();
                    JOptionPane.showMessageDialog(null,"You have been successfully logged out.","Logout Successfull",JOptionPane.INFORMATION_MESSAGE);                    
                   
                    }
            }
            
           });
   

	}

	public void setSignupPanel(){
                
		signUpPanel = new SignupPanel();
		this.add(signUpPanel);
		signUpPanel.signup.addActionListener(new ActionListener() {
               
            public void actionPerformed(ActionEvent e) {  
            	/*Fill this function*/
            	/*Press this signup button, you should be able check whether current account is existed. If existed, pop up an error, if not check input validation(You can design this part according to your database table's restriction) create the new account information*/
            	/*pop up a standard dialog box to show <succeed or failed>*/
                sqlPanel.SQLArea.setText(""); 
                resultArea.setText("");
                String email=signUpPanel.email.getText();
                char[] password=signUpPanel.password.getPassword();
                char[] password2=signUpPanel.password2.getPassword();
                String passinput=new String(signUpPanel.password.getPassword());
                String fname=signUpPanel.fname.getText();
                String lname=signUpPanel.lname.getText();                
                String bday=signUpPanel.birthday.getText();
                String str_no=signUpPanel.str_no.getText();
                String str_address=signUpPanel.str_address.getText();
                String city=signUpPanel.city.getText();
                String zip1=signUpPanel.zip.getText();
                Date d=new Date();
                //int zipi=Integer.parseInt(zip1);
                Boolean condb=true;
                try{
                if (true)
                {if (email.trim().length()==0 || password.length==0 || password2.length==0 ||
                    fname.trim().length()==0 || lname.trim().length()==0 || str_no.trim().length()==0 || 
                    str_address.trim().length()==0 || zip1.trim().length()==0 || city.trim().length()==0) //check emptiness
                    {JOptionPane.showMessageDialog(null,"Sign-up Input Fields cannot be empty.","Empty Fields",JOptionPane.ERROR_MESSAGE);
                    condb=false;
                    }
                String pass=new String(password);//pass match
                String pass2=new String(password2);
                if (pass.equals(pass2)==false)
                    {JOptionPane.showMessageDialog(null,"Your passwords do not match.","Password Error",JOptionPane.ERROR_MESSAGE);
                    condb=false;
                    }                               
               Boolean numcheck=true; //number chk in str_no
               for (int i=0;i<str_no.length();i++)
                    {int a=(int) str_no.charAt(i);                    
                        if (a<48 || a>57)
                            {numcheck=false;
                            condb=false;
                            break;
                            }
                    }               
               if (numcheck==false)
                   JOptionPane.showMessageDialog(null,"Street no. should only have numbers","Input Error",JOptionPane.ERROR_MESSAGE);
                    
               
               Boolean numcheck1=true; //num check in zip
               for (int i=0;i<zip1.length();i++)
                    {int a=(int) zip1.charAt(i);
                        if (a<48 || a>57)
                            {numcheck1=false;
                            condb=false;
                            break;
                            }
                    }               
                    if (numcheck1==false)
                    {JOptionPane.showMessageDialog(null,"Zip Code should only have numbers","Input Error",JOptionPane.ERROR_MESSAGE);}
               
               numcheck1=true;
               for (int i=0;i<pass.length();i++)
                    {int a=(int) pass.charAt(i);
                    if (a==32)
                        {numcheck1=false;
                        condb=false;
                        break;
                        }
                    }
               if (numcheck1==false)
                    {JOptionPane.showMessageDialog(null,"Blanck Space not allowed in password","Password Error",JOptionPane.ERROR_MESSAGE);
                    signUpPanel.password.setText("");
                    signUpPanel.password2.setText("");//pass should not include spaces
                    }
               //date handling mm/dd/yyyy
                             
               try{
               int day=Integer.parseInt(bday.substring(3,5));
               int month=Integer.parseInt(bday.substring(0,2));
               int year=Integer.parseInt(bday.substring(6,10)); 
               if (bday.charAt(2)!='/' || bday.charAt(5)!='/'|| bday.length()!=10)
                    {JOptionPane.showMessageDialog(null,"Date not is expected format (mm/dd/yyyy)1mon.","Date Error",JOptionPane.ERROR_MESSAGE);
                    System.out.println(bday.charAt(2)+" "+bday.charAt(5)+" "+bday.length());
                    condb=false;
                    }
               else
                    {for (int i=0;i<bday.length();i++)
                        {if (i==2 || i==5)
                            continue;
                        else
                            {int a=(int) bday.charAt(i);                           
                            if (a<48 || a>57)
                                {JOptionPane.showMessageDialog(null,"Date not is expected format (mm/dd/yyyy)2...","Date Error",JOptionPane.ERROR_MESSAGE);
                                condb=false;
                                break;
                                }
                            }
                        }                    
                    if (day>31 || month>13 || year<1800 || year>2013)
                        {condb=false;
                        JOptionPane.showMessageDialog(null,"Date values not correct","Date Error",JOptionPane.ERROR_MESSAGE);                        
                        }
                    else if (day>d.getDate() || month>d.getMonth() || day>d.getYear())
                        {condb=false;
                        JOptionPane.showMessageDialog(null,"Date values not correct. Future dates cannot be entered","Date Error",JOptionPane.ERROR_MESSAGE); 
                        }
                    }
                    }                                                  
               catch (Exception e2)
                {JOptionPane.showMessageDialog(null,"Date not is expected format (mm/dd/yyyy).3","Date Error",JOptionPane.ERROR_MESSAGE);
                condb=false;
                }                                       
                }
                if (condb)
                {try{
                        ConnectDB.openConnection();
                        ResultSet rs=ConnectDB.st.executeQuery("select * from member1 where email='"+email+"'");
                        if (rs.next())
                            JOptionPane.showMessageDialog(null,"Invalid User name.","Login error",JOptionPane.ERROR_MESSAGE);
                        else
                            {
                             int updatecount=ConnectDB.st.executeUpdate("insert into member1 values('"+email+"','"+passinput+"','"+fname+"','"+lname+"',to_date('"+bday+"','mm/dd/yyyy'),1) \n");
                             sqlPanel.SQLArea.setText("");
                             sqlPanel.SQLArea.append("insert into member1 values('"+email+"','"+passinput+"','"+fname+"','"+lname+"',to_date('"+bday+"','mm/dd/yyyy'),1)");
                             JOptionPane.showMessageDialog(null,"Welcome, "+fname+" you are Signed up","Login Success",JOptionPane.PLAIN_MESSAGE);
                             ConnectDB.closeConnection(conn);
                             ConnectDB.openConnection();
                             updatecount=ConnectDB.st.executeUpdate("insert into livesin values('"+email+"',1)");
                             sqlPanel.SQLArea.append("insert into livesin values('"+email+"',1)");
                             //clearing fields..
                             signUpPanel.email.setText("");
                             signUpPanel.password.setText("");
                             signUpPanel.password2.setText("");
                             signUpPanel.fname.setText("");
                             signUpPanel.lname.setText("");
                             signUpPanel.city.setText("");
                             signUpPanel.birthday.setText("");
                             signUpPanel.zip.setText("");                             
                             signUpPanel.str_address.setText("");
                             signUpPanel.str_no.setText("");
                             loginPanel.username.setText("");
                                                         
                            }                        
                        ConnectDB.closeConnection(conn);
                        rs.close();
                        }
                    catch (Exception e1)
                        {System.out.println("error "+e1);
                        } 
                    }
                }
                catch (Exception e3)
                {System.out.println("Inappropriate Input given");
                }
            }//actionPerformed end
        });

		signUpPanel.disablePanel();

	}


}


class ConnectDB{
        public static Connection con;
        public static Statement st;
	public static Connection openConnection(){
       
		/*Fill this function*/
    	/*implement open  connection */		
        try
            {Class.forName("oracle.jdbc.OracleDriver");
            con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","monil","monil");
            st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            }
        catch (Exception e)
            {System.out.println("error "+e);
            }
        return null;
	}
	public static void closeConnection(Connection conn)
	{conn=con;
            try
                {conn.close();
                st.close();
                 //rs.close();
                }
            catch (Exception e)
                {System.out.println("error "+e);
                }            
		/*Fill this function*/
    	/*implement close connection */
	}
}
public class Assignment2 {
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
    	MainFrame frame = new MainFrame();
    	frame.setVisible(true);
    	frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
}
