require 'KMeans'
require 'spec_helper'

#write some basic tests here
describe KMeans do
  
  let!(:kmeans) do
    KMeans.new(2, [["SAMPLE1", 1, 2], ["SAMPLE2", 3, 4]])
  end
    #{ KMeans.new(2, [["SAMPLE1", 1, 2], ["SAMPLE2", 3, 4]])}
  
  subject { kmeans }
  
  it "is a simple example" do
    kmeans.runKMeans()
    kmeans.centroids[0].should_not == kmeans.centroids[1]    
  end
  
  #have another test to ensure that the distortion goes down over time
  it "should show the distortion going down" do 
    prev_distortion = KMeans::LARGE_VALUE
    kmeans.init_data_and_centroids()
    kmeans.runIteration()
    cur_distortion = kmeans.distortion_function()
    
    cur_distortion.should_not be > prev_distortion
    
    while (cur_distortion != prev_distortion)
      prev_distortion = cur_distortion
      kmeans.runIteration()
      cur_distortion = kmeans.distortion_function()
      
      cur_distortion.should_not be > prev_distortion
    end
  end
  
  
end