# 118. Pascal's Triangle
'''
Given an integer numRows, return the first numRows of Pascal's triangle.

In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:

Example 1:

Input: numRows = 5
Output: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
Example 2:

Input: numRows = 1
Output: [[1]]
 

Constraints:

1 <= numRows <= 30
'''

class Solution:
    def generate(self, numRows: int) -> List[List[int]]:
        ans = []

        for n in range(numRows):
            nn = n + 1

            if nn == 1:
                ans.append([1])
            elif nn == 2:
                ans.append([1,1])
            elif nn >= 3:
                arr = ['']*nn

                arr[0] = 1
                arr[-1] = 1

                prev = ans[-1]

                for a in range(nn):
                    if arr[a] != 1:
                        arr[a] = prev[a-1] + prev[a]
                
                ans.append(arr)
                prev = arr

        # print('Final => ', ans)
        return (ans)