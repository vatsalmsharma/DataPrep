class Solution:
    def minWindow(self, s: str, t: str) -> str:
        out = ''
        
        if(len(t) > len(s)):
            return out
        
        if(len(t) == len(s)):
            if(sorted(s) == sorted(t)):
                return s
        
        tLen = len(t)
        first = 0
        end = first + (tLen -1)
        
        
        for n in range(len(s)):
            while end < len(s):
                count = 0 
                ss = s[first: (end + 1)]
                for te in t:
#                    print('ss =>', ss)
                    
                    if te in ss:
                        ss = ss.replace(te,'',1)
                        count += 1

                if count == tLen:
                    return s[first: (end + 1)]
                else:
                    first += 1
                    end = first + (tLen -1) + n
                
#            print('here for n = ', n)
            first = 0
            end = first + (tLen -1) + (n+1)
                    
        return out

    
    def minWindoW(self, s: str, t: str) -> str:
        minWin = ''
        minWinLen = float('inf')
        left, right = 0,0
        while left <= len(s) and right <= len(s):
            print('left => ', left, ' right => ', right)
            sub = s[left:right]
            for sEle in sub:
                if sEle not in t:
                    sub = sub.replace(sEle,'')
            
            if(sorted(sub) == sorted(t)):
                win = sub
                if(len(win) < minWinLen):
                    minWinLen = len(win)
                    minWin = win.copy()
                left += 1
            else:
                right += 1
        return(minWin)

sol = Solution()
s = 'ADOBECODEBANC'
t = 'ABC'

print(sol.minWindoW(s,t))