# NOTE: Until you fill in the TTTBoard class mypy is going
# to give you multiple errors talking about unimplemented
# class attributes, don't worry about this as you're working

#cell.board[1]
#create variable for each of 3 rows and then add them all together
#Create a list?


class TTTBoard:
    """A tic tac toe board

    Attributes:
        board - a list of '*'s, 'X's & 'O's. 'X's represent moves by player 'X',
        'O's represent moves by player 'O' and '*'s are spots no one has yet
        played on
    """
    def __init__(self, board):
        self.board = ["*","*","*","*","*","*","*","*","*"]
        

    def __str__(self):
        l = " " + str(self.board[0]) + " " + str(self.board[1]) + " " + str(self.board[2]) +"\n"
        l += " " + str(self.board[3]) + " " + str(self.board[4]) + " " + str(self.board[5]) +"\n"
        l += " " + str(self.board[6]) + " " + str(self.board[7]) + " " + str(self.board[8]) +"\n"
        return l

    def make_move(self, player:str, pos:int):
        self.pos = pos
        self.player = player
        if pos < 0 or pos > 8:
            return False
        elif self.board[pos] == '*':
            self.board[pos] = player
            return True
        else:
            return False
    def has_won(self, player):
        self.player = player
        if self.board[0] == self.board[3] == self.board[6] and self.board[0] != '*' and self.board[0] == player:
            return True
        elif self.board[1] == self.board[4] == self.board[7] and self.board[1] != '*' and self.board[1] == player:
            return True
        elif self.board[2] == self.board[5] == self.board[8] and self.board[2] != '*' and self.board[2] == player:
            return True
        elif self.board[0] == self.board[1] == self.board[2] and self.board[0] != '*' and self.board[0] == player:
            return True
        elif self.board[3] == self.board[4] == self.board[5] and self.board[3] != '*' and self.board[3] == player:
            return True
        elif self.board[6] == self.board[7] == self.board[8] and self.board[6] != '*' and self.board[6] == player:
            return True
        elif self.board[0] == self.board[4] == self.board[8] and self.board[0] != '*' and self.board[0] == player:
            return True
        elif self.board[2] == self.board[4] == self.board[6] and self.board[2] != '*' and self.board[2] == player:
            return True
        else:
            return False
    def game_over(self):
        
        if '*' not in self.board:
            return True
        elif self.has_won("X") == True:
            return True
        elif self.has_won("O") == True:
            return True
        else:
            return False
    def clear(self):
        self.board = ["*","*","*","*","*","*","*","*","*"]
        









        

        

        

    
        

    


# b1 = TTTBoard("*")
# b1.make_move("X",0)
# b1.make_move("O",2)
# b1.make_move("X",3)
# b1.make_move("O",5)
# b1.make_move("X",6)
# b1.make_move("O",4)
# b1.make_move("O",5)
# b1.make_move("X",7)
# b1.make_move("O",8)
# print(b1)
# # print(b1.make_move("X",2))
# print(b1)
# # print(b1.make_move("O",2))
# print(b1.has_won("X"))
# print(b1.has_won("O"))
# print(b1.game_over())
# b1.clear()
# print(b1)



def play_tic_tac_toe() -> None:
    """Uses your class to play TicTacToe"""

    def is_int(maybe_int: str):
        """Returns True if val is int, False otherwise

        Args:
            maybe_int - string to check if it's an int

        Returns:
            True if maybe_int is an int, False otherwise
        """
        try:
            int(maybe_int)
            return True
        except ValueError:
            return False

    brd = TTTBoard("*")
    players = ["X", "O"]
    turn = 0
    

    while not brd.game_over():
        print(brd)
        move: str = input(f"Player {players[turn]} what is your move? ")

        if not is_int(move):
            raise ValueError(
                f"Given invalid position {move}, "
                "position must be integer between 0 and 8 inclusive"
            )

        if brd.make_move(players[turn], int(move)):
            turn = not turn

    print(f"\nGame over!\n\n{brd}")
    if brd.has_won(players[0]):
        print(f"{players[0]} wins!")
    elif brd.has_won(players[1]):
        print(f"{players[1]} wins!")
    else:
        print(f"Board full, that's game!")


# if __name__ == "__main__":
#     # here are some tests. These are not at all exhaustive tests. You will
#     # DEFINITELY need to write some more tests to make sure that your TTTBoard class
#     # is behaving properly.
#     brd = TTTBoard("*")
#     brd.make_move("X", 8)
#     brd.make_move("O", 7)

#     assert brd.game_over() == False

#     brd.make_move("X", 5)
#     brd.make_move("O", 6)
#     brd.make_move("X", 2)

#     assert brd.has_won("X") == True
#     assert brd.has_won("O") == False
#     assert brd.game_over() == True

#     brd.clear()

#     assert brd.game_over() == False

#     brd.make_move("O", 3)
#     brd.make_move("O", 4)
#     brd.make_move("O", 5)

#     assert brd.has_won("X") == False
#     assert brd.has_won("O") == True
#     assert brd.game_over() == True

#     print("All tests passed!")

    # uncomment to play!
play_tic_tac_toe()
