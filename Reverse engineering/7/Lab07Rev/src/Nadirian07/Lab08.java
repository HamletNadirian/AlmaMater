/**
 * 
 */
package Nadirian07;

import java.util.Scanner;

/**
 * @author Ham
 *
 */
public class Lab08 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	       System.out.print("Input password: ");
	       Scanner in = new Scanner(System.in);
	       int upwd = in.nextInt();
	       PWD pwd = new PWD();
	     // System.out.println(pwd.getPwd());
	       if(upwd==pwd.getPwd())
	    	   System.out.println("Right");
	       else
	    	   System.out.println("Incorrect");
	}

}

