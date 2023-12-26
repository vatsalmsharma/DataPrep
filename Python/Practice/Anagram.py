class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        dictS = {}
        dictT = {}

        if(len(s) != len(t)):
            return False
        if(set(s) != set(t)):
            return False
        else:
            for a in s:
                if(a in dictS.keys()):
                    dictS[a] += 1
                else:
                    dictS[a] = 1
            for b in t:
                if(b in dictT.keys()):
                    dictT[b] += 1
                else:
                    dictT[b] = 1
            # print('S = ', dictS)
            # print('T = ', dictT)
            for k in dictS.keys():
                if(dictS[k] != dictT[k]):
                    return False
        return True

    # Appaorach 2
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False
        char_count_s = [0] * 26
        char_count_t = [0] * 26
        for char in s:
            char_count_s[ord(char) - ord('a')] += 1
        for char in t:
            char_count_t[ord(char) - ord('a')] += 1
        return char_count_s == char_count_t    

sol = Solution()
s = 'anagram'
t = 'nagamar'
print(sol.isAnagram(s,t))