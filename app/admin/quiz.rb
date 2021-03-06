ActiveAdmin.register Quiz do
  menu priority: 4

  index do
    column :title
    column "Categories" do |quiz|
      simple_format "<ul>#{quiz.categories.map { |category| "<li>#{category.name}</li>" }.join}</ul>"
    end
    column :status
    column "Duration" do |quiz|
      time_ago_in_words quiz.duration.minutes.from_now
    end
    default_actions
  end

  show do |quiz|
    attributes_table do
      row :title
      row "Description" do
        simple_format quiz.description
      end
      row "Categories" do
        simple_format "<ul>#{quiz.categories.map { |category| "<li>#{category.name}</li>" }.join}</ul>"
      end
      row :status 
      row "Duration" do
        time_ago_in_words quiz.duration.minutes.from_now
      end
   end
   render "questions"
 end

  form do |f|
    f.inputs "Quiz Details" do
      f.input :title
      f.input :description, :as => :text
      f.input :categories, :as => :check_boxes
    end
    f.buttons
  end

  member_action :add_question, :method => :get do
    redirect_to new_admin_question_path
  end

  member_action :publish_quiz, :method => :put do
    puts "Inside Quiz publish controller"
    @quiz = Quiz.find(params[:id])
    @quiz.publish
    redirect_to admin_quiz_path(@quiz)
  end

  action_item :only => :show, :if => Proc.new { !quiz.published? } do
    link_to('Add Question', new_admin_question_path(:quiz_id => quiz.id))
  end

  action_item :only => :edit, :if => Proc.new { !quiz.published? } do
    link_to('Add Question', new_admin_question_path(:quiz_id => quiz.id))
  end

  action_item :only => :show, :if => Proc.new { !quiz.published? } do
    link_to 'Publish Quiz', {:action => :publish_quiz, :id => quiz.id}, :confirm => "Are you sure you want to publish this quiz?", :method => :put
  end

end