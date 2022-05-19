class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy

  #過去一週間分のいいねされたbook（課題7a）
  # has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'

  has_many :post_comments, dependent: :destroy

  #閲覧者数表示のアソシエーション
  has_many :view_counts, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day)} #今日の投稿数　scope :スコープの名前, -> { 条件式 }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day)} #昨日の投稿数
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週の投稿数
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.beginning_of_day)} #先週の投稿数



  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
end