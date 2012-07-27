#require 'matrix'
#
def sigmoid(x)
1 / (1 + Math::E**(-x))  
end


## we just multiply x by its theta value and adding, that will give the hypothesis value
def computeCost(inputX, inputY, theta)
  cur_error = 0
  for i in 0..(inputY.length - 1) do
    hypothesis_val = get_hypothesis_val(inputX, inputY, theta, i)
    
    y_val = inputY[i].to_f
    puts "y val is " + y_val.to_s
    puts "hypothesis val is " + hypothesis_val.to_s
    
    if (y_val == 1.0)
      cur_error += -Math.log(hypothesis_val)
    else
      cur_error += -Math.log(1 - hypothesis_val)
    end
   # cur_error += (-y_val) * Math.log(hypothesis_val) - (1 - y_val) * Math.log(1 - hypothesis_val)
  end
  cur_error /= inputY.length
  
  return cur_error
end

def get_hypothesis_val(inputX, inputY, theta, i)
  sigmoid_input = inputX[2 * i].to_f * theta[1] + inputX[2 * i + 1].to_f * theta[2] + theta[0]
#  puts "hypothesis value is" + sigmoid(sigmoid_input).to_s
  sig_val = sigmoid(sigmoid_input)
  
#  if (sig_val >= 0.5)
#    puts "hyp value is " + 1.0.to_s
 #   return 1.0
  #else
   # puts "hyp value is " + 0.0.to_s
    #return 0.0
 # end
end

def logisticRegression(inputX, inputY, theta, num_iter, alpha)
  for iter in 1..num_iter do
    
    theta_sums = [5, -1, 0]
    for i in 0..(inputY.length - 1) do
      difference = get_hypothesis_val(inputX, inputY, theta, i) - inputY[i].to_f
      theta_sums[0] += difference
      theta_sums[1] += difference * inputX[2 * i].to_f
      theta_sums[2] += difference * inputX[2 * i + 1].to_f
    end
   
    theta[0] -= (alpha / inputY.length) * theta_sums[0]
    theta[1] -= (alpha / inputY.length) * theta_sums[1] 
    theta[2] -= (alpha / inputY.length) * theta_sums[2]
    
    puts computeCost(inputX, inputY, theta)
  end
  
  return theta
end


inputX = []
inputY = []
File.open("ex2data1.txt", "r") do |infile|
  while (line = infile.gets)
    data_point = line.split(",")
    inputX << data_point[0]
    inputX << data_point[1]
    inputY << data_point[2]
  end
end

theta = [0, 0, 0]

puts computeCost(inputX, inputY, theta)
newTheta = logisticRegression(inputX, inputY, theta, 1500, 0.001)
#puts computeCost(inputX, inputY, newTheta)
puts sigmoid(0)
