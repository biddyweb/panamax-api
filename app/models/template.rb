class Template < ActiveRecord::Base
  include TemplateGithub

  has_and_belongs_to_many :images

  serialize :authors, Array

  scope :recommended, -> { where(recommended: true) }

  validates_presence_of :name

  def categories
    images.map(&:categories).flatten.uniq.compact
  end

  def self.search(term)
    term = term.gsub(',', ' ')
    term.split.each_with_object([]) do |t, a|
      a << self.where('name LIKE ? OR keywords LIKE ?', "%#{t}%", "%#{t}%")
    end.flatten.uniq.compact
  end

end
