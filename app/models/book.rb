class Book < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews

  def self.recommendation(current_user)
    # find all of the books that current_user has reviewed
    reviews = current_user.reviews.joins(:book).preload(:book)

    # find all of the people who have reviewed all of those books with the same review as you
    people = []
    reviews.each do |review|
      book = review.book
      related_reviews = Review.joins(:user).where({book_id: book.id, worth_reading: review.worth_reading}).where.not(user_id: current_user.id).preload(:user)
      related_reviews.each do |related_review|
        people << related_review.user
      end
    end

    # find all of the books that all of those people have reviewed positively
    positively_reviewed_books = []
    people.each do |person|
      persons_reviews = person.reviews
      persons_reviews.each do |persons_review|
        if persons_review.worth_reading
          positively_reviewed_books << persons_review.book
        end
      end
    end
    
    # find which book is reviewed the most times
    book_counts = {}
    positively_reviewed_books.each do |prb|
      if book_counts[prb.id]
        book_counts[prb.id] += 1
      else
        book_counts[prb.id] = 1
      end
    end

    max = 0
    id_with_max = nil
    book_counts.each do |key, value|
      if value > max && !current_user.reviews.find_by(book_id: key)
        max = value
        id_with_max = key
      end
    end
    id_with_max && Book.find(id_with_max)
  end
end
