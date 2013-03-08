require 'spec_helper'

describe MoviesController do
	describe 'searching for movies with the same director' do
		before :each do
			@fake_results = [mock('m1'), mock('m2')]
		end		
		it 'should call the model method same_director' do
			Movie.should_receive(:same_director).with("1").and_return(@fake_results)
			post :by_director, {:id => "1"}
		end
		describe 'after valid search' do
			before :each do
				Movie.stub(:same_director).and_return(@fake_results)
				post :by_director, {:id => "1"}
			end
			it 'should render the movies by director template' do
				response.should render_template("by_director")
			end
		end
		describe 'If the movie did not have director information' do
			before :each do
				
				Movie.stub(:same_director).and_return("Aladdin")
				post :by_director, {:id => "1"}
			end
			it 'Should redirect the home page template' do
				response.should redirect_to("/movies")
			end
			it 'Should flash --movie has no director info--' do
				flash[:notice].should == "\'Aladdin\' has no director info"
			end
		end
	end
end
