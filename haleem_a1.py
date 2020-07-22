"""Assignment 1

Fill in the following function skeletons (deleting the 'raise NotImplementedError' lines as you go) - descriptions are provided in the PDF, and briefly in the docstring (the triple quote thing at the top of each function).

Some assert statements have been provided - write more of them to test your code!
"""

from typing import List, TypeVar


def absolute(n: int) -> int:
    """Gives the absolute value of the passed in number. Cannot use the built
    in function `abs`.

    Args:
        n - the number to take the absolute value of

    Returns:
        the absolute value of the passed in number
    """
    return (n**2)**0.5
    

assert absolute(-1) == 1, "absolute of -1 failed"
assert absolute(-2) == 2, "absolute of -2 failed"
assert absolute(-0.5) == 0.5, "absolute of -0.5 failed"
assert absolute(-25.5) == 25.5, "absolute of -25.5 failed"
def factorial(n: int) -> int:
    """Takes a number n, and computes the factorial n! You can assume the passed
    in number will be positive

    Args:
        n - the number to compute factorial of

    Returns:
        factorial of the passed in number
    """
    listn = list(range(n))
    curr = 0
    fact = 1
    while (curr<n):
        listp = listn
        x = listp[0] + 1
        fact = fact * x
        curr += 1
        listp.pop(0)


    return fact

assert factorial (5) == 120, "factorial of 5 failed"
assert factorial(4) == 24, "factorial of 4 failed"
assert factorial(0) == 1, "factorial of 0 failed"
assert factorial(1) == 1, "factorial of 1 failed"

T = TypeVar("T")


def every_other(lst: List[T]) -> List[T]:
    """Takes a list and returns a list of every other element in the list,
    starting with the first.

    Args:
        lst - a list of any (constrained by type T to be the same type as the
            returned list)

    Returns:
        a list of every of other item in the original list starting with the first
    """
    lista = []
    n = 0



    while n < len(lst):
        lista.append(lst[n])
        n+=2
    return lista



assert every_other([1,2,3,4,5,6,7]) == [1,3,5,7], "every_other of [1,2,3,4,5,6,7] failed"
assert every_other([1, 2, 3, 4, 5]) == [1,3,5], "every_other of [1,2,3,4,5] failed"
assert every_other([0.5,1,1.5]) == [0.5,1.5], "every_other of [0.5,1,1.5] failed"
assert every_other([1,2]) == [1], "every_other of [1,2] failed"

def sum_list(lst: List[int]) -> int:
    """Takes a list of numbers, and returns the sum of the numbers in that list.
    Cannot use the built in function `sum`.

    Args:
        lst - a list of numbers

    Returns:
        the sum of the passed in list
    """
    a = len(lst)
    curr = 0
    suma = 0
    while curr < a:
        suma = suma + lst[0]
        lst.pop(0)
        curr +=1
    return suma

assert sum_list([1,5,10,-20]) == -4, "sum_list of [1,5,10.-20] failed"
assert sum_list([1, 2, 3]) == 6, "sum_list of [1,2,3] failed"
assert sum_list([0,1,2]) == 3, "sum_list of [0,1,2] failed"
assert sum_list([0]) == 0, "sum_list of [0] failed"


def mean(lst: List[int]) -> float:
    """Takes a list of numbers, and returns the mean of the numbers.

    Args:
        lst - a list of numbers

    Returns:
        the mean of the passed in list
    """
    b = len(lst)
    a = sum_list(lst)
    c = a/b
    return c


assert mean([1, 2, 3, 4, 5]) == 3, "mean of [1,2,3,4,5] failed"
assert mean ([1,2,3]) == 2, "mean of [1,2,3] failed"
assert mean ([1,1.5,2]) == 1.5, "mean of [1,1.5,2] failed"
assert mean ([0]) == 0, "mean of [0] failed"


def median(lst: List[int]) -> float:
    """Takes an ordered list of numbers, and returns the median of the numbers.
    If the list has an even number of values, it computes the mean of the two
    center values.

    Args:
        lst - an ordered list of numbers

    Returns:
        the median of the passed in list
    """
    n = len(lst)
    m = len(lst)
    curr = 0
    a = 0

    if len(lst) == 1:
        a = lst[0]

    elif len(lst) == 2:
        a = mean(lst)

    elif len(lst)%2 != 0:
        while lst != [] and n - 1 != curr:
            lst.pop(0)
            lst.reverse()
            curr +=1
            a = lst[0]

    elif len(lst)%2 == 0 and len(lst) != 2:
        while lst != [] and m-2 != curr:
            lst.pop(0)
            lst.reverse()
            curr +=1
        a = mean(lst)
    
    return a
        
assert median([1, 2, 3, 4, 5]) == 3, "median of [1,2,3,4,5] failed"
assert median ([1]) == 1, "median of [1] failed"
assert median ([1,2]) == 1.5, "median of [1,2] failed "
assert median ([1,2,3,4,5,6]) == 3.5, "median of [1,2,3,4,5,6] failed"
assert median ([1,4,6,10]) == 5, "median of [1,4,6,10] failed"

def duck_duck_goose(lst: List[str]) -> List[str]:
    """Given an list of names (strings), play 'duck duck goose' with it,
    knocking out every third name (wrapping around) until only two names are
    left. In other words, when you hit the end of the list, wrap around and keep
    counting from where you were.

    For example, if given this list ['Nathan', 'Sasha', 'Sara', 'Jennie'], you'd
    first knock out Sara. Then first 'duck' on Jennie, wrap around to 'duck' on
    Nathan and 'goose' on Sasha - knocking him out and leaving only Nathan and
    Jennie.

    You may assume the list has 3+ names to start

    Args:
        lst - a list of names (strings)

    Returns:
        the resulting list after playing duck duck goose
    """
    n = len(lst)
    curr = 0

    while n > 2:
        if curr >= n:
            curr = 0
        n = len(lst)
        print (lst[curr], "is duck1")
        curr +=1
        if curr >= n:
            curr = 0
        print (lst[curr], "is duck2")
        curr +=1
        if curr >= n:
            curr = 0
        print(lst[curr], "is goose")
        lst.pop(curr)
        n = len(lst)
    return lst


names = ["sasha", "nathan", "jennie", "shane", "will", "sara"]
assert duck_duck_goose(names) == ['sasha', 'will']
names1 = ['sasha', 'nathan', 'jennie', 'shane', 'will']
assert duck_duck_goose(names1) == ['nathan', 'shane']
names2 = ['sasha', 'nathan', 'jennie', 'shane']
assert duck_duck_goose(names2) == ['sasha', 'shane']

print("All tests passed!")
