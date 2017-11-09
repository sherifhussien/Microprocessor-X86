#include <stdio.h>
int main(){
	int a[]  = {4,2,8,1,16,6,27,18,19,3};
	int n = sizeof(a)/ sizeof(int);
	int r[n];


	for (int i =0 ; i<n;i =i+1){
	int result = 0;
	int right = n-1-i;
	int left = i;
		if (right>5){
			right = 5;
		}
		if(left>4){
			left=4;
		}
		for (int j = i-left; j <= i+right; j=j+1) {
			result += a[j];
		}
		r[i]=result/(left+right+1);

	}

			for(int i=0;i<n;i= i+1){
			printf("%d\n", r[i]);
			}
		}


	
