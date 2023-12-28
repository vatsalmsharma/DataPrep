# Name : 49. Group Anagrams
# URL : https://leetcode.com/problems/group-anagrams/description/
# Level : Medium

# Problem details:
    # Given an array of strings strs, group the anagrams together. You can return the answer in any order.

    # An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

    

    # Example 1:

    # Input: strs = ["eat","tea","tan","ate","nat","bat"]
    # Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
    # Example 2:

    # Input: strs = [""]
    # Output: [[""]]
    # Example 3:

    # Input: strs = ["a"]
    # Output: [["a"]]
    

    # Constraints:

    # 1 <= strs.length <= 104
    # 0 <= strs[i].length <= 100
    # strs[i] consists of lowercase English letters.

#Solution: 
from typing import List

class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        def isAnagram(word1, word2):
            dict1 = {}
            dict2 = {}
            if len(word1) == len(word2):
                if(set(word1) == set(word2)):
                    for w1 in word1:
                        if w1 in dict1.keys():
                            dict1[w1] += 1
                        else:
                            dict1[w1] = 1

                    for w2 in word2:
                        if w2 in dict2.keys():
                            dict2[w2] += 1
                        else:
                            dict2[w2] = 1
        
                    for k in dict1.keys():
                        if(dict1[k] != dict2[k]):
                            return False
                    return True
            return False
        
        output = [[strs[0]]]
        for word in strs[1:]:
            wordAdd = False
            # if(len(output) == 0):
            #     tempList = [word]
            #     output.append(tempList)
            # else:
            for o in output:
                if(word in o):
                    o.append(word)
                    wordAdd = True
                else:
                    if len(o) > 0:
                        if(isAnagram(o[0], word)):
                            o.append(word)
                            wordAdd = True
            if(not wordAdd):
                tempList = [word]
                output.append(tempList)

        return output

s = Solution()
#strs = ["eat","tea","tan","ate","nat","bat"]
strs = ["",""]
print(strs)
print(s.groupAnagrams(strs))

# Approach 2 
mydict = {}
strs = ["eat","tea","tan","ate","nat","bat"]
for s in strs:
    k = ''.join(sorted(s))
    print(s, k)
    if k in mydict.keys():
        mydict[k].append(s)
    else:
        mydict[k] = [s]
print(list(mydict.values()))

'''
Intuition:
The intuition is to group words that are anagrams of each other together. Anagrams are words that have the same characters but in a different order.

Explanation:
Let's go through the code step by step using the example input ["eat","tea","tan","ate","nat","bat"] to understand how it works.

Initializing Variables

We start by initializing an empty unordered map called mp (short for map), which will store the groups of anagrams.
Grouping Anagrams
We iterate through each word in the input vector strs. Let's take the first word, "eat", as an example.

Sorting the Word
We create a string variable called word and assign it the value of the current word ("eat" in this case).

Next, we sort the characters in word using the sort() function. After sorting, word becomes "aet".

Grouping the Anagram
We insert word as the key into the mp unordered map using mp[word], and we push the original word ("eat") into the vector associated with that key using mp[word].push_back(x), where x is the current word.

Since "aet" is a unique sorted representation of all the anagrams, it serves as the key in the mp map, and the associated vector holds all the anagrams.

For the given example, the mp map would look like this after processing all the words:

{
  "aet": ["eat", "tea", "ate"],
  "ant": ["tan", "nat"],
  "abt": ["bat"]
}
Creating the Result
We initialize an empty vector called ans (short for answer) to store the final result.

We iterate through each key-value pair in the mp map using a range-based for loop. For each pair, we push the vector of anagrams (x.second) into the ans vector.
For the given example, the ans vector would look like this:

[
  ["eat", "tea", "ate"],
  ["tan", "nat"],
  ["bat"]
]
Returning the Result
We return the ans vector, which contains the groups of anagrams.

https://leetcode.com/problems/group-anagrams/solutions/3687735/beats-100-c-java-python-beginner-friendly/
'''