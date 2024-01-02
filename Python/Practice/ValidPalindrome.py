# Name : 125. Valid Palindrome
# URL : https://leetcode.com/problems/valid-palindrome/
# Level : Easy

# Problem details:
        # A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

        # Given a string s, return true if it is a palindrome, or false otherwise.

        

        # Example 1:

        # Input: s = "A man, a plan, a canal: Panama"
        # Output: true
        # Explanation: "amanaplanacanalpanama" is a palindrome.
        # Example 2:

        # Input: s = "race a car"
        # Output: false
        # Explanation: "raceacar" is not a palindrome.
        # Example 3:

        # Input: s = " "
        # Output: true
        # Explanation: s is an empty string "" after removing non-alphanumeric characters.
        # Since an empty string reads the same forward and backward, it is a palindrome.
        

        # Constraints:

        # 1 <= s.length <= 2 * 105
        # s consists only of printable ASCII characters.

class Solution:
    def isPalindrome(self, s: str) -> bool:
        s = s.lower()
        sNew = ''
        for alphabets in s:
            if(ord(alphabets) >= ord('a') and ord(alphabets) <= ord('z')) :
                sNew += alphabets
            elif(ord(alphabets) >= ord('0') and ord(alphabets) <= ord('9')):
                sNew += alphabets
            else:
                pass
        
        if(sNew == sNew[::-1]):
            return (True)
        else:
            return(False)

# Other LeetCode recommend
# 234. Palindrome Linked List
# 680. Valid Palindrome II
# 2002. Maximum Product of the Length of Two Palindromic Subsequences