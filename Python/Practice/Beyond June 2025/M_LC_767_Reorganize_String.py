# 767. Reorganize String

# Given a string s, rearrange the characters of s so that any two adjacent characters are not the same.
# Return any possible rearrangement of s or return "" if not possible.

# Example 1:

# Input: s = "aab"
# Output: "aba"
# Example 2:

# Input: s = "aaab"
# Output: ""
 

# Constraints:
# 1 <= s.length <= 500
# s consists of lowercase English letters.

from collections import Counter 
import math 

class Solution:
    def reorganizeString(self, s: str) -> str:
        c = Counter(s)
        # A dictionary with key as each alphabet letter and value as its count 

        mc = c.most_common(1)
        # most_common() returns a list of tuple of ('alphabet letter', count). 
        #       The elements will be in descending order
         
        
        mid = math.ceil(len(s)/2)
        # mid = (len(s) + 1) // 2

        len_s = len(s)
        
        if len_s == 0:
            return ''
        
        letter = mc[0][0]
        max_len = mc[0][-1]
        
        if max_len > mid:
            # print('here')
            return ''
        
        ans = [''] * len_s
        
        index = 0
        
        # Place the most frequent letter
        while c[letter] != 0:
            ans[index] = letter
            index += 2
            c[letter] -= 1

        # Place the rest 
        for char, count in c.items():
            while count > 0:
                if index >= len_s:
                    index = 1
                ans[index] = char
                index += 2
                count -= 1

        # print(ans)
        return ''.join(ans)  