require "rails_helper"

describe MovieInfoMailerJob, :type => :job do
  describe "#perform_later" do
    it "send email with csv" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        MovieInfoMailerJob.perform_later("send_info", "movies")
      }.to have_enqueued_job
    end
  end
end