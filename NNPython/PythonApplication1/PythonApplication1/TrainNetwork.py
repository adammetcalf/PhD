import numpy
import scipy
import scipy.special
import csv

# neural network class definiton
class neuralNetwork:

    #initialise the neural network
    def __init__(self, inputNodes, hiddenNodes, outputNodes, learningRate):

        #set the number of nodes in each layer
        self.inodes = inputNodes
        self.hnodes = hiddenNodes
        self.onodes = outputNodes

        #link weight matrices, wih and who
        #weights inside the matrices are w_i_j, where link is from node i to node j in the next layer
        # w11 w21
        # w12 w22 etc
        self.wih = numpy.random.normal(0.0, pow(self.hnodes,-0.5),(self.hnodes,self.inodes))
        self.who = numpy.random.normal(0.0, pow(self.onodes,-0.5),(self.onodes,self.hnodes))

        #set the learningrate
        self.lr = learningRate

        # Using the sigmoid function as the activation function
        self.activationFunction = lambda x: scipy.special.expit(x)
        pass

    #train the neural network
    def train(self, inputsList, targetsList):
        #convert inputs list to a 2D array
        inputs = numpy.array(inputsList, ndmin=2).T
        targets = numpy.array(targetsList, ndmin=2).T

        #calculate signals into the hidden layer
        hiddenInputs = numpy.dot(self.wih,inputs)
        #calculate signals emerging from hidden layer
        hiddenOutputs = self.activationFunction(hiddenInputs)

        #calculate signals into the output layer
        finalInputs = numpy.dot(self.who,hiddenOutputs)
        #calculate signals emerging from putput layer
        finalOutputs = self.activationFunction(finalInputs)

        #output layer error is the target-actual
        outputErrors = targets - finalOutputs
        #hidden layer errors is outputError split by weights, recombined at hidden nodes
        hiddenErrors = numpy.dot(self.who.T, outputErrors)
        
        #Update the weights for the links between the hidden and output layers
        self.who += self.lr * numpy.dot((outputErrors*finalOutputs*(1.0-finalOutputs)),numpy.transpose(hiddenOutputs))
        
        #Update the weights for the links between the input and hidden layers
        self.wih += self.lr*numpy.dot((hiddenErrors*hiddenOutputs*(1.0-hiddenOutputs)),numpy.transpose(inputs))
 
        pass

    # query the neural network
    def query(self, inputsList):
        #convert inputs list to a 2D array
        inputs = numpy.array(inputsList, ndmin=2).T
        
        #calculate signals into the hidden layer
        hiddenInputs = numpy.dot(self.wih,inputs)
        #calculate signals emerging from hidden layer
        hiddenOutputs = self.activationFunction(hiddenInputs)

        #calculate signals into the output layer
        finalInputs = numpy.dot(self.who,hiddenOutputs)
        #calculate signals emerging from putput layer
        finalOutputs = self.activationFunction(finalInputs)
        
        return finalOutputs
#End of Class definiton

###### Define the layers, learning rate and create the class #######
#number of nodes in network layers
input_nodes = 4
hidden_nodes = 700
output_nodes = 2

#learning rate
learning_rate = 0.3

#create an instance of the neural network
n = neuralNetwork(input_nodes,hidden_nodes,output_nodes,learning_rate)
####### NN created ########

#Load the training data into a list
#trainingDataFile = open("C:/Users/adamg/Desktop/ForceData.csv",'r')
#trainingDataList = trainingDataFile.readlines()
#trainingDataFile.close

inputs = []
with open("C:/Users/adamg/Desktop/ForceData.csv") as csvfile:
    reader = csv.reader(csvfile, quoting=csv.QUOTE_NONNUMERIC) # change contents to floats
    for row in reader: # each row is a list
        inputs.append(row)
print(inputs)
targets = []
with open("C:/Users/adamg/Desktop/AnswerData.csv") as csvfile:
    reader = csv.reader(csvfile, quoting=csv.QUOTE_NONNUMERIC) # change contents to floats
    for row in reader: # each row is a list
        targets.append(row)
print(targets)
#train the neural network

epochs = 5
for e in range (epochs):


    n.train(inputs,targets)
    print("training")    

pass