from neural import *

nn = NeuralNet(2, 5, 1)

xorData = [([1.0,1.0],[0.0]),([0.0,1.0],[1.0]),([1.0,0.0],[1.0]),([0.0,0.0],[0.0])]

# nn.train(xorData, iters = 10000, print_interval = 500)

# nn = NeuralNet(2, 1, 1)

# nn.train(xorData, iters = 10000, print_interval = 1000)

#Error does not reset so have to recall function

for triple in nn.test_with_expected(xorData): print(triple)


#1
#1.1: After about 2500 iterations the weights converge
#1.2: The final error is about .0003
#1.3:

# nn = NeuralNet(2, 1, 1)
# nn.train(xorData, iters = 10000, print_interval = 500)

# nn = NeuralNet(2, 10, 1)
# nn.train(xorData, iters = 10000, print_interval = 500)



#2

# nn = NeuralNet(2, 8, 1)
# nn.train(xorData, iters = 10000, print_interval = 500)

#2: It did take less clock time and it did result in a better approximation to the XOR function

#3:

# nn = NeuralNet(2, 1, 1)
# nn.train(xorData, iters = 10000, print_interval = 500)

#3: It gets stuck around .344 error

#4:

# xorData1 = [([0.9,0.6,0.8,0.3,0.1],[1.0]),
# ([0.8,0.8,0.4,0.6,0.4],[1.0]),
# ([0.7,0.2,0.4,0.6,0.3],[1.0]),
# ([0.5,0.5,0.8,0.4,0.8],[0.0]),
# ([0.3,0.1,0.6,0.8,0.8],[0.0]),
# ([0.6,0.3,0.4,0.3,0.6],[0.0])]

# nn = NeuralNet(5,8,1)

# nn.train(xorData1, iters = 10000, print_interval= 500)



# xorData2 = [([1.0,1.0,1.0,0.1,0.1],[1.0]),
# ([0.5,0.2,0.1,0.7,0.7],[0.0]),
# ([0.8,0.3,0.3,0.3,0.8],[1.0]),
# ([0.8,0.3,0.3,0.8,0.3],[0.0]),
# ([0.9,0.8,0.8,0.3,0.6],[1.0])]

# for triple in nn.test_with_expected(xorData2): print(triple)

#4: Some conclusions were fairly in line with what the test data. However others, namely the 4th option in the list
# had an extremely strong conclusion that the voter was a Republican. On it's face it would not have appeared his would be the case.