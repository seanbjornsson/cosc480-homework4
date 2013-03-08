require 'spec_helper'

describe Movie do
	before :each do
		@fake_movie1 = FactoryGirl.build(:movie, :title =>'good movie', :rating => 'G', :id => 1, :director => 'sean bjornsson')
		@fake_movie2 = FactoryGirl.build(:movie, :title =>'bad movie', :rating => 'R', :id => 2, :director => '')
	end
	it 'should search the movie database and return movies with the same director' do
			Movie.should_receive(:find).with(@fake_movie1.id).and_return(@fake_movie1)
			Movie.same_director(@fake_movie1.id)
	end
	describe 'if the movie had no director info' do
		it 'should return the title of the movie' do
				Movie.stub(:find).and_return(@fake_movie2)
				Movie.same_director(@fake_movie2).should == "#{@fake_movie2.title}"
		end
	end
	describe 'finding all ratings' do
		Movie.all_ratings.should == ["G", "PG", "PG-13",  "NC-17", "R"]
	end
end

