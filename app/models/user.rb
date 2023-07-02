class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def novines
    #Article.joins(:article_categories).where( { :category_id => category_users.pluck(:category_id) } ).distinct
    #@articles = Article.joins(:article_categories).
    #where(article_categories: { category_id: @ids })
    #@novines = Novine.joins(:taggings).
    #where(taggings: { tag_id: @ids })
  end
end
