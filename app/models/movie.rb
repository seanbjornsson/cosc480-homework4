class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :director, :release_date
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
	def self.same_director(id)
		director = Movie.find(id).director
		if director == nil || director =~ /\s*/
			return nil
		end
		Movie.find_all_by_director(director)
	end
end
