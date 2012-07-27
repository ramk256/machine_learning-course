require 'matrix'

def identityMatrix(size)
  identity = Matrix.identity(size)
  
end

def printMatrix(matrix)
  matrix.each do |m| 
    print m
    print "\n"
  end
end

#we are going to have a cost function that takes in a 2-d array that represents a matrix of inputs and outputs

def computeCost(inputX, inputY, theta)
  cur_error = 0
  for i in 0..(inputX.length - 1) do
    hypothesis_val = theta[1] * inputX[i].to_f + theta[0]
    cur_error += (hypothesis_val - inputY[i].to_f)**2 
  end
  cur_error /= 2 * inputX.length
end

def gradientDescent(inputX, inputY, theta, num_iter, alpha)
  for iter in 1..num_iter do
    
    theta_sums = [0, 0]
    for i in 0..(inputX.length - 1) do
      difference = (theta[1] * inputX[i].to_f + theta[0]) - inputY[i].to_f
      theta_sums[0] += difference
      theta_sums[1] += difference * inputX[i].to_f
    end
   
    theta[0] -= (alpha / inputX.length) * theta_sums[0]
    theta[1] -= (alpha / inputX.length) * theta_sums[1] 
    
    puts computeCost(inputX, inputY, theta)
  end
  
  return theta
end

#identity = Matrix.identity(5)
#puts identity
inputX = []
inputY = []
File.open("ex1data1.txt", "r") do |infile|
  while (line = infile.gets)
    data_point = line.split(",")
    inputX << data_point[0]
    inputY << data_point[1]
  end
end

theta = [0, 0]

puts computeCost(inputX, inputY, theta)

newTheta = gradientDescent(inputX, inputY, theta, 1500, 0.001)

puts computeCost(inputX, inputY, newTheta)
