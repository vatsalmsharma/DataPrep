# Name : 238. Product of Array Except Self
# URL : https://leetcode.com/problems/product-of-array-except-self/description/
# Level : Medium
# Solution Idea : https://www.youtube.com/watch?v=bNvIQI2wAjk

# Problem details:
    # Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].

    # The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

    # You must write an algorithm that runs in O(n) time and without using the division operation.

    

    # Example 1:

    # Input: nums = [1,2,3,4]
    # Output: [24,12,8,6]
    # Example 2:

    # Input: nums = [-1,1,0,-3,3]
    # Output: [0,0,9,0,0]
    

    # Constraints:

    # 2 <= nums.length <= 105
    # -30 <= nums[i] <= 30
    # The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
    

    # Follow up: Can you solve the problem in O(1) extra space complexity? (The output array does not count as extra space for space complexity analysis.)

# Solution
from typing import List 
import numpy as np

class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        out = []
        # for i in range(len(nums)):
        #     lst = (nums[:i] + nums[i+1:])
        #     # prod = 1
        #     # for n in lst:
        #     #     prod *= n
            
        #     # out.append(prod)
        #     out.append(np.prod(lst))

        pre = [1] * len(nums)
        post = [1] * len(nums)

        pre_val, post_val = 1,1

        for i in range(len(nums)):
            pre_val *= nums[i]
            pre[i] = pre_val

            post_val *= nums[len(nums)-1-i]
            post[len(nums)-1-i] = post_val

        pre = [1] + pre
        post = post + [1]

        for i in range(len(pre) - 1):
            out.append(pre[i]*post[i+1])
        
        return(out)

##############
s = Solution()
nums = [1,2,3,4]
print(s.productExceptSelf(nums)) #  [24, 12, 8, 6]


# Approach 2 : concise way 
class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        n = len(nums)
        prefix_product = 1
        postfix_product = 1
        result = [0]*n
        for i in range(n):
            result[i] = prefix_product
            prefix_product *= nums[i]
        for i in range(n-1,-1,-1):
            result[i] *= postfix_product
            postfix_product *= nums[i]
        return result