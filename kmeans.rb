

# this class will be generic and flexible 
#
#


class KMeans
 
  #a data point has a name, data, and a centroid_info 
  #(which contains the id of the centroid it belongs to as well as the distance to it)
  class DataPoint
     attr_accessor :centroid_info, :data, :name
   
     def initialize(name, data)
       @data = data
       @name = name
    end
  end
 
 attr_accessor :centroids, :data
 
 LARGE_VALUE = 1000000
 
 EPSILON_VALUE = 1
 
 #each entry of the data array is a list of numbers which represent a certain attribute of the stock 
 #for our purposes, the way we store data will be as an array of type DataPoint
 
  def initialize(num_clusters, data)
    @data = []
    data.each { |data_value| @data << DataPoint.new(data_value[0], data_value.slice(1, data_value.length - 1)) }

    #here we would get the data, and randomize the centroids roughly based on the distribution of the data
    randomize_centroids(num_clusters)
  end
  
  # this method randomizes the centroids in a roughly uniform manner
  def randomize_centroids(num_clusters)
    if (num_clusters > @data.length)
      puts "There are more clusters than data points!"
      puts "num_clusters will be set to the # of data points"
      num_clusters = @data.length 
    end
    #we get the centroids randomly from the data itself
    @centroids = @data.sort_by{rand}[0..num_clusters-1].map{ |x|  x.data  }
  end
 
  #this actually runs the k-means clustering algorithm
  #we know that once the centroids stop moving, we can stop
  def runKMeans()
    #this variable represents how much the centroids have moved after an iteration
    #let's initialize it to a large value
    centroid_shift = LARGE_VALUE
   
    while (centroid_shift > EPSILON_VALUE)
      set_closest_centroids()
      centroid_shift = shift_centroids()
    end
  end
  
  #this method does two things:
  #1), it shifts the centroids based on the avg of data points that
  #are closest to it
  #2), it returns the total number of shift that occurs as a result 
  #of step 1
  def shift_centroids
    old_centroid = []
    total_shift = 0
    @centroids = @centroids.each_with_index.map do |centroid, index|
      old_centroid = centroid 
      centroid = shift_centroid(old_centroid, index)
      total_shift += calculate_distance(centroid, old_centroid)
      centroid
    end
    return total_shift
  end
  
  
  #this method will go through all the data points that belong to the
  #given centroid and calculates their average and sets the centroid's
  #value to that point
  def shift_centroid(centroid, index)
    new_location = Array.new(centroid.length, 0)  
    num_points = 0
    @data.each do |data_point|
      if data_point.centroid_info[1] == index
        new_location = new_location.each_with_index.map { |datum, dat_index| datum += data_point.data[dat_index] }
        num_points += 1
      end 
    end
    
    return centroid if num_points == 0
    
    new_location.map { |datum| datum = datum / num_points}
  end
  
  def set_closest_centroids
    @data.map {|x| x.centroid_info = set_closest_centroid(x.data) }
  end
  
  #this function takes in a data point and returns an array that contains
  #the distance of the closest centroid to the data point and the index of
  #that closest centroid 
  def set_closest_centroid(data_point)
    min = [LARGE_VALUE, 2]
    @centroids.each_with_index do |centroid_point, centroids_index|
      new_min = find_distance_between(data_point, centroid_point, centroids_index)
      if (new_min[0] < min[0])
        min = new_min
      end
    end
    return min
  end
  
  #this method finds the Euclidean distance between a data point and a centroid point
  def find_distance_between(data_point, centroid_point, centroids_index)
    return [calculate_distance(data_point, centroid_point), centroids_index]
  end
  
  #this method finds the Euclidean distance between two points
    
  def calculate_distance(point1, point2)
    sum_of_squares = 0
    point1.each_with_index do |point1_coord, index|
      sum_of_squares += (point1_coord - point2[index])**2
    end
    return Math.sqrt(sum_of_squares)
  end
    
end

### let's write some sample code, then possibly write some tests for this code


data = []

for i in 1..5
  data << ["SAMPLE#{i}", rand(100).to_f, rand(100.to_f)]
end
puts data

kmeans = KMeans.new(2, data)

kmeans.runKMeans()
