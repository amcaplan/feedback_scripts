require 'rails_helper'

RSpec.feature 'Taking a Survey', type: :feature do
  before do
    expect(Feedback::SurveyResponse.count).to eq(0)
    visit feedback.survey_responses_new_path
    choose choice
    click_button 'Submit'
  end

  context 'When the user likes the site' do
    let(:choice) { 'Yes' }

    it 'processes the submission' do
      expect(page).to have_text('Thank you')
      expect(Feedback::SurveyResponse.count).to eq(1)
      expect(Feedback::SurveyResponse.last.approval).to eq(true)
    end
  end

  context 'When the user dislikes the site' do
    let(:choice) { 'No' }

    it 'processes the submission' do
      expect(page).to have_text('Thank you')
      expect(Feedback::SurveyResponse.count).to eq(1)
      expect(Feedback::SurveyResponse.last.approval).to eq(false)
    end
  end
end
