package Nadirian07;

public class PWD {
int b=2,c=3,d=4,e=5,f=6;
private  static String a = "Nadirian Hamlet Ovikov";
private static int res = 0;
public int getPwd() {return res;}
public PWD() {
	
	
	for (int i = 0; i < a.length(); i++) {
		res+=b*d+c+e+f+ Math.sqrt((int)(a.charAt(i)));
	}
}
}
