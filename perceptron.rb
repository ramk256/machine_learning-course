
# When we define a perceptron class, we need to have the number of layers, and the number of neurons in each layer
#

def sigmoid(x)
  1 / (1 + Math::E**(-x))  
end

class Perceptron
  attr_accessor :weights,:neurons, :deltas
 
  learning_rate = 0.005
 
  def initialize(num_neurons, num_inputs)
    #now, we initialize all the weights randomly 
    @weights = Array.new(num_neurons)
    @neurons = Array.new(num_neurons)
    @deltas = Array.new(num_neurons)
    
    for i in 0...num_neurons
      layer_length = num_neurons - i
      @neurons[i] = Array.new(layer_length)
      @deltas[i] = Array.new(layer_length)
      for j in 0...(layer_length)
        @neurons[i][j] = 0
        @deltas[i][j] = 0
      end
    end
    
    #now we can randomly initialize the weights
    prev = num_inputs
    current = num_neurons
    
    for i in 0...num_neurons
      @weights[i] = Array.new(prev)
      for j in 0...prev
        @weights[i][j] = Array.new(current)
        for k in 0...current
          @weights[i][j][k] = rand * 2 - 1
        end
      end
      prev = current
      current -= 1
    end
  end
  
  def train(input, output)
    feedforward(input)
    backpropagate(input, output)
  end
  
  ##this function will take in an input and calculate the output of the perceptron
  def feedforward(input)
    #calculate first layer
    for i in 0...weights[0][0].length
      sigmoid_input = 0  
      for j in 0...input.length
        sigmoid_input += input[j] * weights[0][j][i]
      end   
      #puts "neuron value " + sigmoid(sigmoid_input).to_s
      @neurons[0][i] = sigmoid(sigmoid_input)
    end
    
    #then all the other layers
    for i in 1...weights.length
      sigmoid_input = 0
      for j in 0...weights[i][0].length
        for k in 0...neurons[i - 1].length
          sigmoid_input += neurons[i - 1][k] * weights[i][k][j]
        end
        @neurons[i][j] = sigmoid(sigmoid_input)
      end 
    end 
    
    #return the output, which is the last neuron's value
    @neurons[@neurons.length - 1][0]
  end
    
  ## One question worth asking is, why do we multiply the difference by the derivative?
  def backpropagate(input, correct_val)
    #let's calculate all the deltas first
    compute_delta(correct_val)
    #now we have the deltas, we can go ahead and update the weights
    updateWeights(input) 
  end
  
  def activation_derivative(output_val)
    output_val * (1 - output_val)
  end
  
  def compute_delta(correct_val)
    output_val = @neurons[@neurons.length - 1][0]
    @deltas[@deltas.length - 1][0] = (correct_val - output_val)  * activation_derivative(output_val)

    #now go through each layer, calculating the deltas
    (@deltas.length - 2).downto(0) do |i|
      0.upto(@deltas[i].length - 1) do |j|
        
        #now we need to multiply the weights associated with the errors in the next layer that came from this node
        error_sum = 0
        0.upto(@weights[i + 1][j].length - 1) do |k|
          error_sum += @weights[i + 1][j][k] * @deltas[i + 1][k]
        end
        
        output_val = @neurons[i][j]
        @deltas[i][j] =  error_sum * activation_derivative(output_val)
      end
    end
  end
  
  def updateWeights(input)
    learning_rate = 0.005
    0.upto(@weights.length - 1) do |i|
      0.upto(@weights[i].length - 1) do |j|
        0.upto(@weights[i][j].length - 1) do |k|
          if (i == 0)
            @weights[i][j][k] += input[j] * @deltas[i][k] * learning_rate
          else
            @weights[i][j][k] += @neurons[i - 1][j] * @deltas[i][k] * learning_rate  
          end      
        end
      end
    end
  end
  
  def calculateRMSE(data)
    error_sum = 0
    data.each do |x|
      error_sum += calculateSE(x[0], x[1])
    end
    
    Math.sqrt(error_sum / (data.length))
  end
  
  def calculateSE(input, output)
    (feedforward(input) - output)**2
  end
end 
  



sample = Perceptron.new(4, 2)

puts sample.weights[0].length * sample.weights[0][0].length

data = []
counter = 0
File.open("ex2data1.txt", "r") do |infile|
  while (line = infile.gets)
    data << []
    data_point = line.split(",")
    data[counter] << []
    # the 0th index is the input
    data[counter][0] << data_point[0].to_f
    data[counter][0] << data_point[1].to_f
    
    #the 1th index is the output
    data[counter] << data_point[2].to_f
    counter += 1
  end
end

puts sample.calculateRMSE(data)
#puts sample.calculateSE(data[0][0], data[0][1])
##Now we can train on the data
0.upto(1000) do |i|
#  sample.train(data[0][0], data[0][1])
  data.each do |x|
    sample.train(x[0], x[1])
  end
puts sample.calculateRMSE(data)
#puts sample.calculateSE(data[0][0], data[0][1])  
end




