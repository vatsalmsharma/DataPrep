class Solution:
    def isValid(self, s: str) -> bool:
        if ((len(s)%2 != 0) or (len(s) == 0)):
            return False
        
        sArr = [p for p in s]
        # print(sArr)

        open = ['(', '{', '[']
        close = [')', '}', ']']
        pdict = {'(': ')', '{': '}', '[': ']'}

        # print(pdict)

        ptrS = 0
        ptrE = 1
        while (len(sArr) > 0 and ptrE <= len(sArr)):
            ptrE = ptrS + 1
            print('End ', sArr[ptrE] , ' start ', pdict[sArr[ptrS]])
            print('input Arr' , sArr)

            if(sArr[ptrS] in open) and (sArr[ptrE] in close):
                if (sArr[ptrE] == pdict[sArr[ptrS]]):
                    sArr.pop(ptrE)
                    sArr.pop(ptrS)
                    if (len(sArr) == 0):
                        return True
                    else:
                        ptrS = ptrS - 1
                        print('s = ', ptrS)
                        

        if (len(sArr) == 0):
            return True
        else:
            return False


solu = Solution()
s = "()[]{}" # "()"
print(solu.isValid(s))

