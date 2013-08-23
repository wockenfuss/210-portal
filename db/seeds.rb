
#users
# 20.times do |n|
#   email = Faker::Internet.email
#   password  = "password"
#   User.create(email: email,
#                password: password)
# end

#lecture
lecture = Lecture.create(:name => "Week 2 Lecture", 
												:subtitle => "Convention and Expectation")

#lecture question
lec_question = LectureQuestion.create(:content => "It might seem that, since thwarting expectations results primarily in negative emotions, a filmmaker should only be interested in fulfilling viewer expectations. But can you think of reasons why thwarting viewer expectations might be useful?",
												:lecture_id => lecture.id, 
												:order_index => 1)

LectureQuestion.create(:content => "Take a few minutes to talk about your reaction to the ending of the film. When the film cuts to black with the characters waiting for the plane, what was your emotional reaction? Were you disappointed? Satisfied? Did your reaction change at all during the time you sat through the credits reflecting back on what you just watched?",
												:lecture_id => lecture.id, 
												:order_index => 2)

# #lecture question comments
# 5.times do |n|
# 	commentable_id = lec_question.id
# 	commentable_type = "LectureQuestion"
# 	user_id = User.all.sample.id
# 	content = Faker::Lorem.sentence(word_count = 3, supplemental = false)
# 	Comment.create(:commentable_id => commentable_id,
# 									:commentable_type => commentable_type,
# 									:user_id => user_id,
# 									:content => content)
# end


# #discussions
# 3.times do |n|
# 	name = "Week #{n + 1} Discussion"
# 	release = Time.now
# 	close = Time.now + 100000
# 	lorem = Faker::Lorem.paragraphs(paragraph_count = 2, supplemental = false)
# 	content = '<p>' + lorem[0] + '</p>'
# 	Discussion.create(:name => name,
# 									:release_date => release,
# 									:close_date => close,
# 									:content => content)
# end

# # discussion posts
# 25.times do |n|
# 	subject = Faker::Lorem.sentence(word_count = 1, supplemental = false)
# 	content = Faker::Lorem.paragraphs(paragraph_count = 1, supplemental = false)
# 	user_id = User.all.sample.id
# 	commentable_id = Discussion.all.sample.id
# 	commentable_type = "Discussion"
# 	Post.create(:subject => subject,
# 							:content => content,
# 							:user_id => user_id,
# 							:commentable_type => commentable_type,
# 							:commentable_id => commentable_id)
# end

# # discussion post replies
# 25.times do |n|
# 	content = Faker::Lorem.paragraphs(paragraph_count = 1, supplemental = false)
# 	user_id = User.all.sample.id
# 	commentable_id = Post.all.sample.id
# 	commentable_type = "Post"
# 	subject = "Re: #{Post.find(commentable_id).subject}"
# 	Post.create(:subject => subject,
# 							:content => content,
# 							:user_id => user_id,
# 							:commentable_type => commentable_type,
# 							:commentable_id => commentable_id)
# end

# # quizzes
# 5.times do |n|
# 	duration = 10
# 	release_date = Time.now
# 	close_date = Time.now + 100000
# 	name = "Week #{n + 1} Quiz"
# 	quiz = Quiz.create(:duration => duration,
# 							:release_date => release_date,
# 							:close_date => close_date,
# 							:name => name)
# 	5.times do |n|
# 		content = Faker::Lorem.sentence(word_count = 1, supplemental = false)
# 		name = Faker::Lorem.sentence(word_count = 1, supplemental = false)
# 		points = 1
# 		sort_number = n + 1
# 		quiz.questions.create(:content => content,
# 													:name => name,
# 													:points => points,
# 													:sort_number => sort_number)
# 	end
# end

# # units
# unit_name = "Week 1"
# release_date = Time.now
# unit = Unit.create(:name => unit_name,
# 						:release_date => release_date)
# comp1 = unit.components.create(:component_index => 1)
# comp1.lectures << Lecture.first
# comp2 = unit.components.create(:component_index => 2)
# comp2.quizzes << Quiz.first
# comp3 = unit.components.create(:component_index => 3)
# comp3.discussions << Discussion.first

