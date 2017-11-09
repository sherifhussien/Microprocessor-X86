
public class Micro {
	public static void main(String[]args){
		int[] a ={4,2,8,1,16,6,27,18,19,3,22,30,27,14,5};
		int[] r= new int[a.length];
		
		for(int i=0;i<a.length;i++){
		
			int result=0;
			int right = a.length-1-i;
			int left = i-0;
			if (right>5){
				right = 5;
			}
			if(left>4){
				left=4;
			}
			
			for (int j = i-left; j <= i+right; j++) {
				
				result+=a[j];
			}
			r[i]=result/(left+right+1);
			
			
		}
		
		for(int i=0;i<r.length;i++){
			System.out.print(r[i]+" ");
		}
	}

}
