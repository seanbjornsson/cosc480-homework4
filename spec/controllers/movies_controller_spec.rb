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
	describe 'list all movies in the data base on the homepage' do
		it 'should pull the movie ratings  from the model' do
			Movie.should_receive(:all_ratings).and_return(["G", "PG", "PG-13",  "NC-17", "R"])
			post :index
		end
		describe 'when the sort is --release_date--' do
			it 'updates session if needed' do
			post :index, {:sort => 'release_date'}
			end
		end
		
		
		describe 'update session if needed' do
			it'should be able to update variables if session[:sort] and params[:sort] are different' do
				session.stub(:sort).with("release_date")
				post :index, {:sort => "title"}
			end
		
		end
	end
	describe 'when a specific movie needs to be shown' do
		it 'should look up the movie in the model ' do
				fake_movie = mock("movie")
				Movie.should_receive(:find).with("1").and_return(fake_movie)
				post :show, {:id => "1"}
		end
	end
	describe 'when a movie needs to be created' do
		it 'should create a new model object' do
			fake_movie = mock("movie1")
			Movie.stub(:create).and_return(fake_movie)
			post :create, {:title => 'good movie', :id => '1'}
		end
	end
	describe 'when a movie needs to be updated' do
		it 'should lookup the movie' do
			@fake_movie1 = FactoryGirl.build(:movie, :title =>'good movie', :rating => 'G', :id => 1, :director => 'sean bjornsson')
			Movie.should_receive(:find).with("1").and_return(@fake_movie1)
			post :update, {:id => 1}
		end
	end
	describe 'when a movie needs to be edited' do
		it 'should look ups the attributes' do
			@fake_movie1 = FactoryGirl.build(:movie, :title =>'good movie', :rating => 'G', :id => 1, :director => 'sean bjornsson')
			Movie.should_receive(:find).with("1").and_return(@fake_movie1)
			post :edit, {:id => 1}
		end
	end
end
