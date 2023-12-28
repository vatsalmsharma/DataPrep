# Name : 1. Two Sum
# URL : https://leetcode.com/problems/two-sum/description/
# Level : Easy

# Problem details:
    # Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

    # You may assume that each input would have exactly one solution, and you may not use the same element twice.

    # You can return the answer in any order.

    

    # Example 1:

    # Input: nums = [2,7,11,15], target = 9
    # Output: [0,1]
    # Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
    # Example 2:

    # Input: nums = [3,2,4], target = 6
    # Output: [1,2]
    # Example 3:

    # Input: nums = [3,3], target = 6
    # Output: [0,1]
    

    # Constraints:

    # 2 <= nums.length <= 104
    # -109 <= nums[i] <= 109
    # -109 <= target <= 109
    # Only one valid answer exists.
    

    # Follow-up: Can you come up with an algorithm that is less than O(n2) time complexity?

# Solution
from typing import List

class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        for i in range(len(nums)):
            expectedVal = target - nums[i]
            if(expectedVal in nums) and (i != nums.index(expectedVal)):
                return([i, nums.index(expectedVal)])


s = Solution()
A_nums = [[2,7,11,15],[3,2,4],[3,3]]
A_target = [9,6,6]

for i in range(len(A_nums)):
    nums = A_nums[i]
    target = A_target[i]
    print('Problem #', i+1, ' Nums = ', nums, ' Target = ', target, 'Solution Index =' , s.twoSum(nums, target))