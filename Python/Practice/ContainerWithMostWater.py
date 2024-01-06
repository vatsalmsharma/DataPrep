# Name : 11. Container With Most Water
# URL : https://leetcode.com/problems/container-with-most-water/description/
# Level : Medium

# Problem details:
    # You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).

    # Find two lines that together with the x-axis form a container, such that the container contains the most water.

    # Return the maximum amount of water a container can store.

    # Notice that you may not slant the container.

    # Example 1:

    # Input: height = [1,8,6,2,5,4,8,3,7]
    # Output: 49
    # Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
    # Example 2:

    # Input: height = [1,1]
    # Output: 1
    

    # Constraints:

    # n == height.length
    # 2 <= n <= 105
    # 0 <= height[i] <= 104

# Solution : 
from typing import List
class Solution:
    def maxArea(self, height: List[int]) -> int:
        maxArea = 0
        fIdx = 0
        lIdx = len(height)-1

        while lIdx > fIdx:
            firstH = height[fIdx]
            lastH = height[lIdx]

            minH = min(firstH, lastH)
            area = minH * (lIdx - fIdx)

            if maxArea < area:
                maxArea = area

            if minH == firstH:
                fIdx += 1
            else:
                lIdx -= 1
            
        return maxArea
