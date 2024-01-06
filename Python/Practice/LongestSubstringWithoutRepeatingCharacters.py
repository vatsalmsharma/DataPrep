from typing import List
import time

class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        if(len(s) == 0):
            return 0
        
        if(len(s) == 1):
            return 1

        longest = 0
        start = 0
        end = start + 1
        string = [s[start]]

        while (end <= len(s)-1):
            if s[end] not in string:
                string.append(s[end])
                end += 1               
            else:    
                start += 1
                string = [s[start]]
                end = start + 1
                
            if longest < len(string):
                longest = len(string)

        return(longest)

sol = Solution()
s =   "dvdf" # 'bbbbb' # "abcabcbbqwertyuiopppasdfghjkl"
st = time.time()
res = sol.lengthOfLongestSubstring(s)
print(time.time() - st)
print(res)


