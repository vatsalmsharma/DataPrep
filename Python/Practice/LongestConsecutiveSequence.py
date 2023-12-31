# Name : 128. Longest Consecutive Sequence
# URL : https://leetcode.com/problems/longest-consecutive-sequence/description/
# Level : Medium

# Problem details:
    # Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.

    # You must write an algorithm that runs in O(n) time.

    

    # Example 1:

    # Input: nums = [100,4,200,1,3,2]
    # Output: 4
    # Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.
    # Example 2:

    # Input: nums = [0,3,7,2,5,8,4,6,0,1]
    # Output: 9
    

    # Constraints:

    # 0 <= nums.length <= 105
    # -109 <= nums[i] <= 109

# Solution: 
from typing import List

class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        # numSet = set(nums)
        # numSo = list(numSet)
        # numSo.sort()

        # longest = 0
        # tempLong = 1
        # for i in range(len(numSo)-1):
        #     if(numSo[i+1] - numSo[i] == 1):
        #         tempLong += 1
        #     else:
        #         if(tempLong > longest):
        #             longest = tempLong
        #         tempLong = 1
        
        # if(tempLong > longest):
        #     return(tempLong)
        # else:
        #     return(longest)

# O(n) complexity
        numSet = set(nums)
        longest = 0
        
        while numSet:
            low = high = numSet.pop()

            while (low-1 in numSet or high+1 in numSet):
                if(low - 1) in numSet:
                    numSet.remove(low - 1)
                    low -= 1
                
                if(high + 1) in numSet:
                    numSet.remove(high + 1)
                    high += 1 

            longest = max(high - low +1, longest)
        
        return (longest)


s = Solution()
nums = [9,1,-3,2,4,8,3,-1,6,-2,-4,7]
# [9,1,4,7,3,-1,0,5,8,-1,6] # [0,3,7,2,5,8,4,6,0,1] # [100,4,200,1,3,2]

print(s.longestConsecutive(nums))