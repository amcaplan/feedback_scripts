require 'rails_helper'

RSpec.describe 'Surveys', type: :request do
  describe 'Processing a survey response' do
    def http_request
      post feedback.survey_responses_path(
        survey_response: { approval: approval }
      )
    end

    context 'positive survey response' do
      let(:approval) { true }

      it 'creates a new survey response' do
        expect { http_request }
          .to change { Feedback::SurveyResponse.count }
          .by(1)
        expect(Feedback::SurveyResponse.last.approval).to eq(true)
      end

      it 'redirects to the thanks path' do
        http_request
        expect(response).to redirect_to(feedback.thanks_path)
      end
    end

    context 'negative survey response' do
      let(:approval) { false }

      it 'creates a new survey response' do
        expect { http_request }
          .to change { Feedback::SurveyResponse.count }
          .by(1)
        expect(Feedback::SurveyResponse.last.approval).to eq(false)
      end

      it 'redirects to the thanks path' do
        http_request
        expect(response).to redirect_to(feedback.thanks_path)
      end
    end
  end

  describe 'Viewing the survey completion page' do
    it 'thanks the participant for submitting a response' do
      get feedback.thanks_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Thank you')
    end
  end
end
