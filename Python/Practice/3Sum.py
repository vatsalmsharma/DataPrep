# Name : 15. 3Sum
# URL : https://leetcode.com/problems/3sum/description/
# Level : Medium

# Problem details:
    # Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

    # Notice that the solution set must not contain duplicate triplets.

    

    # Example 1:

    # Input: nums = [-1,0,1,2,-1,-4]
    # Output: [[-1,-1,2],[-1,0,1]]
    # Explanation: 
    # nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
    # nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
    # nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
    # The distinct triplets are [-1,0,1] and [-1,-1,2].
    # Notice that the order of the output and the order of the triplets does not matter.
    # Example 2:

    # Input: nums = [0,1,1]
    # Output: []
    # Explanation: The only possible triplet does not sum up to 0.
    # Example 3:

    # Input: nums = [0,0,0]
    # Output: [[0,0,0]]
    # Explanation: The only possible triplet sums up to 0.
    

    # Constraints:

    # 3 <= nums.length <= 3000
    # -105 <= nums[i] <= 105

from typing import List

class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        nums.sort() # sorting cause we need to avoid duplicates, with this duplicates will be near to each other
        l=[]
        for i in range(len(nums)):  #this loop will help to fix the one number i.e, i
            if i>0 and nums[i-1]==nums[i]:  #skipping if we found the duplicate of i
                continue 
			
			#NOW FOLLOWING THE RULE OF TWO POINTERS AFTER FIXING THE ONE VALUE (i)
            j=i+1 #taking j pointer larger than i (as said in ques)
            k=len(nums)-1 #taking k pointer from last 
            while j<k: 
                s=nums[i]+nums[j]+nums[k] 
                if s>0: #if sum s is greater than 0(target) means the larger value(from right as nums is sorted i.e, k at right) 
				#is taken and it is not able to sum up to the target
                    k-=1  #so take value less than previous
                elif s<0: #if sum s is less than 0(target) means the shorter value(from left as nums is sorted i.e, j at left) 
				#is taken and it is not able to sum up to the target
                    j+=1  #so take value greater than previous
                else:
                    l.append([nums[i],nums[j],nums[k]]) #if sum s found equal to the target (0)
                    j+=1 
                    while nums[j-1]==nums[j] and j<k: #skipping if we found the duplicate of j and we dont need to check 
					#the duplicate of k cause it will automatically skip the duplicate by the adjustment of i and j
                        j+=1   
        return l
        # negative = []
        # positive = []
        # zeros = []
        # output = []
        
        # for n in nums:
        #     if(n<0):
        #         negative.append(n)
        #     elif(n>0):
        #         positive.append(n)
        #     else:
        #         zeros.append(n)
    
        # if(len(zeros) > 2):
        #     output.append([0,0,0])
        
        # if(len(zeros)> 0):
        #     ps = set(positive)
        #     for p in ps:
        #         if  (-1 * p) in negative:
        #             o = [p,0,(-1 * p)]
        #             o.sort()
        #             if o not in output:
        #                 output.append(o)                    
        
        # if len(negative) > 1:
        #     for i in range(len(negative)-1):
        #         j = i+1
        #         while j < len(negative):
        #             ex = -1 * (negative[i] + negative[j]) 
        #             if ex in positive:
        #                 o = [negative[i] , negative[j], ex]
        #                 o.sort()
        #                 if o not in output:
        #                     output.append(o)
        #             j += 1
        
        # if len(positive) > 1:
        #     for i in range(len(positive)-1):
        #         j = i+1
        #         while j < len(positive):
        #             ex = -1 * (positive[i] + positive[j]) 
        #             if ex in negative:
        #                 o = [positive[i] , positive[j], ex]
        #                 o.sort()
        #                 if o not in output:
        #                     output.append(o)
        #             j += 1
                    
        # return(output)
    # def threeSum(self, nums: List[int]) -> List[List[int]]:
    #     output = []
        
    #     for i in range(len(nums)-2):
    #         j = i+1
    #         while j < (len(nums) -1):
    #             s2 = nums[i] + nums[j]
    #             compliment = 0 - s2
    #             if(compliment in nums[j+1:]):
    #                 out = [nums[i], nums[j], compliment]
    #                 out.sort()
    #                 if(out not in output):
    #                     output.append(out)
    #             j += 1

    #     return(output)