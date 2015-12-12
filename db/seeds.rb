# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    # employees = Employee.create!(full_name: 'Talha Munshi', date_of_joining: '2015/12/12', gender: 'Male')

    Heading.destroy_all
    ReportCardHeading.destroy_all
    Heading.create(label: 'TermWork(Quarter 1)', method: 'termwork' )
    Heading.create(label: 'Quarter TW Total', method: 'termwork_total' )
    Heading.create(label: 'Quiz & Evaluations Q1', method: 'exams' )
    Heading.create(label: 'Quiz & Evaluations Total', method: 'exams_total' )
    Heading.create(label: 'Quarter 1 Total', method: 'quarter_total' )
    Heading.create(label: '%', method: 'quarter_percentage' )
    Heading.create(label: 'Evaluation', method: 'evaluation' )
    Heading.create(label: 'Grade', method: 'grade' )
    Heading.create(label: 'Credit Hours', method: 'credit_hours' )



