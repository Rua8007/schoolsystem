Rails.application.routes.draw do
  scope "(:locale)", :locale => /en|ar/ do
    mount Bootsy::Engine => '/bootsy', as: 'bootsy'
    resources :grade_groups
    resources :curriculums
    resources :lessonplans
    resources :portions
    resources :conversations, only: [:index, :show, :destroy] do
      member do
        get :notification
        post :reply
        post :restore
        post :mark_as_read
      end
    end

    resources :performances
    resources :roles
    get 'home/timetable'
    get 'home/sms'
    get 'home/sendsms'
    get 'home/backups'
    post 'home/restore_backup'
    get 'home/create_backup'

    resources :rights do
      collection do
        post 'add_roles'
      end
    end

    resources :curriculums do
      collection do
        get :get_requested
        post :approve_requested
        post :disapprove_requested
        post :approve_all_requests
      end
    end

    resources :lessonplans do
      collection do
        post :get_requested
        post :approve_requested
        post :disapprove_requested
        post :approve_all_requests
      end
    end

    resources :portions do
      collection do
        post :get_requested
        post :approve_requested
        post :disapprove_requested
        post :approve_all_requests
      end
    end

    resources :feebreakdowns
    resources :examcalenders do
      collection do
        get 'examdetail'
        get 'quizdetail'
        get 'examdata'
        get 'quizdata'

      end
    end
    resources :calenders do
      collection do
        get "calenderdetail"
        get "calenderdata"
      end
    end
    resources :purchases do
      member do
        put "approve"
        put "disapprove"
      end
      collection do
        post "invoicing"
      end

    end

    resources :conversations, only: [:index, :show, :destroy] do
      member do
        post :reply
        post :restore
        post :mark_as_read
      end
      collection do
        delete :empty_trash
      end
    end
    resources :messages, only: [:new, :create]
    resources :periods do
      collection do
        get 'make_daily_schedule'
        post 'save_daily_schedule'
      end
    end
    resources :time_tables do
      collection do
        get 'show_daily_schedule'
      end
    end
    resources :invoices do
      collection do
        get "items_data"
        post "invoicing"
        get "student_data"
      end
    end

    resources :packages do
      collection do
        get "items_data"
      end
    end

    resources :items do
      collection do
        get 'add_stock'
        get 'adding_stock'
        get 'get_item'
      end
    end

    resources :shopcategories
    resources :transportfeerecords do
      collection do
        get 'fee_data'
      end
    end
    resources :year_plans do
      member do
        get 'show_schedule'
        get 'weekly_schedule'
        get 'show_weekly_schedule'
        post 'update_weekly_schedule'
        delete 'delete_weekly_schedule'
      end
      collection do
        get :get_requested
        post :approve_requested
        post :disapprove_requested
        post :approve_all_requests
      end
      resources :weeks do
        collection do
          get 'schedule_weeks', :as => :schedule_weeks
          post 'add_schedule_weeks', :as => :add_schedule_weeks
        end
      end
    end
    get 'show_weekly_schedule/:id/:week_id/:grade_id' => 'year_plans#show_weekly_schedule', as: :print_weekly_schedule

    resources :fees do
      collection do
        get "fee_data"
        get 'fee_defaulter'
        get 'challan'
        get 'student_list'
        get 'buy_books'
        get 'books_invoice'
        get 'student_fee'
      end
    end
    resources :bus_allotments do
      collection do
        get "stops_data"
        get "transports_data"
      end
    end
    resources :stops

    resources :marks
    get 'select_subject_and_exam/:grade_id/:employee_id' => 'marks#select_subject_and_exam', as: :select_subject_and_exam
    get 'select_marks_details/:student_id/:grade_id/:employee_id' => 'marks#select_marks_details', as: :select_marks_details
    post 'enter_marks/' => 'marks#enter_marks', as: :enter_marks
    get 'enter_marks/:grade_id/:subject_id/:exam_id/:division_id' => 'marks#enter_marks', as: :enter_division_marks
    post 'save_marks' => 'marks#save_marks', as: :save_marks
    get 'subject_result' => 'marks#subject_result', as: :subject_result
    post 'subject_result' => 'marks#subject_result', as: :show_subject_result
    post 'get_subject_result' => 'marks#get_subject_result', as: :get_subject_result
    get  'get_subject_result' => 'marks#get_subject_result', as: :print_subject_result
    get 'class_result' => 'marks#class_result', as: :class_result
    post '/get_grade_exams' => 'marks#get_grade_exams'
    post 'class_result' => 'marks#class_result', as: :show_class_result
    get 'result_card/:student_id/:class_id/:batch_id/' => 'marks#result_card', as: :result_card
    get 'result_card/:student_id/:class_id/:batch_id/:exam_id/:format' => 'marks#result_card', as: :pdf_result_card
    get 'complete_result_card/:student_id/:class_id/:batch_id' => 'marks#complete_result_card', as: :complete_result_card
    get 'complete_result_card/:student_id/:class_id/:batch_id/:format' => 'marks#complete_result_card', as: :complete_pdf_result_card

    get 'print_all_students_results' => 'marks#print_all_students_results', as: :print_all_students_results
    get 'upload_csv/:class_id/:exam_id/:subject_id' => 'marks#upload_csv', as: :upload_csv
    post 'process_csv' => 'marks#process_csv', as: :process_csv
    get 'download_sample/:class_id/:exam_id/:subject_id' => 'marks#download_sample', as: :download_sample

    ##### Parents/Students Portal #####
    match 'my_results/' => 'marks#my_results', as: :my_results, via: [:get, :post]
    resources :marksheets do
      collection do
        post "uploading"
        get "classresult"
        get "get_class_result"
        get "result_card"
        get "subject_result"
        get "get_subject_result"
        get "result"
        post 'edit_marks'
        post 'update_marks'
        get 'marks_details'
        get "upload"
        get "student_marks_subject"
        post "student_marks"

      end
    end
    resources :exams
    resources :student_holidays
    resources :transports
    resources :routes
    resources :stops
    resources :vehicles
    resources :sessionals
    resources :weekends do
      collection do
        post 'add_weekends'
      end
    end


    resources :subjects
    get 'group_subjects' => 'subjects#group_subjects', as: :group_subjects
    post 'group_subjects' => 'subjects#group_subjects', as: :show_subjects
    post 'save_subjects_groups' => 'subjects#save_subjects_groups', as: :save_subjects_groups
    resources :grades do
      collection do
        get 'all_student'
        post 'student_add'
        get 'all_grades'
      end
      member do
        get 'add_students'
        get 'add_subjects'
        post 'subject_add'
      end
    end
    resources :batches
    resources :leaves do
      member do
        post 'approve_leave'
      end
    end
    resources :positions
    resources :departments
    resources :categories

    get 'emergencies/new'

    get 'emergencies/index'

    get 'emergencies/show'

    resources :parents do
      collection do
        get "parents_data"
      end
      member do
        get "edit_parent"
      end
    end
    devise_for :users
    resources :users do
      collection do
        post 'add_user'
      end
      member do
        get 'password'
        get 'enable'
      end
    end

    post '/users/enable_or_disable_users' => 'users#enable_or_disable_users'

    get 'home/index'

    resources :bridges do
      member do
        get 'class_subject'
      end
      collection do
        get 'newassign'
        post 'assigned'
        post 'new'
        post 'assign_teacher'
        get 'teacher_subject'

      end
    end
    resources :employees do
      collection do
        get 'mark_attendance_calendar'
        post 'mark_attendance'
        post 'save_attendances'
        get 'monthly_attendance_report'
        get 'get_monthly_attendance_report_result'
        get 'upload'
        post 'import'
      end
    end
    # get 'home/index'
    resources :emergencies
    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # You can have the root of your site routed with "root"
    root 'home#index'
    resources :students do
      member do
        post "assignParent"
        get "edit_student"
        get "give_discount"
      end
      collection do
        get "detail"
        get 'detail_by_rollnumber'
        get 'mark_attendance_calendar'
        post 'mark_attendance'
        post 'save_attendances'
        get 'monthly_attendance_report'
        get 'get_monthly_attendance_report_result'
      end
    end
    resources :documents do
      member do
        post "addPreviousInfo"
      end
      collection do
        post "upload"
      end
    end

    resources :report_card_settings
    get '/report_card_settings/new/:grade_id/:exam_id' => 'report_card_settings#new', as: :report_card_setting_new
    get '/report_card_settings/create_marks_divisions/:id' => 'report_card_settings#new_marks_divisions', as: :new_marks_divisions
    post '/report_card_settings/create_marks_divisions/:id' => 'report_card_settings#create_marks_divisions', as: :create_marks_divisions

    get '/report_card_settings/report_card_headings/:id' => 'report_card_settings#new_headings', as: :new_headings
    post '/report_card_settings/report_card_headings/:id' => 'report_card_settings#create_headings', as: :create_headings

    get '/report_card_settings/report_card_subjects/:id' => 'report_card_settings#new_subjects', as: :new_subjects
    post '/report_card_settings/report_card_subjects/:id' => 'report_card_settings#create_subjects', as: :create_subjects
    get '/report_card_settings/delete_group/:id' => 'report_card_settings#delete_subject_group', as: :delete_group

    post '/report_card_settings/get_weightage/:id(/:subject_id)' => 'report_card_settings#get_weightage', as: :get_weightage

    get '/select_report_card_settings/select_report_card_setting' => 'report_card_settings#select_report_card_setting', as: :select_report_card

    ###################################################################
    ## Publish Result Routes ##
    ###################################################################

    get '/select_class' => 'publish_results#select_class', as: :select_class_to_publish
    get '/publish_result/:class_id/:batch_id' => 'publish_results#publish_result', as: :publish_result
    get '/hide_result/:class_id/:batch_id' => 'publish_results#hide_result', as: :hide_result
    post 'publish_all/:batch_id' => 'publish_results#publish_all', as: :publish_all
    post 'hide_all/:batch_id' => 'publish_results#hide_all', as: :hide_all

    ####################################################################
    ## Fee moudle Routes ##
    ####################################################################
    resources :fee_entries
    resources :dues

    post 'dues/search_student' => 'dues#search_student', as: :search_student
    get  'dues/create_fee_plan/:student_id' => 'dues#create_fee_plan', as: :create_fee_plan
    post 'dues/save_fee_plan' => 'dues#save_fee_plan', as: :save_fee_plan

    get '/give_estimate' => 'dues#give_estimate', as: :give_estimate
    post '/dues/save_temporary_student' => 'dues#save_temporary_student', as: :save_temporary_student
  end
end
