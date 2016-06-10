class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :university # 학교(서울대, 카이스트 등)
      t.string :classification # 교과 구분(교양, 전선, 전필 등)
      t.string :college # 개설 대학
      t.string :department # 개설 학과
      t.string :level # undergraduate, graduate
      t.string :grade # 학년
      t.string :course_num # 교과목 번호
      t.integer :lecture_num # 강좌 번호
      t.string :title
      t.integer :credit
      t.string :timetable # format: mon(09:30~10:45)/wed(09:30~10:45)
      t.string :location # format: 302-208/302-208 (시간표 순서와 동일)

      t.timestamps null: false
    end
  end
end
