ActiveAdmin.register Question do
  menu false
       
  controller do
    def new
      new! do |format|
        format.html { @question.quiz = Quiz.find(params[:quiz_id]) if params[:quiz_id] }
      end      
    end
    
    def index
      index! do |format|
        format.html { redirect_to admin_quizzes_url }
      end
    end
  end

  

  show :title => :question_text do |category|
    attributes_table do
      row :question_text
      row "Quiz" do |question|
      	link_to question.quiz.title, admin_quiz_path(question.quiz)
      end
    end
  end

  form do |f|
    f.inputs "Question Details" do
      f.input :question_text
      f.input :quiz, :as => :select

      f.inputs "Answers" do
        f.has_many :answers, :header => "" do |answer|
          answer.input :answer_text
          answer.input :hint, :as => :rich, :config => { :width => '85%', :height => '100px' }
          answer.input :is_correct, :as => :boolean
          answer.input :_destroy, :as=>:boolean, :required => false, :label=>'Remove'
        end
      end
    end
    f.buttons
  end
  
  
end