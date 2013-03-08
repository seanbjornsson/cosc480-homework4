require 'spec_helper'

describe MoviesController do
	describe 'searching for movies with the same director' do
		it 'should call the model method same_director' do
			
			fake_movie = FactoryGirl.build(:movie, :title => 'Milk', :rating => 'R', :id => 1, :director => 'sean Bjornsson')
			results = [mock('m1'), mock('m2')]
			Movie.should_receive(:same_director).with("#{fake_movie.id}").and_return(results)
			post :by_director, {:id => fake_movie.id}
		
		end
	end
end
