/*    */ package rev07hc;
/*    */ 
/*    */ import java.util.Scanner;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public class Lab08
/*    */ {
/*    */   public static void main(String[] args) {
/* 20 */     PWD pwd = new PWD();
			 /*System.out.print("Input password: ");
/* 21 */     Scanner in = new Scanner(System.in);
/* 22 */    System.out.println(pwd.getPwd());
			 int upwd = in.nextInt();
/* 23 */     
/*    */     
/* 25 */     if (upwd == pwd.getPwd()) {
/* 26 */       System.out.println("Right");
/*    */     } else {
/* 28 */       System.out.println("Incorrect");
/*    */     } 
/*    */   }
/*    */ }


/* Location:              C:\Revers\7\Lab07Rev\lab7rev.jar!\Nadirian07\Lab08.class
 * Java compiler version: 11 (55.0)
 * JD-Core Version:       1.0.1
 */