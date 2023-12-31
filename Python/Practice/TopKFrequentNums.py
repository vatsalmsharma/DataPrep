# Name : 347. Top K Frequent Elements
# URL : https://leetcode.com/problems/top-k-frequent-elements/description/
# Level : Medium

# Problem details:
        # Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.

        

        # Example 1:

        # Input: nums = [1,1,1,2,2,3], k = 2
        # Output: [1,2]
        # Example 2:

        # Input: nums = [1], k = 1
        # Output: [1]
        

        # Constraints:

        # 1 <= nums.length <= 105
        # -104 <= nums[i] <= 104
        # k is in the range [1, the number of unique elements in the array].
        # It is guaranteed that the answer is unique.
        

        # Follow up: Your algorithm's time complexity must be better than O(n log n), where n is the array's size.

# Solution
from typing import List

class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        myDict = {}

        for n in nums:
            if n in myDict.keys():
                myDict[n] += 1
            else:
                myDict[n] = 1
        
        myArr = []
        for key,val in myDict.items():
            myArr.append((val,key))
        myArr.sort()

        output = []
        for (x,y) in myArr[-k:]:
            output.append(y)
        
        return output