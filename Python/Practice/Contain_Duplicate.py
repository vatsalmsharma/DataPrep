# Name : 217. Contains Duplicate
# URL : https://leetcode.com/problems/contains-duplicate/description/
# Level : Easy

# Problem details:
    # Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct. 

    # Example 1:

    # Input: nums = [1,2,3,1]
    # Output: true
    # Example 2:

    # Input: nums = [1,2,3,4]
    # Output: false
    # Example 3:

    # Input: nums = [1,1,1,3,3,4,3,2,4,2]
    # Output: true
    

    # Constraints:

    # 1 <= nums.length <= 105
    # -109 <= nums[i] <= 109

# Solution :
from typing import List

class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:
        arr_len = len(nums)
        set_len = len(set(nums))
        if(arr_len == set_len):
            return False
        else:
            return True 

sol = Solution()
inNumList1 = [1,2,3,1]
inNumList2 = [1,2,3,4]

print(inNumList1, sol.containsDuplicate(inNumList1))
print(inNumList2, sol.containsDuplicate(inNumList2))