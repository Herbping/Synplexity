
Install z3


(1, 0, 0)    	Complexity O(n) 
		Recurrence Relation T(n) = T(n-1) + O(1)
		
(1, 0, 1)    	Complexity O(n) 
		Recurrence Relation T(n) = T(n-k-1) + T(k) + O(1)
		
(1, 0, 2)    	Complexity O(n) 
		Recurrence Relation T(n) = T(n-k-1) + T(k) + O(1)
		
(0, 1, 2)    	Complexity O(logn) 
		Recurrence Relation T(n) =  O(logn)
		
(1, 1, 0)    	Complexity O(n\logn) 
		Recurrence Relation T(n) = T(n//2) + T(n-n//2) + O(1)
		
(2, 0, 0)    	Complexity O(n^2) 
		Recurrence Relation T(n) = T(n-1) + O(n)
		
(2, 0, 1)    	Complexity O(n^2) 
		Recurrence Relation T(n) = T(n-k-1) + T(k) + O(n)
		
(2, 0, 2)	Complexity O(n^2)
		Recurrence Relation T(n) = O(n^2)
