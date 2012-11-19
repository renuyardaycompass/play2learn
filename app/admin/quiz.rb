ActiveAdmin.register Quiz do
  menu priority: 4

  index do
    column :title
    column :category
    default_actions
  end

  show do |quiz|
    attributes_table do
      row :title
      row "Description" do
        simple_format quiz.description
      end
      row "Category" do
        quiz.category.name
      end
      row "Duration" do
        "#{quiz.time["hours"]} hours and #{quiz.time["minutes"]} minutes"
      end
   end
   render "questions"
 end

  form do |f|
    f.inputs "Quiz Details" do
      f.input :title
      f.input :description, :as => :rich, :config => { :width => '76%', :height => '100px' }
      f.input :category, :as => :select
      f.inputs :for => :time, :name => "Duration" do |t|
        t.input :hours, :as => :select, :collection => 0..23
        t.input :minutes, :as => :select, :collection => 0..59
      end
    end
    f.buttons
  end
end