class Quiz
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  Published_Status = "Published"
  
  field :title,   :type => String
  field :description, :type => String
  field :status, :type => String, :default => "Draft"
  field :duration, :type => Integer, :default => Settings.quiz.duration
  validates_uniqueness_of :title, :case_sensitive => false, :message => "Quiz with similar title is already created"
  has_and_belongs_to_many :categories
  
  has_many :questions
  accepts_nested_attributes_for :questions, :allow_destroy => true
  
  validates_presence_of :title, :categories, :description

  def publish
  	raise "Quiz is already published" if published?
  	self.status = Published_Status
    self.save!
    puts errors.full_messages.length
  end

  def published?
  	self.status == Published_Status
  end
end