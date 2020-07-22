from typing import List


def match(pattern: List[str], source: List[str]) -> List[str]:
    """Attempts to match the pattern to the source.

    % matches a sequence of zero or more words and _ matches any single word

    Args:
        pattern - a pattern using to % and/or _ to extract words from the source
        source - a phrase represented as a list of words (strings)

    Returns:
        None if the pattern and source do not "match" ELSE A list of matched words
        (words in the source corresponding to _'s or %'s, in the pattern, if any)
    """
    sind = 0  # current index we are looking at in source list
    pind = 0  # current index we are looking at in pattern list
    result: List[str] = []  # to store substitutions we will return if matched

    accumulating = False
    accumulator = ""

    # keep checking as long as we haven't hit the end of either pattern or source while
    # pind is still a valid index OR sind is still a valid index (valid index means that
    # the index is != to the length of the list)
    while (sind <= len(source) - 1) or (pind <= len(pattern) - 1):
        print("pind is:" + str(pind))
        print("sind is:" + str(sind))
        print("result is:" + str(result))
        print("accumulator is:" + str(accumulator))
        print("accumulating is:" + str(accumulating))
        
        
        # your job is to fill out the body of this loop

        
        # 1) if we reached the end of the pattern but not source
        if len(pattern) <= sind or pind == len(pattern):
            if accumulating == True and pind == len(pattern) -1:
                result.append(accumulator)
                accumulator = ""
                accumulating = False
                return result
            elif accumulating == True:
                accumulator = accumulator + " " + source[sind]
                accumulator = accumulator.strip()
                sind +=1
                print (accumulator)
                print (accumulating)
                #add current thing in source to accumulator
                #increment sind
                if sind == len(source):
                    result.append(accumulator)
                    print(result)
                    return result

            else:    
                result = None
                return result



        # 2) if the current thing in the pattern is a %
        # WARNING: this condition contains the bulk of the code for the assignment
        # If you get stuck on this one, we encourage you to attempt the other conditions
        #   and come back to this one afterwards
        #if current thing in the pattern is a %
        elif pattern[pind] == '%':
            if len(pattern) > len(source):
                accumulator = ""
                result.append(accumulator)
                return result
            else:
                pind +=1
                accumulating = True
                accumulator = ""


        # 3) if we reached the end of the source but not the pattern
        elif len(source) <= pind:
            result = None
            return result

        # 4) if the current thing in the pattern is an _
        elif (pattern[pind] == '_'):
            result.append(source[sind])
            pind +=1
            sind +=1

        # 5) if the current thing in the pattern is the same as the current thing in the
        # source
        elif (pattern[pind] == source[sind]):
            print(pattern[pind])
            print(source[sind])
            if accumulating == True and pind != sind:
                if accumulating == True and len(pattern) > len(source):
                    accumulator = ""
                    result.append(accumulator)
                    return result
                else:
                    result = None
                    return result
            elif accumulating == True and len(source) > len(pattern):
                accumulator = ""
                accumulating = False
                result = None
                return result
            elif accumulating == True:
                result.append(accumulator)
                accumulator = ""
                accumulating = False
                return result
            else:
                pind +=1
                sind +=1
                
            
    



        # 6) else : this will happen if none of the other conditions are met it
        # indicates the current thing it pattern doesn't match the current thing in
        # source
        elif (pattern[pind] != source[sind]):
            if accumulating == False:
                print(pattern[pind])
                print(source[sind])
                accumulating = False
                result.append(accumulator)
                accumulator = ""
                pind +=1
                sind +=1
                result = None
            elif accumulating == True:
                accumulator = accumulator + " " +source[sind]
                accumulator = accumulator.strip()
                sind +=1
            # stop accumulating
            #     change accumulating to False
            #     move the thing we accumulated to result
            #     set accumulator back to ""
            #     move forward in pind and sind
            print(accumulator)
    return result        
        
        
            
            
            



if __name__ == "__main__":
    assert match(["x", "y", "z"], ["x", "y", "z"]) == [], "test 1 failed"
    assert match(["x", "z", "z"], ["x", "y", "z"]) == None, "test 2 failed"
    assert match(["x", "y"], ["x", "y", "z"]) == None, "test 3 failed"
    assert match(["x", "y", "z", "z"], ["x", "y", "z"]) == None, "test 4 failed"
    assert match(["x", "_", "z"], ["x", "y", "z"]) == ["y"], "test 5 failed"
    assert match(["x", "_", "_"], ["x", "y", "z"]) == ["y", "z"], "test 6 failed"
    assert match(["%"], ["x", "y", "z"]) == ["x y z"], "test 7 failed"
    assert match(["x", "%", "z"], ["x", "y", "z"]) == ["y"], "test 8 failed"
    assert match(["%", "z"], ["x", "y", "z"]) == ["x y"], "test 9 failed"
    assert match(["x", "%", "y"], ["x", "y", "z"]) == None, "test 10 failed"
    assert match(["x", "%", "y", "z"], ["x", "y", "z"]) == [""], "test 11 failed"
    assert match(["x", "y", "z", "%"], ["x", "y", "z"]) == [""], "test 12 failed"
    assert match(["_", "%"], ["x", "y", "z"]) == ["x", "y z"], "test 13 failed"
    assert match(["_", "_", "_", "%"], ["x", "y", "z"]) == [
        "x",
        "y",
        "z",
        "",
    ], "test 14 failed"
    # this last case is a strange one, but it exposes an issue with the way we've
    # written our match function
    assert match(["x", "%", "z"], ["x", "y", "z", "z", "z"]) == None, "test 15 failed"

    print("All tests passed!")
